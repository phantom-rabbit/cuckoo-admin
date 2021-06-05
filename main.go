package main

import (
	"context"
	"cuckoo-admin/api"
	"cuckoo-admin/database"
	"io/ioutil"
	"log"
	"os"
	"os/signal"

	_ "github.com/GoAdminGroup/go-admin/adapter/gin"                 // web framework adapter
	_ "github.com/GoAdminGroup/go-admin/modules/db/drivers/postgres" // sql driver
	_ "github.com/GoAdminGroup/themes/sword"                         // ui theme

	"github.com/GoAdminGroup/go-admin/engine"
	"github.com/GoAdminGroup/go-admin/template"
	"github.com/GoAdminGroup/go-admin/template/chartjs"
	"github.com/gin-gonic/gin"

	"cuckoo-admin/pages"
	"cuckoo-admin/tables"
)

func main() {
	err := database.SetCuckooClient(context.Background(), "127.0.0.1:9033")
	if err != nil {
		panic(err)
	}

	startServer()
}

func startServer() {
	gin.SetMode(gin.ReleaseMode)
	gin.DefaultWriter = ioutil.Discard

	r := gin.Default()

	template.AddComp(chartjs.NewChart())

	eng := engine.Default()

	if err := eng.AddConfigFromJSON("./config.json").
		AddGenerators(tables.Generators).
		Use(r); err != nil {
		panic(err)
	}

	database.SetConn(eng.PostgresqlConnection())
	r.Static("/uploads", "./uploads")
	r.POST("/api/callback", api.CallBack)
	eng.HTML("GET", "/admin", pages.GetDashBoard)
	//eng.HTMLFile("GET", "/admin/hello", "./html/hello.tmpl", map[string]interface{}{
	//	"msg": "Hello world",
	//})

	_ = r.Run(":9033")

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt)
	<-quit
	log.Print("closing database connection")
	eng.PostgresqlConnection().Close()
}

package main

import (
	"context"
	"cuckoo-admin/api"
	"cuckoo-admin/database"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/signal"

	_ "github.com/GoAdminGroup/go-admin/adapter/gin"                 // js framework adapter
	_ "github.com/GoAdminGroup/go-admin/modules/db/drivers/postgres" // sql driver
	_ "github.com/GoAdminGroup/themes/sword"                         // ui theme

	"github.com/GoAdminGroup/go-admin/engine"
	"github.com/GoAdminGroup/go-admin/template"
	"github.com/GoAdminGroup/go-admin/template/chartjs"
	"github.com/gin-gonic/gin"

	"cuckoo-admin/pages"
	"cuckoo-admin/tables"
)

var (
	apiAddr     string
	config      string
	listen      string
)

func main() {
	flag.StringVar(&apiAddr, "service", "127.0.0.1:9000", "cuckoo service ip:port")
	flag.StringVar(&config, "config", "./config.json", "config path")
	flag.StringVar(&listen, "l", "0.0.0.0:9001", "listen port")
	flag.Parse()

	err := database.SetCuckooClient(context.Background(), apiAddr)
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

	if err := eng.AddConfigFromJSON(config).
		AddGenerators(tables.Generators).
		Use(r); err != nil {
		panic(err)
	}

	database.SetConn(eng.PostgresqlConnection())
	r.Static("/uploads", "./uploads")
	r.POST("/service/callback", api.CallBack)
	eng.HTML("GET", "/admin", pages.GetDashBoard)
	//eng.HTMLFile("GET", "/admin/hello", "./html/hello.tmpl", map[string]interface{}{
	//	"msg": "Hello world",
	//})

	fmt.Println("listen:", listen)
	err := r.Run(listen)
	if err != nil {
		fmt.Println("run admin err:", err)
		return
	}

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt)
	<-quit
	log.Print("closing database connection")
	eng.PostgresqlConnection().Close()
}

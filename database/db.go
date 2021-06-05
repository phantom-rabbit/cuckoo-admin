package database

import (
	"github.com/GoAdminGroup/go-admin/modules/db"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var Conn *gorm.DB

func SetConn(conn db.Connection)  {
	db, err := gorm.Open(postgres.New(postgres.Config{
		Conn:                 conn.GetDB("cuckoo"),
		PreferSimpleProtocol: true,
	}), &gorm.Config{})
	if err != nil {
		panic(err)
	}
	Conn = db
}
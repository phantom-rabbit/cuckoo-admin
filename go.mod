module cuckoo-admin

go 1.16

require (
	cuckoo-pay v0.0.0-00010101000000-000000000000
	github.com/GoAdminGroup/go-admin v1.2.23
	github.com/GoAdminGroup/themes v0.0.43
	github.com/ajg/form v1.5.1 // indirect
	github.com/buaazp/fasthttprouter v0.1.1 // indirect
	github.com/fasthttp-contrib/websocket v0.0.0-20160511215533-1f3b11f56072 // indirect
	github.com/fatih/structs v1.1.0 // indirect
	github.com/gavv/httpexpect v2.0.0+incompatible
	github.com/gin-gonic/gin v1.7.2
	github.com/gobuffalo/packr/v2 v2.8.1 // indirect
	github.com/google/go-querystring v1.1.0 // indirect
	github.com/imkira/go-interpol v1.1.0 // indirect
	github.com/moul/http2curl v1.0.0 // indirect
	github.com/sclevine/agouti v3.0.0+incompatible // indirect
	github.com/sergi/go-diff v1.2.0 // indirect
	github.com/sirupsen/logrus v1.6.0
	github.com/valyala/fasthttp v1.26.0 // indirect
	github.com/xeipuuv/gojsonschema v1.2.0 // indirect
	github.com/yalp/jsonpath v0.0.0-20180802001716-5cc68e5049a0 // indirect
	github.com/yudai/gojsondiff v1.0.0 // indirect
	github.com/yudai/golcs v0.0.0-20170316035057-ecda9a501e82 // indirect
	github.com/yudai/pp v2.0.1+incompatible // indirect
	gorm.io/driver/postgres v1.1.0
	gorm.io/gorm v1.21.10
)

replace (
	cuckoo-pay => ../cuckoo-pay
	tron => ../tron-rpc
)

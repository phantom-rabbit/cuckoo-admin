package pay

import (
	"cuckoo-admin/database"
	"github.com/GoAdminGroup/go-admin/context"
	"github.com/GoAdminGroup/go-admin/modules/db"
	"github.com/GoAdminGroup/go-admin/plugins/admin/modules/parameter"
	"github.com/GoAdminGroup/go-admin/plugins/admin/modules/table"
	"github.com/GoAdminGroup/go-admin/template/types"
	log "github.com/sirupsen/logrus"
)

func GetAppInfoTable(ctx *context.Context) table.Table {
	var userTable = table.NewDefaultTable(table.Config{}.SetPrimaryKey("app_id", db.Varchar))
	info := userTable.GetInfo()

	info.HideNewButton()

	info.HideEditButton()
	info.HideDeleteButton()
	info.HideDetailButton()

	info.HideFilterArea()
	info.SetFilterFormInputWidth(6)

	info.AddField("AppId", "app_id", db.Text)
	info.AddField("出款地址", "drawing_addr", db.Text).FieldDisplay(func(value types.FieldModel) interface{} {
		return `<a target="_blank" href="https://trx.tokenview.com/cn/address/`+ value.Value + `" >` + value.Value + `</a>`
	})
	info.AddField("出款地址余额(USDT)", "drawing_usdt", db.Float8)
	info.AddField("手续费地址", "trx_addr", db.Text)
	info.AddField("手续费地址余额(TRX)", "trx_trx", db.Float8)
	info.AddField("归集地址", "collect", db.Text)

	info.SetTable("AppIds").
		SetTitle("AppIds").
		SetDescription("app").
		// 返回值：第一个为数据列表，第二个为数据量
		SetGetDataFn(func(param parameter.Parameters) (data []map[string]interface{}, size int) {
			param.IsAll()

			// 情况2：返回指定主键对应的数据
			param.PK()

			// 对于参数说明
			//
			// param.SortField     排序字段
			// param.Fields        筛选的字段
			// param.SortType      排序类型
			// param.Columns       隐藏的字段
			// param.PageSize      每页数据数
			// param.Page          当面页码
		apps, err := database.GetCuckooClient().GetApps(ctx.Request.Context())
		if err != nil {
			log.Error(err)
			return
		}

		data = make([]map[string]interface{}, 0)

		for _, app := range apps {
			data = append(data, map[string]interface{}{
				"app_id": app.AppId,
				"drawing_addr": app.DrawingAddr.Address,
				"drawing_usdt": app.DrawingAddr.Usdt,
				"trx_addr": app.TrxAddr.Address,
				"trx_trx": app.TrxAddr.Trx,
				"collect": app.CollectAddr,
			})
		}

		return data, len(data)})


	return userTable
}
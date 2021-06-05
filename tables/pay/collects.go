package pay

import (
	"github.com/GoAdminGroup/go-admin/context"
	"github.com/GoAdminGroup/go-admin/modules/db"
	"github.com/GoAdminGroup/go-admin/plugins/admin/modules/table"
	"github.com/GoAdminGroup/go-admin/template/types"
	"github.com/GoAdminGroup/go-admin/template/types/form"
)

func GetCollectsTable(ctx *context.Context) table.Table {

	collects := table.NewDefaultTable(table.DefaultConfigWithDriver("postgresql"))

	info := collects.GetInfo()

	info.HideNewButton()

	info.HideEditButton()
	info.HideDeleteButton()
	info.HideDetailButton()

	info.HideFilterArea()
	info.SetFilterFormLayout(form.LayoutTwoCol)
	info.SetFilterFormInputWidth(6)

	info.AddField("Id", "id", db.Int8)
	info.AddField("hash", "tx_id", db.Text).FieldDisplay(func(model types.FieldModel) interface{} {
		return `<a target="view_window" href="https://trx.tokenview.com/cn/tx/`+ model.Value + `" >` + model.Value + `</a>`
	})
	info.AddField("time", "created_at", db.Timestamptz)
	info.AddField("转出地址", "from", db.Text).FieldFilterable()
	info.AddField("归集地址", "to", db.Text)
	info.AddField("Value", "value", db.Text)
	info.AddField("类型", "tx_type", db.Text)

	info.SetTable("collects").SetTitle("归集记录").SetDescription("Collects")

	return collects
}

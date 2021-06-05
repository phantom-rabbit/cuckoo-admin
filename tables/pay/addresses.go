package pay

import (
	"github.com/GoAdminGroup/go-admin/context"
	"github.com/GoAdminGroup/go-admin/modules/db"
	"github.com/GoAdminGroup/go-admin/plugins/admin/modules/table"
	"github.com/GoAdminGroup/go-admin/template/types/form"
)

func GetAddressesTable(ctx *context.Context) table.Table {

	addresses := table.NewDefaultTable(table.DefaultConfigWithDriver("postgresql"))

	info := addresses.GetInfo()

	info.HideNewButton()

	info.HideEditButton()
	info.HideDeleteButton()
	info.HideDetailButton()

	info.HideFilterArea()
	info.SetFilterFormInputWidth(6)
	info.SetFilterFormLayout(form.LayoutTwoCol)
	info.AddField("Id", "id", db.Int8).
		FieldSortable()
	info.AddField("创建时间", "created_at", db.Timestamptz)
	info.AddField("地址", "addr", db.Text).
		FieldFilterable()
	info.AddField("私钥(加密)", "private_key", db.Text).
		FieldHide()

	info.SetTable("addresses").SetTitle("地址列表").SetDescription("地址")

	formList := addresses.GetForm()
	formList.AddField("Id", "id", db.Int8, form.Default).
		FieldDisableWhenCreate()
	formList.AddField("Created_at", "created_at", db.Timestamptz, form.Datetime).
		FieldHide().FieldNowWhenInsert()
	formList.AddField("Updated_at", "updated_at", db.Timestamptz, form.Datetime).
		FieldHide().FieldNowWhenUpdate()
	formList.AddField("Deleted_at", "deleted_at", db.Timestamptz, form.Datetime)
	formList.AddField("Addr", "addr", db.Text, form.RichText)
	formList.AddField("Private_key", "private_key", db.Text, form.RichText)

	formList.SetTable("addresses").SetTitle("Addresses").SetDescription("Addresses")

	return addresses
}

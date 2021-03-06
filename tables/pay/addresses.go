package pay

import (
	"cuckoo-admin/database"
	"cuckoo-pay/service/module"
	"encoding/json"
	"github.com/GoAdminGroup/go-admin/context"
	"github.com/GoAdminGroup/go-admin/modules/db"
	"github.com/GoAdminGroup/go-admin/plugins/admin/modules/table"
	"github.com/GoAdminGroup/go-admin/template/types/action"
	"github.com/GoAdminGroup/go-admin/template/types/form"
)

func GetAddressesTable(ctx *context.Context) table.Table {
	addresses := table.NewDefaultTable(table.DefaultConfigWithDriverAndConnection("postgresql", "cuckoo"))

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
	info.AddField("AppId", "app_id", db.Text).
		FieldFilterable()
	info.AddField("私钥(加密)", "private_key", db.Text)

	info.AddActionButton("查询余额", action.PopUp("queryBalance", "余额", func(ctx *context.Context) (success bool, msg string, data interface{}) {
		var adrr module.Address
		if err := database.Conn.Where("id = ?", ctx.Request.PostForm.Get("id")).First(&adrr).Error; err != nil {
			return true, err.Error(), nil
		}
		result := database.GetCuckooClient().GetBalance(ctx.Request.Context(), adrr.Addr)
		indent, _ := json.MarshalIndent(result.Data, " ", " ")

		return true, "ok", string(indent)
	}))

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

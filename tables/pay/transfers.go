package pay

import (
	"cuckoo-admin/database"
	"cuckoo-pay/service"
	"cuckoo-pay/service/module"
	"fmt"
	"github.com/GoAdminGroup/go-admin/context"
	"github.com/GoAdminGroup/go-admin/modules/db"
	"github.com/GoAdminGroup/go-admin/modules/db/dialect"
	"github.com/GoAdminGroup/go-admin/plugins/admin/modules/table"
	"github.com/GoAdminGroup/go-admin/template/icon"
	"github.com/GoAdminGroup/go-admin/template/types"
	"github.com/GoAdminGroup/go-admin/template/types/action"
	"github.com/GoAdminGroup/go-admin/template/types/form"
	"strconv"
	"time"
)

func GetTransfersTable(ctx *context.Context) table.Table {
	transfers := table.NewDefaultTable(table.DefaultConfigWithDriver("postgresql"))
	info := transfers.GetInfo()
	transfers.GetForm()
	info.HideNewButton()
	info.HideDeleteButton()

	info.HideFilterArea()
	info.SetFilterFormLayout(form.LayoutTwoCol)
	info.SetFilterFormInputWidth(6)

	info.AddField("id", "id", db.Int8)
	info.AddField("hash", "tx_id", db.Text).FieldDisplay(func(model types.FieldModel) interface{} {
		return `<a target="view_window" href="https://trx.tokenview.com/cn/tx/`+ model.Value + `" >` + model.Value + `</a>`
	}).FieldFilterable()
	info.AddField("区块高度", "block_height", db.Int8)
	info.AddField("时间", "timestamp", db.Int8).FieldDisplay(func(model types.FieldModel) interface{} {
		unix, _ := strconv.ParseInt(model.Value, 10, 64)
		return time.Unix(unix / 1000, 0).Format("2006-01-02 15:04:05")
	})
	info.AddField("转出", "from", db.Text)
	info.AddField("转入", "to", db.Text).FieldFilterable()
	info.AddField("类型", "tx_type", db.Text)
	info.AddField("金额", "value", db.Text)
	info.AddField("状态", "status", db.Int8).FieldDisplay(func(model types.FieldModel) interface{} {
		switch model.Value {
		case "0":
			return "Failure"
		case "1":
			return "Success"
		default:
			return model.Value
		}
	})
	info.AddField("回调状态", "call_back", db.Bool)
	info.AddField("回调次数", "call_back_num", db.Int)

	info.AddColumnButtons("手动回调", types.GetColumnButton("回调", icon.MailForward,
		action.PopUp("/info/callback", "回调结果", func(ctx *context.Context) (success bool, msg string, data interface{}) {
			value := ctx.FormValue("id")

			first, err := db.WithDriver(database.Conn).Table("transfers").Where("id", "=", value).First()
			if err != nil {
				return true, "err", err.Error()
			}

			if first["call_back_url"].(string) == "" {
				return true, "err", "回调地址为空，请设置回调地址"
			}

			tx := module.Transfer{
				TxId:         first["tx_id"].(string),
				BlockHeight:  first["block_height"].(int64),
				Timestamp:    first["timestamp"].(int64),
				From:         first["from"].(string),
				To:           first["to"].(string),
				TxType:       first["tx_type"].(string),
				Value:        first["value"].(string),
				Status:       first["status"].(int64),
				CallBack:     first["call_back"].(bool),
				CallBackNum:  first["call_back_num"].(int64),
				CallBackUrl:  first["call_back_url"].(string),
			}
			err = service.CallBack(first["call_back_url"].(string), tx)
			if err != nil {
				return true, "err", err.Error()
			}
			_, err = db.WithDriver(database.Conn).Table("transfers").Where("id", "=", value).
				Update(dialect.H{
					"call_back":      true,
					"call_back_time": time.Now().Unix(),
				})
			if err != nil {
				fmt.Println("UPDATE transfers CallBack Err:", err)
			}

			return true, "ok", "SUCCESS"
		})))

	info.SetTable("transfers").SetTitle("充值记录").SetDescription("充值记录列表")

	detail := transfers.GetDetail()
	detail.AddField("回调状态", "call_back", db.Bool)
	detail.AddField("回调次数", "call_back_num", db.Int)
	detail.AddField("回调地址", "call_back_url", db.Text)
	detail.AddField("回调时间", "call_back_time", db.Int).FieldDisplay(func(model types.FieldModel) interface{} {
		if model.Value == "0" {
			return ""
		}
		fmt.Println(model.Value)

		parseInt, _ := strconv.ParseInt(model.Value, 10, 64)
		return time.Unix(parseInt, 0).Format("2006-01-02 15:04:05")
	})
	detail.SetTable("transfers").
		SetTitle("回调").
		SetDescription("回调详情")

	formList := transfers.GetForm()
	formList.AddField("回调地址", "call_back_url", db.Text, form.RichText)

	formList.HideContinueEditCheckBox()
	formList.HideContinueNewCheckBox()

	formList.SetTable("transfers").SetTitle("设置回调地址").SetDescription("Transfers")
	return transfers
}

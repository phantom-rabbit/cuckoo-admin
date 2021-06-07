package pay

import (
	"cuckoo-admin/database"
	"cuckoo-pay/service"
	"cuckoo-pay/service/module"
	"fmt"
	"github.com/GoAdminGroup/go-admin/context"
	"github.com/GoAdminGroup/go-admin/modules/db"
	"github.com/GoAdminGroup/go-admin/plugins/admin/modules/table"
	"github.com/GoAdminGroup/go-admin/template/types"
	"github.com/GoAdminGroup/go-admin/template/types/action"
	"github.com/GoAdminGroup/go-admin/template/types/form"
	"strconv"
	"time"
)

func GetTransfersTable(ctx *context.Context) table.Table {
	transfers := table.NewDefaultTable(table.DefaultConfigWithDriverAndConnection("postgresql", "cuckoo"))
	info := transfers.GetInfo()

	transfers.GetForm()
	info.HideNewButton()
	info.HideDeleteButton()

	info.HideFilterArea()
	info.SetFilterFormLayout(form.LayoutTwoCol)
	info.SetFilterFormInputWidth(6)

	info.AddField("id", "id", db.Int8)
	info.AddField("hash", "tx_id", db.Text).FieldDisplay(func(model types.FieldModel) interface{} {
		return `<a target="_blank" href="https://trx.tokenview.com/cn/tx/`+ model.Value + `" >` + model.Value + `</a>`
	}).FieldFilterable()
	//info.AddField("区块高度", "block_height", db.Int8)
	info.AddField("时间", "timestamp", db.Int8).FieldDisplay(func(model types.FieldModel) interface{} {
		unix, _ := strconv.ParseInt(model.Value, 10, 64)
		return time.Unix(unix / 1000, 0).Format("2006-01-02 15:04:05")
	})
	info.AddField("AppId", "app_id", db.Text).FieldFilterable()
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
	info.AddField("归集状态", "collect", db.Bool)


	info.AddActionButton("回调", action.PopUp("callback", "回调结果", func(ctx *context.Context) (success bool, msg string, data interface{}) {
		value := ctx.FormValue("id")
		transfer, err := module.GetTransferById(database.Conn, value)
		if err != nil {
			return true, "err", err.Error()
		}

		if transfer.CallBackUrl == "" {
			return true, "err", "回调地址为空，请设置回调地址"
		}

		err = service.CallBack(transfer.CallBackUrl, transfer)
		if err != nil {
			return true, "err", err.Error()
		}

		transfer.CallBack = true
		transfer.CallBackTime = time.Now().Unix()
		transfer.CallBackNum += 1

		err = transfer.UpdateCallBack(database.Conn)
		if err != nil {
			fmt.Println("UPDATE transfers CallBack Err:", err)
		}

		return true, "ok", "SUCCESS"
	}))

	info.AddActionButton("归集", action.PopUp("collect", "归集结果", func(ctx *context.Context) (success bool, msg string, data interface{}) {
		tx, err := module.GetTransferById(database.Conn, ctx.FormValue("id"))
		if err != nil {
			return true, "err", err.Error()
		}
		if tx.Collect {
			return true, "err", "该笔交易已经归集过了,请勿重复归集"
		}

		collect, err := database.GetCuckooClient().Collect(ctx.Request.Context(), ctx.FormValue("id"))
		if err != nil {
			return true, "err", "归集失败:" + err.Error()
		}

		err = tx.UpdateCollect(database.Conn)
		if err != nil {
			return true, err.Error(),nil
		}

		return true, "ok", "归集成功,交易Hash:" + collect
	}))

	info.SetTable("transfers").SetTitle("充值记录").SetDescription("充值记录列表").SetNoCompress()

	detail := transfers.GetDetail()
	detail.AddField("回调状态", "call_back", db.Bool)
	detail.AddField("回调次数", "call_back_num", db.Int)
	detail.AddField("回调地址", "call_back_url", db.Text)
	detail.AddField("回调时间", "call_back_time", db.Int).FieldDisplay(func(model types.FieldModel) interface{} {
		if model.Value == "0" {
			return ""
		}
		parseInt, _ := strconv.ParseInt(model.Value, 10, 64)
		return time.Unix(parseInt, 0).Format("2006-01-02 15:04:05")
	})
	detail.SetTable("transfers").
		SetTitle("回调").
		SetDescription("回调详情")

	formList := transfers.GetForm()
	formList.AddField("回调地址", "call_back_url", db.Text, form.Text)

	formList.HideContinueEditCheckBox()
	formList.HideContinueNewCheckBox()

	formList.SetTable("transfers").SetTitle("设置回调地址").SetDescription("Transfers")
	return transfers
}

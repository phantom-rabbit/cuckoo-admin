package pay

import (
	"cuckoo-admin/database"
	"cuckoo-pay/service"
	"cuckoo-pay/service/module"
	"database/sql"
	"fmt"
	"github.com/GoAdminGroup/go-admin/context"
	"github.com/GoAdminGroup/go-admin/modules/db"
	"github.com/GoAdminGroup/go-admin/plugins/admin/modules/table"
	"github.com/GoAdminGroup/go-admin/template"
	"github.com/GoAdminGroup/go-admin/template/types"
	"github.com/GoAdminGroup/go-admin/template/types/action"
	"github.com/GoAdminGroup/go-admin/template/types/form"
	"github.com/GoAdminGroup/themes/sword/components/card"
	"strconv"
	"time"

	htemplate "html/template"
)

func GetTransfersTable(ctx *context.Context) table.Table {
	transfers := table.NewDefaultTable(table.DefaultConfigWithDriverAndConnection("postgresql", "cuckoo"))
	info := transfers.GetInfo()
	info.HideNewButton()
	info.HideDeleteButton()

	info.HideFilterArea()
	info.SetFilterFormLayout(form.LayoutTwoCol)
	info.SetFilterFormInputWidth(6)

	info.AddField("id", "id", db.Int8)
	info.AddField("hash", "tx_id", db.Text).FieldDisplay(func(model types.FieldModel) interface{} {
		return `<a target="_blank" href="https://trx.tokenview.com/cn/tx/`+ model.Value + `" >` + model.Value + `</a>`
	}).FieldFilterable()

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
	info.AddField("归集状态", "collect", db.Bool).FieldFilterable(types.FilterType{FormType: form.SelectSingle}).FieldFilterOptions(types.FieldOptions{
		{Value: "0", Text: "失败"},
		{Value: "1", Text: "成功"},
	})

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

	info.SetHeaderHtml(TransferHeaderHtml(ctx))
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

type RequestStruct struct {
	Hash  string `json:"hash"`
	AppId string `json:"app_id"`
	To    string `json:"to"`
	Collect string `json:"collect"`
}

func TransferHeaderHtml(ctx *context.Context) htemplate.HTML {
	var sqlQuery = `select sum(to_number("value", '99999.99')) from transfers where 1 = 1`
	var params []interface{}
	if ctx.Query("to") != "" {
		sqlQuery += `and to = ?`
		params = append(params, ctx.Query("to"))
	} else if  ctx.Query("collect") != "" {
		sqlQuery += `and collect = ?`
		params = append(params, ctx.Query("collect"))
	} else if  ctx.Query("app_id") != "" {
		sqlQuery += `and app_id = ?`
		params = append(params, ctx.Query("app_id"))
	} else if  ctx.Query("tx_id") != "" {
		sqlQuery += `and tx_id = ?`
		params = append(params, ctx.Query("tx_id"))
	}

	var value sql.NullFloat64
	err := database.Conn.Raw(sqlQuery, params).Scan(&value).Error
	if err != nil {
		fmt.Println("query err:", err)
	}

	var todayValue sql.NullFloat64
	sqlQuery += " and created_at >= CURRENT_DATE"
	err = database.Conn.Raw(sqlQuery, params).Scan(&todayValue).Error
	if err != nil {
		fmt.Println("query err:", err)
	}

	cardcard := card.New().
		SetTitle("充值USDT").
		SetSubTitle("$ " + fmt.Sprintf("%.2f", value.Float64)).
		SetFooter(template.HTML(`今日充值 <strong style="margin-left:8px;">`+ "$ " + fmt.Sprintf("%v", todayValue.Float64) + `</strong>`))
	infobox := cardcard.GetContent()

	return infobox
}
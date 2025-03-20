using Newtonsoft.Json.Linq;
using System;
using System.Configuration;
using System.Windows.Forms;
using JiandaoyunAPI;

namespace MakeT_Voucher
{
    public partial class Main : Form
    {
        public string apiKey = ConfigurationManager.AppSettings["apiKey"].ToString();
        public Main()
        {
            InitializeComponent();
        }

        //UTC时间转换为北京时间
        public static string ToChineseDateTime(string UTCdatetime)
        {
            if (string.IsNullOrEmpty(UTCdatetime))
                return "null";
            DateTime dt;
            System.Globalization.DateTimeFormatInfo dtFormat = new System.Globalization.DateTimeFormatInfo();
            dtFormat.ShortDatePattern = "yyyy-MM-dd HH:mm:ss";
            try
            {
                dt = Convert.ToDateTime(UTCdatetime, dtFormat);
                return "'" + dt.ToString() + "'";
            }
            catch
            {
                return "null";
            }
        }

        //获取单位简称
        public string GetOrgName(string Fullname)
        {
            if (Fullname == "广西华纳新材料股份有限公司")
                return "华纳股份";
            else if (Fullname == "广西合山市华纳新材料科技有限公司")
                return "合山华纳";
            else if (Fullname == "安徽省宣城市华纳新材料科技有限公司")
                return "宣城华纳";
            else
                return Fullname;
        }

        //获取销售发货单（产成品）api接口，写入销售发货表
        private void AddSaleDetailFromApi(int action, string tablename, bool Isautomatic, string startDate, string endDate)
        {
            string queryField = "createTime";
            if (!Isautomatic)
            {
                queryField = "bill_date";
            }
            else
            {
                if (action == 2)
                    queryField = "updateTime";
                else
                    queryField = "createTime";
            }

            string appId = ConfigurationManager.AppSettings["appId_salefh"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_salefh"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            try
            {
                   // 按条件获取表单内容
                   JArray cond = new JArray{
                    //new JObject
                    //{
                    //    ["field"] = "dw",
                    //    ["method"] = "in",
                    //    ["value"] = new JArray{ "广西华纳新材料股份有限公司", "广西合山市华纳新材料科技有限公司", "安徽省宣城市华纳新材料科技有限公司" }
                    //},
                     new JObject
                    {
                        ["field"] = queryField,
                        ["method"] = "range",
                        ["value"] = new JArray { startDate, endDate }
                    },
                    new JObject
                    {
                        ["field"] = "flowState",
                        ["method"] = "in",
                        ["value"] = new JArray{ 0, 1 }
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };

                JArray data = api.GetFormData(null, 3000, null, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string xs_sn = item["xs_sn"].ToString();
                        string carno = item["carno"].ToString();
                        string bill_date = ToChineseDateTime(item["bill_date"].ToString());
                        string dw = item["dw"].ToString();
                        string production = item["production"].ToString();
                        string customer = item["customer"].ToString();
                        string dealer = item["dealer"].ToString();
                        string salesman = item["salesman"].ToString();
                        JArray m_list = (JArray)item["m_list"];
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string flowState = item["flowState"].ToString();
                        HuanaBiz.AddSaleDetail(tablename, action, xs_sn, carno, bill_date, dw, production, customer, dealer, salesman, m_list, CreateTime, UpdateTime, flowState);
                    }
                }
            }
            catch (Exception ex)
            {
                rTxtLog.AppendText(ex.Message);
            }
            finally
            {
            }
        }

        //获取销售退货单（产成品）api接口，写入销售退货表
        private void GetSaleReturnFromApi(string startDate, string endDate)
        {
            string appId = ConfigurationManager.AppSettings["appId_salefh"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_saleth"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray{
                     new JObject
                    {
                        ["field"] = "createTime",
                        ["method"] = "range",
                        ["value"] = new JArray { startDate, endDate }
                    },
                    new JObject
                    {
                        ["field"] = "flowState",
                        ["method"] = "in",
                        ["value"] = new JArray{ 0, 1 }
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };
                JArray data = api.GetFormData(null, 1500, null, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string th_sn = item["th_sn"].ToString();
                        string xs_sn = item["xs_sn"].ToString();
                        string reason_1 = item["reason"].ToString();
                        string carno = item["carno"].ToString();
                        string bill_date = ToChineseDateTime(item["bill_date"].ToString());
                        string dw = item["dw"].ToString();
                        string customer = item["customer"].ToString();
                        string dealer = item["dealer"].ToString();
                        string salesman = item["salesman"].ToString();
                        JArray m_list = (JArray)item["m_list"];
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string flowState = item["flowState"].ToString();
                        HuanaBiz.AddSaleReturn(th_sn, xs_sn, carno, bill_date, dw,customer, dealer, salesman, reason_1, m_list, CreateTime, UpdateTime, flowState);
                    }
                }
            }
            catch (Exception ex)
            {
                rTxtLog.AppendText(ex.Message);
            }
            finally
            {
            }
        }

        //获取开增值税发票录入表api接口，写入
        private void AddInvoicedFromApi(int action, string tablename, bool Isautomatic, string startDate, string endDate)
        {
            string queryField = "createTime";
            if (!Isautomatic)
            {
                queryField = "kprq";
            }
            else
            {
                if (action == 2)
                    queryField = "updateTime";
                else
                    queryField = "createTime";
            }

            string appId = ConfigurationManager.AppSettings["appId_salefh"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_invoiced"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray{
                     new JObject
                    {
                        ["field"] = queryField,
                        ["method"] = "range",
                        ["value"] = new JArray { startDate, endDate }
                    },
                    new JObject
                    {
                        ["field"] = "flowState",
                        ["method"] = "in",
                        ["value"] = new JArray{ 0, 1 }
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };
                JArray data = api.GetFormData(null, 3000, null, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string kprq = ToChineseDateTime(item["kprq"].ToString());
                        if (!kprq.Equals("null"))
                        {
                            string id = item["_id"].ToString();  //简道云数据唯一ID
                            string dw = item["dw"].ToString();
                            string xs_sn = item["xs_sn"].ToString();
                            string kphm = item["kphm"].ToString();
                            string customer = item["customer"].ToString();
                            string fhrq = ToChineseDateTime(item["fhrq"].ToString());
                            string goodsname = item["goodsname"].ToString();
                            string amount = item["amount"].ToString() == "" ? "0" : item["amount"].ToString();
                            string price = item["price"].ToString() == "" ? "0" : item["price"].ToString();
                            string money = item["money"].ToString() == "" ? "0" : item["money"].ToString();
                            string money_notax = item["money_notax"].ToString() == "" ? "0" : item["money_notax"].ToString();
                            string money_tax = item["money_tax"].ToString() == "" ? "0" : item["money_tax"].ToString();
                            string options = item["options"].ToString();
                            string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                            string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                            string flowState = item["flowState"].ToString();
                            HuanaBiz.AddInvoiced(tablename, action, id, dw, xs_sn, kprq, kphm, customer, fhrq, goodsname, amount, price, money, money_notax, money_tax, options, CreateTime, UpdateTime, flowState);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                rTxtLog.AppendText(ex.Message);
            }
            finally
            {
            }
        }

        //获取磅差处理单api接口
        private void AddSalePcFromApi(string startDate, string endDate)
        {
            string appId = ConfigurationManager.AppSettings["appId_salefh"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_pc"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray{
                     new JObject
                    {
                        ["field"] = "createTime",
                        ["method"] = "range",
                        ["value"] = new JArray { startDate, endDate }
                    },
                    new JObject
                    {
                        ["field"] = "flowState",
                        ["method"] = "in",
                        ["value"] = new JArray{ 0, 1 }
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };

                JArray data = api.GetFormData(null, 3000, null, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string id = item["sid"].ToString();
                        string xs_sn = item["xs_sn"].ToString();
                        string fhrq = ToChineseDateTime(item["fhrq"].ToString());
                        string dw = item["dw"].ToString();
                        string customer = item["customer"].ToString();
                        string strReason = item["reason"].ToString();
                        string handleway = item["handleway"].ToString();
                        JArray m_list = (JArray)item["m_list"];
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string flowState = item["flowState"].ToString();
                        HuanaBiz.AddSalePc(1, id, xs_sn, dw, customer, fhrq, strReason, handleway, m_list, CreateTime, UpdateTime, flowState);
                    }
                }
            }
            catch (Exception ex)
            {
                rTxtLog.AppendText(ex.Message);
            }
            finally
            {
            }
        }

        //获取T+往月库存商品单价表单api接口
        private void AddSaleStockPriceFromApi(string startDate, string endDate)
        {
            string appId = ConfigurationManager.AppSettings["appId_salefh"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_stockprice"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray{
                     new JObject
                    {
                        ["field"] = "jsrq",
                        ["method"] = "range",
                        ["value"] = new JArray { startDate, endDate }
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };

                JArray data = api.GetFormData(null, 3000, null, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string id = item["_id"].ToString();
                        string dw = item["dw"].ToString();
                        string jsrq = ToChineseDateTime(item["jsrq"].ToString());
                        string accountcode = item["accountcode"].ToString();
                        string goodsname = item["goodsname"].ToString();
                        string price = item["price"].ToString() == "" ? "0" : item["price"].ToString();
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        HuanaBiz.AddSaleStockPrice(1, id, dw, jsrq, accountcode, goodsname, price, CreateTime, UpdateTime);
                    }
                }
            }
            catch (Exception ex)
            {
                rTxtLog.AppendText(ex.Message);
            }
            finally
            {
            }
        }

        //获取采购入库单api接口,新增数据
        private void AddPurchaseFromApi(int action, string tablename, bool Isautomatic, string startDate, string endDate)
        {
            string queryField = "createTime";
            if (!Isautomatic)
            {
                queryField = "indate";
            }
            else
            {
                if (action == 2)
                    queryField = "updateTime";
                else
                    queryField = "createTime";
            }

            string appId = ConfigurationManager.AppSettings["appId_purchasein"].ToString();

            //五金采购入库
            string entryId = ConfigurationManager.AppSettings["entryId_purchasein_wj"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            //大宗采购质检后入库
            entryId = ConfigurationManager.AppSettings["entryId_purchasein_pl1"].ToString();
            APIUtils api1 = new APIUtils(appId, entryId, apiKey);

            //大宗采购入库
            entryId = ConfigurationManager.AppSettings["entryId_purchasein_pl2"].ToString();
            APIUtils api2 = new APIUtils(appId, entryId, apiKey);

            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray{
                     new JObject
                    {
                        ["field"] = "dw",
                        ["method"] = "in",
                        ["value"] = new JArray{ "广西华纳新材料股份有限公司", "广西合山市华纳新材料科技有限公司", "安徽省宣城市华纳新材料科技有限公司" }
                    },
                    new JObject
                    {
                        ["field"] = queryField,
                        ["method"] = "range",
                        ["value"] = new JArray { startDate, endDate }
                    },
                    new JObject
                    {
                        ["field"] = "flowState",
                        ["method"] = "in",
                        ["value"] = new JArray{ 0, 1 }
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };

                //五金采购入库
                JArray data = api.GetFormData(null, 3000, null, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string cg_sn = item["cg_sn"].ToString();
                        string dw = item["dw"].ToString();
                        string indate = ToChineseDateTime(item["indate"].ToString());
                        string supplier_no = item["supplier_no"].ToString();
                        string supplier = item["supplier"].ToString();
                        string useto = item["useto"].ToString();
                        JArray m_list = (JArray)item["m_list"];
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string flowState = item["flowState"].ToString();

                        int i = 0;
                        foreach (JToken member in m_list)
                        {
                            i = i + 1;
                            string sno = i.ToString();
                            string warehouse_no = member["warehouse_no"].ToString();
                            string warehouse = member["warehouse"].ToString();
                            string goodsno = member["goodsno"].ToString();
                            string goodsname = member["goodsname"].ToString();
                            string goodsspec = member["goodsspec"].ToString();
                            string goodsunit = member["goodsunit"].ToString();
                            string amount = member["amount"].ToString() == "" ? "0" : member["amount"].ToString();
                            string price = member["price"].ToString() == "" ? "0" : member["price"].ToString();
                            string money = member["money"].ToString() == "" ? "0" : member["money"].ToString();
                            string money_notax = member["money_notax"].ToString() == "" ? "0" : member["money_notax"].ToString();
                            string money_tax = member["money_tax"].ToString() == "" ? "0" : member["money_tax"].ToString();
                            string notes = member["notes"].ToString();
                            HuanaBiz.AddPurchase(tablename, action, cg_sn, sno, dw, indate, supplier_no, supplier, warehouse_no, warehouse, goodsno, goodsname, goodsspec, goodsunit, amount, price
                                , money, money_notax, money_tax, notes, useto, flowState, CreateTime, UpdateTime);
                        }
                    }
                }

                //大宗采购质检后入库
                JArray data1 = api1.GetFormData(null, 3000, null, filter);
                if (data1 != null && data1.Count > 0)
                {
                    foreach (JToken item in data1)
                    {
                        string cg_sn = item["cg_sn"].ToString();
                        string dw = item["dw"].ToString();
                        string indate = ToChineseDateTime(item["indate"].ToString());
                        string supplier_no = item["supplier_no"].ToString();
                        string supplier = item["supplier"].ToString();
                        string useto = item["useto"].ToString();
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string flowState = item["flowState"].ToString();

                        string sno = "1";
                        string warehouse_no = item["warehouse_no"].ToString();
                        string warehouse = item["warehouse"].ToString();
                        string goodsno = item["goodsno"].ToString();
                        string goodsname = item["goodsname"].ToString();
                        string goodsspec = item["goodsspec"].ToString();
                        string goodsunit = item["goodsunit"].ToString();
                        string amount = item["amount"].ToString() == "" ? "0" : item["amount"].ToString();
                        string price = item["price"].ToString() == "" ? "0" : item["price"].ToString();
                        string money = item["money"].ToString() == "" ? "0" : item["money"].ToString();
                        string money_notax = item["money_notax"].ToString() == "" ? "0" : item["money_notax"].ToString();
                        string money_tax = item["money_tax"].ToString() == "" ? "0" : item["money_tax"].ToString();
                        string notes = item["notes"].ToString();
                        HuanaBiz.AddPurchase(tablename, action, cg_sn, sno, dw, indate, supplier_no, supplier, warehouse_no, warehouse, goodsno, goodsname, goodsspec, goodsunit, amount, price
                            , money, money_notax, money_tax, notes, useto, flowState, CreateTime, UpdateTime);
                    }
                }

                //大宗采购入库
                JArray data2 = api2.GetFormData(null, 3000, null, filter);
                if (data2 != null && data2.Count > 0)
                {
                    foreach (JToken item in data2)
                    {
                        string cg_sn = item["cg_sn"].ToString();
                        string dw = item["dw"].ToString();
                        string indate = ToChineseDateTime(item["indate"].ToString());
                        string supplier_no = item["supplier_no"].ToString();
                        string supplier = item["supplier"].ToString();
                        string warehouse_no = item["warehouse_no"].ToString();
                        string warehouse = item["warehouse"].ToString();
                        string useto = item["useto"].ToString();
                        JArray m_list = (JArray)item["m_list"];
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string flowState = item["flowState"].ToString();

                        int i = 0;
                        foreach (JToken member in m_list)
                        {
                            i = i + 1;
                            string sno = i.ToString();
                            string goodsno = member["goodsno"].ToString();
                            string goodsname = member["goodsname"].ToString();
                            string goodsspec = member["goodsspec"].ToString();
                            string goodsunit = member["goodsunit"].ToString();                            string amount = member["amount"].ToString() == "" ? "0" : member["amount"].ToString();
                            string price = member["price"].ToString() == "" ? "0" : member["price"].ToString();
                            string money = member["money"].ToString() == "" ? "0" : member["money"].ToString();
                            string money_notax = member["money_notax"].ToString() == "" ? "0" : member["money_notax"].ToString();
                            string money_tax = member["money_tax"].ToString() == "" ? "0" : member["money_tax"].ToString();
                            string notes = member["notes"].ToString();
                            HuanaBiz.AddPurchase(tablename, action, cg_sn, sno, dw, indate, supplier_no, supplier, warehouse_no, warehouse, goodsno, goodsname, goodsspec, goodsunit, amount, price
                                , money, money_notax, money_tax, notes, useto, flowState, CreateTime, UpdateTime);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                rTxtLog.AppendText(ex.Message);
            }
            finally
            {
            }
        }

        //获取采购退货冲红单api接口,新增数据
        private void AddPurchasethFromApi(string startDate, string endDate)
        {
            string appId = ConfigurationManager.AppSettings["appId_purchasein"].ToString();

            //五金采购退货冲红单
            string entryId = ConfigurationManager.AppSettings["entryId_purchaseth_wj"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            //批量原料退货冲红单
            entryId = ConfigurationManager.AppSettings["entryId_purchaseth_yl"].ToString();
            APIUtils api1 = new APIUtils(appId, entryId, apiKey);

            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray{
                     new JObject
                    {
                        ["field"] = "dw",
                        ["method"] = "in",
                        ["value"] = new JArray{ "广西华纳新材料股份有限公司", "广西合山市华纳新材料科技有限公司", "安徽省宣城市华纳新材料科技有限公司" }
                    },
                    new JObject
                    {
                        ["field"] = "createTime",
                        ["method"] = "range",
                        ["value"] = new JArray { startDate, endDate }
                    },
                    new JObject
                    {
                        ["field"] = "flowState",
                        ["method"] = "in",
                        ["value"] = new JArray{ 0, 1 }
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };

                //五金
                JArray data = api.GetFormData(null, 3000, null, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string cg_sn = "";
                        JArray m_cgsn = (JArray)item["cg_sn"];
                        for (int j = 0; j < m_cgsn.Count; j++)
                        {
                            cg_sn += "," + m_cgsn[j].ToString();
                        }
                        if (!cg_sn.Equals(""))
                            cg_sn = cg_sn.Remove(0, 1);  //去掉第一位

                        string sid = item["sid"].ToString();
                        string options = item["options"].ToString();
                        string dw = item["dw"].ToString();
                        string thdate = ToChineseDateTime(item["thdate"].ToString());
                        string supplier_no = item["supplier_no"].ToString();
                        string supplier = item["supplier"].ToString();
                        JArray m_list = (JArray)item["m_list"];
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string flowState = item["flowState"].ToString();

                        int i = 0;
                        foreach (JToken member in m_list)
                        {
                            i = i + 1;
                            string sno = i.ToString();
                            string warehouse_no = member["warehouse_no"].ToString();
                            string warehouse = member["warehouse"].ToString();
                            string goodsno = member["goodsno"].ToString();
                            string goodsname = member["goodsname"].ToString();
                            string goodsspec = member["goodsspec"].ToString();
                            string goodsunit = member["goodsunit"].ToString();
                            string amount = member["amount"].ToString() == "" ? "0" : member["amount"].ToString();
                            string price = member["price"].ToString() == "" ? "0" : member["price"].ToString();
                            string money = member["money"].ToString() == "" ? "0" : member["money"].ToString();
                            string money_notax = member["money_notax"].ToString() == "" ? "0" : member["money_notax"].ToString();
                            string money_tax = member["money_tax"].ToString() == "" ? "0" : member["money_tax"].ToString();
                            string notes = member["notes"].ToString();
                            HuanaBiz.AddPurchaseth(1, sid, options, cg_sn, sno, dw, thdate, supplier_no, supplier, warehouse_no, warehouse, goodsno, goodsname, goodsspec, goodsunit, amount, price
                                , money, money_notax, money_tax, notes, flowState, CreateTime, UpdateTime);
                        }
                    }
                }

                //批量原料
                JArray data1 = api1.GetFormData(null, 3000, null, filter);
                if (data1 != null && data1.Count > 0)
                {
                    foreach (JToken item in data1)
                    { 
                        string sid = item["sid"].ToString();
                        string options = item["options"].ToString();
                        string dw = item["dw"].ToString();
                        string thdate = ToChineseDateTime(item["thdate"].ToString());
                        string supplier_no = item["supplier_no"].ToString();
                        string supplier = item["supplier"].ToString();
                        JArray m_list = (JArray)item["m_list"];
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string flowState = item["flowState"].ToString();

                        int i = 0;
                        foreach (JToken member in m_list)
                        {
                            i = i + 1;
                            string sno = i.ToString();
                            string cg_sn = member["cg_sn"].ToString();
                            string warehouse_no = member["warehouse_no"].ToString();
                            string warehouse = member["warehouse"].ToString();
                            string goodsno = member["goodsno"].ToString();
                            string goodsname = member["goodsname"].ToString();
                            string goodsspec = member["goodsspec"].ToString();
                            string goodsunit = member["goodsunit"].ToString();
                            string amount = member["amount"].ToString() == "" ? "0" : member["amount"].ToString();
                            string price = member["price"].ToString() == "" ? "0" : member["price"].ToString();
                            string money = member["money"].ToString() == "" ? "0" : member["money"].ToString();
                            string money_notax = member["money_notax"].ToString() == "" ? "0" : member["money_notax"].ToString();
                            string money_tax = member["money_tax"].ToString() == "" ? "0" : member["money_tax"].ToString();
                            string notes = member["notes"].ToString();
                            HuanaBiz.AddPurchaseth(1, sid, options, cg_sn, sno, dw, thdate, supplier_no, supplier, warehouse_no, warehouse, goodsno, goodsname, goodsspec, goodsunit, amount, price
                                , money, money_notax, money_tax, notes, flowState, CreateTime, UpdateTime);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                rTxtLog.AppendText(ex.Message);
            }
            finally
            {
            }
        }

        //获取采购发票(单据)交接记录api接口，新增数据
        private void AddPurchaseInvoicedFromApi(int action, string tablename, bool Isautomatic, string startDate, string endDate)
        {
            string queryField = "createTime";
            if (!Isautomatic)
            {
                queryField = "jsrq";
            }
            else
            {
                if (action == 2)
                    queryField = "updateTime";
                else
                    queryField = "createTime";
            }

            string appId = ConfigurationManager.AppSettings["appId_purchasein"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_purchasein_kp"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray{
                    new JObject
                    {
                        ["field"] = "dw",
                        ["method"] = "in",
                        ["value"] = new JArray{ "广西华纳新材料股份有限公司", "广西合山市华纳新材料科技有限公司", "安徽省宣城市华纳新材料科技有限公司" }
                    },
                    new JObject
                    {
                        ["field"] = queryField,
                        ["method"] = "range",
                        ["value"] = new JArray { startDate, endDate }
                    },
                    new JObject
                    {
                        ["field"] = "flowState",
                        ["method"] = "in",
                        ["value"] = new JArray{ 1 }
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };
                JArray data = api.GetFormData(null, 5000, null, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string sid = item["sid"].ToString();
                        string dw = item["dw"].ToString();
                        string supplier = item["supplier"].ToString();
                        JArray m_list = (JArray)item["m_list"];
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string jsrq = ToChineseDateTime(item["jsrq"].ToString()); //接收日期

                        int i = 0;
                        foreach (JToken member in m_list)
                        {
                            i = i + 1;
                            string sno = i.ToString();
                            string kprq = ToChineseDateTime(member["kprq"].ToString());

                            string cg_sn = member["cg_sn"].ToString();
                            string indate = ToChineseDateTime(member["indate"].ToString());
                            string warehouse = member["warehouse"].ToString();
                            string goodsname = member["goodsname"].ToString();
                            string goodsunit = member["goodsunit"].ToString();
                            string amount = member["amount"].ToString() == "" ? "0" : member["amount"].ToString();
                            string price = member["price"].ToString() == "" ? "0" : member["price"].ToString();
                            string money = member["money"].ToString() == "" ? "0" : member["money"].ToString();
                            string money_notax = member["money_notax"].ToString() == "" ? "0" : member["money_notax"].ToString();
                            string money_tax = member["money_tax"].ToString() == "" ? "0" : member["money_tax"].ToString();
                            string kphm = member["kphm"].ToString();
                            string fplx = member["fplx"].ToString();
                            string options = "";//member["options"].ToString();
                            string notes = member["notes"].ToString();
                            HuanaBiz.AddPurchaseInvoiced(tablename, action, sid, sno, cg_sn, dw, jsrq, supplier, indate, warehouse, goodsname, goodsunit, amount, price, money, money_notax, money_tax, kprq, kphm, fplx, options, notes, CreateTime, UpdateTime);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                rTxtLog.AppendText(ex.Message);
            }
            finally
            {
            }
        }
        
        //删除多余的发货、开票数据
        private void DelExcessiveData(out string reason)
        {
            DateTime currentDate = DateTime.Now;
            int currentYear = currentDate.Year;
            int currentPeriod = currentDate.Month;
            if (currentDate.Day <7 )
            {
                currentYear = currentDate.AddMonths(-1).Year;
                currentPeriod = currentDate.AddMonths(-1).Month;
            }

            reason = "";
            try
            {
                HuanaBiz.DelExcessiveData(currentYear,currentPeriod);
            }
            catch (Exception ex)
            {
                reason = ex.Message;
            }
            finally
            {
            }
        }


        private void Main_Load(object sender, EventArgs e)
        {
            DateTime currentDate = DateTime.Now;
            int currentYear = currentDate.Year;
            int currentPeriod = currentDate.Month;
            if (currentDate.Day < 7)
            {
                currentYear = currentDate.AddMonths(-1).Year;
                currentPeriod = currentDate.AddMonths(-1).Month;
            }
            cmbYear.SelectedItem = currentYear.ToString();
            cmbmonth.SelectedItem = currentPeriod.ToString();

            DateTime time = DateTime.Now;
            Console.WriteLine(time.Day);
            //当月第一天
            Console.WriteLine(time.AddDays(1 - time.Day));
            //当月最后一天
            Console.WriteLine(time.AddDays(1 - time.Day).AddMonths(1).AddDays(-1));
            //下月第一天
            Console.WriteLine(time.AddDays(1 - time.Day).AddMonths(1));
            //下月最后一天
            Console.WriteLine(time.AddDays(1 - time.Day).AddMonths(2).AddDays(-1));

            //string str1 = "data source=36.134.167.252;initial catalog=MakeT+Voucher;persist security info=True;user id=jiandaoyun;password=hnx2022.;packet size=8192;connection timeout=60;";
            //Console.WriteLine(HuanaBiz.EncodeBase64(str1));  //64位加密
        }

        private void btnQuit_Click(object sender, EventArgs e)
        {
            Application.Exit();
            if (txtQuitPassword.Text == "666888")
            {
                Application.Exit();
            }
            else
            {
                MessageBox.Show("退出密码输入错误，无法退出", "提示");
            }
        }

        private void Main_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("你确定要退出系统?", "警告", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning) == DialogResult.OK)
            {
                if (txtQuitPassword.Text == "666888")
                {
                    e.Cancel = false;
                }
                else
                {
                    MessageBox.Show("退出密码输入错误，无法退出", "提示");
                    e.Cancel = true;
                }
            }
            else
                e.Cancel = true;
        }

        private void timerHandle_Tick(object sender, EventArgs e)
        {
            DateTime currentDate = DateTime.Now;
            DateTime lastDate = currentDate.AddDays(1 - currentDate.Day).AddMonths(1).AddDays(-1); //当月最后一天
            string startDate = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd");
            string endDate = DateTime.Now.ToString("yyyy-MM-dd");

            if (currentDate.ToLongTimeString() == "13:00:00" || currentDate.ToLongTimeString() == "19:00:00")
            {
                this.AddSaleDetailFromApi(1, "sale_fh", true, startDate, endDate);
                rTxtLog.AppendText("\n销售发货单（产成品）录入，" + currentDate.ToString());
            }
            else if (currentDate.ToLongTimeString() == "13:10:00" || currentDate.ToLongTimeString() == "19:10:00")
            {
                this.AddSaleDetailFromApi(2, "sale_fh", true, startDate, endDate);
            }
            else if (currentDate.ToLongTimeString() == "13:20:00" || currentDate.ToLongTimeString() == "19:20:00")
            {
                this.GetSaleReturnFromApi(startDate, endDate);
            }
            //else if (currentDate.ToLongTimeString() == "13:30:00" || currentDate.ToLongTimeString() == "19:30:00")
            //{
            //    this.AddInvoicedFromApi(1, "tb_invoiced", true, startDate, endDate);
            //    rTxtLog.AppendText("\n开增值税发票录入，" + currentDate.ToString());
            //}
            //else if (currentDate.ToLongTimeString() == "13:40:00" || currentDate.ToLongTimeString() == "19:40:00")
            //{
            //    this.AddInvoicedFromApi(2, "tb_invoiced", true, startDate, endDate);
            //}
            else if (currentDate.ToLongTimeString() == "13:50:00" || currentDate.ToLongTimeString() == "19:50:00")
            {
                this.AddPurchaseFromApi(1, "purchase_in", true, startDate, endDate);
                rTxtLog.AppendText("\n采购入库单-录入，" + currentDate.ToString());
            }
            else if (currentDate.ToLongTimeString() == "14:00:00" || currentDate.ToLongTimeString() == "20:00:00")
            {
                this.AddPurchaseFromApi(2, "purchase_in", true, startDate, endDate);
            }
            //else if (currentDate.ToLongTimeString() == "14:10:00" || currentDate.ToLongTimeString() == "20:10:00")
            //{
            //    this.AddPurchaseInvoicedFromApi(1, "purchase_invoiced", true, startDate, endDate);
            //    rTxtLog.AppendText("\n采购开票-录入，" + currentDate.ToString());
            //}
            //else if (currentDate.ToLongTimeString() == "14:20:00" || currentDate.ToLongTimeString() == "20:20:00")
            //{
            //    this.AddPurchaseInvoicedFromApi(2, "purchase_invoiced", true, startDate, endDate);
            //}
            else if (currentDate.ToLongTimeString() == "14:30:00" || currentDate.ToLongTimeString() == "20:30:00")
            {
                this.AddPurchasethFromApi(startDate, endDate);
            }
            else if (currentDate.ToLongTimeString() == "14:40:00" || currentDate.ToLongTimeString() == "20:40:00")
            {
                this.AddSalePcFromApi(startDate, endDate);
            }
            else if (currentDate.ToLongTimeString() == "14:50:00" || currentDate.ToLongTimeString() == "20:50:00")
            {
                this.AddSaleStockPriceFromApi(startDate, endDate);
            }

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string startDate, endDate;
            startDate = dtStart.Text;
            endDate = dtEnd.Text;

            if (cmbFormName.Text.Trim() == "")
            {
                MessageBox.Show("请从下拉框选择简道云表单", "警告", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            string reason = "";
            if (cmbFormName.Text == "销售发货单-录入")
            {
                this.AddSaleDetailFromApi(1, "sale_fh", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "销售发货单-修改")
            {
                this.AddSaleDetailFromApi(2, "sale_fh", false, startDate, endDate);
            }
            else if (cmbFormName.Text == "销售发货单-月录入")
            {
                this.AddSaleDetailFromApi(1, "sale_fhtemp", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "销售退货单")
            {
                this.GetSaleReturnFromApi(startDate, endDate);
            }
            else if (cmbFormName.Text == "开增值税发票-录入")
            {
                this.AddInvoicedFromApi(1, "tb_invoiced", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "开增值税发票-修改")
            {
                this.AddInvoicedFromApi(2, "tb_invoiced", false, startDate, endDate);
            }
            else if (cmbFormName.Text == "开增值税发票-月录入")
            {
                this.AddInvoicedFromApi(1, "tb_invoicedtemp", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "删除多余的数据")
            {
                this.DelExcessiveData(out reason);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "磅差处理单-录入")
            {
                this.AddSalePcFromApi(startDate, endDate);
            }
            else if (cmbFormName.Text == "往月库存商品单价-录入")
            {
                this.AddSaleStockPriceFromApi(startDate, endDate);
            }
            else if (cmbFormName.Text == "采购入库单-录入")
            {
                this.AddPurchaseFromApi(1, "purchase_in", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "采购入库单-修改")
            {
                this.AddPurchaseFromApi(2, "purchase_in", false, startDate, endDate);
            }
            else if (cmbFormName.Text == "采购入库单-月录入")
            {
                this.AddPurchaseFromApi(1, "purchase_intemp", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "采购开票-录入")
            {
                this.AddPurchaseInvoicedFromApi(1, "purchase_invoiced", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);            }
            else if (cmbFormName.Text == "采购开票-修改")
            {
                this.AddPurchaseInvoicedFromApi(2, "purchase_invoiced", false, startDate, endDate);
            }
            else if (cmbFormName.Text == "采购开票-月录入")
            {
                this.AddPurchaseInvoicedFromApi(1, "purchase_invoicedtemp", false, startDate, endDate);
            }
            else if (cmbFormName.Text == "采购退货冲红-录入")
            {
                this.AddPurchasethFromApi(startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        
        //按下拉框项目顺序，运行程序
        private void button2_Click(object sender, EventArgs e)
        {
            string accountyear = cmbYear.Text.Trim();
            string accountperiod = cmbmonth.Text.Trim();
            string title = cmbT.Text.Trim();
            

            if (accountyear=="" || accountperiod=="")
            {
                MessageBox.Show("请选择凭证会计期间", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            if (title == "")
            {
                MessageBox.Show("请选择相应的T+凭证", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            if (title == "销售-有凭证冲红重开票" || title == "销售-无凭证冲红重开票" || title == "销售-无凭证冲红不开票")
            {
                if (txtCustomer.Text.Trim()=="")
                {
                    MessageBox.Show("推送冲红凭证，请输入客户名称", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    txtCustomer.Focus();
                    return;
                }
            }

                //string storedprocedure = "WriteOffNotinvoiced";
            if (title== "销售-冲销上月暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec WriteOffNotinvoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec ah_WriteOffNotinvoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec hs_WriteOffNotinvoiced " + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
            else if (title == "销售-有凭证冲红重开票")
            {
                Dbsql.ExecuteSql("exec WriteOffInvoiced '" + txtCustomer.Text + "'," + accountyear + "," + accountperiod);
                //Dbsql.ExecuteSql("exec ah_WriteOffInvoiced '" + txtCustomer.Text + "'," + accountyear + "," + accountperiod);
                //Dbsql.ExecuteSql("exec hs_WriteOffInvoiced '" + txtCustomer.Text + "'," + accountyear + "," + accountperiod);
                MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (title == "销售-无凭证冲红重开票")
            {
                Dbsql.ExecuteSql("exec WriteOffInvoiced_kai '" + txtCustomer.Text + "'," + accountyear + "," + accountperiod);
                MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (title == "销售-无凭证冲红不开票")
            {
                Dbsql.ExecuteSql("exec WriteOffInvoiced_nokai '" + txtCustomer.Text + "'," + accountyear + "," + accountperiod);
                MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (title == "销售-当月发货当月开票")
            {
                try
                {
                    Dbsql.ExecuteSql("exec InvoicedTwo " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec Invoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec ah_Invoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec hs_Invoiced " + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
            else if (title == "销售-当月未开票暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec Notinvoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec ah_Notinvoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec hs_Notinvoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec Notinvoiced_zhekou " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec InsertGiveAndPc 0,''," + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
            else if (title == "采购五金-冲销上月暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec cg_wj_WriteOffNotinvoicedTwo " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wj_WriteOffNotinvoicedTwo_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wj_WriteOffNotinvoicedTwo_hs " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wj_WriteOffNotinvoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wj_WriteOffNotinvoiced_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wj_WriteOffNotinvoiced_hs " + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
            else if (title == "采购五金-当月入库当月开票")
            {
                try
                {
                    Dbsql.ExecuteSql("exec cg_wj_Invoiced " + accountyear + "," + accountperiod); 
                    Dbsql.ExecuteSql("exec cg_wj_Invoiced_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wj_Invoiced_hs " + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
            else if (title == "零星采购-当月入库当月开票")
            {
                try
                {
                    Dbsql.ExecuteSql("exec cg_wjlxcg_Invoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wjlxcg_Invoiced_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wjlxcg_Invoiced_hs " + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
            else if (title == "采购五金-当月未开票暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec cg_wj_Notinvoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wj_Notinvoiced_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wj_Notinvoiced_hs " + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
            else if (title == "零星采购-当月未开票暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec cg_wjlxcg_NotInvoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wjlxcg_NotInvoiced_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_wjlxcg_NotInvoiced_hs " + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
            else if (title == "采购原料-冲销上月暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec cg_yl_WriteOffNotinvoicedTwo " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_WriteOffNotinvoicedTwo_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_WriteOffNotinvoicedTwo_hs " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_WriteOffNotinvoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_WriteOffNotinvoiced_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_WriteOffNotinvoiced_hs " + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
            else if (title == "采购原料-当月入库当月开票")
            {
                try
                {
                    Dbsql.ExecuteSql("exec cg_yl_InvoicedTwo " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_InvoicedTwo_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_InvoicedTwo_hs " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_Invoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_Invoiced_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_Invoiced_hs " + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
            else if (title == "采购原料-当月未开票暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec cg_yl_Notinvoiced " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_Notinvoiced_ah " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec cg_yl_Notinvoiced_hs " + accountyear + "," + accountperiod);
                    MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    rTxtLog.AppendText(ex.Message);
                }
                finally
                {
                }
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            if (cmbFormName.Text.Trim() == "")
            {
                MessageBox.Show("请选择简道云表单", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            string tablename = "";
            if (cmbFormName.Text == "销售发货单-月录入")
                tablename = "sale_fhtemp";
            else if (cmbFormName.Text == "开增值税发票-月录入")
                tablename = "tb_invoicedtemp";
            else if (cmbFormName.Text == "采购入库单-月录入")
                tablename = "purchase_intemp";
            else if (cmbFormName.Text == "采购开票-月录入")
                tablename = "purchase_invoicedtemp";


            Dbsql.ExecuteSql("truncate table "+tablename);
        }
    }
}

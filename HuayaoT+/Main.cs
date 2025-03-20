using Newtonsoft.Json.Linq;
using System;
using System.Configuration;
using System.Windows.Forms;
using JiandaoyunAPI;

namespace HuayaoT
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

        //获取华耀石场销售出库单
        private void AddSaleDetailFromApi(int action, string tablename, bool Isautomatic, string startDate, string endDate)
        {
            string queryField = "createTime";
            if (!Isautomatic)
            {
                queryField = "zcsj";
            }
            else
            {
                if (action == 2)
                    queryField = "updateTime";
                else
                    queryField = "createTime";
            }

            string appId = ConfigurationManager.AppSettings["appId_huayaofh"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_huayaofh"].ToString();
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
                    }
                     ,
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
                        string dw = item["dw"].ToString();
                        string division = item["division"].ToString();
                        string customer_type = item["customer_type"].ToString();
                        string customer = item["customer"].ToString();
                        string zcsj = ToChineseDateTime(item["zcsj"].ToString());
                        string kcsj = ToChineseDateTime(item["kcsj"].ToString());
                        string carno = item["carno"].ToString();
                        string goodsname = item["goodsname"].ToString();
                        string amount_mao = item["amount_mao"].ToString() == "" ? "0" : item["amount_mao"].ToString();
                        string amount_pi = item["amount_pi"].ToString() == "" ? "0" : item["amount_pi"].ToString();
                        string amount_jing = item["amount_jing"].ToString() == "" ? "0" : item["amount_jing"].ToString();
                        string price = item["price"].ToString() == "" ? "0" : item["price"].ToString();
                        string money = item["money"].ToString() == "" ? "0" : item["money"].ToString();
                        string amount_hd = item["amount_hd"].ToString() == "" ? "0" : item["amount_hd"].ToString();
                        string hdrq = ToChineseDateTime(item["hdrq"].ToString());
                        string amount_pc = item["amount_pc"].ToString() == "" ? "0" : item["amount_pc"].ToString();
                        string notes = item["notes"].ToString();
                        string notes_hd = item["notes_hd"].ToString();
                        string ys_qyyfdj = item["ys_qyyfdj"].ToString() == "" ? "0" : item["ys_qyyfdj"].ToString();
                        string ys_qyyfje = item["ys_qyyfje"].ToString() == "" ? "0" : item["ys_qyyfje"].ToString();
                        string price_material = item["price_material"].ToString() == "" ? "0" : item["price_material"].ToString();
                        string money_material = item["money_material"].ToString() == "" ? "0" : item["money_material"].ToString();
                        string yf_sjyfdj = item["yf_sjyfdj"].ToString() == "" ? "0" : item["yf_sjyfdj"].ToString();
                        string yf_sjyfje = item["yf_sjyfje"].ToString() == "" ? "0" : item["yf_sjyfje"].ToString();
                        string money_material_k = item["money_material_k"].ToString() == "" ? "0" : item["money_material_k"].ToString();
                        string flowState = item["flowState"].ToString();
                        string createTime = ToChineseDateTime(item["createTime"].ToString());
                        string updateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string yfjsfs = item["yfjsfs"].ToString();
                        HuanaBiz.AddSaleDetail(tablename, action, id, xs_sn, dw, division, customer_type, customer, zcsj, kcsj, carno, goodsname, amount_mao, amount_pi, amount_jing, price, money, amount_hd, hdrq, amount_pc,
                            notes, notes_hd, ys_qyyfdj, ys_qyyfje, price_material, money_material, yf_sjyfdj, yf_sjyfje, money_material_k, flowState, createTime, updateTime, yfjsfs);
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

        //获取上角山石场销售出库单
        private void AddSaleDetailFromApi_sjs(int action, string tablename, bool Isautomatic, string startDate, string endDate)
        {
            string queryField = "createTime";
            if (!Isautomatic)
            {
                queryField = "zcsj";
            }
            else
            {
                if (action == 2)
                    queryField = "updateTime";
                else
                    queryField = "createTime";
            }

            string appId = ConfigurationManager.AppSettings["appId_huayaofh"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_huayaofh_sjs"].ToString();
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
                    }
                    //  ,
                    //new JObject
                    //{
                    //    ["field"] = "notes",
                    //    ["method"] = "in",
                    //    ["value"] = new JArray {"华耀" }
                    //}
                     ,
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
                        string dw = item["dw"].ToString();
                        string division = item["division"].ToString();
                        string customer_type = item["customer_type"].ToString();
                        string customer = item["customer"].ToString();
                        string zcsj = ToChineseDateTime(item["zcsj"].ToString());
                        string kcsj = ToChineseDateTime(item["kcsj"].ToString());
                        string carno = item["carno"].ToString();
                        string goodsname = item["goodsname"].ToString();
                        string amount_mao = item["amount_mao"].ToString() == "" ? "0" : item["amount_mao"].ToString();
                        string amount_pi = item["amount_pi"].ToString() == "" ? "0" : item["amount_pi"].ToString();
                        string amount_jing = item["amount_jing"].ToString() == "" ? "0" : item["amount_jing"].ToString();
                        string price = item["price"].ToString() == "" ? "0" : item["price"].ToString();
                        string money = item["money"].ToString() == "" ? "0" : item["money"].ToString();
                        string amount_hd = item["amount_hd"].ToString() == "" ? "0" : item["amount_hd"].ToString();
                        string hdrq = ToChineseDateTime(item["hdrq"].ToString());
                        string amount_pc = item["amount_pc"].ToString() == "" ? "0" : item["amount_pc"].ToString();
                        string notes = item["notes"].ToString();
                        string notes_hd = item["notes_hd"].ToString();
                        string ys_qyyfdj = item["ys_qyyfdj"].ToString() == "" ? "0" : item["ys_qyyfdj"].ToString();
                        string ys_qyyfje = item["ys_qyyfje"].ToString() == "" ? "0" : item["ys_qyyfje"].ToString();
                        string price_material = item["price_material"].ToString() == "" ? "0" : item["price_material"].ToString();
                        string money_material = item["money_material"].ToString() == "" ? "0" : item["money_material"].ToString();
                        string yf_sjyfdj = item["yf_sjyfdj"].ToString() == "" ? "0" : item["yf_sjyfdj"].ToString();
                        string yf_sjyfje = item["yf_sjyfje"].ToString() == "" ? "0" : item["yf_sjyfje"].ToString();
                        string money_material_k = item["money_material_k"].ToString() == "" ? "0" : item["money_material_k"].ToString();
                        string flowState = item["flowState"].ToString();
                        string createTime = ToChineseDateTime(item["createTime"].ToString());
                        string updateTime = ToChineseDateTime(item["updateTime"].ToString());
                        string yfjsfs = item["yfjsfs"].ToString();
                        HuanaBiz.AddSaleDetail(tablename, action, id, xs_sn, dw, division, customer_type, customer, zcsj, kcsj, carno, goodsname, amount_mao, amount_pi, amount_jing, price, money, amount_hd, hdrq, amount_pc,
                            notes, notes_hd, ys_qyyfdj, ys_qyyfje, price_material, money_material, yf_sjyfdj, yf_sjyfje, money_material_k, flowState, createTime, updateTime, yfjsfs);
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

            string appId = ConfigurationManager.AppSettings["appId_huayaofh"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_huayaoInvoiced"].ToString();
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
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };
                JArray data = api.GetFormData(null, 10000, null, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string id = item["sid"].ToString();  //流水号
                        string dw = item["dw"].ToString();
                        string xs_sn = item["xs_sn"].ToString();
                        string kprq = ToChineseDateTime(item["kprq"].ToString());
                        string kphm = item["kphm"].ToString(); 
                        string customer = item["customer"].ToString();
                        string customer_period = item["customer_period"].ToString();
                        string fhrq = ToChineseDateTime(item["fhrq"].ToString());
                        string goodsname = item["goodsname"].ToString();
                        string amount = item["amount"].ToString() == "" ? "0" : item["amount"].ToString();
                        string price = item["price"].ToString() == "" ? "0" : item["price"].ToString();
                        string money = item["money"].ToString() == "" ? "0" : item["money"].ToString();
                        string money_notax = item["money_notax"].ToString() == "" ? "0" : item["money_notax"].ToString();
                        string money_tax = item["money_tax"].ToString() == "" ? "0" : item["money_tax"].ToString();
                        string price_avg = item["price_avg"].ToString() == "" ? "0" : item["price_avg"].ToString();
                        string amount_pc = item["amount_pc"].ToString() == "" ? "0" : item["amount_pc"].ToString();
                        string money_pc = item["money_pc"].ToString() == "" ? "0" : item["money_pc"].ToString();
                        string n_kprq = ToChineseDateTime(item["n_kprq"].ToString());
                        string n_kphm = item["n_kphm"].ToString();
                        string kpdw = item["kpdw"].ToString();
                        string options = item["options"].ToString();
                        string CreateTime = ToChineseDateTime(item["createTime"].ToString());
                        string UpdateTime = ToChineseDateTime(item["updateTime"].ToString());
                        HuanaBiz.AddInvoiced(tablename, action, id, dw, xs_sn, kprq, kphm, customer, customer_period, fhrq, goodsname, amount, price, money, money_notax, money_tax
                            ,price_avg, amount_pc, money_pc, n_kprq, n_kphm, kpdw, options, CreateTime, UpdateTime);
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
        private void DelExcessiveData()
        {
            DateTime currentDate = DateTime.Now;
            int currentYear = currentDate.Year;
            int currentPeriod = currentDate.Month;
            if (currentDate.Day < 10)
            {
                currentYear = currentDate.AddMonths(-1).Year;
                currentPeriod = currentDate.AddMonths(-1).Month;
            }

            try
            {

                HuanaBiz.DelExcessiveData(currentYear, currentPeriod);
            }
            catch (Exception ex)
            {
                rTxtLog.AppendText(ex.Message);
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

            //string str1 = "data source=120.77.220.175;initial catalog=MakeT+Voucher;persist security info=True;user id=jiandaoyun;password=hnx2022.;packet size=8192;connection timeout=60;";
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

            if (currentDate.ToLongTimeString() == "13:00:00" || currentDate.ToLongTimeString() == "20:00:00")
            {
                this.AddSaleDetailFromApi(1, "huayao_fh", true, startDate, endDate);
                rTxtLog.AppendText("\n华耀出库单录入，" + currentDate.ToString());
            }
            else if (currentDate.ToLongTimeString() == "13:40:00" || currentDate.ToLongTimeString() == "20:30:00")
            {
                this.AddSaleDetailFromApi(2, "huayao_fh", true, startDate, endDate);
            }
            else if (currentDate.ToLongTimeString() == "13:20:00" || currentDate.ToLongTimeString() == "20:10:00")
            {
                this.AddSaleDetailFromApi_sjs(1, "sjs_fh", true, startDate, endDate);
                rTxtLog.AppendText("\n上角山出库单-录入，" + currentDate.ToString());
            }
            else if (currentDate.ToLongTimeString() == "13:30:00" || currentDate.ToLongTimeString() == "20:20:00")
            {
                this.AddSaleDetailFromApi_sjs(2, "sjs_fh", true, startDate, endDate);
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

            if (cmbFormName.Text == "华耀出库单-录入")
            {
                this.AddSaleDetailFromApi(1, "huayao_fh", false, startDate, endDate);
                //this.AddSaleDetailFromApi_sjs(1, "huayao_fh", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "华耀出库单-修改")
            {
                this.AddSaleDetailFromApi(2, "huayao_fh", false, startDate, endDate);
                this.AddSaleDetailFromApi_sjs(2, "huayao_fh", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            if (cmbFormName.Text == "上角山出库单-录入")
            {
                this.AddSaleDetailFromApi_sjs(1, "sjs_fh", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "上角山出库单-修改")
            {
                this.AddSaleDetailFromApi_sjs(2, "sjs_fh", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "增值税开票-录入")
            {
                this.AddInvoicedFromApi(1, "huayao_invoiced", false, startDate, endDate);
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (cmbFormName.Text == "删除多余的数据")
            {
                this.DelExcessiveData();
                MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btGetPeriod_Click(object sender, EventArgs e)
        {
            string startDate, endDate;
            startDate = dtStart.Text;
            endDate = dtEnd.Text;

            this.AddSaleDetailFromApi(1, "huayao_fhtemp", false, startDate, endDate);
            this.AddSaleDetailFromApi_sjs(1, "huayao_fhtemp", false, startDate, endDate);

            MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void btClear_Click(object sender, EventArgs e)
        {
            Dbsql.ExecuteSql("truncate table huayao_fhtemp"); //清空目标表
        }

        //按下拉框项目顺序，运行程序
        private void button2_Click(object sender, EventArgs e)
        {
            string accountyear = cmbYear.Text.Trim();
            string accountperiod = cmbmonth.Text.Trim();
            string title = cmbT.Text.Trim();


            if (accountyear == "" || accountperiod == "")
            {
                MessageBox.Show("请选择凭证会计期间", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            if (title == "")
            {
                MessageBox.Show("请选择相应的T+凭证", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            if (title == "销售-冲销上月暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec huayao_WriteOffNotinvoiced_gr " + accountyear + "," + accountperiod);  //个人
                    Dbsql.ExecuteSql("exec huayao_WriteOffNotinvoiced_one " + accountyear + "," + accountperiod); //一票制
                    Dbsql.ExecuteSql("exec huayao_WriteOffNotinvoiced_two " + accountyear + "," + accountperiod);  //两票制
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
            else if (title == "销售-当月发货当月开票")
            {
                Dbsql.ExecuteSql("exec huayao_Invoice " + accountyear + "," + accountperiod);
                MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (title == "销售-当月未开票暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec huayao_Notinvoiced_gr " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec huayao_Notinvoiced_one " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec huayao_Notinvoiced_two " + accountyear + "," + accountperiod);
                    Dbsql.ExecuteSql("exec huayao_Notinvoiced_period " + accountyear + "," + accountperiod);  //分段暂估
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
            if (title == "路畅-冲销上月暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec luchang_WriteOffNotinvoiced " + accountyear + "," + accountperiod);  //个人
                    Dbsql.ExecuteSql("exec huayao_WriteOffNotinvoiced_one " + accountyear + "," + accountperiod); //一票制
                    Dbsql.ExecuteSql("exec huayao_WriteOffNotinvoiced_two " + accountyear + "," + accountperiod);  //两票制
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
            else if (title == "路畅-当月发货当月开票")
            {
                Dbsql.ExecuteSql("exec luchang_Invoiced " + accountyear + "," + accountperiod);
                MessageBox.Show("推送T+凭证成功：" + title, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else if (title == "路畅-当月未开票暂估")
            {
                try
                {
                    Dbsql.ExecuteSql("exec luchang_Notinvoiced_period " + accountyear + "," + accountperiod);  //分段暂估
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
    }
}

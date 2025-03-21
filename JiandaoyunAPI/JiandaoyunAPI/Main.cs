using Newtonsoft.Json.Linq;
using System;
using System.Configuration;
using System.Windows.Forms;

namespace JiandaoyunAPI
{
    public partial class Main : Form
    {
        public string apiKey = ConfigurationManager.AppSettings["apiKey"].ToString();
        public Main()
        {
            InitializeComponent();
        }

        //UTC时间转换为北京时间
        private string ToChineseDateTime(string UTCdatetime)
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
        private string GetOrgName(string Fullname)
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

        //获取员工入职档案api接口数据，写入员工表
        private void GetEmployeeFromApi(out string reason)
        {
            string appId = ConfigurationManager.AppSettings["appId_employee"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_employee"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            reason = "";
            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray{
                    new JObject
                    {
                        ["field"] = "dw",
                        ["method"] = "in",
                        ["value"] = new JArray{ "广西华纳新材料股份有限公司", "广西合山市华纳新材料科技有限公司", "安徽省宣城市华纳新材料科技有限公司" }
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };
                JArray data = api.GetFormData(null, 1000, null, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string OrgName = item["dw"].ToString();
                        string Department = item["bm"].ToString();
                        string EmployeeNo = item["gh"].ToString();
                        string FullName = item["xm"].ToString();
                        string Sex = item["xb"].ToString();
                        string IDNo = item["sfzhm"].ToString();
                        string BirthDate = this.ToChineseDateTime(item["csnyr"].ToString());
                        string Education = item["zgxl"].ToString();
                        string Speciality = item["sxzy"].ToString();
                        string Station = item["zw"].ToString();
                        string EmployeeType = item["yglx"].ToString();
                        string EntryDate = this.ToChineseDateTime(item["rzrq"].ToString());
                        string QuitDate = this.ToChineseDateTime(item["lzrq"].ToString());
                        string Status = item["ygzt"].ToString();
                        HuanaBiz.AddEmployee(GetOrgName(OrgName), Department, EmployeeNo, FullName, Sex, IDNo, BirthDate, Education, Speciality, Station, EmployeeType, EntryDate, QuitDate, Status);
                    }
                }
            }
            catch (Exception ex)
            {
                reason = ex.Message;
            }
            finally
            {
            }
        }

        //获取请假api接口数据，写入请假表
        private void GetLeaveFromApi(string startDate, string endDate)
        {
            string appId = ConfigurationManager.AppSettings["appId_leave"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_leave"].ToString();
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
                        ["method"] = "eq",
                        ["value"] = 1
                    }
                }; 
                 JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };
                JArray fields = new JArray { "gh", "xm", "dw", "bm", "lx", "ly", "createTime", "m_list", "kssj", "jssj", "qjts", "ksxs", "flowState" };
                JArray data = api.GetFormData(null, 2000, fields, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string EmployeeNo = item["gh"].ToString();
                        string FullName = item["xm"]["name"].ToString();
                        string OrgName = item["dw"].ToString();
                        string Department = item["bm"].ToString();
                        string LeaveType = item["lx"].ToString();
                        string Reason = item["ly"].ToString();
                        string createTime = this.ToChineseDateTime(item["createTime"].ToString());
                        foreach (JToken list in (JArray)item["m_list"])
                        {
                            if (this.ToChineseDateTime(list["kssj"].ToString()) != "null")
                            {
                                string st = this.ToChineseDateTime(list["kssj"].ToString());
                                string Days = string.IsNullOrEmpty(list["qjts"].ToString()) ? "0" : list["qjts"].ToString();
                                string ksxs = string.IsNullOrEmpty(list["ksxs"].ToString()) ? "08:00:00" : list["ksxs"].ToString().Substring(0, 2)+ ":00:00";
                                string starttime = "'" + Convert.ToDateTime(st.Replace("'", "")).ToShortDateString() + " " + ksxs + "'";
                                string endtime = this.ToChineseDateTime(list["jssj"].ToString());
                                HuanaBiz.AddLeave(GetOrgName(OrgName), Department, EmployeeNo, FullName, LeaveType, starttime, endtime, Days, Reason, createTime);
                            }
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

        //获取项目申请api接口数据，写入项目表
        private void GetProjectsFromApi(out string reason)
        {
            string startDate = DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd"); ;
            string endDate = DateTime.Now.ToString("yyyy-MM-dd");

            string appId = ConfigurationManager.AppSettings["appId_project"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_project"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            reason = "";
            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray
                {
                    new JObject
                    {
                        ["field"] = "createTime",
                        ["method"] = "range",
                        ["value"] = new JArray { startDate,endDate }
                    },
                    new JObject
                    {
                        ["field"] = "flowState",
                        ["method"] = "eq",
                        ["value"] = 1
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };
                JArray fields = new JArray { "flowState", "xmbh", "dw", "xmmc", "kssj", "jssj", "xmfzr", "xmzzz", "xmzcy", "createTime" };
                JArray data = api.GetFormData(null, 1000, fields, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string ProjectNo = String.IsNullOrEmpty(item["xmbh"].ToString()) ? "" : item["xmbh"].ToString();
                        string ProjectName = item["xmmc"].ToString();
                        string OrgName = item["dw"].ToString();
                        string StartDate = this.ToChineseDateTime(item["kssj"].ToString());
                        string EndDate = this.ToChineseDateTime(item["jssj"].ToString());
                        string Charger = item["xmfzr"]["name"].ToString();
                        string GroupLeader = item["xmzzz"]["name"].ToString();
                        string CreateTime = this.ToChineseDateTime(item["createTime"].ToString());
                        JArray xmzycy_list = (JArray)item["xmzcy"];
                        HuanaBiz.AddProjects(ProjectNo, ProjectName, GetOrgName(OrgName), StartDate, EndDate, Charger, GroupLeader, xmzycy_list, CreateTime);
                    }
                }
            }
            catch (Exception ex)
            {
                reason = ex.Message;
            }
            finally
            {
            }
        }

        //获取研发试产单api接口数据，写入项目试产人员表
        private void GetProjectTestMembersFromApi(out string reason)
        {
            string startDate = DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd"); ;
            string endDate = DateTime.Now.ToString("yyyy-MM-dd");

            string appId = ConfigurationManager.AppSettings["appId_projectTest"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_projectTest"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            reason = "";
            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray
                {
                    new JObject
                    {
                        ["field"] = "createTime",
                        ["method"] = "range",
                        ["value"] = new JArray { startDate,endDate }
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };
                JArray fields = new JArray { "flowState", "xmbh", "xmmc", "sccpmc", "kssj", "jssj", "xmfzr", "zscybm_list", "sccyry_list", "createTime" };
                JArray data = api.GetFormData(null, 1000, fields, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string ProjectNo = item["xmbh"].ToString();
                        string ProductName = item["sccpmc"].ToString();
                        string StartDate = this.ToChineseDateTime(item["kssj"].ToString());
                        string EndDate = this.ToChineseDateTime(item["jssj"].ToString());
                        string CreateTime = this.ToChineseDateTime(item["createTime"].ToString());
                        foreach (JToken member in (JArray)item["sccyry_list"])
                        {
                            string FullName = member["name"].ToString(); //姓名
                            HuanaBiz.AddProjectTestMembers(ProjectNo, ProductName, FullName, StartDate, EndDate, CreateTime);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                reason = ex.Message;
            }
            finally
            {
            }
        }

        //获取项目变更计划书api接口数据
        private void ProjectChangeFromApi(out string reason)
        {
            string startDate = DateTime.Now.AddDays(-10).ToString("yyyy-MM-dd"); ;
            string endDate = DateTime.Now.ToString("yyyy-MM-dd");

            string appId = ConfigurationManager.AppSettings["appId_projectChange"].ToString();
            string entryId = ConfigurationManager.AppSettings["entryId_projectChange"].ToString();
            APIUtils api = new APIUtils(appId, entryId, apiKey);

            reason = "";
            try
            {
                // 按条件获取表单内容
                JArray cond = new JArray
                {
                    new JObject
                    {
                        ["field"] = "updateTime",
                        ["method"] = "range",
                        ["value"] = new JArray { startDate,endDate }
                    },
                    new JObject
                    {
                        ["field"] = "flowState",
                        ["method"] = "eq",
                        ["value"] = 1
                    }
                };
                JObject filter = new JObject
                {
                    ["rel"] = "and",
                    ["cond"] = cond
                };
                JArray fields = new JArray { "flowState", "xmbh", "dw", "xmmc", "change_date", "change_count", "change_options", "xmmc_old", "xmmc_new", "kssj_old", "kssj_new",
                    "jssj_old", "jssj_new", "xmfzr_old", "xmfzr_new", "xmzycy_list"};
                JArray data = api.GetFormData(null, 1000, fields, filter);
                if (data != null && data.Count > 0)
                {
                    foreach (JToken item in data)
                    {
                        string ProjectNo = String.IsNullOrEmpty(item["xmbh"].ToString()) ? "" : item["xmbh"].ToString();
                        string ProjectName = item["xmmc"].ToString();
                        string OrgName = item["dw"].ToString();
                        string ChangeDate = this.ToChineseDateTime(item["change_date"].ToString());
                        string ChangeCount = item["change_count"].ToString();
                        string ChangeOptions = "";
                        string ProjectName_old = item["xmmc_old"].ToString();
                        string ProjectName_new = item["xmmc_new"].ToString();
                        string StartDate_old = this.ToChineseDateTime(item["kssj_old"].ToString());
                        string StartDate_new = this.ToChineseDateTime(item["kssj_new"].ToString());
                        string EndDate_old = this.ToChineseDateTime(item["jssj_old"].ToString());
                        string EndDate_new = this.ToChineseDateTime(item["jssj_new"].ToString());
                        string Charger_old = item["xmfzr_old"].ToString();
                        string Charger_new = item["xmfzr_new"].ToString();
                        JArray xmzycy_list = (JArray)item["xmzycy_list"];
                        JArray array= (JArray)item["change_options"];
                        foreach (string option in array)
                        {
                            ChangeOptions += "," + option;
                        }
                        if (ChangeOptions != "") ChangeOptions = ChangeOptions.Substring(1);

                        HuanaBiz.ProjectChange(ProjectNo, ProjectName, GetOrgName(OrgName), ChangeDate, ChangeCount, ChangeOptions, ProjectName_old, ProjectName_new
                            , StartDate_old, StartDate_new, EndDate_old, EndDate_new, Charger_old, Charger_new, xmzycy_list);
                    }
                }
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
            //string startDate = DateTime.Now.AddDays(-28).ToString("yyyy-MM-dd"); ;
            //string endDate = DateTime.Now.ToString("yyyy-MM-dd");
            //Console.WriteLine(startDate + "," + endDate);

            //string appId = ConfigurationManager.AppSettings["appId_project"].ToString();
            //string entryId = ConfigurationManager.AppSettings["entryId_project"].ToString();
            //APIUtils api = new APIUtils(appId, entryId, apiKey);

            // 按条件获取表单内容
            //JArray cond = new JArray
            //{
            //    new JObject
            //    {
            //        ["field"] = "xmbh",
            //        ["method"] = "eq",
            //        ["value"] = "HNYF20210404"
            //    }
            //};
            //JObject filter = new JObject
            //{
            //    ["rel"] = "and",
            //    ["cond"] = cond
            //};
            //JArray fields = new JArray { "flowState", "xmbh", "dw", "xmmc", "kssj", "jssj", "xmfzr", "xmzzz", "xmzcy", "createTime" };
            //JArray data = api.GetFormData(null, 1000, null, filter);
            //if (data != null && data.Count > 0)
            //{
            //    foreach (JToken item in data)
            //    {
            //        string Charger = item["xmfzr"]["name"].ToString();
            //        string GroupLeader = item["xmzzz"]["name"].ToString();
            //        Console.WriteLine("负责人:" + Charger + "，组长:" + GroupLeader);
            //    }
            //}
            //Console.WriteLine("项目计划单：");
            //Console.WriteLine(data);
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
            string startDate = DateTime.Now.AddDays(-15).ToString("yyyy-MM-dd");
            string endDate = DateTime.Now.ToString("yyyy-MM-dd");

            string reason = "";
            if (DateTime.Now.ToLongTimeString() == "5:00:00" || DateTime.Now.ToLongTimeString() == "13:00:00")
            {
                this.GetEmployeeFromApi(out reason);
                if (reason != "")
                {
                    rTxtLog.AppendText("\n人员信息档案，" + DateTime.Now.ToString() + "：" + reason);
                }
            }
            else if (DateTime.Now.ToLongTimeString() == "6:00:00" || DateTime.Now.ToLongTimeString() == "14:00:00")
            {
                this.GetLeaveFromApi(startDate, endDate);
                if (reason != "")
                {
                    rTxtLog.AppendText("\n请休假，" + DateTime.Now.ToString() + "：" + reason);
                }
            }
            else if (DateTime.Now.ToLongTimeString() == "7:00:00" || DateTime.Now.ToLongTimeString() == "14:30:00")
            {
                this.GetProjectsFromApi(out reason);
                if (reason != "")
                {
                    rTxtLog.AppendText("\n研究开发项目计划书，" + DateTime.Now.ToString() + "：" + reason);
                }
            }
            else if (DateTime.Now.ToLongTimeString() == "7:30:00" || DateTime.Now.ToLongTimeString() == "15:00:00")
            {
                this.GetProjectTestMembersFromApi(out reason);
                if (reason != "")
                {
                    rTxtLog.AppendText("\n研发试产单，" + DateTime.Now.ToString() + "：" + reason);
                }
            }
            else if (DateTime.Now.ToLongTimeString() == "8:00:00" || DateTime.Now.ToLongTimeString() == "13:30:00")
            {
                this.ProjectChangeFromApi(out reason);
                if (reason != "")
                {
                    rTxtLog.AppendText("\n项目变更计划书，" + DateTime.Now.ToString() + "：" + reason);
                }
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
            if (cmbFormName.Text == "研究开发项目计划书")
            {
                this.GetProjectsFromApi(out reason);
                if (reason != "")
                {
                    rTxtLog.AppendText("\n研究开发项目计划书，" + DateTime.Now.ToString() + "：" + reason);
                }
                else
                {
                    MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            else if (cmbFormName.Text == "项目变更计划书")
            {
                this.ProjectChangeFromApi(out reason);
                if (reason != "")
                {
                    rTxtLog.AppendText("\n项目变更计划书，" + DateTime.Now.ToString() + "：" + reason);
                }
                else
                {
                    MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            else if (cmbFormName.Text == "研发试产单")
            {
                this.GetProjectTestMembersFromApi(out reason);
                if (reason != "")
                {
                    rTxtLog.AppendText("\n研发试产单，" + DateTime.Now.ToString() + "：" + reason);
                }
                else
                {
                    MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            else if (cmbFormName.Text == "人员信息档案")
            {
                this.GetEmployeeFromApi(out reason);
                if (reason != "")
                {
                    rTxtLog.AppendText("\n人员信息档案，" + DateTime.Now.ToString() + "：" + reason);
                }
                else
                {
                    MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            else  //请休假
            {
                this.GetLeaveFromApi(startDate, endDate);
                if (reason != "")
                {
                    rTxtLog.AppendText("\n请休假，" + DateTime.Now.ToString() + "：" + reason);
                }
                else
                {
                    MessageBox.Show("简道云API获取数据成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
        }
    }
}

using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json.Linq;

namespace JiandaoyunAPI
{
    /// <summary>
    /// 华纳公司相关
    /// </summary>
    public class HuanaBiz
    {
        //插入员工表
        public static int AddEmployee(string OrgName, string Department, string EmployeeNo, string FullName, string Sex, string IDNo, string BirthDate, string Education, string Speciality
            , string Station, string EmployeeType, string EntryDate, string QuitDate, String Status)
        {
            int cnt = 0;
            string strSql = "select count(*) from Employees where  EmployeeNo='" + EmployeeNo + "'";
            DataSet ds = Dbsql.Query(strSql);
            if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
            {
                strSql = " insert into Employees(OrgName, Department,EmployeeNo, FullName, Sex, IDNo, BirthDate, Education, Speciality,";
                strSql +="Station,EmployeeType, EntryDate, QuitDate, Status,CreateTime) ";
                strSql += "values('" + OrgName + "','" + Department + "','" + EmployeeNo + "','" + FullName + "','" + Sex + "','" + IDNo + "'," + BirthDate + ",'" + Education + "','" + Speciality + "'";
                strSql += ",'" + Station + "','" + EmployeeType + "'," + EntryDate + "," + QuitDate + ",'" + Status + "',getdate())";
            }
            else
            {
                strSql = "update Employees set OrgName='" + OrgName + "',Department='" + Department + "',FullName='" + FullName + "',Sex='" + Sex + "',IDNo='" + IDNo + "'";
                strSql += ",BirthDate=" + BirthDate + ",Education='" + Education + "',Speciality='" + Speciality + "',Station='" + Station + "',EmployeeType='" + EmployeeType + "'";
                strSql += ",EntryDate=" + EntryDate + ",QuitDate=" + QuitDate + ",Status='" + Status + "' where EmployeeNo='" + EmployeeNo + "'";
            }
            Dbsql.ExecuteSql(strSql);
            cnt++;
            return cnt;
        }
        //插入请假表
        public static int AddLeave(string OrgName, string Department, string EmployeeNo, string FullName, string LeaveType
            , string StartTime, string EndTime, string Days, string Reason,string createTime)
        {
            int cnt = 0;
            string strSql = "select count(*) from Leave where  EmployeeNo='" + EmployeeNo + "' and StartTime=" + StartTime;
            DataSet ds = Dbsql.Query(strSql);
            if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
            {
                strSql = "insert into Leave(EmployeeNo, FullName, OrgName, Department, LeaveType, StartTime, EndTime, Days, Reason, Status, CreateTime) ";
                strSql += "values('" + EmployeeNo + "','" + FullName + "','" + OrgName + "','" + Department + "','" + LeaveType + "'," + StartTime + "," + EndTime;
                strSql += ",'" + Days + "','" + Reason + "',0," + createTime + ")";
                Dbsql.ExecuteSql(strSql);
                cnt++;
            }
            return cnt;
        }

        //插入项目表
        public static void AddProjects(string ProjectNo, string ProjectName, string OrgName, string StartDate, string EndDate, string Charger, string GroupLeader, JArray xmzycy_list, string CreateTime)
        {
            if (ProjectNo != "")
            {
                string strSql = "select count(*) from Projects where  ProjectNo='" + ProjectNo + "'";
                DataSet ds = Dbsql.Query(strSql);
                if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into Projects(ProjectNo, ProjectName, OrgName, StartDate, EndDate, Charger, GroupLeader, Status, CreateTime) ";
                    strSql += "values('" + ProjectNo + "','" + ProjectName + "','" + OrgName + "'," + StartDate + "," + EndDate + ",'" + Charger + "'";
                    strSql += ",'" + GroupLeader + "',0," + CreateTime + ")";
                    Dbsql.ExecuteSql(strSql);

                    //插入项目成员表
                    foreach (JToken member in xmzycy_list)
                    {
                        string IDNo = member["sfzhm"].ToString(); //身份证号码
                        string JobContent = member["dwcxmdgx"].ToString();
                        string Ratio = member["gzsjzb"].ToString();
                        string IsFull = member["sfqz"].ToString();
                        AddProjectMembers(ProjectNo, IDNo, JobContent, Ratio, StartDate, EndDate, IsFull, CreateTime);
                    }
                }
            }
        }

        //插入项目成员表
        private static void AddProjectMembers(string ProjectNo, string IDNo, string JobContent, string Ratio, string StartDate, string EndDate, string IsFull, string CreateTime)
        {
            if (ProjectNo != "")
            {
                string EmployeeNo = "";
                string FullName = "";
                DataSet dsTemp = Dbsql.Query("select EmployeeNo,FullName from Employees where IDNo='" + IDNo + "' and [Status] not in('已离职')");
                if (Convert.ToInt32(dsTemp.Tables[0].Rows.Count) > 0)
                {
                    EmployeeNo = dsTemp.Tables[0].Rows[0][0].ToString();
                    FullName = dsTemp.Tables[0].Rows[0][1].ToString();
                }

                if (EmployeeNo != "")
                {
                    string strSql = "select count(*) from ProjectMembers where  ProjectNo='" + ProjectNo + "' and EmployeeNo='" + EmployeeNo + "'";
                    DataSet ds = Dbsql.Query(strSql);
                    if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                    {
                        strSql = "insert into ProjectMembers(ProjectNo,EmployeeNo,FullName,JobContent, Ratio, StartDate, EndDate, IsFull, IsDel, CreateTime) ";
                        strSql += "values('" + ProjectNo + "','" + EmployeeNo + "','" + FullName + "','" + JobContent + "','" + Ratio.Replace("%", "").Replace("％", "") + "'";
                        strSql += "," + StartDate + "," + EndDate + ", '" + IsFull + "',0," + CreateTime + ")";
                        Dbsql.ExecuteSql(strSql);
                    } 
                }
            }
        }

        //插入项目试产人员
        public static void AddProjectTestMembers(string ProjectNo, string ProductName, string FullName, string StartDate, string EndDate, string CreateTime)
        {
            if (ProjectNo != "")
            {
                string EmployeeNo = "";
                DataSet dsTemp = Dbsql.Query("select EmployeeNo from Employees where FullName='" + FullName + "' and [Status] not in('已离职')");
                if (Convert.ToInt32(dsTemp.Tables[0].Rows.Count) > 0)
                {
                    EmployeeNo = dsTemp.Tables[0].Rows[0][0].ToString();
                }

                dsTemp = Dbsql.Query("select count(*) from Projects where ProjectNo='" + ProjectNo + "'");
                if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
                {
                    ProjectNo = "";
                }

                if (EmployeeNo != "" && ProjectNo != "")
                {
                    string strSql = "select count(*) from ProjectTestMembers where  ProjectNo='" + ProjectNo + "' and EmployeeNo='" + EmployeeNo + "' and StartDate=" + StartDate;
                    DataSet ds = Dbsql.Query(strSql);
                    if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                    {
                        strSql = "insert into ProjectTestMembers(ProjectNo, ProductName, EmployeeNo,FullName, StartDate, EndDate, CreateTime) ";
                        strSql += "values('" + ProjectNo + "','" + ProductName + "','" + EmployeeNo + "','" + FullName + "'," + StartDate + "," + EndDate + "," + CreateTime + ")";
                    }
                    else
                    {
                        strSql = "update ProjectTestMembers set ProductName='" + ProductName + "',FullName = '" + FullName + "',StartDate=" + StartDate + ",EndDate=" + EndDate;
                        strSql += " where  ProjectNo='" + ProjectNo + "' and EmployeeNo='" + EmployeeNo + "' and StartDate=" + StartDate;
                    }
                    Dbsql.ExecuteSql(strSql);
                }
            }
        }

        //插入项目表
        public static void ProjectChange(string ProjectNo, string ProjectName, string OrgName, string ChangeDate, string ChangeCount
            , string ChangeOptions, string ProjectName_old, string ProjectName_new, string StartDate_old, string StartDate_new, string EndDate_old
            , string EndDate_new, string Charger_old, string Charger_new, JArray xmzycy_list)
        {
            //变更选项：项目名称,研发截止及经费,研发项目负责人,项目主要成员分工
            string MemberChange = "";
            if (ProjectNo != "")
            {
                DataSet ds = Dbsql.Query("select count(*) from ProjectChange where ProjectNo='" + ProjectNo + "' and ChangeCount=" + ChangeCount);
                if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                {
                    if (ProjectName_new != "")
                    {
                        Dbsql.ExecuteSql("update Projects set ProjectName='" + ProjectName_new + "' where ProjectNo='" + ProjectNo + "'");
                    }
                    else if (StartDate_new != "null")
                    {
                        Dbsql.ExecuteSql("update Projects set StartDate=" + StartDate_new + " where ProjectNo='" + ProjectNo + "'");
                    }
                    else if (EndDate_new != "null")
                    {
                        Dbsql.ExecuteSql("update Projects set EndDate=" + EndDate_new + " where ProjectNo='" + ProjectNo + "'");
                    }
                    else if (Charger_new != "")
                    {
                        Dbsql.ExecuteSql("update Projects set Charger='" + Charger_new + "' where ProjectNo='" + ProjectNo + "'");
                    }

                    //获取项目研发结束时间
                    string StartDate = "null";
                    string EndDate = "null";
                    DataSet dsTemp = Dbsql.Query("select StartDate,EndDate from Projects where ProjectNo='" + ProjectNo + "'");
                    if (Convert.ToInt32(dsTemp.Tables[0].Rows.Count) > 0)
                    {
                        StartDate = "'" + dsTemp.Tables[0].Rows[0][0].ToString() + "'";
                        EndDate = "'" + dsTemp.Tables[0].Rows[0][1].ToString() + "'";
                    }

                    foreach (JToken member in xmzycy_list)
                    {
                        string IDNo = member["sfzhm"].ToString();
                        string FullName = member["xm"].ToString();
                        string JobContent = member["dwcxmdgx"].ToString();
                        string Ratio = member["gzsjzb"].ToString();
                        string IsFull = member["sfqz"].ToString();
                        string ChangeType = "";
                        JArray array = (JArray)member["change_type"];
                        foreach (string option in array)
                        {
                            ChangeType += "," + option;
                        }
                        if (ChangeType != "") ChangeType = ChangeType.Substring(1);

                        if (ChangeType.IndexOf("删减人员") > -1)
                        {
                            Dbsql.ExecuteSql("update ProjectMembers set IsDel=1,EndDate=" + ChangeDate + " where ProjectNo='" + ProjectNo + "' and FullName='" + FullName + "'");
                        }
                        else if (ChangeType.IndexOf("增加人员") > -1)
                        {
                            AddProjectMembers(ProjectNo, IDNo, JobContent, Ratio, ChangeDate, EndDate, IsFull, ChangeDate);
                        }
                        else
                        {
                            Dbsql.ExecuteSql("update ProjectMembers set IsFull='" + IsFull + "',JobContent='" + JobContent + "',Ratio='" + Ratio.Replace("%", "").Replace("％", "") + "'  where ProjectNo='" + ProjectNo + "' and FullName='" + FullName + "'");
                        }

                        MemberChange += "|" + ChangeType + ";" + FullName + ";" + JobContent + ";" + Ratio;
                    }

                    if (MemberChange != "") MemberChange = MemberChange.Substring(1);

                    string strSql = "insert into ProjectChange(ProjectNo, ProjectName, OrgName, ChangeDate, ChangeCount, ChangeOptions, ProjectName_old,ProjectName_new";
                    strSql += ", StartDate_old, StartDate_new, EndDate_old, EndDate_new, Charger_old, Charger_new, MemberChange, CreateTime) ";
                    strSql += "values('" + ProjectNo + "','" + ProjectName + "','" + OrgName + "'," + ChangeDate + "," + ChangeCount + ",'" + ChangeOptions + "'";
                    strSql += ",'" + ProjectName_old + "','" + ProjectName_new + "'," + StartDate_old + "," + StartDate_new + "," + EndDate_old + "," + EndDate_new;
                    strSql += ",'" + Charger_old + "','" + Charger_new + "','" + MemberChange + "',getdate())";
                    Dbsql.ExecuteSql(strSql);
                }
            }
        }
    }
}

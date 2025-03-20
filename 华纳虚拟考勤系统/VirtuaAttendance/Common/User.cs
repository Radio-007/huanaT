using System;
using System.Data;

namespace GxRadio.Common
{
    public partial class User
    {
        public int UserID; //id
        public string UserName; //用户名
        public string UserPassword;
        public string EmployeeNo; //员工编号
        public string Position;  //职务
        public string UserPer; //用户权限,以半角逗号隔开
        public bool DeptLeader; //部门主管

        public string DeptNameLevel; //部门级别字符串
        public string DepartmentName;  //部门名称
        public string OrgName; //机构名称
        public int CompanyID = 1;  //公司ID
        public string CompanyName; //公司名称

        public User() 
        {
        }

        #region 通过姓名获取用户
        
        public static User GetUser(string UserName)
        {
            User t_user = null;
            string strSql="select * from SysUser where username='" + UserName + "'";
            DataSet ds = SqlHelper.ExecuteDs(strSql);
            if (ds.Tables[0].Rows.Count > 0)
            {
                t_user = new User();
                t_user.UserID = Convert.ToInt32(ds.Tables[0].Rows[0]["ID"]);
                //t_user.EmployeeNo = Convert.ToString(ds.Tables[0].Rows[0]["UserID"]);
                t_user.UserName = Convert.ToString(ds.Tables[0].Rows[0]["username"]);
                //t_user.Position = Convert.ToString(ds.Tables[0].Rows[0]["posiname"]);
                t_user.UserPassword = Convert.ToString(ds.Tables[0].Rows[0]["password"]);
                t_user.UserPer = Convert.ToString(ds.Tables[0].Rows[0]["userPers"]);
                //t_user.DeptLeader = false;
                //if (Convert.ToInt32(ds.Tables[0].Rows[0]["DeptLeader"]) == 1)
                //    t_user.DeptLeader = true;
                //t_user.DeptNameLevel = Convert.ToString(ds.Tables[0].Rows[0]["DeptNameLevel"]);
                //t_user.CompanyName = t_user.DeptNameLevel.Split('>')[0].ToString();
                //if (t_user.CompanyName == "赣州竹林") t_user.CompanyID = 2;
                //t_user.DepartmentName = Convert.ToString(ds.Tables[0].Rows[0]["DeptName"]);
                //t_user.OrgName = Convert.ToString(ds.Tables[0].Rows[0]["OrgName"]);
            }

            return t_user;
        }
        #endregion
    }
}

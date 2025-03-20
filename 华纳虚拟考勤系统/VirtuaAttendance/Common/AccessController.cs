using System;
using System.Data;

namespace GxRadio.Common
{
    public class AccessController
    {
        public static User CurrentUser = null;

        #region  检查权限

        public static bool HasPerByCode(string per_code)
        {
            if (CurrentUser == null)
                return false;
            if (per_code == "")
                return false;

            string[] pers = CurrentUser.UserPer.Split(',');
            for (int i = 0; i < pers.Length; i++)
            {
                //if (pers[i] == "01") return true;//系统管理员
                if (per_code == pers[i]) return true;
            }

            return false;
        }
        #endregion

        #region 写日志

        public static void WriteLog(string content)
        {
            string strSql = "insert into SysLog(username,logContent,logTime) values(";
            strSql += "'" + CurrentUser.UserName + "','" + content + "',getdate())";
            SqlHelper.ExecuteSql(strSql);
        }
        #endregion

        #region 获取服务器时间

        public static DateTime GetServerDateTime()
        {
            DataSet ds = SqlHelper.ExecuteDs("select getdate()");
            return Convert.ToDateTime(ds.Tables[0].Rows[0][0]);
        }
        #endregion

        #region 获取公司下拉框当前项
        public static int IndexOfCompany()
        {
            if (CurrentUser.CompanyName == "赣州竹林")  return 1;
            return 0;
        }
        #endregion
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Web;
using System.IO;
using System.Net;
using DevExpress.XtraEditors;

namespace GxRadio.Common
{
    public class SharePro
    {
        public SharePro()
        {
        }

        #region  下拉框级联选择部门

        public static void cmbSelectDeparment(string parent_text,DevExpress.XtraEditors.ComboBoxEdit cmbChild)
        {
            cmbChild.Properties.Items.Clear();
            cmbChild.Properties.Items.Add("");
            if (parent_text.Trim() == "")
            {
                cmbChild.Text = "";
                return;
            }

            DataSet ds = SqlHelper.ExecuteDs("select 1,Department from v_Department where OrgName='" + parent_text + "'");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                GxRadio.Common.ComboxData obj = new ComboxData();
                obj.Text = Convert.ToString(ds.Tables[0].Rows[i][1]);
                obj.Value = Convert.ToString(ds.Tables[0].Rows[i][0]);
                cmbChild.Properties.Items.Add(obj);
            }
            cmbChild.Text = "";
        }
        #endregion

        #region 获取当月第一天
        public static DateTime GetFirstDayOfMonth(DateTime curDateTime)
        {
            DateTime dt = new DateTime(curDateTime.Year, curDateTime.Month, 1);
            return dt;
        }
        #endregion

        #region 获取当月最后一天
        public static DateTime GetLastDayOfMonth(DateTime curDateTime)
        {
            return curDateTime.AddMonths(1).AddDays(-1);
        }
        #endregion

        #region 空串转换为NULL插入SQL Server数据库
        public static object EmptyToNull(string s)
        {
            string result = "NULL";
            if (s.Trim() != "")
                result = "'" + s + "'";
            return result;
        }
        #endregion

        #region SQL Server NULL转换为空串
        public static object NullToEmpty(string s)
        {
            string result = "";
            if (!string.IsNullOrEmpty(s))
                result = s;
            return result;
        }
        #endregion

        /// <summary>
        /// Base64加密
        /// </summary>
        /// <param name="codeName">加密采用的编码方式</param>
        /// <param name="source">待加密的明文</param>
        /// <returns></returns>
        public static string EncodeBase64(Encoding encode, string source)
        {
            string enstring = "";
            byte[] bytes = encode.GetBytes(source);
            try
            {
                enstring = Convert.ToBase64String(bytes);
            }
            catch
            {
                enstring = source;
            }
            return enstring;
        }

        /// <summary>
        /// Base64加密，采用utf8编码方式加密
        /// </summary>
        /// <param name="source">待加密的明文</param>
        /// <returns>加密后的字符串</returns>
        public static string EncodeBase64(string source)
        {
            return EncodeBase64(Encoding.UTF8, source);
        }

        /// <summary>
        /// Base64解密
        /// </summary>
        /// <param name="codeName">解密采用的编码方式，注意和加密时采用的方式一致</param>
        /// <param name="result">待解密的密文</param>
        /// <returns>解密后的字符串</returns>
        public static string DecodeBase64(Encoding encode, string result)
        {
            string decode = "";
            byte[] bytes = Convert.FromBase64String(result);
            try
            {
                decode = encode.GetString(bytes);
            }
            catch
            {
                decode = result;
            }
            return decode;
        }

        /// <summary>
        /// Base64解密，采用utf8编码方式解密
        /// </summary>
        /// <param name="result">待解密的密文</param>
        /// <returns>解密后的字符串</returns>
        public static string DecodeBase64(string result)
        {
            return DecodeBase64(Encoding.UTF8, result);
        }

        #region GPS坐标转换为百度坐标
        public static string GPSToBaidu(string gpsCoords)
        {
            string retXY = "";
            if (string.IsNullOrEmpty(gpsCoords) || gpsCoords.Trim() == "")
                return retXY;

            string[] gpsXY = gpsCoords.Split('|');
            string gpsResult = "";
            for (int i = 0; i < gpsXY.Length; i++)
            {
                string gpsX = gpsXY[i].Split(',')[0];
                string gpsY = gpsXY[i].Split(',')[1];
                string ApiURL = "http://api.map.baidu.com/ag/coord/convert?from=0&to=4&x=" + gpsX + "&y=" + gpsY + "";
                HttpWebRequest request;
                request = (System.Net.HttpWebRequest)WebRequest.Create(ApiURL);
                HttpWebResponse response;
                response = (HttpWebResponse)request.GetResponse();
                StreamReader myreader = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
                string resultText = myreader.ReadToEnd();
                if (resultText != "" && resultText != null)
                {
                    string[] resultStr = resultText.Split(',');
                    string[] resultX = resultStr[1].Split(':');
                    string[] resultY = resultStr[2].Split(':');
                    if (resultX != null && resultY != null)
                    {
                        //解压Base64码
                        byte[] xBuffer = Convert.FromBase64String(resultX[1].Substring(1, resultX[1].Length - 2));
                        byte[] yBuffer = Convert.FromBase64String(resultY[1].Substring(1, resultY[1].Length - 3));
                        if (xBuffer != null && yBuffer != null)
                        {
                            string strX = Encoding.UTF8.GetString(xBuffer, 0, xBuffer.Length);
                            string strY = Encoding.UTF8.GetString(yBuffer, 0, yBuffer.Length);
                            //如果为百度转为GPS，多出如下处理
                            //if (this.checkBox1.Checked == true)
                            //{
                            //    strX = (2 * Convert.ToDouble(gpsX) - Convert.ToDouble(strX)).ToString();
                            //    strY = (2 * Convert.ToDouble(gpsY) - Convert.ToDouble(strY)).ToString();
                            //}
                            gpsResult += strX.Substring(0, strX.IndexOf('.') + 7) + "," + strY.Substring(0, strY.IndexOf('.') + 7) + "|";
                            retXY = gpsResult.Substring(0, gpsResult.Length - 1);
                        }
                    }
                }
            }

            return retXY;
        }
        #endregion

        //获取单位简称
        public static string GetOrgName(string Fullname)
        {
            if (Fullname == "广西华纳新材料股份有限公司")
                return "华纳股份";
            else if (Fullname == "广西合山市华纳新材料科技有限公司")
                return "合山华纳";
            else if (Fullname == "安徽省宣城市华纳新材料科技有限公司")
                return "宣城华纳";
            else
                return "";
        }
    }
}

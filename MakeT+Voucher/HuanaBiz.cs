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

        //插入简道云销售发货表
        public static void AddSaleDetail(string tablename, int action, string xs_sn, string carno, string bill_date, string dw, string production, 
            string customer, string dealer, string salesman, JArray m_list, string CreateTime, string UpdateTime, string flowState)
        {
            //插入发货表
            foreach (JToken member in m_list)
            {
                string randomcode = member["m_randomcode"].ToString();
                string fhrq = MakeT_Voucher.Main.ToChineseDateTime(member["m_fhrq"].ToString());
                if (!randomcode.Equals("") && !fhrq.Equals("null"))
                {
                    string goodsno = member["m_goodsno"].ToString();
                    string goodsname = member["m_goodsname"].ToString();
                    string goodsspec = member["m_goodsspec"].ToString();
                    string goodsunit = member["m_goodsunit"].ToString();
                    string amount = member["m_amount"].ToString() == "" ? "0" : member["m_amount"].ToString();
                    string price = member["m_price"].ToString() == "" ? "0" : member["m_price"].ToString();
                    string money = member["m_money"].ToString() == "" ? "0" : member["m_money"].ToString();
                    if (action == 1)  //添加
                    {
                        string strSql = "select count(*) from " + tablename + " where xs_sn='" + xs_sn + "' and randomcode='" + randomcode + "'";
                        DataSet ds = Dbsql.Query(strSql);
                        if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                        {
                            strSql = "insert into " + tablename + "(xs_sn, randomcode, carno, bill_date, dw, production, customer, dealer, salesman, createTime, updateTime, flowState, ";
                            strSql += "fhrq, goodsno, goodsname, goodsspec, goodsunit, amount,price, money,writeoffState) ";
                            strSql += "values('" + xs_sn + "','" + randomcode + "','" + carno + "'," + bill_date + ",'" + dw + "','" + production + "'";
                            strSql += ",'" + customer + "','" + dealer + "','" + salesman + "'," + CreateTime + "," + UpdateTime + ",'" + flowState + "'";
                            strSql += "," + fhrq + ",'" + goodsno + "','" + goodsname + "','" + goodsspec + "','" + goodsunit + "','" + amount + "','" + price + "','" + money + "',0)";
                            Dbsql.ExecuteSql(strSql);
                        }
                    }
                    else
                    {
                        string strSql = "update " + tablename + " set customer='" + customer + "',production='" + production + "',fhrq=" + fhrq + ",goodsno='" + goodsno + "',goodsname='" + goodsname + "',goodsspec='" + goodsspec + "'";
                        strSql += ",goodsunit='" + goodsunit + "',amount='" + amount + "',price='" + price + "',money='" + money + "'";
                        strSql += ",updateTime=" + UpdateTime + ",flowState='" + flowState + "'";
                        strSql += " where xs_sn='" + xs_sn + "' and randomcode='" + randomcode + "'";
                        Dbsql.ExecuteSql(strSql);
                    }
                }
            }
        }

        //插入简道云销售退货表
        public static void AddSaleReturn(string th_sn, string xs_sn, string carno, string bill_date, string dw,
            string customer, string dealer, string salesman, string reason, JArray m_list, string CreateTime, string UpdateTime, string flowState)
        {
            //插入退货表
            foreach (JToken member in m_list)
            {
                string thrq = MakeT_Voucher.Main.ToChineseDateTime(member["m_thrq"].ToString());
                if (!thrq.Equals("null"))
                {
                    string randomcode = member["m_randomcode"].ToString();
                    string goodsno = member["m_goodsno"].ToString();
                    string goodsname = member["m_goodsname"].ToString();
                    string goodsspec = member["m_goodsspec"].ToString();
                    string goodsunit = member["m_goodsunit"].ToString();
                    string amount = member["m_amount"].ToString() == "" ? "0" : member["m_amount"].ToString();
                    string price = member["m_price"].ToString() == "" ? "0" : member["m_price"].ToString();
                    string money = member["m_money"].ToString() == "" ? "0" : member["m_money"].ToString();
                    string strSql = "select count(*) from sale_th where th_sn='" + th_sn + "' and randomcode='" + randomcode + "'";
                    string notes = member["m_notes"].ToString();
                    DataSet ds = Dbsql.Query(strSql);
                    if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                    {
                        strSql = "insert into sale_th(th_sn, randomcode, xs_sn, carno, bill_date, dw, customer, dealer, salesman, reason, writeoffState, createTime, updateTime, flowState, ";
                        strSql += "thrq, goodsno, goodsname, goodsspec, goodsunit, amount, price, money,notes) ";
                        strSql += "values('" + th_sn +"','" + randomcode + "','" + xs_sn + "','" + carno + "'," + bill_date + ",'" + dw + "'";
                        strSql += ",'" + customer + "','" + dealer + "','" + salesman + "','" + reason + "',0," + CreateTime + "," + UpdateTime + ",'" + flowState + "'";
                        strSql += "," + thrq + ",'" + goodsno + "','" + goodsname + "','" + goodsspec + "','" + goodsunit + "','" + amount + "','" + price + "','" + money + "','" + notes + "')";
                        Dbsql.ExecuteSql(strSql);
                    }
                    else
                    {
                        strSql = "update sale_th set customer='" + customer + "',xs_sn='" + xs_sn + "', thrq=" + thrq + ",goodsno='" + goodsno + "',goodsname='" + goodsname + "',goodsspec='" + goodsspec + "'";
                        strSql += ",goodsunit='" + goodsunit + "',amount='" + amount + "',price='" + price + "',money='" + money + "',updateTime=" + UpdateTime + ",flowState='" + flowState + "'";
                        strSql += " where th_sn='" + th_sn + "' and randomcode='" + randomcode + "'";
                        Dbsql.ExecuteSql(strSql);
                    }
                }
            }
        }

        //插入简道云开增值税发票录入表
        public static void AddInvoiced(string tablename, int action, string id, string dw, string xs_sn, string kprq, string kphm, string customer, string fhrq, string goodsname, string amount, string price
            , string money, string money_notax, string money_tax, string options, string CreateTime, string UpdateTime, string flowState)
        {
            string production = "";
            string strSql = "select production from sale_fh where xs_sn='" + xs_sn + "'";
            DataSet ds1 = Dbsql.Query(strSql);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                production = Convert.ToString(ds1.Tables[0].Rows[0][0]);
            }

            if (action == 1)  //添加
            {
                strSql = "select count(*) from " + tablename + " where id='" + id + "'";
                DataSet ds = Dbsql.Query(strSql);
                if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into " + tablename + "(id, fhrq, customer, goodsname, amount, price, money, money_notax, money_tax, dw, production, xs_sn, kprq, kphm,options, createTime, updateTime, flowState, writeoffState) ";
                    strSql += "values('" + id + "'," + fhrq + ",'" + customer + "','" + goodsname + "','" + amount + "','" + price + "','" + money + "','" + money_notax + "','" + money_tax + "','" + dw + "','" + production + "','" + xs_sn + "'";
                    strSql += "," + kprq + ",'" + kphm + "','" + options + "'," + CreateTime + "," + UpdateTime + ",'" + flowState + "','0')";
                    Dbsql.ExecuteSql(strSql);
                }
            }
            else
            {
                strSql = "update "+ tablename+" set fhrq=" + fhrq + ",customer='" + customer + "',goodsname='" + goodsname + "',amount='" + amount + "',price='" + price + "',money='" + money + "',money_notax='" + money_notax + "',money_tax='" + money_tax + "'";
                strSql += ",production='" + production + "',xs_sn ='" + xs_sn + "',kprq=" + kprq + ",kphm='" + kphm + "',options='" + options + "',updateTime=" + UpdateTime + ",flowState='" + flowState + "'";
                strSql += " where id='" + id + "'";
                Dbsql.ExecuteSql(strSql);
            }
        }

        //删除多余的发货、开票的数据
        public static void DelExcessiveData(int currentYear, int currentPeriod)
        {
            DataSet ds = null;
            DataSet ds1 = null;
            //销售发货
            string strSql = "select count(*) from sale_fhtemp where year(fhrq) = " + currentYear.ToString() + " and month(fhrq) = " + currentPeriod.ToString();
            DataSet dsRecord = Dbsql.Query(strSql);
            if (Convert.ToInt32(dsRecord.Tables[0].Rows[0][0]) > 0)
            {
                strSql = "select id,xs_sn,randomcode from sale_fh where year(fhrq) = " + currentYear.ToString() + " and month(fhrq) = " + currentPeriod.ToString() + " order by fhrq";
                ds = Dbsql.Query(strSql);
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    strSql = "select count(*) from sale_fhtemp where xs_sn='" + Convert.ToString(ds.Tables[0].Rows[i]["xs_sn"]) + "' and randomcode='" + Convert.ToString(ds.Tables[0].Rows[i]["randomcode"]) + "'";
                    DataSet dsTemp = Dbsql.Query(strSql);
                    if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
                    {
                        Dbsql.ExecuteSql("delete from sale_fh where id=" + Convert.ToString(ds.Tables[0].Rows[i]["id"]));
                    }
                }
            }

            strSql = "select id,xs_sn,randomcode from sale_fhtemp where year(fhrq) = " + currentYear.ToString() + " and month(fhrq) = " + currentPeriod.ToString() + " order by fhrq";
            ds1 = Dbsql.Query(strSql);
            for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
            {
                strSql = "select count(*) from sale_fh where xs_sn='" + Convert.ToString(ds1.Tables[0].Rows[i]["jjxs_sn"]) + "' and randomcode='" + Convert.ToString(ds1.Tables[0].Rows[i]["randomcode"]) + "'";
                DataSet dsTemp = Dbsql.Query(strSql);
                if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into sale_fh(xs_sn, randomcode, carno, bill_date, dw, production, customer, dealer, salesman, createTime, updateTime, flowState, ";
                    strSql += "fhrq, goodsno, goodsname, goodsspec, goodsunit, amount,price, money,writeoffState) ";
                    strSql += "select xs_sn, randomcode, carno, bill_date, dw, production, customer, dealer, salesman, createTime, updateTime, flowState,";
                    strSql += "fhrq, goodsno, goodsname, goodsspec, goodsunit, amount,price, money,writeoffState ";
                    strSql += "from sale_fhtemp where xs_sn='" + Convert.ToString(ds1.Tables[0].Rows[i]["xs_sn"]) + "' and randomcode='" + Convert.ToString(ds1.Tables[0].Rows[i]["randomcode"]) + "'";
                    Dbsql.ExecuteSql(strSql);
                }
            }

            ////销售开票
            //strSql = "select count(*) from tb_invoicedtemp where year(kprq) = " + currentYear.ToString() + " and month(kprq) = " + currentPeriod.ToString();
            //dsRecord = Dbsql.Query(strSql);
            //if (Convert.ToInt32(dsRecord.Tables[0].Rows[0][0]) > 0)
            //{
            //    strSql = "select id from tb_invoiced where year(kprq) = " + currentYear.ToString() + " and month(kprq) = " + currentPeriod.ToString() + " order by kprq";
            //    ds1 = Dbsql.Query(strSql);
            //    for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
            //    {
            //        strSql = "select count(*) from tb_invoicedtemp where id='" + Convert.ToString(ds1.Tables[0].Rows[i]["id"]) + "'";
            //        DataSet dsTemp = Dbsql.Query(strSql);
            //        if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
            //        {
            //            Dbsql.ExecuteSql("delete from tb_invoiced where id='" + Convert.ToString(ds1.Tables[0].Rows[i]["id"]) + "'");
            //        }
            //    }
            //}

            //采购录入
            strSql = "select count(*) from purchase_intemp where year(indate) = " + currentYear.ToString() + " and month(indate) = " + currentPeriod.ToString();
            dsRecord = Dbsql.Query(strSql);
            if (Convert.ToInt32(dsRecord.Tables[0].Rows[0][0]) > 0)
            {
                strSql = "select cg_sn,sno from purchase_in where year(indate) = " + currentYear.ToString() + " and month(indate) = " + currentPeriod.ToString() + " order by cg_sn,sno";
                ds = Dbsql.Query(strSql);
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    strSql = "select count(*) from purchase_intemp where cg_sn='" + Convert.ToString(ds.Tables[0].Rows[i]["cg_sn"]) + "' and sno='" + Convert.ToString(ds.Tables[0].Rows[i]["sno"]) + "'";
                    DataSet dsTemp = Dbsql.Query(strSql);
                    if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
                    {
                        Dbsql.ExecuteSql("delete from purchase_in where cg_sn='" + Convert.ToString(ds.Tables[0].Rows[i]["cg_sn"]) + "' and sno='" + Convert.ToString(ds.Tables[0].Rows[i]["sno"]) + "'");
                    }
                }
            }

            strSql = "select cg_sn,sno from purchase_intemp where year(indate) = " + currentYear.ToString() + " and month(indate) = " + currentPeriod.ToString() + " order by cg_sn,sno";
            ds1 = Dbsql.Query(strSql);
            for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
            {
                strSql = "select count(*) from purchase_in where cg_sn='" + Convert.ToString(ds1.Tables[0].Rows[i]["cg_sn"]) + "' and sno='" + Convert.ToString(ds1.Tables[0].Rows[i]["sno"]) + "'";
                DataSet dsTemp = Dbsql.Query(strSql);
                if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into purchase_in(cg_sn, sno, dw, indate, supplier_no, supplier, warehouse_no, warehouse, goodsno, goodsname, goodsspec, goodsunit, ";
                    strSql += "amount, price, money, money_notax, money_tax, notes, useto, writeoffState, flowState, createTime, updateTime) ";
                    strSql += "select cg_sn, sno, dw, indate, supplier_no, supplier, warehouse_no, warehouse, goodsno, goodsname, goodsspec, goodsunit,";
                    strSql += "amount, price, money, money_notax, money_tax, notes, useto, writeoffState, flowState, createTime, updateTime ";
                    strSql += "from purchase_intemp where cg_sn='" + Convert.ToString(ds1.Tables[0].Rows[i]["cg_sn"]) + "' and sno='" + Convert.ToString(ds1.Tables[0].Rows[i]["sno"]) + "'";
                    Dbsql.ExecuteSql(strSql);
                }
            }

            ////采购开票
            //strSql = "select count(*) from purchase_invoicedtemp where year(jsrq) = " + currentYear.ToString() + " and month(jsrq) = " + currentPeriod.ToString();
            //dsRecord = Dbsql.Query(strSql);
            //if (Convert.ToInt32(dsRecord.Tables[0].Rows[0][0]) > 0)
            //{
            //    strSql = "select sid,sno from purchase_invoiced where year(jsrq) = " + currentYear.ToString() + " and month(jsrq) = " + currentPeriod.ToString() + " order by supplier,kphm,cg_sn";
            //    ds = Dbsql.Query(strSql);
            //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            //    {
            //        strSql = "select count(*) from purchase_invoicedtemp where sid='" + Convert.ToString(ds.Tables[0].Rows[i]["sid"]) + "' and sno='" + Convert.ToString(ds.Tables[0].Rows[i]["sno"]) + "'";
            //        DataSet dsTemp = Dbsql.Query(strSql);
            //        if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
            //        {
            //            Dbsql.ExecuteSql("delete from purchase_invoiced where sid='" + Convert.ToString(ds.Tables[0].Rows[i]["sid"]) + "' and sno='" + Convert.ToString(ds.Tables[0].Rows[i]["sno"]) + "'");
            //        }
            //    }
            //}
        }

        //插入简道云磅差处理单
        public static void AddSalePc(int action, string id, string xs_sn, string dw, string customer, string fhrq,
            string reason, string handleway, JArray m_list, string CreateTime, string UpdateTime, string flowState)
        {
            string production = "";
            DataSet ds1 = Dbsql.Query("select top 1 production from sale_fh where xs_sn='" + xs_sn + "'");
            if (ds1.Tables[0].Rows.Count > 0)
            {
                production = Convert.ToString(ds1.Tables[0].Rows[0][0]);
            }
                //插入发货表
                int sno = 1;
            foreach (JToken member in m_list)
            {
                string goodsname = member["m_goodsname"].ToString();
                string amount = member["m_amount"].ToString() == "" ? "0" : member["m_amount"].ToString();
                string price = member["m_price"].ToString() == "" ? "0" : member["m_price"].ToString();
                string money = member["m_money"].ToString() == "" ? "0" : member["m_money"].ToString();
                if (action == 1)  //添加
                {
                    string strSql = "select count(*) from sale_pc where xs_sn='" + xs_sn + "' and sno='" + sno + "'";
                    DataSet ds = Dbsql.Query(strSql);
                    if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                    {
                        strSql = "insert into sale_pc(id,xs_sn, sno, dw, production, customer, createTime, updateTime, flowState, reason, handleway,";
                        strSql += "fhrq, goodsname, amount,price, money,writeoffState) ";
                        strSql += "values('" + id + "','" + xs_sn + "','" + sno + "','" + dw + "','" + production + "','" + customer + "'," + CreateTime + "," + UpdateTime + ",'" + flowState + "','" + reason + "','" + handleway + "'";
                        strSql += "," + fhrq + ",'" + goodsname + "','" + amount + "','" + price + "','" + money + "',0)";
                        Dbsql.ExecuteSql(strSql);
                    }
                }
                else
                {
                    string strSql = "update sale_pc set id='" + id + "',dw='" + dw + "',production='" + production + "',customer='" + customer + "',fhrq=" + fhrq + ",reason='" + reason + "',goodsname='" + goodsname + "',handleway='" + handleway + "'";
                    strSql += ",amount='" + amount + "',price='" + price + "',money='" + money + "',updateTime=" + UpdateTime + ",flowState='" + flowState + "'";
                    strSql += " where xs_sn='" + xs_sn + "' and sno='" + sno + "'";
                    Dbsql.ExecuteSql(strSql);
                }
                sno++;
            }
        }

        //插入简道云T+往月库存商品单价表单
        public static void AddSaleStockPrice(int action, string id, string dw, string jsrq, string accountcode, string goodsname, string price, string CreateTime, string UpdateTime)
        {
            if (action == 1)  //添加
            {
                string strSql = "select count(*) from sale_stockprice where sid='" + id + "'";
                DataSet ds = Dbsql.Query(strSql);
                if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into sale_stockprice( sid, dw, jsrq, accountcode, goodsname, price, createTime, updateTime)";
                    strSql += "values('" + id + "','" + dw + "'," + jsrq + ",'" + accountcode + "','" + goodsname + "','" + price + "'," + CreateTime + "," + UpdateTime + ")";
                    Dbsql.ExecuteSql(strSql);
                }
            }
            else
            {
                string strSql = "update sale_stockprice set dw='" + dw + "',jsrq=" + jsrq + ",accountcode='" + accountcode + "',goodsname='" + goodsname + "',price='" + price + "'";
                strSql += ",updateTime=" + UpdateTime + " where sid='" + id + "'";
                Dbsql.ExecuteSql(strSql);
            }
        }

        //采购入库单录入
        public static void AddPurchase(string tablename,int action, string cg_sn, string sno, string dw, string indate, string supplier_no, string supplier, string warehouse_no, string warehouse, 
            string goodsno, string goodsname, string goodsspec, string goodsunit, string amount, string price, string money, string money_notax, string money_tax, 
            string notes, string useto, string flowState, string CreateTime, string UpdateTime)
        {
            if (action == 1)  //添加
            {
                string strSql = "select count(*) from " + tablename + " where cg_sn='" + cg_sn + "' and sno='" + sno + "'";
                DataSet ds = Dbsql.Query(strSql);
                if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into " + tablename + "(cg_sn, sno, dw, indate, supplier_no, supplier, warehouse_no, warehouse";
                    strSql += ",goodsno, goodsname, goodsspec, goodsunit, amount,price, money, money_notax, money_tax, notes,useto,writeoffState, flowState, createTime, updateTime) ";
                    strSql += "values('" + cg_sn + "','" + sno + "','" + dw + "'," + indate + ",'" + supplier_no + "','" + supplier + "','" + warehouse_no + "','" + warehouse + "'";
                    strSql += ",'" + goodsno + "','" + goodsname + "','" + goodsspec + "','" + goodsunit + "','" + amount + "','" + price + "','" + money + "','" + money_notax + "','" + money_tax + "'";
                    strSql += ",'" + notes + "','" + useto + "',0,'" + flowState + "'," + CreateTime + "," + UpdateTime + ")";
                    Dbsql.ExecuteSql(strSql);
                }
            }
            else
            {
                string strSql = "update " + tablename + " set indate=" + indate + ",supplier_no='" + supplier_no + "',supplier='" + supplier + "',warehouse_no='" + warehouse_no + "',warehouse='" + warehouse + "'";
                strSql += ",goodsno='" + goodsno + "',goodsname='" + goodsname + "',goodsspec='" + goodsspec + "',goodsunit='" + goodsunit + "'";
                strSql += ",amount='" + amount + "',price='" + price + "',money='" + money + "',money_notax='" + money_notax + "',money_tax='" + money_tax + "'";
                strSql += ",notes='" + notes + "',useto='" + useto + "',updateTime=" + UpdateTime + ",flowState='" + flowState + "'";
                strSql += " where cg_sn='" + cg_sn + "' and sno='" + sno + "'";
                Dbsql.ExecuteSql(strSql);
            }
        }

        //采购开票录入
        public static void AddPurchaseInvoiced(string tablename, int action, string sid, string sno, string cg_sn, string dw, string jsrq,string supplier, string indate, string warehouse, string goodsname, string goodsunit, string amount
            , string price, string money, string money_notax, string money_tax, string kprq, string kphm, string fplx, string options, string notes, string CreateTime, string UpdateTime)
        {
            string strSql = "";
            if (cg_sn.IndexOf("冲红单") > -1 && Convert.ToDecimal(money) < 0)
            {
                options = "冲红";
            }
            else if (cg_sn.IndexOf("退货单") > -1 && Convert.ToDecimal(money) < 0)
            {
                options = "退货";
            }
            else if (cg_sn.IndexOf("维修单") > -1)
            {
                options = "维修";
            }
            else if (Convert.ToDecimal(money) < 0)
            {
                options = "折扣";
            }

            if (action == 1)  //添加
            {
                strSql = "select count(*) from " + tablename + " where sno='" + sno + "' and sid='" + sid + "'";
                DataSet ds = Dbsql.Query(strSql);
                if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into "+ tablename+"(cg_sn, sid, sno, dw, jsrq, supplier, indate, warehouse, goodsname, goodsunit, amount, price, money, money_notax, money_tax, kprq, kphm, fplx, options, notes, writeoffState, createTime, updateTime) ";
                    strSql += "values('" + cg_sn + "','" + sid + "','" + sno + "','" + dw + "'," + jsrq + ",'" + supplier + "'," + indate + ",'" + warehouse + "','" + goodsname + "','" + goodsunit + "'";
                    strSql += ",'" + amount + "','" + price + "','" + money + "','" + money_notax + "','" + money_tax + "'," + kprq + ",'" + kphm + "','" + fplx + "','" + options + "','" + notes + "'";
                    strSql += ",'0'," + CreateTime + "," + UpdateTime + ")";
                    Dbsql.ExecuteSql(strSql);
                }
            }
            else
            {
                strSql = "update "+ tablename+" set dw='" + dw + "',jsrq=" + jsrq + ",supplier='" + supplier + "',indate=" + indate + ",warehouse='" + warehouse + "',goodsname = '" + goodsname + "',goodsunit='" + goodsunit + "'";
                strSql += ",amount='" + amount + "',price='" + price + "',money='" + money + "',money_notax='" + money_notax + "',money_tax='" + money_tax + "'";
                strSql += ",kprq=" + kprq + ",kphm='" + kphm + "',fplx='" + fplx + "',options='" + options + "',notes='" + notes + "',updateTime=" + UpdateTime;
                strSql += " where sno='" + sno + "' and sid='" + sid + "'";
                Dbsql.ExecuteSql(strSql);
            }
        }

        //采购退货冲红单录入
        public static void AddPurchaseth(int action, string sid, string options, string cg_sn, string sno, string dw, string thdate, string supplier_no, string supplier, string warehouse_no, string warehouse,
            string goodsno, string goodsname, string goodsspec, string goodsunit, string amount, string price, string money, string money_notax, string money_tax,
            string notes, string flowState, string CreateTime, string UpdateTime)
        {
            string sn_1 = cg_sn.Split(',')[0].ToString();
            string strSql = "";
            DateTime indate = Convert.ToDateTime("1901-01-01");  //入库日期
            DataSet ds1 = Dbsql.Query("select Top 1 indate from purchase_in where cg_sn='" + sn_1 + "'");
            if (ds1.Tables[0].Rows.Count > 0)
            {
                indate = Convert.ToDateTime(ds1.Tables[0].Rows[0][0]);
            }

            if (action == 1)  //添加
            {
                strSql = "select count(*) from purchase_th where sid='" + sid + "' and sno='" + sno + "'";
                DataSet ds = Dbsql.Query(strSql);
                if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into purchase_th(sid,options, cg_sn, sno, dw, thdate, indate, supplier_no, supplier, warehouse_no, warehouse";
                    strSql += ",goodsno, goodsname, goodsspec, goodsunit, amount,price, money, money_notax, money_tax, notes,writeoffState, flowState, createTime, updateTime) ";
                    strSql += "values('" + sid + "','" + options + "','" + cg_sn + "','" + sno + "','" + dw + "'," + thdate + ",'" + indate + "','" + supplier_no + "','" + supplier + "','" + warehouse_no + "','" + warehouse + "'";
                    strSql += ",'" + goodsno + "','" + goodsname + "','" + goodsspec + "','" + goodsunit + "','" + amount + "','" + price + "','" + money + "','" + money_notax + "','" + money_tax + "'";
                    strSql += ",'" + notes + "',0,'" + flowState + "'," + CreateTime + "," + UpdateTime + ")";
                    Dbsql.ExecuteSql(strSql);
                }
            }
            else
            {
                strSql = "update purchase_th set options='" + options + "',cg_sn='" + cg_sn + "',thdate=" + thdate + ",indate='" + indate + "',supplier_no='" + supplier_no + "',supplier='" + supplier + "',warehouse_no='" + warehouse_no + "',warehouse='" + warehouse + "'";
                strSql += ",goodsno='" + goodsno + "',goodsname='" + goodsname + "',goodsspec='" + goodsspec + "',goodsunit='" + goodsunit + "'";
                strSql += ",amount='" + amount + "',price='" + price + "',money='" + money + "',money_notax='" + money_notax + "',money_tax='" + money_tax + "'";
                strSql += ",notes='" + notes + "',updateTime=" + UpdateTime + ",flowState='" + flowState + "'";
                strSql += " where sid='" + sid + "' and sno='" + sno + "'";
                Dbsql.ExecuteSql(strSql);
            }
        }
    }
}
 
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

        //插入简道云
        public static void AddSaleDetail(string tablename, int action, string id, string xs_sn, string dw, string division, string customer_type, string customer, string zcsj, string kcsj, string carno,
            string goodsname, string amount_mao, string amount_pi, string amount_jing, string price, string money, string amount_hd, string hdrq, string amount_pc,
            string notes, string notes_hd, string ys_qyyfdj, string ys_qyyfje, string price_material, string money_material, string yf_sjyfdj, string yf_sjyfje, string money_material_k,
            string flowState, string createTime, string updateTime, string yfjsfs)
        {
            if (action == 1)  //添加
            {
                string strSql = "select count(*) from  " + tablename + " where id='" + id + "'";
                DataSet ds = Dbsql.Query(strSql);
                if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into " + tablename + "( id, xs_sn, dw, division, customer_type, customer, zcsj, kcsj, carno,";
                    strSql += "goodsname, amount_mao, amount_pi, amount_jing, price, money, amount_hd, hdrq, amount_pc, notes, notes_hd, ys_qyyfdj, ys_qyyfje,";
                    strSql += "price_material, money_material, yf_sjyfdj, yf_sjyfje, money_material_k, writeoffState, flowState, createTime, updateTime, yfjsfs)";
                    strSql += "values('" + id + "','" + xs_sn + "','" + dw + "','" + division + "','" + customer_type + "','" + customer + "'," + zcsj + "," + kcsj + ",'" + carno + "'";
                    strSql += ",'" + goodsname + "','" + amount_mao + "','" + amount_pi + "','" + amount_jing + "','" + price + "','" + money + "','" + amount_hd + "'," + hdrq + ",'" + amount_pc + "'";
                    strSql += ",'" + notes + "','" + notes_hd + "','" + ys_qyyfdj + "','" + ys_qyyfje + "','" + price_material + "','" + money_material + "','" + yf_sjyfdj + "','" + yf_sjyfje + "','" + money_material_k + "'";
                    strSql += ",0,'" + flowState + "'," + createTime + "," + updateTime + ",'" + yfjsfs + "')";
                    Dbsql.ExecuteSql(strSql);
                }
            }
            else
            {
                string strSql = "update " + tablename + " set id='" + id + "',dw='" + dw + "',division='" + division + "',customer_type='" + customer_type + "',customer='" + customer + "',zcsj=" + zcsj + ",kcsj=" + kcsj + ",carno='" + carno + "'";
                strSql += ",goodsname='" + goodsname + "',amount_mao='" + amount_mao + "',amount_pi='" + amount_pi + "',amount_jing='" + amount_jing + "',price='" + price + "',money='" + money + "',amount_hd='" + amount_hd + "',hdrq=" + hdrq + ",amount_pc='" + amount_pc + "'";
                strSql += ",notes='" + notes + "',notes_hd='" + notes_hd + "',ys_qyyfdj='" + ys_qyyfdj + "',ys_qyyfje='" + ys_qyyfje + "',price_material='" + price_material + "',money_material='" + money_material + "',yf_sjyfdj='" + yf_sjyfdj + "',yf_sjyfje=" + yf_sjyfje + ",money_material_k='" + money_material_k + "'";
                strSql += ",flowState='" + flowState + "',updateTime=" + updateTime + ",yfjsfs='" + yfjsfs + "'";
                strSql += " where id='" + id + "' and writeoffState=0";
                Dbsql.ExecuteSql(strSql);
            }
        }


        //插入简道云开增值税发票录入表
        public static void AddInvoiced(string tablename, int action, string id, string dw, string xs_sn, string kprq, string kphm, string customer, string customer_period, string fhrq, string goodsname, string amount, string price
            , string money, string money_notax, string money_tax, string price_avg, string amount_pc, string money_pc, string n_kprq, string n_kphm, string kpdw,string options, string CreateTime, string UpdateTime)
        {
            string customer_type = "";
            string yfjsfs = "";
            string strSql = "select Top 1 customer_type,yfjsfs from huayao_fh where xs_sn='" + xs_sn + "' order by zcsj desc";
            DataSet ds1 = Dbsql.Query(strSql);
            int count = ds1.Tables.Count;
            if (ds1.Tables[0].Rows.Count > 0)
            {
                customer_type = Convert.ToString(ds1.Tables[0].Rows[0][0]);
                yfjsfs = Convert.ToString(ds1.Tables[0].Rows[0][1]);
            }

            if (action == 1)  //添加
            {
                strSql = "select count(*) from  " + tablename + " where id='" + id + "'";
                DataSet ds = Dbsql.Query(strSql);
                if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into " + tablename + "( id,dw,fhrq,customer_type,customer,customer_period,goodsname,amount,price,money,money_notax,money_tax";
                    strSql += ",price_avg,amount_pc,money_pc,xs_sn,kprq,kphm,kpdw,options,createTime,updateTime,yfjsfs,writeoffState) ";
                    strSql += "values('" + id + "','" + dw + "'," + fhrq + ",'" + customer_type + "','" + customer + "','" + customer_period + "','" + goodsname + "','" + amount + "','" + price + "','" + money + "','" + money_notax + "','" + money_tax + "'";
                    strSql += ",'" + price_avg + "','" + amount_pc + "','" + money_pc + "','" + xs_sn + "'," + kprq + ",'" + kphm + "','" + kpdw + "','" + options + "'," + CreateTime + "," + UpdateTime + ",'" + yfjsfs + "','0')";
                    Dbsql.ExecuteSql(strSql);
                }
            }
            else
            {
                strSql = "update " + tablename + " set fhrq=" + fhrq + ",customer='" + customer + "',customer_period='" + customer_period + "',goodsname='" + goodsname + "',amount='" + amount + "',price='" + price + "',money='" + money + "',amount_pc='" + amount_pc + "',money_pc='" + money_pc + "'";
                strSql += ",money_notax='" + money_notax + "',money_tax='" + money_tax + "',price_avg='" + price_avg + "',xs_sn ='" + xs_sn + "',kprq=" + kprq + ",kphm='" + kphm + "',kpdw='" + kpdw + "',options='" + options + "',updateTime=" + UpdateTime + ",yfjsfs='" + yfjsfs + "'";
                strSql += " where id='" + id + "' and writeoffState=0";
                Dbsql.ExecuteSql(strSql);
            }
        }

        //删除多余的发货、开票的数据
        public static void DelExcessiveData(int currentYear, int currentPeriod)
        {
            DataSet ds = null;
            DataSet ds1 = null;
            //华耀销售发货表
            string strSql = "select count(*) from huayao_fhtemp where year(zcsj) = " + currentYear.ToString() + " and month(zcsj) = " + currentPeriod.ToString();
            DataSet dsRecord = Dbsql.Query(strSql);
            if (Convert.ToInt32(dsRecord.Tables[0].Rows[0][0]) > 0)
            {
                strSql = "select id,xs_sn from huayao_fh where year(zcsj) = " + currentYear.ToString() + " and month(zcsj) = " + currentPeriod.ToString() + " order by zcsj";
                ds = Dbsql.Query(strSql);
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    strSql = "select count(*) from huayao_fhtemp where id='" + Convert.ToString(ds.Tables[0].Rows[i]["id"]) + "'";
                    DataSet dsTemp = Dbsql.Query(strSql);
                    if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
                    {
                        Dbsql.ExecuteSql("delete from huayao_fh where id='" + Convert.ToString(ds.Tables[0].Rows[i]["id"]) + "'");
                    }
                }
            }

            strSql = "select id,xs_sn from huayao_fhtemp where year(zcsj) = " + currentYear.ToString() + " and month(zcsj) = " + currentPeriod.ToString() + " order by zcsj";
            ds1 = Dbsql.Query(strSql);
            for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
            {
                strSql = "select count(*) from huayao_fh where id='" + Convert.ToString(ds1.Tables[0].Rows[i]["id"]) + "'";
                DataSet dsTemp = Dbsql.Query(strSql);
                if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
                {
                    strSql = "insert into huayao_fh(id, xs_sn, dw, division, customer_type, customer, zcsj, kcsj, carno, ";
                    strSql += "goodsname, amount_mao, amount_pi, amount_jing, price, money, amount_hd, hdrq, amount_pc, notes, notes_hd, ys_qyyfdj, ys_qyyfje,";
                    strSql += "price_material, money_material, yf_sjyfdj, yf_sjyfje, money_material_k, writeoffState, flowState, createTime, updateTime, yfjsfs)";
                    strSql += " select id, xs_sn, dw, division, customer_type, customer, zcsj, kcsj, carno,goodsname, amount_mao, amount_pi, amount_jing, price, money, amount_hd, hdrq, amount_pc, notes, notes_hd, ys_qyyfdj, ys_qyyfje,";
                    strSql += "price_material, money_material, yf_sjyfdj, yf_sjyfje, money_material_k, writeoffState, flowState, createTime, updateTime, yfjsfs ";
                    strSql += "from huayao_fhtemp where id='" + Convert.ToString(ds1.Tables[0].Rows[i]["id"]) + "'";
                    Dbsql.ExecuteSql(strSql);
                }
                else
                {
                    Console.WriteLine(Convert.ToString(ds1.Tables[0].Rows[i]["xs_sn"])+"，"+ Convert.ToString(ds1.Tables[0].Rows[i]["id"]));
                }
            }

            //拉取整月数据后，同步更新相关的数据
            strSql = "update huayao_fh set dw=b.dw,customer_type=b.customer_type,customer=b.customer,zcsj=b.zcsj,yfjsfs=b.yfjsfs,amount_hd=b.amount_hd,hdrq=b.hdrq,amount_jing=b.amount_jing";
            strSql += ",money=b.money,price=b.price,amount_pc=b.amount_pc,price_material=b.price_material,money_material=b.money_material ";
            strSql += " from huayao_fh a inner join huayao_fhtemp b on b.xs_sn=a.xs_s where year(b.zcsj)=" + currentYear + " and month(b.zcsj)=" + currentPeriod;
            Dbsql.ExecuteSql(strSql);

            //上角山销售发货表
            //strSql = "select count(*) from sjs_fhtemp where year(zcsj) = " + currentYear.ToString() + " and month(zcsj) = " + currentPeriod.ToString();
            //dsRecord = Dbsql.Query(strSql);
            //if (Convert.ToInt32(dsRecord.Tables[0].Rows[0][0]) > 0)
            //{
            //    strSql = "select id,xs_sn from sjs_fh where year(zcsj) = " + currentYear.ToString() + " and month(zcsj) = " + currentPeriod.ToString() + " order by zcsj";
            //    ds = Dbsql.Query(strSql);
            //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            //    {
            //        strSql = "select count(*) from sjs_fhtemp where id='" + Convert.ToString(ds.Tables[0].Rows[i]["id"]) + "'";
            //        DataSet dsTemp = Dbsql.Query(strSql);
            //        if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
            //        {
            //            Dbsql.ExecuteSql("delete from sjs_fh where id='" + Convert.ToString(ds.Tables[0].Rows[i]["id"]) + "'");
            //        }
            //    }
            //}

            //strSql = "select id,xs_sn from sjs_fhtemp where year(zcsj) = " + currentYear.ToString() + " and month(zcsj) = " + currentPeriod.ToString() + " order by zcsj";
            //ds1 = Dbsql.Query(strSql);
            //for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
            //{
            //    strSql = "select count(*) from sjs_fh where id='" + Convert.ToString(ds1.Tables[0].Rows[i]["id"]) + "'";
            //    DataSet dsTemp = Dbsql.Query(strSql);
            //    if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
            //    {
            //        strSql = "insert into sjs_fh(id, xs_sn, dw, division, customer_type, customer, zcsj, kcsj, carno, ";
            //        strSql += "goodsname, amount_mao, amount_pi, amount_jing, price, money, amount_hd, hdrq, amount_pc, notes, notes_hd, ys_qyyfdj, ys_qyyfje,";
            //        strSql += "price_material, money_material, yf_sjyfdj, yf_sjyfje, money_material_k, writeoffState, flowState, createTime, updateTime, yfjsfs)";
            //        strSql += " select id, xs_sn, dw, division, customer_type, customer, zcsj, kcsj, carno,goodsname, amount_mao, amount_pi, amount_jing, price, money, amount_hd, hdrq, amount_pc, notes, notes_hd, ys_qyyfdj, ys_qyyfje,";
            //        strSql += "price_material, money_material, yf_sjyfdj, yf_sjyfje, money_material_k, writeoffState, flowState, createTime, updateTime, yfjsfs ";
            //        strSql += "from sjs_fhtemp where id='" + Convert.ToString(ds1.Tables[0].Rows[i]["id"]) + "'";
            //        Dbsql.ExecuteSql(strSql);
            //    }
            //    else
            //    {
            //        Console.WriteLine(Convert.ToString(ds1.Tables[0].Rows[i]["xs_sn"]) + "，" + Convert.ToString(ds1.Tables[0].Rows[i]["id"]));
            //    }
            //}

            //拉取整月数据后，同步更新相关的数据
            //strSql = "update sjs_fh set dw=b.dw,customer_type=b.customer_type,customer=b.customer,zcsj=b.zcsj,yfjsfs=b.yfjsfs,amount_hd=b.amount_hd,hdrq=b.hdrq,amount_jing=b.amount_jing";
            //strSql += ",money=b.money,price=b.price,amount_pc=b.amount_pc,price_material=b.price_material,money_material=b.money_material ";
            //strSql += " from sjs_fh a inner join sjs_fhtemp b on b.xs_sn=a.xs_s where year(b.zcsj)=" + currentYear + " and month(b.zcsj)=" + currentPeriod;
            //Dbsql.ExecuteSql(strSql);

            //开票信息表
            //strSql = "select id from tb_invoiced where year(kprq) = " + currentYear.ToString() + " and month(kprq) = " + currentPeriod.ToString() + " order by kprq";
            //DataSet ds1 = Dbsql.Query(strSql);
            //for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
            //{
            //    strSql = "select count(*) from tb_invoicedtemp where id='" + Convert.ToString(ds1.Tables[0].Rows[i]["id"]) + "'";
            //    DataSet dsTemp = Dbsql.Query(strSql);
            //    if (Convert.ToInt32(dsTemp.Tables[0].Rows[0][0]) == 0)
            //    {
            //        Dbsql.ExecuteSql("delete from tb_invoiced where id='" + Convert.ToString(ds1.Tables[0].Rows[i]["id"]) + "'");
            //    }
            //}
        }
    }
}

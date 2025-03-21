using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Collections;

namespace JiandaoyunAPI
{
    public class Dbsql
    {
        //数据库连接字符串(web.config来配置)
        public static string connectionString = ConfigurationManager.AppSettings["DB.ConnectionString"].ToString();

        //构造函数
        public Dbsql()
        {
        }

        //执行程序一般sql,不反回值
        // <summary>
        // 执行SQL语句，返回影响的记录数
        // </summary>
        // <param name="SQLString">SQL语句</param>
        // <returns>影响的记录数</returns>

        public static int ExecuteSql(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(SQLString, connection))
                {
                    try
                    {
                        connection.Open();
                        int rows = cmd.ExecuteNonQuery();
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException E)
                    {
                        connection.Close();
                        throw new Exception(E.Message);
                    }
                }
            }
        }
        // 执行带一个存储过程参数的的SQL语句。
        // <summary>
        // 执行带一个存储过程参数的的SQL语句。
        // </summary>
        // <param name="SQLString">SQL语句</param>
        // <param name="content">参数内容,比如一个字段是格式复杂的文章，有特殊符号，可以通过这个方式添加</param>
        // <returns>影响的记录数</returns>
        public static int ExecuteSql(string SQLString, string content)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(SQLString, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter("@content", SqlDbType.NText);
                myParameter.Value = content;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    throw new Exception(E.Message);
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }

        //执行带有多个参数的存储过程,不返回记录集
        public static void ExecuteStoreNone(string storename, Hashtable parameters)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(storename, connection);
                cmd.CommandType = CommandType.StoredProcedure;
                foreach (DictionaryEntry de in parameters)
                {
                    if (IsInteger(de.Value.ToString()))
                        cmd.Parameters.Add("@" + de.Key, SqlDbType.Int);
                    else
                        cmd.Parameters.Add("@" + de.Key, SqlDbType.VarChar);
                    cmd.Parameters["@" + de.Key].Value = de.Value;
                }

                try
                {
                    connection.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    throw new Exception(E.Message);
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }

            }
        }

        //执行带有多个参数的存储过程,返回记录集
        public static DataSet ExecuteStoreDs(string storename, Hashtable parameters)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet ds = new DataSet();
                SqlCommand cmd = new SqlCommand(storename, connection);
                cmd.CommandType = CommandType.StoredProcedure;
                foreach (DictionaryEntry de in parameters)
                {
                    if (IsInteger(de.Value.ToString()))
                        cmd.Parameters.Add("@" + de.Key, SqlDbType.Int);
                    else
                        cmd.Parameters.Add("@" + de.Key, SqlDbType.VarChar);
                    cmd.Parameters["@" + de.Key].Value = de.Value;
                }

                try
                {
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(ds);
                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    throw new Exception(E.Message);
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
                return ds;
            }
        }

        // <summary>
        // 向数据库里插入图像格式的字段(和上面情况类似的另一种实例)
        // </summary>
        // <param name="strSQL">SQL语句</param>
        // <param name="fs">图像字节,数据库的字段类型为image的情况</param>
        // <returns>影响的记录数</returns>
        public static int ExecuteSqlInsertImg(string strSQL, byte[] fs)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(strSQL, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter("@fs", SqlDbType.Image);
                myParameter.Value = fs;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    throw new Exception(E.Message);
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }

        // <summary>
        // 执行一条计算查询结果语句，返回查询结果（object）。
        // </summary>
        // <param name="SQLString">计算查询结果语句</param>
        // <returns>查询结果（object）</returns>
        public static object GetSingle(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(SQLString, connection))
                {
                    try
                    {
                        connection.Open();
                        object obj = cmd.ExecuteScalar();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            return null;
                        }
                        else
                        {
                            return obj;
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw new Exception(e.Message);
                    }
                }
            }
        }

        // <summary>
        // 执行查询语句，返回SqlDataReader
        // </summary>
        // <param name="strSQL">查询语句</param>
        // <returns>SqlDataReader</returns>
        public static SqlDataReader ExecuteReader(string strSQL)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(strSQL, connection))
                {
                    try
                    {
                        connection.Open();
                        //SqlDataReader myReader = cmd.ExecuteReader(); //
                        SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                        //connection.Close();
                        return myReader;

                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        throw new Exception(e.Message);
                    }

                }
            }
        }

        // <summary>
        // 执行查询语句，返回DataSet
        // </summary>
        // <param name="SQLString">查询语句</param>
        // <returns>DataSet</returns>
        public static DataSet Query(string SQLString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                    command.Fill(ds, "ds");
                    connection.Close();
                    connection.Dispose();
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                return ds;
            }
        }

        //是否为整数
        public static bool IsInteger(string s)
        {
            if (s.Trim() == "")
                return false;

            char ch0 = '0';
            char ch9 = '9';
            for (int i = 0; i < s.Length; i++)
            {
                if (s[i] < ch0 || s[i] > ch9)
                    return false;
            }

            return true;
        }

        //取得指定长度的字符串
        public static string getLeftSubString(string content, int length)
        {
            System.Text.Encoding encoding = System.Text.Encoding.GetEncoding("gb2312");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            int totalLength = 0;
            foreach (char contentChar in content)
            {
                int size = encoding.GetByteCount(new char[] { contentChar });
                if (totalLength + size > length - 2)
                {
                    sb.Append("..");
                    break;
                }
                sb.Append(contentChar);
                totalLength += size;
            }
            return sb.ToString();
        }
    }
}

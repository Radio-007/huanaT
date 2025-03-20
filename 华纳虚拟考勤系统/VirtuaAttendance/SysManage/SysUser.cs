using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Windows.Forms;
using DevExpress.XtraEditors;
using GxRadio.Common;

namespace GxRadio.SysManage
{
    public partial class SysUser : DevExpress.XtraEditors.XtraForm
    {
        private string CommonSQL;
        public SysUser()
        {
            InitializeComponent();
        }

        #region 绑定数据源

        public void BindDataSource(int RowID)
        {
            DataSet ds = SqlHelper.ExecuteDs(this.CommonSQL);
            gridControl1.DataSource = ds.Tables[0];
            if (RowID > 0)
            {
                gridView1.FocusedRowHandle = gridView1.LocateByValue("ID", RowID);
            }
        }
        #endregion

        #region 数据绑定

        private void DataBound(int RowID)
        {
            DataSet ds = SqlHelper.ExecuteDs("select * from SysUser where ID=" + RowID);
            if (ds.Tables[0].Rows.Count == 0) return;

            txtUserName.Text = Convert.ToString(ds.Tables[0].Rows[0]["username"]);
            txtUserPer.Text = Convert.ToString(ds.Tables[0].Rows[0]["userPers"]);

            string[] UserPer_list = txtUserPer.Text.Split(',');
            for (int i = 0; i < listView1.Items.Count; i++)
            {
                if (UserPer_list.ToList().IndexOf(listView1.Items[i].SubItems[1].Text) > -1)
                    listView1.Items[i].Checked = true;
                else
                    listView1.Items[i].Checked = false;
            }
        }
        #endregion

        #region 验证数据

        private bool validata()
        {
            if (txtUserName.Text.Trim() == "")
            {
                MessageBox.Show("用户名不能为空", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            txtUserPer.Text = "";
            for (int i = 0; i < listView1.Items.Count; i++)
            {
                if (listView1.Items[i].Checked)
                {
                    if (txtUserPer.Text.Trim() != "")
                        txtUserPer.Text += "," + listView1.Items[i].SubItems[1].Text;
                    else
                        txtUserPer.Text = listView1.Items[i].SubItems[1].Text;
                }
            }

            return true;
        }
        #endregion

        private void SysUser_Load(object sender, EventArgs e)
        {
            listView1.Items.Clear();
            DataSet ds = SqlHelper.ExecuteDs("select * from SysPer");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                ListViewItem list = new ListViewItem();
                list.Text = "";
                list.SubItems.Add(Convert.ToString(ds.Tables[0].Rows[i]["code"]));
                list.SubItems.Add(Convert.ToString(ds.Tables[0].Rows[i]["name"]));
                listView1.Items.Add(list);
            }

            this.btnFind_Click(sender, e);
        }

        private void btnFind_Click(object sender, EventArgs e)
        {
            string strFilter = "";
            if (txtUserName.Text.Trim() != "")
                strFilter = " and username like'%" + txtUserName.Text + "%'";
            
            this.CommonSQL = "select * from SysUser where 1=1" + strFilter;
            try
            {
                this.BindDataSource(0);
            }
            finally
            {
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (!this.validata()) return;

            string strSql = "select count(*) from SysUser where username='" + txtUserName.Text + "'";
            DataSet ds = SqlHelper.ExecuteDs(strSql);
            if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) > 0)
            {
                MessageBox.Show("该用户名已经存在！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            //密码:88888888,加密后:ODg4ODg4ODg=
            try
            {
                SqlHelper.ExecuteSql("insert into SysUser(username,[password],userPers) values('" + txtUserName.Text + "','ODg4ODg4ODg=','" + txtUserPer.Text + "')");
                //重新绑定数据源
                this.BindDataSource(0);
                MessageBox.Show("添加成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch
            {
                MessageBox.Show("添加失败", "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (!this.validata()) return;

            DataRow dr = gridView1.GetFocusedDataRow();
            string id = dr["ID"].ToString();

            string strSql = "select count(*) from SysUser where username='" + txtUserName.Text + "' and ID!=" + id;
            DataSet ds = SqlHelper.ExecuteDs(strSql);
            if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) > 0)
            {
                MessageBox.Show("该用户名已经存在！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            try
            {
                SqlHelper.ExecuteSql("update SysUser set username='" + txtUserName.Text + "',userPers='" + txtUserPer.Text + "' where ID=" + id);
                //重新绑定数据源
                this.BindDataSource(Convert.ToInt32(id));
                MessageBox.Show("修改成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch
            {
                MessageBox.Show("修改失败", "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            DataRow dr = gridView1.GetFocusedDataRow();
            string id = dr["ID"].ToString();

            if (MessageBox.Show("确定要删除记录？", "删除记录", MessageBoxButtons.OKCancel) == DialogResult.Cancel) return;

            try
            {
                SqlHelper.ExecuteSql("delete from SysUser where ID=" + id);
                this.BindDataSource(0);
            }
            catch
            {
                MessageBox.Show("删除出错！");
            }
        }

        private void gridView1_FocusedRowChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs e)
        {
            DataRow dr = gridView1.GetFocusedDataRow();
            int RowID = Convert.ToInt32(dr["ID"]);
            this.DataBound(RowID);
        }

        private void btnResetPass_Click(object sender, EventArgs e)
        {
            if (txtUserName.Text.Trim() == "")
            {
                MessageBox.Show("用户名不能为空", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            try
            {
                SqlHelper.ExecuteSql("update SysUser set password='ODg4ODg4ODg=' where username='" + txtUserName.Text + "'");
                MessageBox.Show("重置密码成功，初始密码：88888888", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch
            {
                MessageBox.Show("重置密码失败", "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
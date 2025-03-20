using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using GxRadio.Common;

namespace GxRadio.SysManage
{
    public partial class ChangePassword : DevExpress.XtraEditors.XtraForm
    {
        public ChangePassword()
        {
            InitializeComponent();
        }

        private void ChangePassword_Load(object sender, EventArgs e)
        {
            txtUserName.Text = AccessController.CurrentUser.UserName;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (txtUserName.Text.Trim() == "")
            {
                MessageBox.Show("用户名不能为空", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            string strSql = "select count(*) from SysUser where username='" + txtUserName.Text + "' and password='" + SharePro.EncodeBase64(txtOld.Text.Trim()) + "'";
            DataSet ds = SqlHelper.ExecuteDs(strSql);
            if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) == 0)
            {
                MessageBox.Show("旧密码不正确", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            if (txtNew.Text.Trim() == "")
            {
                MessageBox.Show("新密码不能为空", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            if (txtNew.Text.Trim().Length < 8)
            {
                MessageBox.Show("密码太短", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            if (txtNew.Text.Trim() != txtConfirm.Text.Trim())
            {
                MessageBox.Show("密码确认不一致", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            try
            {
                SqlHelper.ExecuteSql("update SysUser set password='" + SharePro.EncodeBase64(txtNew.Text.Trim()) + "' where username='" + txtUserName.Text + "'");
                MessageBox.Show("修改登录密码成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch
            {
                MessageBox.Show("修改失败", "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            this.Close();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
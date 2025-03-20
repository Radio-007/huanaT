using System;
using System.Drawing;
using System.Windows.Forms;
using DevExpress.XtraEditors;
using DevExpress.Utils;
using GxRadio;
using GxRadio.Common;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;

namespace VirtuaAttendance
{
    public partial class Login : XtraForm
    {
        public Login()
        {
            InitializeComponent();
        }

        #region OnLoad

        protected override void OnLoad(EventArgs e)
        {
            //txtUsername.Text = SharePro.EncodeBase64("data source=192.168.30.250;initial catalog=AttendanceForRD;persist security info=True;user id=sa;password=123456;packet size=8192;connection timeout=600;");
            base.OnLoad(e);
            CloseWaitDialog();
        }
        #endregion

        #region btnExit_Click

        private void btnExit_Click(object sender, EventArgs e)
        {
            System.Environment.Exit(0); //全部退出
        }
        #endregion

        #region CreateWaitDialog

        WaitDialogForm dlg = null;
        public void CreateWaitDialog()
        {
            CreateWaitDialog("正在启动...", "请稍等...");
        }
        public void CreateWaitDialog(string caption, string title, Size size)
        {
            CloseWaitDialog();
            dlg = new DevExpress.Utils.WaitDialogForm(caption, title, size);
        }
        public void CreateWaitDialog(string caption, string title)
        {
            CloseWaitDialog();
            dlg = new DevExpress.Utils.WaitDialogForm(caption, title);
        }
        public void SetWaitDialogCaption(string fCaption)
        {
            if (dlg != null)
                dlg.Caption = fCaption;
        }
        public void CloseWaitDialog()
        {
            if (dlg != null)
                dlg.Close();
        }
        #endregion

        private void btnLogin_Click(object sender, EventArgs e)
        {
            CreateWaitDialog("正在验证用户...", "请稍等...", new Size(180, 50));
            bool logined = true;
            User t_user = User.GetUser(txtUsername.Text);
            AccessController.CurrentUser = t_user;
            if (AccessController.CurrentUser == null)
            {
                MessageBox.Show("用户名不存在！", "警告", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                logined = false;
            }
            else
            {
                string pwd = AccessController.CurrentUser.UserPassword;
                if (pwd != SharePro.EncodeBase64(txtPassword.Text.Trim()))
                {
                    MessageBox.Show("输入密码错误！", "警告", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    logined = false;
                }
            }
            CloseWaitDialog();
            if (logined) this.DialogResult = DialogResult.OK;
        }
    }
}

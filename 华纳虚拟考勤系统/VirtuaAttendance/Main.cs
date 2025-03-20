using System;
using System.Drawing;
using System.Windows.Forms;
using System.Reflection;
using DevExpress.Utils;
using GxRadio.SysManage;
using GxRadio.Common;
using VirtuaAttendance.Attendance;
using VirtuaAttendance.JiandaoyunAPI;
using VirtuaAttendance.Report;

namespace VirtuaAttendance
{
    public partial class Main : DevExpress.XtraBars.Ribbon.RibbonForm
    {
        public Main()
        {
            InitializeComponent();
        }

        private void Main_Load(object sender, EventArgs e)
        {
            if (AccessController.CurrentUser == null) Login();
        }

        #region Login
        public void Login()
        {
            using (Login frmLogin = new Login())
            {
                DialogResult result = frmLogin.ShowDialog();
                switch (result)
                {
                    case DialogResult.OK:
                        break;
                    default:
                        break;
                }
            }
            if (AccessController.CurrentUser != null)
                currUsername.Caption = string.Format("当前用户：{0}{1}             ", AccessController.CurrentUser.CompanyName, AccessController.CurrentUser.UserName);
            else
                currUsername.Caption = "——未登录——            ";
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

        #region ShowWindow

        public void ShowWindow(Type windowType, bool isDialog)
        {
            foreach (Form child in this.MdiChildren)
            {
                if (child.GetType() == windowType && !child.IsDisposed)
                {
                    child.Activate();
                    return;
                }
                else
                {
                    child.Close();
                }
            }

            ConstructorInfo constructorInfoObj = windowType.GetConstructor(Type.EmptyTypes);

            if (constructorInfoObj == null)
                MessageBox.Show(windowType.FullName + "没有不带参数的构造器");
            else
            {
                CreateWaitDialog("正在查询...", "请稍等", new Size(160, 50));

                Form ret = constructorInfoObj.Invoke(null) as Form;

                CloseWaitDialog();

                if (isDialog)
                    ret.ShowDialog();
                else
                {
                    ret.MdiParent = this;
                    ret.Show();
                }
            }
        }
        #endregion

        private void Main_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("你确定要退出系统?", "警告", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning) == DialogResult.OK)
                e.Cancel = false;
            else
                e.Cancel = true;
        }

        private void ribbonControl1_SelectedPageChanging(object sender, DevExpress.XtraBars.Ribbon.RibbonPageChangingEventArgs e)
        {
            switch (e.Page.Text)
            {
                case "简道云API数据":
                    ShowWindow(typeof(ProjectMembers), false);
                    break;
                case "每日考勤表":
                    ShowWindow(typeof(OnWorkRecForProject), false);
                    break;
                //case "野外工作":
                //    ShowWindow(typeof(LBWorkTimeDetail), false);
                //    break;
                //case "护林员考勤":
                //    ShowWindow(typeof(PatrolRecord), false);
                //    break;
                //case "炊事员考勤":
                //    ShowWindow(typeof(Hwagain.MobileGPSSystem.Attendance.CookerGotoWork), false);
                //    break;
                //case "工作记录":
                //    ShowWindow(typeof(LdWorkPlan), false);
                //    break;
                case "统计报表":
                    ShowWindow(typeof(RptWorkForProject), false);
                    break;
                //case "日志":
                //    ShowWindow(typeof(GoToOrOffWorkLog), false);
                //    break;
                case "系统管理":
                    if (AccessController.HasPerByCode("01"))  //用户管理
                    {
                        ShowWindow(typeof(SysUser), false);
                    }
                    break;
                default:
                    //ShowWindow(typeof(Employee), false);
                    break;

            }
        }

        #region 用户管理
        private void btnSysUser_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (!AccessController.HasPerByCode("01"))  //用户管理
            {
                MessageBox.Show("对不起，你没有权限！", "警告", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            ShowWindow(typeof(SysUser), false);
        }
        #endregion

        //系统日志
        private void btnSysLog_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (!AccessController.HasPerByCode("01"))  //用户管理
            {
                MessageBox.Show("对不起，你没有权限！", "警告", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            ShowWindow(typeof(SysLog), false);
        }

        //研发人员上班记录
        private void btnOnWorkRec_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(OnWorkRecForProject), false);
        }

        //请假记录
        private void btnLeaveRec_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(LeaveRec), false);
        }

        //员工档案
        private void btnEmployee_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(Employee), false);
        }

        //研发项目单
        private void btnProject_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(Projects), false);
        }

        //研发项目人员
        private void btnProjectMember_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(ProjectMembers), false);
        }

        //修改密码
        private void btnChangePassword_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ChangePassword dg = new ChangePassword();
            dg.ShowDialog();
        }

        //研发人员考勤统计表
        private void btnCalProjectAttenSum_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(RptAllMembersAttenStat), false);
        }

        private void btnRptLbWorkTime_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(RptWageDistribution), false);
        }

        private void btnTestProduce_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(ProjectTestMembers), false);
        }

        private void btnOnWorkRecForTest_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(OnWorkRecForTest), false);
        }

        private void btnRptRecForProject_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(RptWorkForProject), false);
        }

        private void btnRptRecForTest_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(RptWorkForTest), false);
        }

        private void barButtonItem3_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(RptSocialSecurityDistribution), false);
        }

        private void barButtonItem5_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            ShowWindow(typeof(RptYearAttenStat), false);
        }
    }
}

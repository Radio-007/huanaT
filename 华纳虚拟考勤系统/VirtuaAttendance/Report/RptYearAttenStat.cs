using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using DevExpress.Utils;
using DevExpress.XtraBars;
using GxRadio.Common;


namespace VirtuaAttendance.Report
{
    public partial class RptYearAttenStat : DevExpress.XtraEditors.XtraForm
    {
        private string CommonSQL;
        public RptYearAttenStat()
        {
            InitializeComponent();
        }

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

        #region 检查权限

        private void CheckRight()
        {
            btnExport.Visibility = BarItemVisibility.Never;
            if (AccessController.HasPerByCode("10"))  //考勤数据导出
            {
                btnExport.Visibility = BarItemVisibility.Always;
            }
        }
        #endregion

        #region 绑定数据源

        public void BindDataSource(int RowID)
        {
            DataSet ds = SqlHelper.ExecuteDs(this.CommonSQL);
            gridControl1.DataSource = ds.Tables[0];
        }
        #endregion

        private void RptYearAttenStat_Load(object sender, EventArgs e)
        {
            cmbOrgName.Properties.Items.Clear();
            cmbOrgName.Properties.Items.Add(" ");
            DataSet ds = SqlHelper.ExecuteDs("select distinct OrgName,OrgNo from v_Department order by OrgNo");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                cmbOrgName.Properties.Items.Add(Convert.ToString(ds.Tables[0].Rows[i][0]));
            }
            if (cmbOrgName.Properties.Items.Count > 1)
                cmbOrgName.SelectedIndex = 1;
            else
                cmbOrgName.SelectedIndex = 0;

            //获取服务器时间
            DateTime currDatetime = AccessController.GetServerDateTime();
            for (int i = currDatetime.Year - 3; i < currDatetime.Year + 1; i++)
            {
                cmbYear.Properties.Items.Add(i.ToString());
            }

            //默认上个月
            cmbYear.Text = currDatetime.AddMonths(-1).Year.ToString();

            this.CheckRight(); //检查权限
            btnQuery_ItemClick(sender, e as ItemClickEventArgs);
        }

        private void btnQuery_ItemClick(object sender, ItemClickEventArgs e)
        {
            if (cmbOrgName.Text.Trim() == "")
            {
                MessageBox.Show("公司不能为空！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            this.CommonSQL = "exec RptYearAttenStatDetail '" + cmbOrgName.Text + "'," + cmbYear.Text;
            btnQuery.Enabled = false;

            try
            {
                CreateWaitDialog("正在加载...", "请稍等...");
                DataSet ds1 = SqlHelper.ExecuteDs("exec RptYearAttenStatHeader '" + cmbOrgName.Text + "'," + cmbYear.Text);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    txtEmpAllCount.Text = ds1.Tables[0].Rows[0]["EmpAllCount"].ToString();
                    txtEmpTestCount.Text = ds1.Tables[0].Rows[0]["EmpTestCount"].ToString();
                    txtEmpProjectCount.Text = ds1.Tables[0].Rows[0]["EmpProjectCount"].ToString();
                    txtQuitCount.Text = ds1.Tables[0].Rows[0]["QuitCount"].ToString();
                    txtEntryCount.Text = ds1.Tables[0].Rows[0]["EntryCount"].ToString();
                    txtEmpProjectInCount.Text = ds1.Tables[0].Rows[0]["EmpProjectInCount"].ToString();
                }
                this.BindDataSource(0);
            }
            finally
            {
                btnQuery.Enabled = true;
                CloseWaitDialog();
            }

            lblTitle.Text = cmbOrgName.Text + cmbYear.Text + "年研发考勤情况汇总表";
        }
    }
}
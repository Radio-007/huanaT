using System;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using DevExpress.Utils;
using DevExpress.XtraBars;
using GxRadio.Common;

namespace VirtuaAttendance.Report
{
    public partial class RptWageDistribution : DevExpress.XtraEditors.XtraForm
    {
        private string CommonSQL;
        public RptWageDistribution()
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
            if (RowID > 0)
            {
                gridView1.FocusedRowHandle = gridView1.LocateByValue("ID", RowID);
            }
        }
        #endregion

        private void AttendanceReport_Load(object sender, EventArgs e)
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
            for (int i = currDatetime.Year - 1; i < currDatetime.Year + 1; i++)
            {
                cmbYear.Properties.Items.Add(i.ToString());
            }

            //默认上个月
            cmbYear.Text = currDatetime.AddMonths(-1).Year.ToString(); ;
            cmbMonth.Text = currDatetime.AddMonths(-1).Month.ToString();

            this.CheckRight(); //检查权限
            btnQuery_ItemClick(sender, e as ItemClickEventArgs);
        }

        private void btnQuery_ItemClick(object sender, ItemClickEventArgs e)
        {
            string strFilter = " sYear=" + cmbYear.Text + " and sMonth=" + cmbMonth.Text;
            if (cmbOrgName.Text.Trim() != "")
                strFilter += " and OrgName='" + cmbOrgName.Text + "'";
            if (txtProjectNo.Text.Trim() != "")
                strFilter += " and ProjectNo like'%" + txtProjectNo.Text + "%'";
            if (txtProjectName.Text.Trim() != "")
                strFilter += " and ProjectName like'%" + txtProjectName.Text + "%'";
            if (txtFullName.Text.Trim() != "")
                strFilter += " and FullName like'%" + txtFullName.Text + "%'";

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select *,case when JobContent='项目负责人' then 1 when JobContent='项目成员' then 2 else 3 end as OrderNo from ProjectAttenSum");
            strSql.Append(" where " + strFilter);
            strSql.Append(" order by ProjectNo,OrderNo");
            this.CommonSQL = strSql.ToString();

            btnQuery.Enabled = false;

            try
            {
                CreateWaitDialog("正在加载...", "请稍等...");
                this.BindDataSource(0);
            }
            finally
            {
                btnQuery.Enabled = true;
                CloseWaitDialog();
            }

            lblTitle.Text = cmbOrgName.Text + cmbYear.Text + "年" + cmbMonth.Text + "月工资分配表";
        }

        private void btnExport_ItemClick(object sender, ItemClickEventArgs e)
        {
            if (gridView1.DataRowCount == 0) return;

            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.Title = "导出Excel";
            saveFileDialog.Filter = "Excel文件(*.xls)|*.xls";
            DialogResult dialogResult = saveFileDialog.ShowDialog(this);
            if (dialogResult == DialogResult.OK)
            {
                DevExpress.XtraPrinting.XlsExportOptions options = new DevExpress.XtraPrinting.XlsExportOptions();
                gridControl1.ExportToXls(saveFileDialog.FileName, options);
                DevExpress.XtraEditors.XtraMessageBox.Show("保存成功！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
    }
}
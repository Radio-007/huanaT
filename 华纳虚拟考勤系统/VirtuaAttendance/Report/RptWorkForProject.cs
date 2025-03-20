using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using DevExpress.XtraBars;
using DevExpress.Utils;
using GxRadio.Common;

namespace VirtuaAttendance.Report
{
    public partial class RptWorkForProject : DevExpress.XtraEditors.XtraForm
    {
        private string CommonSQL;
        public RptWorkForProject()
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
            btnAdd.Visibility = BarItemVisibility.Never;
            btnEdit.Visibility = BarItemVisibility.Never;
            btnDelete.Visibility = BarItemVisibility.Never;
            btnExport.Visibility = BarItemVisibility.Never;
            //if (AccessController.HasPerByCode("02"))  //上班录入
            //{
            //    btnAdd.Visibility = BarItemVisibility.Always;
            //    btnEdit.Visibility = BarItemVisibility.Always;
            //    btnDelete.Visibility = BarItemVisibility.Always;
            //    btnExport.Visibility = BarItemVisibility.Always;
            //}
            if (AccessController.HasPerByCode("10"))  //数据导出
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

        private void RptOnWorkRecForProject_Load(object sender, EventArgs e)
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
            string strFilter = " and ProjectNo is not null and Year(WorkDate)=" + cmbYear.Text + " and Month(WorkDate)=" + cmbMonth.Text;
            string strFilter1 = "";
            if (cmbOrgName.Text.Trim() != "")
                strFilter1 += " and a.OrgName='" + cmbOrgName.Text + "'";
            if (txtProjectNo.Text.Trim() != "")
                strFilter1 += " and a.ProjectNo like'%" + txtProjectNo.Text + "%'";
            if (txtProjectName.Text.Trim() != "")
                strFilter1 += " and a.ProjectName like'%" + txtProjectName.Text + "%'";

            this.CommonSQL = "select ROW_NUMBER() over(order by a.ProjectNo) as RowNo,a.*," + cmbYear.Text + " as sYear," + cmbMonth.Text + " as sMonth ";
            this.CommonSQL += " from Projects a inner join ( ";
            this.CommonSQL += " select ProjectNo from OnWorkRec where 1=1 " + strFilter + " group by ProjectNo ";
            this.CommonSQL += " ) b on b.ProjectNo=a.ProjectNo where 1=1" + strFilter1;
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

        private void gridControl1_DoubleClick(object sender, EventArgs e)
        {
            if (gridView1.DataRowCount == 0) return;

            RptOnWorkRecForProject dg = new RptOnWorkRecForProject(this);
            dg.OrgName = Convert.ToString(gridView1.GetFocusedDataRow()["OrgName"]);
            dg.ProjectNo = Convert.ToString(gridView1.GetFocusedDataRow()["ProjectNo"]);
            dg.ProjectName = Convert.ToString(gridView1.GetFocusedDataRow()["ProjectName"]);
            dg.sYear= Convert.ToInt32(gridView1.GetFocusedDataRow()["sYear"]);
            dg.sMonth = Convert.ToInt32(gridView1.GetFocusedDataRow()["sMonth"]);
            dg.ShowDialog();
        }
    }
}
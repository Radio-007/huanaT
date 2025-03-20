using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using DevExpress.XtraBars;
using DevExpress.Utils;
using GxRadio.Common;

namespace VirtuaAttendance.JiandaoyunAPI
{
    public partial class ProjectTestMembers : DevExpress.XtraEditors.XtraForm
    {
        private string CommonSQL;
        public ProjectTestMembers()
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

        private void ProjectTestMembers_Load(object sender, EventArgs e)
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

            this.CheckRight(); //检查权限
            btnQuery_ItemClick(sender, e as ItemClickEventArgs);
        }

        private void btnQuery_ItemClick(object sender, ItemClickEventArgs e)
        {
            string strFilter = "";
            if (cmbOrgName.Text.Trim() != "")
                strFilter += " and b.OrgName='" + cmbOrgName.Text + "'";
            if (txtFullName.Text.Trim() != "")
                strFilter += " and a.FullName like'%" + txtFullName.Text + "%'";
            if (txtProjectNo.Text.Trim() != "")
                strFilter += " and a.ProjectNo like'%" + txtProjectNo.Text + "%'";
            if (txtProjectName.Text.Trim() != "")
                strFilter += " and ProjectName like'%" + txtProjectName.Text + "%'";
            if (dtDate1.Text.Trim() != "")
                strFilter += " and a.StartDate>='" + dtDate1.Text + "'";
            if (dtDate2.Text.Trim() != "")
                strFilter += " and a.StartDate<'" + dtDate2.Text + " 23:59:00'";

            this.CommonSQL = "select b.ID as ProjectID,b.OrgName,b.ProjectNo,b.ProjectName,a.ID,a.ProductName,a.EmployeeNo,a.FullName,a.StartDate,a.EndDate,a.CreateTime";
            this.CommonSQL += " from ProjectTestMembers a inner join Projects b on b.ProjectNo=a.ProjectNo ";
            this.CommonSQL += " where 1=1" + strFilter;
            this.CommonSQL += " order by a.ProjectNo";
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

        private void btnAdd_ItemClick(object sender, ItemClickEventArgs e)
        {
            //
        }

        private void btnEdit_ItemClick(object sender, ItemClickEventArgs e)
        {
            //
        }

        private void btnDelete_ItemClick(object sender, ItemClickEventArgs e)
        {
            //
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
            btnEdit_ItemClick(sender, e as ItemClickEventArgs);
        }
    }
}
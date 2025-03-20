using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using DevExpress.Utils;
using DevExpress.XtraBars;
using GxRadio.Common;

namespace GxRadio.SysManage
{
    public partial class SysLog : DevExpress.XtraEditors.XtraForm
    {
        private string CommonSQL;
        public SysLog()
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

        private void PatrolLog_Load(object sender, EventArgs e)
        {
            this.CheckRight(); //检查权限

            //获取服务器时间
            DateTime currDatetime = AccessController.GetServerDateTime();
            dtDate1.Text = currDatetime.AddDays(-1).ToString("yyyy-MM-dd");
            dtDate2.Text = currDatetime.ToString("yyyy-MM-dd");
            btnQuery_ItemClick(sender, e as ItemClickEventArgs);
        }

        private void cmbCompany_SelectedValueChanged(object sender, EventArgs e)
        {
            
        }

        private void btnQuery_ItemClick(object sender, ItemClickEventArgs e)
        {
            string strFilter = "";
            if (txtLogContent.Text.Trim() != "")
                strFilter += " and logContent like'%" + txtLogContent.Text + "%'";
            if (txtUsername.Text.Trim() != "")
                strFilter += " and username like'%" + txtUsername.Text + "%'";
            if (dtDate1.Text.Trim() != "")
                strFilter += " and logTime>='" + dtDate1.Text + "'";
            if (dtDate2.Text.Trim() != "")
                strFilter += " and logTime<'" + dtDate2.Text + " 23:59:00'";

            this.CommonSQL = "select * from SysLog where 1=1" + strFilter + " order by logTime desc";

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
    }
}
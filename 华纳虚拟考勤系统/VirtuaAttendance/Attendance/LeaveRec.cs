using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using DevExpress.Utils;
using DevExpress.XtraBars;
using GxRadio.Common;

namespace VirtuaAttendance.Attendance
{
    public partial class LeaveRec : DevExpress.XtraEditors.XtraForm
    {
        private string CommonSQL;
        public LeaveRec()
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
            if (AccessController.HasPerByCode("08"))  //考勤数据录入
            {
                btnAdd.Visibility = BarItemVisibility.Always;
                btnEdit.Visibility = BarItemVisibility.Always;
                btnDelete.Visibility = BarItemVisibility.Always;
            }
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

        private void AskForLeaveRecord_Load(object sender, EventArgs e)
        {
            cmbOrgName.Properties.Items.Clear();
            cmbOrgName.Properties.Items.Add(" ");
            DataSet ds = SqlHelper.ExecuteDs("select distinct OrgName,OrgNo from v_Department order by OrgNo");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                cmbOrgName.Properties.Items.Add(Convert.ToString(ds.Tables[0].Rows[i][0]));
            }
            cmbOrgName.SelectedIndex = 0;

            //获取服务器时间
            DateTime currDatetime = AccessController.GetServerDateTime();
            dtDate1.Text = SharePro.GetFirstDayOfMonth(currDatetime).ToString("yyyy-MM-dd");
            dtDate2.Text = currDatetime.ToString("yyyy-MM-dd");

            this.CheckRight(); //检查权限
            btnQuery_ItemClick(sender, e as ItemClickEventArgs);
        }

        private void btnQuery_ItemClick(object sender, ItemClickEventArgs e)
        {
            string strFilter = "";
            if (cmbOrgName.Text.Trim() != "")
                strFilter += " and OrgName='" + cmbOrgName.Text + "'";
            if (txtFullName.Text.Trim() != "")
                strFilter += " and FullName like'%" + txtFullName.Text + "%'";
            if (cmbType.Text.Trim() != "")
                strFilter += " and LeaveType like'%" + cmbType.Text + "%'";
            if (dtDate1.Text.Trim() != "" && dtDate2.Text.Trim() != "")
                strFilter += " and '" + dtDate2.Text + " 23:59:00'>=StartTime" + " and '" + dtDate1.Text + "'<=EndTime";
            
            this.CommonSQL = "select * from Leave where 1=1" + strFilter;

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

        private void btnDelete_ItemClick(object sender, ItemClickEventArgs e)
        {
            if (MessageBox.Show("确定要删除记录？", "删除记录", MessageBoxButtons.OKCancel) == DialogResult.Cancel) return;

            DataRow dr = gridView1.GetFocusedDataRow();
            string id = dr["ID"].ToString();
            try
            {
                SqlHelper.ExecuteSql("delete from Leave where ID=" + id);
                this.BindDataSource(0);
            }
            catch
            {
                MessageBox.Show("删除出错！");
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

        private void btnAdd_ItemClick(object sender, ItemClickEventArgs e)
        {
            //AskForLeaveRecordAdd dg = new AskForLeaveRecordAdd(this);
            //dg.RecordID = 0;
            //dg.ShowDialog();
        }

        private void btnEdit_ItemClick(object sender, ItemClickEventArgs e)
        {
            if (gridView1.DataRowCount == 0) return;

            //AskForLeaveRecordAdd dg = new AskForLeaveRecordAdd(this);
            //dg.RecordID = Convert.ToInt32(gridView1.GetFocusedDataRow()["ID"]);
            //dg.ShowDialog();
        }

        private void gridControl1_DoubleClick(object sender, EventArgs e)
        {
            btnEdit_ItemClick(sender, e as ItemClickEventArgs);
        }
    }
}
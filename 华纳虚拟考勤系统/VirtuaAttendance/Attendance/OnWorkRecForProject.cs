﻿using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using DevExpress.Utils;
using DevExpress.XtraBars;
using GxRadio.Common;

namespace VirtuaAttendance.Attendance
{
    public partial class OnWorkRecForProject : DevExpress.XtraEditors.XtraForm
    {
        private string CommonSQL;
        public OnWorkRecForProject()
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
            if (AccessController.HasPerByCode("02"))  //上班录入
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

        private void OnWorkRecForProject_Load(object sender, EventArgs e)
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
            DateTime preMonDate = currDatetime.AddMonths(-1);
            dtWorkDate1.Text = preMonDate.AddDays(1 - preMonDate.Day).ToString("yyyy-MM-dd"); //上个月第一天
            dtWorkDate2.Text = preMonDate.AddDays(1 - preMonDate.Day).AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd"); //上个月最后一天
            //dtWorkDate1.Text = currDatetime.AddDays(1-currDatetime.Day).ToString("yyyy-MM-dd");  //本月第一天
            //dtWorkDate2.Text = currDatetime.ToString("yyyy-MM-dd");

            this.CheckRight(); //检查权限
            btnQuery_ItemClick(sender, e as ItemClickEventArgs);
        }

        private void btnQuery_ItemClick(object sender, ItemClickEventArgs e)
        {
            string strFilter = "";
            if (cmbOrgName.Text.Trim() != "")
                strFilter += " and b.OrgName='" + cmbOrgName.Text + "'";
            if (txtProjectNo.Text.Trim() != "")
                strFilter += " and a.ProjectNo like'%" + txtProjectNo.Text + "%'";
            if (txtProjectName.Text.Trim() != "")
                strFilter += " and c.ProjectName like'%" + txtProjectName.Text + "%'";
            if (txtFullName.Text.Trim() != "")
                strFilter += " and a.FullName like'%" + txtFullName.Text + "%'";
            if (dtWorkDate1.Text.Trim() != "")
                strFilter += " and a.WorkDate>='" + dtWorkDate1.Text + "'";
            if (dtWorkDate2.Text.Trim() != "")
                strFilter += " and a.WorkDate<'" + dtWorkDate2.Text + " 23:59:00'";
            if (cmbWorkPeriod.Text.Trim() != "")
                strFilter += " and a.Period='" + cmbWorkPeriod.Text + "'";

            this.CommonSQL = "select a.*,b.OrgName,b.Department,b.Station,c.ProjectName from OnWorkRec a inner join Employees b on b.EmployeeNo=a.EmployeeNo ";
            this.CommonSQL += "left join Projects c on c.ProjectNo=a.ProjectNo ";
            this.CommonSQL += " where 1=1" + strFilter + " order by a.ProjectNo,a.WorkDate";

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

        private void btnEdit_ItemClick(object sender, ItemClickEventArgs e)
        {
            if (gridView1.DataRowCount == 0) return;

            OnWorkRecForProjectAdd dg = new OnWorkRecForProjectAdd(this);
            dg.RecordID = Convert.ToInt32(gridView1.GetFocusedDataRow()["ID"]);
            dg.ShowDialog(); 
        }

        private void btnAdd_ItemClick(object sender, ItemClickEventArgs e)
        {
            OnWorkRecForProjectAdd dg = new OnWorkRecForProjectAdd(this);
            dg.RecordID = 0;
            dg.ShowDialog();
        }

        private void btnDelete_ItemClick(object sender, ItemClickEventArgs e)
        {
            DataRow dr = gridView1.GetFocusedDataRow();
            string id = dr["ID"].ToString();

            if (MessageBox.Show("确定要删除记录？", "删除记录", MessageBoxButtons.OKCancel) == DialogResult.Cancel) return;

            try
            {
                AccessController.WriteLog("删除上班记录：" + dr["FullName"].ToString() + ",日期:" + dr["WorkDate"].ToString() + dr["Period"].ToString());
                SqlHelper.ExecuteSql("delete from OnWorkRecForProject where ID=" + id);
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

        private void gridControl1_DoubleClick(object sender, EventArgs e)
        {
            btnEdit_ItemClick(sender, e as ItemClickEventArgs);
        }

        private void btnMakeRec_ItemClick(object sender, ItemClickEventArgs e)
        {
            //获取上月
            DateTime currDatetime = AccessController.GetServerDateTime();
            string sYear = currDatetime.AddMonths(-1).Year.ToString();
            string sMonth = currDatetime.AddMonths(-1).Month.ToString();

            if (MessageBox.Show("确定计算研发人员" + sYear + "年" + sMonth + "月的项目考勤记录？", "提示", MessageBoxButtons.OKCancel) == DialogResult.Cancel) return;

            btnMakeRec.Enabled = false;
            try
            {
                CreateWaitDialog("正在计算研发人员" + sYear + "年" + sMonth + "月的项目考勤记录...", "请稍等...");
                SqlHelper.ExecuteSql("exec TimerUpdateOnWorkRecByLeave");  //剔除请假休息
                SqlHelper.ExecuteSql("exec CalOnWorkRecForProject " + sYear + "," + sMonth);
                AccessController.WriteLog("计算研发人员" + sYear + "年" + sMonth + "月的项目考勤记录");
                MessageBox.Show("计算生成上月考勤记录成功！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            finally
            {
                btnMakeRec.Enabled = true;
                CloseWaitDialog();
            }
        }
    }
}
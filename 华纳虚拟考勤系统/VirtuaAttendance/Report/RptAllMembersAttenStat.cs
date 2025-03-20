using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using DevExpress.Utils;
using DevExpress.XtraBars;
using DevExpress.XtraGrid.Columns;
using GxRadio.Common;

namespace VirtuaAttendance.Report
{
    public partial class RptAllMembersAttenStat : DevExpress.XtraEditors.XtraForm
    {
        private string CommonSQL;
        public RptAllMembersAttenStat()
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
            btnMakeRec.Visibility = BarItemVisibility.Never;
            btnExport.Visibility = BarItemVisibility.Never;
            if (AccessController.HasPerByCode("10"))  //考勤数据导出
            {
                btnExport.Visibility = BarItemVisibility.Always;
            }
            if (AccessController.HasPerByCode("02"))  //上班记录
            {
                btnMakeRec.Visibility = BarItemVisibility.Always;
            }
        }
        #endregion

        #region 绑定数据源

        public void BindDataSource(int RowID)
        {
            DataSet ds = SqlHelper.ExecuteDs(this.CommonSQL);
            if (ds.Tables.Count == 0)
            {
                ds = SqlHelper.ExecuteDs("select FullName,IsFull,WorkDays,'' as 项目A,'' as 项目B,'' as 项目C,'' as 项目D,'' as 项目E from ProjectAttenSum where 1=0");
            }
            gridControl1.DataSource = ds.Tables[0];
        }
        #endregion

        private void RptAllMembersAttenStat_Load(object sender, EventArgs e)
        {
            //this.gridView1.BestFitColumns();//自适应列宽
            //this.gridView1.Columns[0].BestFit();//某列自动列宽

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
            cmbYear.Text = currDatetime.AddMonths(-1).Year.ToString();
            cmbMonth.Text = currDatetime.AddMonths(-1).Month.ToString();

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

            this.CommonSQL = "exec RptAllMembersAttenStat '" + cmbOrgName.Text + "'," + cmbYear.Text + "," + cmbMonth.Text;
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

            //重置gridView的列名
            this.ResetGridView();

            lblTitle.Text = cmbOrgName.Text + cmbYear.Text + "年" + cmbMonth.Text + "月研发工时分配汇总表";
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

        //设置网格gridview
        private void ResetGridView()
        {
            //设置列文字换行显示
            gridView1.OptionsView.AllowHtmlDrawHeaders = true;
            gridView1.ColumnPanelRowHeight = 90;

            if (gridView1.Columns.Count < 4)
                return;

            gridView1.Columns[0].Caption = "姓名";
            gridView1.Columns[1].Caption = "是否全职";
            gridView1.Columns[2].Caption = "总出勤天数";

            for (int i = 0; i < gridView1.Columns.Count; i++)
            {
                gridView1.Columns[i].AppearanceHeader.TextOptions.HAlignment = HorzAlignment.Center;
                gridView1.Columns[i].AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center;
                gridView1.Columns[i].OptionsColumn.AllowEdit = false;
                gridView1.Columns[i].OptionsColumn.ReadOnly = true;
                gridView1.Columns[i].OptionsFilter.AllowFilter = false;
                gridView1.Columns[i].OptionsFilter.AllowAutoFilter = false;
                if (i > 2)
                {
                    gridView1.Columns[i].Width = 160;
                    gridView1.Columns[i].AppearanceHeader.TextOptions.WordWrap = WordWrap.Wrap;
                }
            }

            //GridColumn columnSum = new GridColumn();
            //columnSum.Caption = "研发出勤天数合计";
            //columnSum.UnboundType = DevExpress.Data.UnboundColumnType.Decimal;
            //gridView1.Columns.Add(columnSum);
        }

        private void btnMakeRec_ItemClick(object sender, ItemClickEventArgs e)
        {
            //获取上月
            DateTime currDatetime = AccessController.GetServerDateTime();
            string sYear = currDatetime.AddMonths(-1).Year.ToString();
            string sMonth = currDatetime.AddMonths(-1).Month.ToString();

            if (MessageBox.Show("确定生成" + sYear + "年" + sMonth + "月的考勤汇总表？", "提示", MessageBoxButtons.OKCancel) == DialogResult.Cancel) return;

            btnMakeRec.Enabled = false;
            try
            {
                CreateWaitDialog("正在生成" + sYear + "年" + sMonth + "月的考勤汇总表...", "请稍等...");
                SqlHelper.ExecuteSql("exec CalProjectAttenSum " + sYear + "," + sMonth);
                AccessController.WriteLog("生成" + sYear + "年" + sMonth + "月的考勤汇总表");
                MessageBox.Show("生成上月考勤汇总成功！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            finally
            {
                btnMakeRec.Enabled = true;
                CloseWaitDialog();
            }
        }
    }
}
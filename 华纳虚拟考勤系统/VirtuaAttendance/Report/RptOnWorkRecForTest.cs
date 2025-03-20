using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using DevExpress.Utils;
using DevExpress.XtraBars;
using GxRadio.Common;

namespace VirtuaAttendance.Report
{
    public partial class RptOnWorkRecForTest : DevExpress.XtraEditors.XtraForm
    {
        private RptWorkForTest pForm;
        public string OrgName = "";
        public string ProjectNo = "";
        public string ProjectName = "";
        public int sYear = 0;
        public int sMonth = 0;
        public RptOnWorkRecForTest(RptWorkForTest parentForm)
        {
            InitializeComponent();
            this.pForm = parentForm;
        }

        private void RptOnWorkRecForTest_Load(object sender, EventArgs e)
        {
            lblTitle.Text = this.OrgName + this.sYear.ToString() + "年" + this.sMonth.ToString() + "月：" + this.ProjectName + "【" + this.ProjectNo + "】";
            this.BindData();
            //重置gridView的列名
            this.ResetGridView();
        }

        private void BindData()
        {
            string strSql = "exec RptOnWorkRecForTest '" + ProjectNo + "'," + sYear.ToString() + "," + sMonth.ToString();
            DataSet ds = SqlHelper.ExecuteDs(strSql);
            if (ds.Tables.Count == 0)
            {
                ds = SqlHelper.ExecuteDs("select WorkDate,Period,'' as 员工A,'' as 员工B,'' as 员工C,'' as 员工D,'' as 员工E from OnWorkRecForTest where 1=0");
            }
            gridControl1.DataSource = ds.Tables[0];

        }

        private void btnExport_Click(object sender, EventArgs e)
        {
            if (gridView1.DataRowCount == 0) return;

            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.Title = "导出Excel";
            saveFileDialog.Filter = "Excel文件(*.xls)|*.xls";
            DialogResult dialogResult = saveFileDialog.ShowDialog(this);
            if (dialogResult == DialogResult.OK)
            {
                DevExpress.XtraPrinting.XlsExportOptions options = new DevExpress.XtraPrinting.XlsExportOptions();
                options.TextExportMode = DevExpress.XtraPrinting.TextExportMode.Text; //为了能显示gridView1_CustomColumnDisplayText事件的“√”
                gridControl1.ExportToXls(saveFileDialog.FileName, options);
                DevExpress.XtraEditors.XtraMessageBox.Show("保存成功！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        //设置网格gridview
        private void ResetGridView()
        {
            if (gridView1.Columns.Count < 3)
                return;

            gridView1.Columns[0].Caption = "日期";
            gridView1.Columns[0].DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            gridView1.Columns[0].DisplayFormat.FormatString = "M-d";
            gridView1.Columns[1].Caption = "时段";

            for (int i = 0; i < gridView1.Columns.Count; i++)
            {
                gridView1.Columns[i].AppearanceHeader.TextOptions.HAlignment = HorzAlignment.Center;
                gridView1.Columns[i].AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center;
                gridView1.Columns[i].OptionsColumn.AllowEdit = false;
                gridView1.Columns[i].OptionsColumn.ReadOnly = true;
                gridView1.Columns[i].OptionsFilter.AllowFilter = false;
                gridView1.Columns[i].OptionsFilter.AllowAutoFilter = false;
                //只有第一列合并
                if (i > 0)
                {
                    gridView1.Columns[i].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.False;
                }

                //合计
                if (i > 1)
                {
                    gridView1.Columns[i].SummaryItem.DisplayFormat = "{0:n1}";//设置显示格式
                    gridView1.Columns[i].SummaryItem.SummaryType = DevExpress.Data.SummaryItemType.Sum;//设置显示类型
                }
            }
        }

        private void gridView1_CustomColumnDisplayText(object sender, DevExpress.XtraGrid.Views.Base.CustomColumnDisplayTextEventArgs e)
        {
            if (e.Value.ToString() == "0.5")
                e.DisplayText = "√";
        }
    }
}
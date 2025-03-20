namespace VirtuaAttendance.Attendance
{
    partial class OnWorkRecForProject
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            DevExpress.XtraGrid.StyleFormatCondition styleFormatCondition1 = new DevExpress.XtraGrid.StyleFormatCondition();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(OnWorkRecForProject));
            this.labelControl2 = new DevExpress.XtraEditors.LabelControl();
            this.ID = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Department = new DevExpress.XtraGrid.Columns.GridColumn();
            this.FullName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.EmployeeNo = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Station = new DevExpress.XtraGrid.Columns.GridColumn();
            this.WorkDate = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Period = new DevExpress.XtraGrid.Columns.GridColumn();
            this.OnDesc = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Remark = new DevExpress.XtraGrid.Columns.GridColumn();
            this.gridView1 = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.OrgName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.ProjectNo = new DevExpress.XtraGrid.Columns.GridColumn();
            this.ProjectName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.gridControl1 = new DevExpress.XtraGrid.GridControl();
            this.repositoryItemDateEdit1 = new DevExpress.XtraEditors.Repository.RepositoryItemDateEdit();
            this.repositoryItemComboBox1 = new DevExpress.XtraEditors.Repository.RepositoryItemComboBox();
            this.txtProjectName = new DevExpress.XtraEditors.TextEdit();
            this.labelControl1 = new DevExpress.XtraEditors.LabelControl();
            this.txtProjectNo = new DevExpress.XtraEditors.TextEdit();
            this.btnMakeRec = new DevExpress.XtraBars.BarButtonItem();
            this.splitContainerControl1 = new DevExpress.XtraEditors.SplitContainerControl();
            this.panelControl1 = new DevExpress.XtraEditors.PanelControl();
            this.cmbOrgName = new DevExpress.XtraEditors.ComboBoxEdit();
            this.labelControl4 = new DevExpress.XtraEditors.LabelControl();
            this.dtWorkDate2 = new DevExpress.XtraEditors.DateEdit();
            this.barManager1 = new DevExpress.XtraBars.BarManager(this.components);
            this.bar1 = new DevExpress.XtraBars.Bar();
            this.btnAdd = new DevExpress.XtraBars.BarButtonItem();
            this.btnEdit = new DevExpress.XtraBars.BarButtonItem();
            this.btnDelete = new DevExpress.XtraBars.BarButtonItem();
            this.btnQuery = new DevExpress.XtraBars.BarButtonItem();
            this.btnExport = new DevExpress.XtraBars.BarButtonItem();
            this.barDockControlTop = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlBottom = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlLeft = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlRight = new DevExpress.XtraBars.BarDockControl();
            this.imageCollection1 = new DevExpress.Utils.ImageCollection(this.components);
            this.dtWorkDate1 = new DevExpress.XtraEditors.DateEdit();
            this.labelControl11 = new DevExpress.XtraEditors.LabelControl();
            this.labelControl10 = new DevExpress.XtraEditors.LabelControl();
            this.cmbWorkPeriod = new DevExpress.XtraEditors.ComboBoxEdit();
            this.labelControl9 = new DevExpress.XtraEditors.LabelControl();
            this.txtFullName = new DevExpress.XtraEditors.TextEdit();
            this.labelControl3 = new DevExpress.XtraEditors.LabelControl();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemComboBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectName.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectNo.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).BeginInit();
            this.splitContainerControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cmbOrgName.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtWorkDate2.Properties.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtWorkDate2.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.imageCollection1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtWorkDate1.Properties.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtWorkDate1.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cmbWorkPeriod.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtFullName.Properties)).BeginInit();
            this.SuspendLayout();
            // 
            // labelControl2
            // 
            this.labelControl2.Location = new System.Drawing.Point(192, 15);
            this.labelControl2.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl2.Name = "labelControl2";
            this.labelControl2.Size = new System.Drawing.Size(60, 18);
            this.labelControl2.TabIndex = 46;
            this.labelControl2.Text = "项目编号";
            // 
            // ID
            // 
            this.ID.AppearanceCell.Options.UseTextOptions = true;
            this.ID.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ID.AppearanceHeader.Options.UseTextOptions = true;
            this.ID.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ID.Caption = "ID";
            this.ID.FieldName = "ID";
            this.ID.MinWidth = 23;
            this.ID.Name = "ID";
            this.ID.OptionsColumn.AllowEdit = false;
            this.ID.OptionsColumn.ReadOnly = true;
            this.ID.OptionsFilter.AllowAutoFilter = false;
            this.ID.OptionsFilter.AllowFilter = false;
            this.ID.Visible = true;
            this.ID.VisibleIndex = 0;
            this.ID.Width = 100;
            // 
            // Department
            // 
            this.Department.AppearanceHeader.Options.UseTextOptions = true;
            this.Department.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Department.Caption = "部门";
            this.Department.FieldName = "Department";
            this.Department.MinWidth = 23;
            this.Department.Name = "Department";
            this.Department.OptionsColumn.AllowEdit = false;
            this.Department.OptionsColumn.ReadOnly = true;
            this.Department.OptionsFilter.AllowAutoFilter = false;
            this.Department.OptionsFilter.AllowFilter = false;
            this.Department.Summary.AddRange(new DevExpress.XtraGrid.GridSummaryItem[] {
            new DevExpress.XtraGrid.GridColumnSummaryItem(DevExpress.Data.SummaryItemType.Count, "机构名称", "共{0}条")});
            this.Department.Visible = true;
            this.Department.VisibleIndex = 4;
            this.Department.Width = 114;
            // 
            // FullName
            // 
            this.FullName.AppearanceCell.Options.UseTextOptions = true;
            this.FullName.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.FullName.AppearanceHeader.Options.UseTextOptions = true;
            this.FullName.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.FullName.Caption = "姓名";
            this.FullName.FieldName = "FullName";
            this.FullName.MinWidth = 23;
            this.FullName.Name = "FullName";
            this.FullName.OptionsColumn.AllowEdit = false;
            this.FullName.OptionsColumn.ReadOnly = true;
            this.FullName.OptionsFilter.AllowAutoFilter = false;
            this.FullName.OptionsFilter.AllowFilter = false;
            this.FullName.Visible = true;
            this.FullName.VisibleIndex = 1;
            this.FullName.Width = 80;
            // 
            // EmployeeNo
            // 
            this.EmployeeNo.AppearanceCell.Options.UseTextOptions = true;
            this.EmployeeNo.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.EmployeeNo.AppearanceHeader.Options.UseTextOptions = true;
            this.EmployeeNo.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.EmployeeNo.Caption = "工号";
            this.EmployeeNo.FieldName = "EmployeeNo";
            this.EmployeeNo.MinWidth = 23;
            this.EmployeeNo.Name = "EmployeeNo";
            this.EmployeeNo.OptionsColumn.AllowEdit = false;
            this.EmployeeNo.OptionsColumn.ReadOnly = true;
            this.EmployeeNo.OptionsFilter.AllowAutoFilter = false;
            this.EmployeeNo.OptionsFilter.AllowFilter = false;
            this.EmployeeNo.Visible = true;
            this.EmployeeNo.VisibleIndex = 2;
            this.EmployeeNo.Width = 100;
            // 
            // Station
            // 
            this.Station.AppearanceHeader.Options.UseTextOptions = true;
            this.Station.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Station.Caption = "职务";
            this.Station.FieldName = "Station";
            this.Station.MinWidth = 23;
            this.Station.Name = "Station";
            this.Station.OptionsColumn.AllowEdit = false;
            this.Station.OptionsColumn.ReadOnly = true;
            this.Station.OptionsFilter.AllowAutoFilter = false;
            this.Station.OptionsFilter.AllowFilter = false;
            this.Station.Visible = true;
            this.Station.VisibleIndex = 5;
            this.Station.Width = 114;
            // 
            // WorkDate
            // 
            this.WorkDate.AppearanceHeader.Options.UseTextOptions = true;
            this.WorkDate.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.WorkDate.Caption = "日期";
            this.WorkDate.DisplayFormat.FormatString = "yyyy-MM-dd";
            this.WorkDate.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.WorkDate.FieldName = "WorkDate";
            this.WorkDate.MinWidth = 23;
            this.WorkDate.Name = "WorkDate";
            this.WorkDate.OptionsColumn.AllowEdit = false;
            this.WorkDate.OptionsColumn.ReadOnly = true;
            this.WorkDate.OptionsFilter.AllowAutoFilter = false;
            this.WorkDate.OptionsFilter.AllowFilter = false;
            this.WorkDate.Visible = true;
            this.WorkDate.VisibleIndex = 8;
            this.WorkDate.Width = 100;
            // 
            // Period
            // 
            this.Period.AppearanceCell.Options.UseTextOptions = true;
            this.Period.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Period.AppearanceHeader.Options.UseTextOptions = true;
            this.Period.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Period.Caption = "时段";
            this.Period.FieldName = "Period";
            this.Period.MinWidth = 23;
            this.Period.Name = "Period";
            this.Period.OptionsColumn.AllowEdit = false;
            this.Period.OptionsColumn.ReadOnly = true;
            this.Period.OptionsFilter.AllowAutoFilter = false;
            this.Period.OptionsFilter.AllowFilter = false;
            this.Period.Visible = true;
            this.Period.VisibleIndex = 9;
            this.Period.Width = 69;
            // 
            // OnDesc
            // 
            this.OnDesc.AppearanceCell.Options.UseTextOptions = true;
            this.OnDesc.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.OnDesc.AppearanceHeader.Options.UseTextOptions = true;
            this.OnDesc.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.OnDesc.Caption = "出勤";
            this.OnDesc.FieldName = "OnDesc";
            this.OnDesc.MinWidth = 23;
            this.OnDesc.Name = "OnDesc";
            this.OnDesc.OptionsColumn.AllowEdit = false;
            this.OnDesc.OptionsColumn.ReadOnly = true;
            this.OnDesc.OptionsFilter.AllowAutoFilter = false;
            this.OnDesc.OptionsFilter.AllowFilter = false;
            this.OnDesc.Visible = true;
            this.OnDesc.VisibleIndex = 10;
            this.OnDesc.Width = 80;
            // 
            // Remark
            // 
            this.Remark.AppearanceHeader.Options.UseTextOptions = true;
            this.Remark.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Remark.Caption = "备注";
            this.Remark.FieldName = "Remark";
            this.Remark.MinWidth = 23;
            this.Remark.Name = "Remark";
            this.Remark.OptionsColumn.AllowEdit = false;
            this.Remark.OptionsColumn.ReadOnly = true;
            this.Remark.OptionsFilter.AllowAutoFilter = false;
            this.Remark.OptionsFilter.AllowFilter = false;
            this.Remark.Visible = true;
            this.Remark.VisibleIndex = 11;
            this.Remark.Width = 160;
            // 
            // gridView1
            // 
            this.gridView1.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder;
            this.gridView1.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.ID,
            this.FullName,
            this.EmployeeNo,
            this.OrgName,
            this.Department,
            this.Station,
            this.ProjectNo,
            this.ProjectName,
            this.WorkDate,
            this.Period,
            this.OnDesc,
            this.Remark});
            this.gridView1.DetailHeight = 450;
            this.gridView1.FixedLineWidth = 3;
            styleFormatCondition1.Appearance.ForeColor = System.Drawing.Color.Red;
            styleFormatCondition1.Appearance.Options.UseForeColor = true;
            styleFormatCondition1.Appearance.Options.UseTextOptions = true;
            styleFormatCondition1.ApplyToRow = true;
            styleFormatCondition1.Condition = DevExpress.XtraGrid.FormatConditionEnum.Equal;
            styleFormatCondition1.Expression = "[审核状态] == [0]";
            styleFormatCondition1.Value1 = 0;
            this.gridView1.FormatConditions.AddRange(new DevExpress.XtraGrid.StyleFormatCondition[] {
            styleFormatCondition1});
            this.gridView1.GridControl = this.gridControl1;
            this.gridView1.Name = "gridView1";
            this.gridView1.OptionsView.ColumnAutoWidth = false;
            this.gridView1.OptionsView.ShowFooter = true;
            this.gridView1.OptionsView.ShowGroupPanel = false;
            // 
            // OrgName
            // 
            this.OrgName.AppearanceCell.Options.UseTextOptions = true;
            this.OrgName.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.OrgName.AppearanceHeader.Options.UseTextOptions = true;
            this.OrgName.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.OrgName.Caption = "公司";
            this.OrgName.FieldName = "OrgName";
            this.OrgName.MinWidth = 25;
            this.OrgName.Name = "OrgName";
            this.OrgName.OptionsColumn.AllowEdit = false;
            this.OrgName.OptionsColumn.ReadOnly = true;
            this.OrgName.OptionsFilter.AllowAutoFilter = false;
            this.OrgName.OptionsFilter.AllowFilter = false;
            this.OrgName.Visible = true;
            this.OrgName.VisibleIndex = 3;
            this.OrgName.Width = 90;
            // 
            // ProjectNo
            // 
            this.ProjectNo.AppearanceCell.Options.UseTextOptions = true;
            this.ProjectNo.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectNo.AppearanceHeader.Options.UseTextOptions = true;
            this.ProjectNo.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectNo.Caption = "项目编号";
            this.ProjectNo.FieldName = "ProjectNo";
            this.ProjectNo.MinWidth = 25;
            this.ProjectNo.Name = "ProjectNo";
            this.ProjectNo.OptionsColumn.AllowEdit = false;
            this.ProjectNo.OptionsColumn.ReadOnly = true;
            this.ProjectNo.OptionsFilter.AllowAutoFilter = false;
            this.ProjectNo.OptionsFilter.AllowFilter = false;
            this.ProjectNo.Visible = true;
            this.ProjectNo.VisibleIndex = 6;
            this.ProjectNo.Width = 130;
            // 
            // ProjectName
            // 
            this.ProjectName.AppearanceHeader.Options.UseTextOptions = true;
            this.ProjectName.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectName.Caption = "项目名称";
            this.ProjectName.FieldName = "ProjectName";
            this.ProjectName.MinWidth = 25;
            this.ProjectName.Name = "ProjectName";
            this.ProjectName.OptionsColumn.AllowEdit = false;
            this.ProjectName.OptionsColumn.ReadOnly = true;
            this.ProjectName.OptionsFilter.AllowAutoFilter = false;
            this.ProjectName.OptionsFilter.AllowFilter = false;
            this.ProjectName.Visible = true;
            this.ProjectName.VisibleIndex = 7;
            this.ProjectName.Width = 300;
            // 
            // gridControl1
            // 
            this.gridControl1.Cursor = System.Windows.Forms.Cursors.Default;
            this.gridControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gridControl1.EmbeddedNavigator.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.gridControl1.Location = new System.Drawing.Point(0, 0);
            this.gridControl1.MainView = this.gridView1;
            this.gridControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.gridControl1.Name = "gridControl1";
            this.gridControl1.RepositoryItems.AddRange(new DevExpress.XtraEditors.Repository.RepositoryItem[] {
            this.repositoryItemDateEdit1,
            this.repositoryItemComboBox1});
            this.gridControl1.Size = new System.Drawing.Size(1152, 381);
            this.gridControl1.TabIndex = 19;
            this.gridControl1.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gridView1});
            this.gridControl1.DoubleClick += new System.EventHandler(this.gridControl1_DoubleClick);
            // 
            // repositoryItemDateEdit1
            // 
            this.repositoryItemDateEdit1.AutoHeight = false;
            this.repositoryItemDateEdit1.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.repositoryItemDateEdit1.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton()});
            this.repositoryItemDateEdit1.Name = "repositoryItemDateEdit1";
            this.repositoryItemDateEdit1.NullDate = "";
            // 
            // repositoryItemComboBox1
            // 
            this.repositoryItemComboBox1.AutoHeight = false;
            this.repositoryItemComboBox1.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.repositoryItemComboBox1.Items.AddRange(new object[] {
            "元/提",
            "元/包",
            "元/盒",
            "元/条"});
            this.repositoryItemComboBox1.Name = "repositoryItemComboBox1";
            // 
            // txtProjectName
            // 
            this.txtProjectName.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtProjectName.Location = new System.Drawing.Point(448, 14);
            this.txtProjectName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtProjectName.Name = "txtProjectName";
            this.txtProjectName.Size = new System.Drawing.Size(112, 24);
            this.txtProjectName.TabIndex = 49;
            // 
            // labelControl1
            // 
            this.labelControl1.Location = new System.Drawing.Point(383, 16);
            this.labelControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl1.Name = "labelControl1";
            this.labelControl1.Size = new System.Drawing.Size(60, 18);
            this.labelControl1.TabIndex = 48;
            this.labelControl1.Text = "项目名称";
            // 
            // txtProjectNo
            // 
            this.txtProjectNo.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtProjectNo.Location = new System.Drawing.Point(257, 13);
            this.txtProjectNo.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtProjectNo.Name = "txtProjectNo";
            this.txtProjectNo.Size = new System.Drawing.Size(100, 24);
            this.txtProjectNo.TabIndex = 47;
            // 
            // btnMakeRec
            // 
            this.btnMakeRec.Caption = "生成上月考勤记录";
            this.btnMakeRec.Id = 5;
            this.btnMakeRec.ImageOptions.ImageIndex = 9;
            this.btnMakeRec.ImageOptions.LargeImageIndex = 9;
            this.btnMakeRec.Name = "btnMakeRec";
            this.btnMakeRec.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            this.btnMakeRec.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnMakeRec_ItemClick);
            // 
            // splitContainerControl1
            // 
            this.splitContainerControl1.Cursor = System.Windows.Forms.Cursors.Default;
            this.splitContainerControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainerControl1.Horizontal = false;
            this.splitContainerControl1.Location = new System.Drawing.Point(0, 35);
            this.splitContainerControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.splitContainerControl1.Name = "splitContainerControl1";
            this.splitContainerControl1.Panel1.Controls.Add(this.panelControl1);
            this.splitContainerControl1.Panel1.Text = "Panel1";
            this.splitContainerControl1.Panel2.Controls.Add(this.gridControl1);
            this.splitContainerControl1.Panel2.Text = "Panel2";
            this.splitContainerControl1.Size = new System.Drawing.Size(1152, 443);
            this.splitContainerControl1.SplitterPosition = 52;
            this.splitContainerControl1.TabIndex = 4;
            this.splitContainerControl1.Text = "splitContainerControl1";
            // 
            // panelControl1
            // 
            this.panelControl1.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder;
            this.panelControl1.Controls.Add(this.cmbOrgName);
            this.panelControl1.Controls.Add(this.labelControl4);
            this.panelControl1.Controls.Add(this.txtProjectName);
            this.panelControl1.Controls.Add(this.labelControl1);
            this.panelControl1.Controls.Add(this.txtProjectNo);
            this.panelControl1.Controls.Add(this.labelControl2);
            this.panelControl1.Controls.Add(this.dtWorkDate2);
            this.panelControl1.Controls.Add(this.dtWorkDate1);
            this.panelControl1.Controls.Add(this.labelControl11);
            this.panelControl1.Controls.Add(this.labelControl10);
            this.panelControl1.Controls.Add(this.cmbWorkPeriod);
            this.panelControl1.Controls.Add(this.labelControl9);
            this.panelControl1.Controls.Add(this.txtFullName);
            this.panelControl1.Controls.Add(this.labelControl3);
            this.panelControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelControl1.Location = new System.Drawing.Point(0, 0);
            this.panelControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.panelControl1.Name = "panelControl1";
            this.panelControl1.Size = new System.Drawing.Size(1152, 52);
            this.panelControl1.TabIndex = 1;
            // 
            // cmbOrgName
            // 
            this.cmbOrgName.Cursor = System.Windows.Forms.Cursors.Default;
            this.cmbOrgName.EditValue = "";
            this.cmbOrgName.Location = new System.Drawing.Point(60, 14);
            this.cmbOrgName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbOrgName.Name = "cmbOrgName";
            this.cmbOrgName.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cmbOrgName.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            this.cmbOrgName.Size = new System.Drawing.Size(105, 24);
            this.cmbOrgName.TabIndex = 51;
            // 
            // labelControl4
            // 
            this.labelControl4.Location = new System.Drawing.Point(26, 17);
            this.labelControl4.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl4.Name = "labelControl4";
            this.labelControl4.Size = new System.Drawing.Size(30, 18);
            this.labelControl4.TabIndex = 50;
            this.labelControl4.Text = "公司";
            // 
            // dtWorkDate2
            // 
            this.dtWorkDate2.EditValue = null;
            this.dtWorkDate2.Location = new System.Drawing.Point(1049, 14);
            this.dtWorkDate2.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dtWorkDate2.MenuManager = this.barManager1;
            this.dtWorkDate2.Name = "dtWorkDate2";
            this.dtWorkDate2.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dtWorkDate2.Properties.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dtWorkDate2.Properties.DisplayFormat.FormatString = "yyyy-MM-dd";
            this.dtWorkDate2.Properties.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.dtWorkDate2.Size = new System.Drawing.Size(103, 24);
            this.dtWorkDate2.TabIndex = 35;
            // 
            // barManager1
            // 
            this.barManager1.Bars.AddRange(new DevExpress.XtraBars.Bar[] {
            this.bar1});
            this.barManager1.DockControls.Add(this.barDockControlTop);
            this.barManager1.DockControls.Add(this.barDockControlBottom);
            this.barManager1.DockControls.Add(this.barDockControlLeft);
            this.barManager1.DockControls.Add(this.barDockControlRight);
            this.barManager1.Form = this;
            this.barManager1.Images = this.imageCollection1;
            this.barManager1.Items.AddRange(new DevExpress.XtraBars.BarItem[] {
            this.btnAdd,
            this.btnEdit,
            this.btnDelete,
            this.btnQuery,
            this.btnExport,
            this.btnMakeRec});
            this.barManager1.LargeImages = this.imageCollection1;
            this.barManager1.MaxItemId = 6;
            // 
            // bar1
            // 
            this.bar1.BarName = "工具";
            this.bar1.DockCol = 0;
            this.bar1.DockRow = 0;
            this.bar1.DockStyle = DevExpress.XtraBars.BarDockStyle.Top;
            this.bar1.LinksPersistInfo.AddRange(new DevExpress.XtraBars.LinkPersistInfo[] {
            new DevExpress.XtraBars.LinkPersistInfo(this.btnAdd),
            new DevExpress.XtraBars.LinkPersistInfo(this.btnEdit),
            new DevExpress.XtraBars.LinkPersistInfo(this.btnDelete),
            new DevExpress.XtraBars.LinkPersistInfo(this.btnQuery),
            new DevExpress.XtraBars.LinkPersistInfo(this.btnExport),
            new DevExpress.XtraBars.LinkPersistInfo(this.btnMakeRec)});
            this.bar1.OptionsBar.AllowQuickCustomization = false;
            this.bar1.OptionsBar.DrawBorder = false;
            this.bar1.OptionsBar.DrawDragBorder = false;
            this.bar1.Text = "工具";
            // 
            // btnAdd
            // 
            this.btnAdd.Caption = "添加";
            this.btnAdd.Id = 0;
            this.btnAdd.ImageOptions.ImageIndex = 1;
            this.btnAdd.ImageOptions.LargeImageIndex = 1;
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            this.btnAdd.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnAdd_ItemClick);
            // 
            // btnEdit
            // 
            this.btnEdit.Caption = "修改";
            this.btnEdit.Id = 1;
            this.btnEdit.ImageOptions.ImageIndex = 2;
            this.btnEdit.ImageOptions.LargeImageIndex = 2;
            this.btnEdit.Name = "btnEdit";
            this.btnEdit.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            this.btnEdit.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnEdit_ItemClick);
            // 
            // btnDelete
            // 
            this.btnDelete.Caption = "删除";
            this.btnDelete.Id = 2;
            this.btnDelete.ImageOptions.ImageIndex = 3;
            this.btnDelete.ImageOptions.LargeImageIndex = 3;
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            this.btnDelete.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnDelete_ItemClick);
            // 
            // btnQuery
            // 
            this.btnQuery.Caption = "查询";
            this.btnQuery.Id = 3;
            this.btnQuery.ImageOptions.ImageIndex = 4;
            this.btnQuery.ImageOptions.LargeImageIndex = 4;
            this.btnQuery.Name = "btnQuery";
            this.btnQuery.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            this.btnQuery.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnQuery_ItemClick);
            // 
            // btnExport
            // 
            this.btnExport.Caption = "导出";
            this.btnExport.Id = 4;
            this.btnExport.ImageOptions.ImageIndex = 5;
            this.btnExport.ImageOptions.LargeImageIndex = 5;
            this.btnExport.Name = "btnExport";
            this.btnExport.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            this.btnExport.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnExport_ItemClick);
            // 
            // barDockControlTop
            // 
            this.barDockControlTop.CausesValidation = false;
            this.barDockControlTop.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControlTop.Location = new System.Drawing.Point(0, 0);
            this.barDockControlTop.Manager = this.barManager1;
            this.barDockControlTop.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlTop.Size = new System.Drawing.Size(1152, 35);
            // 
            // barDockControlBottom
            // 
            this.barDockControlBottom.CausesValidation = false;
            this.barDockControlBottom.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControlBottom.Location = new System.Drawing.Point(0, 478);
            this.barDockControlBottom.Manager = this.barManager1;
            this.barDockControlBottom.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlBottom.Size = new System.Drawing.Size(1152, 0);
            // 
            // barDockControlLeft
            // 
            this.barDockControlLeft.CausesValidation = false;
            this.barDockControlLeft.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControlLeft.Location = new System.Drawing.Point(0, 35);
            this.barDockControlLeft.Manager = this.barManager1;
            this.barDockControlLeft.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlLeft.Size = new System.Drawing.Size(0, 443);
            // 
            // barDockControlRight
            // 
            this.barDockControlRight.CausesValidation = false;
            this.barDockControlRight.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControlRight.Location = new System.Drawing.Point(1152, 35);
            this.barDockControlRight.Manager = this.barManager1;
            this.barDockControlRight.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlRight.Size = new System.Drawing.Size(0, 443);
            // 
            // imageCollection1
            // 
            this.imageCollection1.ImageStream = ((DevExpress.Utils.ImageCollectionStreamer)(resources.GetObject("imageCollection1.ImageStream")));
            this.imageCollection1.InsertGalleryImage("save_16x16.png", "images/save/save_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/save/save_16x16.png"), 0);
            this.imageCollection1.Images.SetKeyName(0, "save_16x16.png");
            this.imageCollection1.InsertGalleryImage("add_16x16.png", "images/actions/add_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/actions/add_16x16.png"), 1);
            this.imageCollection1.Images.SetKeyName(1, "add_16x16.png");
            this.imageCollection1.InsertGalleryImage("edit_16x16.png", "images/edit/edit_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/edit/edit_16x16.png"), 2);
            this.imageCollection1.Images.SetKeyName(2, "edit_16x16.png");
            this.imageCollection1.InsertGalleryImage("delete_16x16.png", "images/edit/delete_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/edit/delete_16x16.png"), 3);
            this.imageCollection1.Images.SetKeyName(3, "delete_16x16.png");
            this.imageCollection1.InsertGalleryImage("zoom_16x16.png", "images/zoom/zoom_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/zoom/zoom_16x16.png"), 4);
            this.imageCollection1.Images.SetKeyName(4, "zoom_16x16.png");
            this.imageCollection1.InsertGalleryImage("export_16x16.png", "images/export/export_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/export/export_16x16.png"), 5);
            this.imageCollection1.Images.SetKeyName(5, "export_16x16.png");
            this.imageCollection1.InsertGalleryImage("cancel_16x16.png", "images/actions/cancel_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/actions/cancel_16x16.png"), 6);
            this.imageCollection1.Images.SetKeyName(6, "cancel_16x16.png");
            this.imageCollection1.InsertGalleryImage("refresh_16x16.png", "images/actions/refresh_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/actions/refresh_16x16.png"), 7);
            this.imageCollection1.Images.SetKeyName(7, "refresh_16x16.png");
            this.imageCollection1.InsertGalleryImage("usergroup_16x16.png", "images/people/usergroup_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/people/usergroup_16x16.png"), 8);
            this.imageCollection1.Images.SetKeyName(8, "usergroup_16x16.png");
            this.imageCollection1.InsertGalleryImage("masterfilter_16x16.png", "images/filter/masterfilter_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/filter/masterfilter_16x16.png"), 9);
            this.imageCollection1.Images.SetKeyName(9, "masterfilter_16x16.png");
            this.imageCollection1.InsertGalleryImage("find_16x16.png", "images/find/find_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/find/find_16x16.png"), 10);
            this.imageCollection1.Images.SetKeyName(10, "find_16x16.png");
            this.imageCollection1.InsertGalleryImage("preview_16x16.png", "images/print/preview_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/print/preview_16x16.png"), 11);
            this.imageCollection1.Images.SetKeyName(11, "preview_16x16.png");
            this.imageCollection1.InsertGalleryImage("print_16x16.png", "images/print/print_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/print/print_16x16.png"), 12);
            this.imageCollection1.Images.SetKeyName(12, "print_16x16.png");
            this.imageCollection1.InsertGalleryImage("ide_16x16.png", "images/programming/ide_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/programming/ide_16x16.png"), 13);
            this.imageCollection1.Images.SetKeyName(13, "ide_16x16.png");
            this.imageCollection1.InsertGalleryImage("properties_16x16.png", "images/setup/properties_16x16.png", DevExpress.Images.ImageResourceCache.Default.GetImage("images/setup/properties_16x16.png"), 14);
            this.imageCollection1.Images.SetKeyName(14, "properties_16x16.png");
            // 
            // dtWorkDate1
            // 
            this.dtWorkDate1.EditValue = null;
            this.dtWorkDate1.Location = new System.Drawing.Point(929, 13);
            this.dtWorkDate1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dtWorkDate1.MenuManager = this.barManager1;
            this.dtWorkDate1.Name = "dtWorkDate1";
            this.dtWorkDate1.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dtWorkDate1.Properties.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dtWorkDate1.Properties.DisplayFormat.FormatString = "yyyy-MM-dd";
            this.dtWorkDate1.Properties.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.dtWorkDate1.Size = new System.Drawing.Size(103, 24);
            this.dtWorkDate1.TabIndex = 34;
            // 
            // labelControl11
            // 
            this.labelControl11.Location = new System.Drawing.Point(1035, 15);
            this.labelControl11.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl11.Name = "labelControl11";
            this.labelControl11.Size = new System.Drawing.Size(11, 18);
            this.labelControl11.TabIndex = 33;
            this.labelControl11.Text = "~";
            // 
            // labelControl10
            // 
            this.labelControl10.Location = new System.Drawing.Point(895, 16);
            this.labelControl10.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl10.Name = "labelControl10";
            this.labelControl10.Size = new System.Drawing.Size(30, 18);
            this.labelControl10.TabIndex = 31;
            this.labelControl10.Text = "日期";
            // 
            // cmbWorkPeriod
            // 
            this.cmbWorkPeriod.Cursor = System.Windows.Forms.Cursors.Default;
            this.cmbWorkPeriod.EditValue = " ";
            this.cmbWorkPeriod.Location = new System.Drawing.Point(773, 13);
            this.cmbWorkPeriod.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbWorkPeriod.Name = "cmbWorkPeriod";
            this.cmbWorkPeriod.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cmbWorkPeriod.Properties.Items.AddRange(new object[] {
            " ",
            "上午",
            "下午"});
            this.cmbWorkPeriod.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            this.cmbWorkPeriod.Size = new System.Drawing.Size(83, 24);
            this.cmbWorkPeriod.TabIndex = 30;
            // 
            // labelControl9
            // 
            this.labelControl9.Location = new System.Drawing.Point(741, 16);
            this.labelControl9.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl9.Name = "labelControl9";
            this.labelControl9.Size = new System.Drawing.Size(30, 18);
            this.labelControl9.TabIndex = 29;
            this.labelControl9.Text = "时段";
            // 
            // txtFullName
            // 
            this.txtFullName.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtFullName.Location = new System.Drawing.Point(622, 13);
            this.txtFullName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtFullName.Name = "txtFullName";
            this.txtFullName.Size = new System.Drawing.Size(97, 24);
            this.txtFullName.TabIndex = 16;
            // 
            // labelControl3
            // 
            this.labelControl3.Location = new System.Drawing.Point(590, 15);
            this.labelControl3.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl3.Name = "labelControl3";
            this.labelControl3.Size = new System.Drawing.Size(30, 18);
            this.labelControl3.TabIndex = 5;
            this.labelControl3.Text = "姓名";
            // 
            // OnWorkRecForProject
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1152, 478);
            this.Controls.Add(this.splitContainerControl1);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.Name = "OnWorkRecForProject";
            this.Text = "研发人员上班记录";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.OnWorkRecForProject_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemComboBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectName.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectNo.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).EndInit();
            this.splitContainerControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            this.panelControl1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cmbOrgName.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtWorkDate2.Properties.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtWorkDate2.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.imageCollection1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtWorkDate1.Properties.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtWorkDate1.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cmbWorkPeriod.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtFullName.Properties)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.LabelControl labelControl2;
        private DevExpress.XtraGrid.Columns.GridColumn ID;
        private DevExpress.XtraGrid.Columns.GridColumn Department;
        private DevExpress.XtraGrid.Columns.GridColumn FullName;
        private DevExpress.XtraGrid.Columns.GridColumn EmployeeNo;
        private DevExpress.XtraGrid.Columns.GridColumn Station;
        private DevExpress.XtraGrid.Columns.GridColumn WorkDate;
        private DevExpress.XtraGrid.Columns.GridColumn Period;
        private DevExpress.XtraGrid.Columns.GridColumn OnDesc;
        private DevExpress.XtraGrid.Columns.GridColumn Remark;
        public DevExpress.XtraGrid.Views.Grid.GridView gridView1;
        private DevExpress.XtraGrid.Columns.GridColumn ProjectNo;
        private DevExpress.XtraGrid.Columns.GridColumn ProjectName;
        public DevExpress.XtraGrid.GridControl gridControl1;
        private DevExpress.XtraEditors.Repository.RepositoryItemDateEdit repositoryItemDateEdit1;
        private DevExpress.XtraEditors.Repository.RepositoryItemComboBox repositoryItemComboBox1;
        private DevExpress.XtraEditors.TextEdit txtProjectName;
        private DevExpress.XtraEditors.LabelControl labelControl1;
        private DevExpress.XtraEditors.TextEdit txtProjectNo;
        private DevExpress.XtraBars.BarButtonItem btnMakeRec;
        private DevExpress.XtraEditors.SplitContainerControl splitContainerControl1;
        private DevExpress.XtraEditors.PanelControl panelControl1;
        private DevExpress.XtraEditors.DateEdit dtWorkDate2;
        private DevExpress.XtraBars.BarManager barManager1;
        private DevExpress.XtraBars.Bar bar1;
        private DevExpress.XtraBars.BarButtonItem btnAdd;
        private DevExpress.XtraBars.BarButtonItem btnEdit;
        private DevExpress.XtraBars.BarButtonItem btnDelete;
        private DevExpress.XtraBars.BarButtonItem btnQuery;
        private DevExpress.XtraBars.BarButtonItem btnExport;
        private DevExpress.XtraBars.BarDockControl barDockControlTop;
        private DevExpress.XtraBars.BarDockControl barDockControlBottom;
        private DevExpress.XtraBars.BarDockControl barDockControlLeft;
        private DevExpress.XtraBars.BarDockControl barDockControlRight;
        private DevExpress.Utils.ImageCollection imageCollection1;
        private DevExpress.XtraEditors.DateEdit dtWorkDate1;
        private DevExpress.XtraEditors.LabelControl labelControl11;
        private DevExpress.XtraEditors.LabelControl labelControl10;
        private DevExpress.XtraEditors.ComboBoxEdit cmbWorkPeriod;
        private DevExpress.XtraEditors.LabelControl labelControl9;
        private DevExpress.XtraEditors.TextEdit txtFullName;
        private DevExpress.XtraEditors.LabelControl labelControl3;
        private DevExpress.XtraEditors.ComboBoxEdit cmbOrgName;
        private DevExpress.XtraEditors.LabelControl labelControl4;
        private DevExpress.XtraGrid.Columns.GridColumn OrgName;
    }
}
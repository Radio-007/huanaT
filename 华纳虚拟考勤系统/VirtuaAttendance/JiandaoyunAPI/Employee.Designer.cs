namespace VirtuaAttendance.JiandaoyunAPI
{
    partial class Employee
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Employee));
            this.Status = new DevExpress.XtraGrid.Columns.GridColumn();
            this.gridControl1 = new DevExpress.XtraGrid.GridControl();
            this.gridView1 = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.ID = new DevExpress.XtraGrid.Columns.GridColumn();
            this.OrgName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Department = new DevExpress.XtraGrid.Columns.GridColumn();
            this.EmployeeNo = new DevExpress.XtraGrid.Columns.GridColumn();
            this.FullName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Sex = new DevExpress.XtraGrid.Columns.GridColumn();
            this.IDNo = new DevExpress.XtraGrid.Columns.GridColumn();
            this.BirthDate = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Education = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Speciality = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Position = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Station = new DevExpress.XtraGrid.Columns.GridColumn();
            this.EntryDate = new DevExpress.XtraGrid.Columns.GridColumn();
            this.QuitDate = new DevExpress.XtraGrid.Columns.GridColumn();
            this.EmployeeType = new DevExpress.XtraGrid.Columns.GridColumn();
            this.CreateTime = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemDateEdit1 = new DevExpress.XtraEditors.Repository.RepositoryItemDateEdit();
            this.repositoryItemComboBox1 = new DevExpress.XtraEditors.Repository.RepositoryItemComboBox();
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
            this.splitContainerControl1 = new DevExpress.XtraEditors.SplitContainerControl();
            this.panelControl1 = new DevExpress.XtraEditors.PanelControl();
            this.cmbOrgName = new DevExpress.XtraEditors.ComboBoxEdit();
            this.labelControl9 = new DevExpress.XtraEditors.LabelControl();
            this.txtFullName = new DevExpress.XtraEditors.TextEdit();
            this.labelControl3 = new DevExpress.XtraEditors.LabelControl();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemComboBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.imageCollection1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).BeginInit();
            this.splitContainerControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cmbOrgName.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtFullName.Properties)).BeginInit();
            this.SuspendLayout();
            // 
            // Status
            // 
            this.Status.AppearanceCell.Options.UseTextOptions = true;
            this.Status.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Status.AppearanceHeader.Options.UseTextOptions = true;
            this.Status.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Status.Caption = "员工状态";
            this.Status.FieldName = "Status";
            this.Status.MinWidth = 23;
            this.Status.Name = "Status";
            this.Status.OptionsColumn.AllowEdit = false;
            this.Status.OptionsColumn.ReadOnly = true;
            this.Status.OptionsFilter.AllowAutoFilter = false;
            this.Status.OptionsFilter.AllowFilter = false;
            this.Status.Visible = true;
            this.Status.VisibleIndex = 15;
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
            // gridView1
            // 
            this.gridView1.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder;
            this.gridView1.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.ID,
            this.OrgName,
            this.Department,
            this.EmployeeNo,
            this.FullName,
            this.Sex,
            this.IDNo,
            this.BirthDate,
            this.Education,
            this.Speciality,
            this.Position,
            this.Station,
            this.EntryDate,
            this.QuitDate,
            this.EmployeeType,
            this.Status,
            this.CreateTime});
            this.gridView1.DetailHeight = 450;
            this.gridView1.FixedLineWidth = 3;
            styleFormatCondition1.Appearance.ForeColor = System.Drawing.Color.Red;
            styleFormatCondition1.Appearance.Options.UseForeColor = true;
            styleFormatCondition1.Appearance.Options.UseTextOptions = true;
            styleFormatCondition1.ApplyToRow = true;
            styleFormatCondition1.Column = this.Status;
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
            this.OrgName.Summary.AddRange(new DevExpress.XtraGrid.GridSummaryItem[] {
            new DevExpress.XtraGrid.GridColumnSummaryItem(DevExpress.Data.SummaryItemType.Count, "OrgName", "共{0}条")});
            this.OrgName.Visible = true;
            this.OrgName.VisibleIndex = 1;
            this.OrgName.Width = 90;
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
            this.Department.Visible = true;
            this.Department.VisibleIndex = 2;
            this.Department.Width = 120;
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
            this.EmployeeNo.VisibleIndex = 3;
            this.EmployeeNo.Width = 100;
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
            this.FullName.VisibleIndex = 4;
            this.FullName.Width = 80;
            // 
            // Sex
            // 
            this.Sex.AppearanceCell.Options.UseTextOptions = true;
            this.Sex.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Sex.AppearanceHeader.Options.UseTextOptions = true;
            this.Sex.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Sex.Caption = "性别";
            this.Sex.FieldName = "Sex";
            this.Sex.MinWidth = 25;
            this.Sex.Name = "Sex";
            this.Sex.OptionsColumn.AllowEdit = false;
            this.Sex.OptionsColumn.ReadOnly = true;
            this.Sex.OptionsFilter.AllowAutoFilter = false;
            this.Sex.OptionsFilter.AllowFilter = false;
            this.Sex.Visible = true;
            this.Sex.VisibleIndex = 5;
            this.Sex.Width = 60;
            // 
            // IDNo
            // 
            this.IDNo.AppearanceCell.Options.UseTextOptions = true;
            this.IDNo.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.IDNo.AppearanceHeader.Options.UseTextOptions = true;
            this.IDNo.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.IDNo.Caption = "身份证号";
            this.IDNo.FieldName = "IDNo";
            this.IDNo.MinWidth = 25;
            this.IDNo.Name = "IDNo";
            this.IDNo.OptionsColumn.AllowEdit = false;
            this.IDNo.OptionsColumn.ReadOnly = true;
            this.IDNo.OptionsFilter.AllowAutoFilter = false;
            this.IDNo.OptionsFilter.AllowFilter = false;
            this.IDNo.Visible = true;
            this.IDNo.VisibleIndex = 6;
            this.IDNo.Width = 165;
            // 
            // BirthDate
            // 
            this.BirthDate.AppearanceHeader.Options.UseTextOptions = true;
            this.BirthDate.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.BirthDate.Caption = "出生日期";
            this.BirthDate.DisplayFormat.FormatString = "d";
            this.BirthDate.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.BirthDate.FieldName = "BirthDate";
            this.BirthDate.MinWidth = 25;
            this.BirthDate.Name = "BirthDate";
            this.BirthDate.OptionsColumn.AllowEdit = false;
            this.BirthDate.OptionsColumn.ReadOnly = true;
            this.BirthDate.OptionsFilter.AllowAutoFilter = false;
            this.BirthDate.OptionsFilter.AllowFilter = false;
            this.BirthDate.Visible = true;
            this.BirthDate.VisibleIndex = 7;
            this.BirthDate.Width = 100;
            // 
            // Education
            // 
            this.Education.AppearanceCell.Options.UseTextOptions = true;
            this.Education.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Education.AppearanceHeader.Options.UseTextOptions = true;
            this.Education.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Education.Caption = "最高学历";
            this.Education.FieldName = "Education";
            this.Education.MinWidth = 25;
            this.Education.Name = "Education";
            this.Education.OptionsColumn.AllowEdit = false;
            this.Education.OptionsColumn.ReadOnly = true;
            this.Education.OptionsFilter.AllowAutoFilter = false;
            this.Education.OptionsFilter.AllowFilter = false;
            this.Education.Visible = true;
            this.Education.VisibleIndex = 8;
            this.Education.Width = 90;
            // 
            // Speciality
            // 
            this.Speciality.AppearanceHeader.Options.UseTextOptions = true;
            this.Speciality.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Speciality.Caption = "所学专业";
            this.Speciality.FieldName = "Speciality";
            this.Speciality.MinWidth = 25;
            this.Speciality.Name = "Speciality";
            this.Speciality.OptionsColumn.AllowEdit = false;
            this.Speciality.OptionsColumn.ReadOnly = true;
            this.Speciality.OptionsFilter.AllowAutoFilter = false;
            this.Speciality.OptionsFilter.AllowFilter = false;
            this.Speciality.Visible = true;
            this.Speciality.VisibleIndex = 9;
            this.Speciality.Width = 90;
            // 
            // Position
            // 
            this.Position.AppearanceHeader.Options.UseTextOptions = true;
            this.Position.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Position.Caption = "职称";
            this.Position.FieldName = "Position";
            this.Position.MinWidth = 25;
            this.Position.Name = "Position";
            this.Position.OptionsColumn.AllowEdit = false;
            this.Position.OptionsColumn.ReadOnly = true;
            this.Position.OptionsFilter.AllowAutoFilter = false;
            this.Position.OptionsFilter.AllowFilter = false;
            this.Position.Visible = true;
            this.Position.VisibleIndex = 10;
            this.Position.Width = 90;
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
            this.Station.VisibleIndex = 11;
            this.Station.Width = 110;
            // 
            // EntryDate
            // 
            this.EntryDate.AppearanceHeader.Options.UseTextOptions = true;
            this.EntryDate.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.EntryDate.Caption = "入职时间";
            this.EntryDate.DisplayFormat.FormatString = "yyyy-MM-dd";
            this.EntryDate.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.EntryDate.FieldName = "EntryDate";
            this.EntryDate.MinWidth = 23;
            this.EntryDate.Name = "EntryDate";
            this.EntryDate.OptionsColumn.AllowEdit = false;
            this.EntryDate.OptionsColumn.ReadOnly = true;
            this.EntryDate.OptionsFilter.AllowAutoFilter = false;
            this.EntryDate.OptionsFilter.AllowFilter = false;
            this.EntryDate.Visible = true;
            this.EntryDate.VisibleIndex = 12;
            this.EntryDate.Width = 100;
            // 
            // QuitDate
            // 
            this.QuitDate.AppearanceHeader.Options.UseTextOptions = true;
            this.QuitDate.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.QuitDate.Caption = "离职时间";
            this.QuitDate.DisplayFormat.FormatString = "d";
            this.QuitDate.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.QuitDate.FieldName = "QuitDate";
            this.QuitDate.MinWidth = 23;
            this.QuitDate.Name = "QuitDate";
            this.QuitDate.OptionsColumn.AllowEdit = false;
            this.QuitDate.OptionsColumn.ReadOnly = true;
            this.QuitDate.OptionsFilter.AllowAutoFilter = false;
            this.QuitDate.OptionsFilter.AllowFilter = false;
            this.QuitDate.Visible = true;
            this.QuitDate.VisibleIndex = 13;
            this.QuitDate.Width = 100;
            // 
            // EmployeeType
            // 
            this.EmployeeType.AppearanceCell.Options.UseTextOptions = true;
            this.EmployeeType.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.EmployeeType.AppearanceHeader.Options.UseTextOptions = true;
            this.EmployeeType.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.EmployeeType.Caption = "员工类型";
            this.EmployeeType.FieldName = "EmployeeType";
            this.EmployeeType.MinWidth = 23;
            this.EmployeeType.Name = "EmployeeType";
            this.EmployeeType.OptionsColumn.AllowEdit = false;
            this.EmployeeType.OptionsColumn.ReadOnly = true;
            this.EmployeeType.OptionsFilter.AllowAutoFilter = false;
            this.EmployeeType.OptionsFilter.AllowFilter = false;
            this.EmployeeType.Visible = true;
            this.EmployeeType.VisibleIndex = 14;
            this.EmployeeType.Width = 80;
            // 
            // CreateTime
            // 
            this.CreateTime.AppearanceHeader.Options.UseTextOptions = true;
            this.CreateTime.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.CreateTime.Caption = "创建时间";
            this.CreateTime.DisplayFormat.FormatString = "yyyy-MM-dd HH:mm:ss";
            this.CreateTime.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.CreateTime.FieldName = "CreateTime";
            this.CreateTime.MinWidth = 23;
            this.CreateTime.Name = "CreateTime";
            this.CreateTime.OptionsColumn.AllowEdit = false;
            this.CreateTime.OptionsColumn.ReadOnly = true;
            this.CreateTime.OptionsFilter.AllowAutoFilter = false;
            this.CreateTime.OptionsFilter.AllowFilter = false;
            this.CreateTime.Visible = true;
            this.CreateTime.VisibleIndex = 16;
            this.CreateTime.Width = 149;
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
            this.btnExport});
            this.barManager1.LargeImages = this.imageCollection1;
            this.barManager1.MaxItemId = 5;
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
            new DevExpress.XtraBars.LinkPersistInfo(this.btnExport)});
            this.bar1.OptionsBar.AllowQuickCustomization = false;
            this.bar1.OptionsBar.DrawBorder = false;
            this.bar1.OptionsBar.DrawDragBorder = false;
            this.bar1.Text = "工具";
            // 
            // btnAdd
            // 
            this.btnAdd.ActAsDropDown = true;
            this.btnAdd.ButtonStyle = DevExpress.XtraBars.BarButtonStyle.DropDown;
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
            this.cmbOrgName.EditValue = " ";
            this.cmbOrgName.Location = new System.Drawing.Point(59, 9);
            this.cmbOrgName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbOrgName.Name = "cmbOrgName";
            this.cmbOrgName.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cmbOrgName.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            this.cmbOrgName.Size = new System.Drawing.Size(105, 24);
            this.cmbOrgName.TabIndex = 32;
            // 
            // labelControl9
            // 
            this.labelControl9.Location = new System.Drawing.Point(24, 12);
            this.labelControl9.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl9.Name = "labelControl9";
            this.labelControl9.Size = new System.Drawing.Size(30, 18);
            this.labelControl9.TabIndex = 31;
            this.labelControl9.Text = "公司";
            // 
            // txtFullName
            // 
            this.txtFullName.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtFullName.Location = new System.Drawing.Point(255, 9);
            this.txtFullName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtFullName.Name = "txtFullName";
            this.txtFullName.Size = new System.Drawing.Size(97, 24);
            this.txtFullName.TabIndex = 16;
            // 
            // labelControl3
            // 
            this.labelControl3.Location = new System.Drawing.Point(223, 11);
            this.labelControl3.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl3.Name = "labelControl3";
            this.labelControl3.Size = new System.Drawing.Size(30, 18);
            this.labelControl3.TabIndex = 5;
            this.labelControl3.Text = "姓名";
            // 
            // Employee
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1152, 478);
            this.Controls.Add(this.splitContainerControl1);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.IconOptions.Image = ((System.Drawing.Image)(resources.GetObject("Employee.IconOptions.Image")));
            this.Name = "Employee";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "员工入职档案";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.Employee_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemComboBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.imageCollection1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).EndInit();
            this.splitContainerControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            this.panelControl1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cmbOrgName.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtFullName.Properties)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        public DevExpress.XtraGrid.GridControl gridControl1;
        public DevExpress.XtraGrid.Views.Grid.GridView gridView1;
        private DevExpress.XtraGrid.Columns.GridColumn ID;
        private DevExpress.XtraGrid.Columns.GridColumn Department;
        private DevExpress.XtraGrid.Columns.GridColumn FullName;
        private DevExpress.XtraGrid.Columns.GridColumn EmployeeNo;
        private DevExpress.XtraGrid.Columns.GridColumn Station;
        private DevExpress.XtraGrid.Columns.GridColumn EntryDate;
        private DevExpress.XtraGrid.Columns.GridColumn QuitDate;
        private DevExpress.XtraGrid.Columns.GridColumn EmployeeType;
        private DevExpress.XtraGrid.Columns.GridColumn Status;
        private DevExpress.XtraGrid.Columns.GridColumn CreateTime;
        private DevExpress.XtraEditors.Repository.RepositoryItemDateEdit repositoryItemDateEdit1;
        private DevExpress.XtraEditors.Repository.RepositoryItemComboBox repositoryItemComboBox1;
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
        private DevExpress.XtraEditors.SplitContainerControl splitContainerControl1;
        private DevExpress.XtraEditors.PanelControl panelControl1;
        private DevExpress.XtraEditors.TextEdit txtFullName;
        private DevExpress.XtraEditors.LabelControl labelControl3;
        private DevExpress.Utils.ImageCollection imageCollection1;
        private DevExpress.XtraGrid.Columns.GridColumn OrgName;
        private DevExpress.XtraGrid.Columns.GridColumn Sex;
        private DevExpress.XtraGrid.Columns.GridColumn IDNo;
        private DevExpress.XtraGrid.Columns.GridColumn BirthDate;
        private DevExpress.XtraGrid.Columns.GridColumn Education;
        private DevExpress.XtraGrid.Columns.GridColumn Speciality;
        private DevExpress.XtraGrid.Columns.GridColumn Position;
        private DevExpress.XtraEditors.ComboBoxEdit cmbOrgName;
        private DevExpress.XtraEditors.LabelControl labelControl9;
    }
}
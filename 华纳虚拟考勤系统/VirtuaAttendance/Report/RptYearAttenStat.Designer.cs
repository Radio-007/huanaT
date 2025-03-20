namespace VirtuaAttendance.Report
{
    partial class RptYearAttenStat
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(RptYearAttenStat));
            DevExpress.XtraGrid.StyleFormatCondition styleFormatCondition2 = new DevExpress.XtraGrid.StyleFormatCondition();
            this.btnExport = new DevExpress.XtraBars.BarButtonItem();
            this.imageCollection1 = new DevExpress.Utils.ImageCollection(this.components);
            this.barManager1 = new DevExpress.XtraBars.BarManager(this.components);
            this.bar1 = new DevExpress.XtraBars.Bar();
            this.btnQuery = new DevExpress.XtraBars.BarButtonItem();
            this.barDockControlTop = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlBottom = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlLeft = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlRight = new DevExpress.XtraBars.BarDockControl();
            this.panelControl1 = new DevExpress.XtraEditors.PanelControl();
            this.txtEmpProjectInCount = new DevExpress.XtraEditors.TextEdit();
            this.labelControl6 = new DevExpress.XtraEditors.LabelControl();
            this.txtEntryCount = new DevExpress.XtraEditors.TextEdit();
            this.labelControl5 = new DevExpress.XtraEditors.LabelControl();
            this.txtQuitCount = new DevExpress.XtraEditors.TextEdit();
            this.labelControl4 = new DevExpress.XtraEditors.LabelControl();
            this.cmbYear = new DevExpress.XtraEditors.ComboBoxEdit();
            this.labelControl10 = new DevExpress.XtraEditors.LabelControl();
            this.txtEmpTestCount = new DevExpress.XtraEditors.TextEdit();
            this.labelControl1 = new DevExpress.XtraEditors.LabelControl();
            this.txtEmpAllCount = new DevExpress.XtraEditors.TextEdit();
            this.labelControl2 = new DevExpress.XtraEditors.LabelControl();
            this.txtEmpProjectCount = new DevExpress.XtraEditors.TextEdit();
            this.labelControl3 = new DevExpress.XtraEditors.LabelControl();
            this.splitContainerControl1 = new DevExpress.XtraEditors.SplitContainerControl();
            this.gridControl1 = new DevExpress.XtraGrid.GridControl();
            this.gridView1 = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.FullName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Sex = new DevExpress.XtraGrid.Columns.GridColumn();
            this.IsFull = new DevExpress.XtraGrid.Columns.GridColumn();
            this.ProjectNo = new DevExpress.XtraGrid.Columns.GridColumn();
            this.ProjectName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.JobContent = new DevExpress.XtraGrid.Columns.GridColumn();
            this.ProjectDays = new DevExpress.XtraGrid.Columns.GridColumn();
            this.WorkDays = new DevExpress.XtraGrid.Columns.GridColumn();
            this.YearRatio = new DevExpress.XtraGrid.Columns.GridColumn();
            this.YearProjectDays = new DevExpress.XtraGrid.Columns.GridColumn();
            this.QuitDate = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemDateEdit1 = new DevExpress.XtraEditors.Repository.RepositoryItemDateEdit();
            this.repositoryItemComboBox1 = new DevExpress.XtraEditors.Repository.RepositoryItemComboBox();
            this.cmbOrgName = new DevExpress.XtraEditors.ComboBoxEdit();
            this.labelControl7 = new DevExpress.XtraEditors.LabelControl();
            this.OrgName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.lblTitle = new DevExpress.XtraEditors.LabelControl();
            ((System.ComponentModel.ISupportInitialize)(this.imageCollection1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtEmpProjectInCount.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtEntryCount.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtQuitCount.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cmbYear.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtEmpTestCount.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtEmpAllCount.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtEmpProjectCount.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).BeginInit();
            this.splitContainerControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemComboBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cmbOrgName.Properties)).BeginInit();
            this.SuspendLayout();
            // 
            // btnExport
            // 
            this.btnExport.Caption = "导出";
            this.btnExport.Id = 4;
            this.btnExport.ImageOptions.ImageIndex = 5;
            this.btnExport.ImageOptions.LargeImageIndex = 5;
            this.btnExport.Name = "btnExport";
            this.btnExport.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
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
            new DevExpress.XtraBars.LinkPersistInfo(this.btnQuery),
            new DevExpress.XtraBars.LinkPersistInfo(this.btnExport)});
            this.bar1.OptionsBar.AllowQuickCustomization = false;
            this.bar1.OptionsBar.DrawBorder = false;
            this.bar1.OptionsBar.DrawDragBorder = false;
            this.bar1.Text = "工具";
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
            // barDockControlTop
            // 
            this.barDockControlTop.CausesValidation = false;
            this.barDockControlTop.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControlTop.Location = new System.Drawing.Point(0, 0);
            this.barDockControlTop.Manager = this.barManager1;
            this.barDockControlTop.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlTop.Size = new System.Drawing.Size(1314, 35);
            // 
            // barDockControlBottom
            // 
            this.barDockControlBottom.CausesValidation = false;
            this.barDockControlBottom.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControlBottom.Location = new System.Drawing.Point(0, 466);
            this.barDockControlBottom.Manager = this.barManager1;
            this.barDockControlBottom.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlBottom.Size = new System.Drawing.Size(1314, 0);
            // 
            // barDockControlLeft
            // 
            this.barDockControlLeft.CausesValidation = false;
            this.barDockControlLeft.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControlLeft.Location = new System.Drawing.Point(0, 35);
            this.barDockControlLeft.Manager = this.barManager1;
            this.barDockControlLeft.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlLeft.Size = new System.Drawing.Size(0, 431);
            // 
            // barDockControlRight
            // 
            this.barDockControlRight.CausesValidation = false;
            this.barDockControlRight.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControlRight.Location = new System.Drawing.Point(1314, 35);
            this.barDockControlRight.Manager = this.barManager1;
            this.barDockControlRight.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlRight.Size = new System.Drawing.Size(0, 431);
            // 
            // panelControl1
            // 
            this.panelControl1.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder;
            this.panelControl1.Controls.Add(this.lblTitle);
            this.panelControl1.Controls.Add(this.cmbOrgName);
            this.panelControl1.Controls.Add(this.labelControl7);
            this.panelControl1.Controls.Add(this.txtEmpProjectInCount);
            this.panelControl1.Controls.Add(this.labelControl6);
            this.panelControl1.Controls.Add(this.txtEntryCount);
            this.panelControl1.Controls.Add(this.labelControl5);
            this.panelControl1.Controls.Add(this.txtQuitCount);
            this.panelControl1.Controls.Add(this.labelControl4);
            this.panelControl1.Controls.Add(this.cmbYear);
            this.panelControl1.Controls.Add(this.labelControl10);
            this.panelControl1.Controls.Add(this.txtEmpTestCount);
            this.panelControl1.Controls.Add(this.labelControl1);
            this.panelControl1.Controls.Add(this.txtEmpAllCount);
            this.panelControl1.Controls.Add(this.labelControl2);
            this.panelControl1.Controls.Add(this.txtEmpProjectCount);
            this.panelControl1.Controls.Add(this.labelControl3);
            this.panelControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelControl1.Location = new System.Drawing.Point(0, 0);
            this.panelControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.panelControl1.Name = "panelControl1";
            this.panelControl1.Size = new System.Drawing.Size(1314, 88);
            this.panelControl1.TabIndex = 1;
            // 
            // txtEmpProjectInCount
            // 
            this.txtEmpProjectInCount.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtEmpProjectInCount.Location = new System.Drawing.Point(938, 51);
            this.txtEmpProjectInCount.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtEmpProjectInCount.Name = "txtEmpProjectInCount";
            this.txtEmpProjectInCount.Size = new System.Drawing.Size(85, 24);
            this.txtEmpProjectInCount.TabIndex = 54;
            // 
            // labelControl6
            // 
            this.labelControl6.Location = new System.Drawing.Point(798, 54);
            this.labelControl6.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl6.Name = "labelControl6";
            this.labelControl6.Size = new System.Drawing.Size(135, 18);
            this.labelControl6.TabIndex = 53;
            this.labelControl6.Text = "年末在研全职人员数";
            // 
            // txtEntryCount
            // 
            this.txtEntryCount.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtEntryCount.Location = new System.Drawing.Point(661, 51);
            this.txtEntryCount.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtEntryCount.Name = "txtEntryCount";
            this.txtEntryCount.Size = new System.Drawing.Size(85, 24);
            this.txtEntryCount.TabIndex = 52;
            // 
            // labelControl5
            // 
            this.labelControl5.Location = new System.Drawing.Point(536, 54);
            this.labelControl5.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl5.Name = "labelControl5";
            this.labelControl5.Size = new System.Drawing.Size(120, 18);
            this.labelControl5.TabIndex = 51;
            this.labelControl5.Text = "项目组人员现存数";
            // 
            // txtQuitCount
            // 
            this.txtQuitCount.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtQuitCount.Location = new System.Drawing.Point(369, 51);
            this.txtQuitCount.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtQuitCount.Name = "txtQuitCount";
            this.txtQuitCount.Size = new System.Drawing.Size(85, 24);
            this.txtQuitCount.TabIndex = 50;
            // 
            // labelControl4
            // 
            this.labelControl4.Location = new System.Drawing.Point(229, 54);
            this.labelControl4.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl4.Name = "labelControl4";
            this.labelControl4.Size = new System.Drawing.Size(135, 18);
            this.labelControl4.TabIndex = 49;
            this.labelControl4.Text = "项目组离职人员总数";
            // 
            // cmbYear
            // 
            this.cmbYear.Cursor = System.Windows.Forms.Cursors.Default;
            this.cmbYear.EditValue = "";
            this.cmbYear.Location = new System.Drawing.Point(92, 51);
            this.cmbYear.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbYear.Name = "cmbYear";
            this.cmbYear.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cmbYear.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            this.cmbYear.Size = new System.Drawing.Size(88, 24);
            this.cmbYear.TabIndex = 48;
            // 
            // labelControl10
            // 
            this.labelControl10.Location = new System.Drawing.Point(28, 54);
            this.labelControl10.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl10.Name = "labelControl10";
            this.labelControl10.Size = new System.Drawing.Size(60, 18);
            this.labelControl10.TabIndex = 47;
            this.labelControl10.Text = "统计年份";
            // 
            // txtEmpTestCount
            // 
            this.txtEmpTestCount.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtEmpTestCount.Location = new System.Drawing.Point(661, 15);
            this.txtEmpTestCount.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtEmpTestCount.Name = "txtEmpTestCount";
            this.txtEmpTestCount.Size = new System.Drawing.Size(85, 24);
            this.txtEmpTestCount.TabIndex = 45;
            // 
            // labelControl1
            // 
            this.labelControl1.Location = new System.Drawing.Point(506, 18);
            this.labelControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl1.Name = "labelControl1";
            this.labelControl1.Size = new System.Drawing.Size(150, 18);
            this.labelControl1.TabIndex = 44;
            this.labelControl1.Text = "研发中试辅助人员总数";
            // 
            // txtEmpAllCount
            // 
            this.txtEmpAllCount.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtEmpAllCount.Location = new System.Drawing.Point(369, 15);
            this.txtEmpAllCount.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtEmpAllCount.Name = "txtEmpAllCount";
            this.txtEmpAllCount.Size = new System.Drawing.Size(85, 24);
            this.txtEmpAllCount.TabIndex = 43;
            // 
            // labelControl2
            // 
            this.labelControl2.Location = new System.Drawing.Point(213, 18);
            this.labelControl2.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl2.Name = "labelControl2";
            this.labelControl2.Size = new System.Drawing.Size(150, 18);
            this.labelControl2.TabIndex = 42;
            this.labelControl2.Text = "年度参与考勤人员总数";
            // 
            // txtEmpProjectCount
            // 
            this.txtEmpProjectCount.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtEmpProjectCount.Location = new System.Drawing.Point(938, 15);
            this.txtEmpProjectCount.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtEmpProjectCount.Name = "txtEmpProjectCount";
            this.txtEmpProjectCount.Size = new System.Drawing.Size(85, 24);
            this.txtEmpProjectCount.TabIndex = 16;
            // 
            // labelControl3
            // 
            this.labelControl3.Location = new System.Drawing.Point(798, 18);
            this.labelControl3.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl3.Name = "labelControl3";
            this.labelControl3.Size = new System.Drawing.Size(135, 18);
            this.labelControl3.TabIndex = 5;
            this.labelControl3.Text = "全年全职研发人员数";
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
            this.splitContainerControl1.Size = new System.Drawing.Size(1314, 431);
            this.splitContainerControl1.SplitterPosition = 88;
            this.splitContainerControl1.TabIndex = 5;
            this.splitContainerControl1.Text = "splitContainerControl1";
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
            this.gridControl1.Size = new System.Drawing.Size(1314, 333);
            this.gridControl1.TabIndex = 19;
            this.gridControl1.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gridView1});
            // 
            // gridView1
            // 
            this.gridView1.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder;
            this.gridView1.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.OrgName,
            this.FullName,
            this.Sex,
            this.IsFull,
            this.ProjectNo,
            this.ProjectName,
            this.JobContent,
            this.ProjectDays,
            this.WorkDays,
            this.YearRatio,
            this.YearProjectDays,
            this.QuitDate});
            this.gridView1.DetailHeight = 450;
            this.gridView1.FixedLineWidth = 3;
            styleFormatCondition2.Appearance.ForeColor = System.Drawing.Color.Red;
            styleFormatCondition2.Appearance.Options.UseForeColor = true;
            styleFormatCondition2.Appearance.Options.UseTextOptions = true;
            styleFormatCondition2.ApplyToRow = true;
            styleFormatCondition2.Condition = DevExpress.XtraGrid.FormatConditionEnum.Equal;
            styleFormatCondition2.Expression = "[审核状态] == [0]";
            styleFormatCondition2.Value1 = 0;
            this.gridView1.FormatConditions.AddRange(new DevExpress.XtraGrid.StyleFormatCondition[] {
            styleFormatCondition2});
            this.gridView1.GridControl = this.gridControl1;
            this.gridView1.Name = "gridView1";
            this.gridView1.OptionsView.ColumnAutoWidth = false;
            this.gridView1.OptionsView.ShowFooter = true;
            this.gridView1.OptionsView.ShowGroupPanel = false;
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
            // Sex
            // 
            this.Sex.AppearanceCell.Options.UseTextOptions = true;
            this.Sex.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Sex.AppearanceHeader.Options.UseTextOptions = true;
            this.Sex.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Sex.Caption = "性别";
            this.Sex.FieldName = "Sex";
            this.Sex.MinWidth = 23;
            this.Sex.Name = "Sex";
            this.Sex.OptionsColumn.AllowEdit = false;
            this.Sex.OptionsColumn.ReadOnly = true;
            this.Sex.OptionsFilter.AllowAutoFilter = false;
            this.Sex.OptionsFilter.AllowFilter = false;
            this.Sex.Visible = true;
            this.Sex.VisibleIndex = 2;
            this.Sex.Width = 60;
            // 
            // IsFull
            // 
            this.IsFull.AppearanceCell.Options.UseTextOptions = true;
            this.IsFull.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.IsFull.AppearanceHeader.Options.UseTextOptions = true;
            this.IsFull.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.IsFull.Caption = "是否全职";
            this.IsFull.FieldName = "IsFull";
            this.IsFull.MinWidth = 23;
            this.IsFull.Name = "IsFull";
            this.IsFull.OptionsColumn.AllowEdit = false;
            this.IsFull.OptionsColumn.ReadOnly = true;
            this.IsFull.OptionsFilter.AllowAutoFilter = false;
            this.IsFull.OptionsFilter.AllowFilter = false;
            this.IsFull.Summary.AddRange(new DevExpress.XtraGrid.GridSummaryItem[] {
            new DevExpress.XtraGrid.GridColumnSummaryItem(DevExpress.Data.SummaryItemType.Count, "机构名称", "共{0}条")});
            this.IsFull.Visible = true;
            this.IsFull.VisibleIndex = 3;
            this.IsFull.Width = 70;
            // 
            // ProjectNo
            // 
            this.ProjectNo.AppearanceCell.Options.UseTextOptions = true;
            this.ProjectNo.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectNo.AppearanceHeader.Options.UseTextOptions = true;
            this.ProjectNo.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectNo.Caption = "参与的项目编号";
            this.ProjectNo.FieldName = "ProjectNo";
            this.ProjectNo.MinWidth = 25;
            this.ProjectNo.Name = "ProjectNo";
            this.ProjectNo.OptionsColumn.AllowEdit = false;
            this.ProjectNo.OptionsColumn.ReadOnly = true;
            this.ProjectNo.OptionsFilter.AllowAutoFilter = false;
            this.ProjectNo.OptionsFilter.AllowFilter = false;
            this.ProjectNo.Visible = true;
            this.ProjectNo.VisibleIndex = 4;
            this.ProjectNo.Width = 130;
            // 
            // ProjectName
            // 
            this.ProjectName.AppearanceHeader.Options.UseTextOptions = true;
            this.ProjectName.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectName.Caption = "参与的项目名称";
            this.ProjectName.FieldName = "ProjectName";
            this.ProjectName.MinWidth = 25;
            this.ProjectName.Name = "ProjectName";
            this.ProjectName.OptionsColumn.AllowEdit = false;
            this.ProjectName.OptionsColumn.ReadOnly = true;
            this.ProjectName.OptionsFilter.AllowAutoFilter = false;
            this.ProjectName.OptionsFilter.AllowFilter = false;
            this.ProjectName.Visible = true;
            this.ProjectName.VisibleIndex = 5;
            this.ProjectName.Width = 400;
            // 
            // JobContent
            // 
            this.JobContent.AppearanceCell.Options.UseTextOptions = true;
            this.JobContent.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.JobContent.AppearanceHeader.Options.UseTextOptions = true;
            this.JobContent.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.JobContent.Caption = "任务安排";
            this.JobContent.FieldName = "JobContent";
            this.JobContent.MinWidth = 23;
            this.JobContent.Name = "JobContent";
            this.JobContent.OptionsColumn.AllowEdit = false;
            this.JobContent.OptionsColumn.ReadOnly = true;
            this.JobContent.OptionsFilter.AllowAutoFilter = false;
            this.JobContent.OptionsFilter.AllowFilter = false;
            this.JobContent.Visible = true;
            this.JobContent.VisibleIndex = 6;
            this.JobContent.Width = 110;
            // 
            // ProjectDays
            // 
            this.ProjectDays.AppearanceCell.Options.UseTextOptions = true;
            this.ProjectDays.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectDays.AppearanceHeader.Options.UseTextOptions = true;
            this.ProjectDays.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectDays.Caption = "出勤项目天数";
            this.ProjectDays.FieldName = "ProjectDays";
            this.ProjectDays.MinWidth = 23;
            this.ProjectDays.Name = "ProjectDays";
            this.ProjectDays.OptionsColumn.AllowEdit = false;
            this.ProjectDays.OptionsColumn.ReadOnly = true;
            this.ProjectDays.OptionsFilter.AllowAutoFilter = false;
            this.ProjectDays.OptionsFilter.AllowFilter = false;
            this.ProjectDays.Visible = true;
            this.ProjectDays.VisibleIndex = 7;
            this.ProjectDays.Width = 100;
            // 
            // WorkDays
            // 
            this.WorkDays.AppearanceCell.Options.UseTextOptions = true;
            this.WorkDays.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.WorkDays.AppearanceHeader.Options.UseTextOptions = true;
            this.WorkDays.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.WorkDays.Caption = "整年工作天数";
            this.WorkDays.FieldName = "WorkDays";
            this.WorkDays.MinWidth = 23;
            this.WorkDays.Name = "WorkDays";
            this.WorkDays.OptionsColumn.AllowEdit = false;
            this.WorkDays.OptionsColumn.ReadOnly = true;
            this.WorkDays.OptionsFilter.AllowAutoFilter = false;
            this.WorkDays.OptionsFilter.AllowFilter = false;
            this.WorkDays.Visible = true;
            this.WorkDays.VisibleIndex = 8;
            this.WorkDays.Width = 100;
            // 
            // YearRatio
            // 
            this.YearRatio.AppearanceCell.Options.UseTextOptions = true;
            this.YearRatio.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.YearRatio.AppearanceHeader.Options.UseTextOptions = true;
            this.YearRatio.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.YearRatio.Caption = "年度项目工时占比(%)";
            this.YearRatio.FieldName = "YearRatio";
            this.YearRatio.MinWidth = 23;
            this.YearRatio.Name = "YearRatio";
            this.YearRatio.OptionsColumn.AllowEdit = false;
            this.YearRatio.OptionsColumn.ReadOnly = true;
            this.YearRatio.OptionsFilter.AllowAutoFilter = false;
            this.YearRatio.OptionsFilter.AllowFilter = false;
            this.YearRatio.Visible = true;
            this.YearRatio.VisibleIndex = 9;
            this.YearRatio.Width = 160;
            // 
            // YearProjectDays
            // 
            this.YearProjectDays.AppearanceCell.Options.UseTextOptions = true;
            this.YearProjectDays.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.YearProjectDays.AppearanceHeader.Options.UseTextOptions = true;
            this.YearProjectDays.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.YearProjectDays.Caption = "整年研发出勤天数";
            this.YearProjectDays.FieldName = "YearProjectDays";
            this.YearProjectDays.MinWidth = 23;
            this.YearProjectDays.Name = "YearProjectDays";
            this.YearProjectDays.OptionsColumn.AllowEdit = false;
            this.YearProjectDays.OptionsColumn.ReadOnly = true;
            this.YearProjectDays.OptionsFilter.AllowAutoFilter = false;
            this.YearProjectDays.OptionsFilter.AllowFilter = false;
            this.YearProjectDays.Visible = true;
            this.YearProjectDays.VisibleIndex = 10;
            this.YearProjectDays.Width = 130;
            // 
            // QuitDate
            // 
            this.QuitDate.AppearanceCell.Options.UseTextOptions = true;
            this.QuitDate.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.QuitDate.AppearanceHeader.Options.UseTextOptions = true;
            this.QuitDate.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.QuitDate.Caption = "停止考勤日期";
            this.QuitDate.FieldName = "QuitDate";
            this.QuitDate.MinWidth = 25;
            this.QuitDate.Name = "QuitDate";
            this.QuitDate.OptionsColumn.AllowEdit = false;
            this.QuitDate.OptionsColumn.ReadOnly = true;
            this.QuitDate.OptionsFilter.AllowAutoFilter = false;
            this.QuitDate.OptionsFilter.AllowFilter = false;
            this.QuitDate.Visible = true;
            this.QuitDate.VisibleIndex = 11;
            this.QuitDate.Width = 110;
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
            // cmbOrgName
            // 
            this.cmbOrgName.Cursor = System.Windows.Forms.Cursors.Default;
            this.cmbOrgName.EditValue = "";
            this.cmbOrgName.Location = new System.Drawing.Point(75, 12);
            this.cmbOrgName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbOrgName.Name = "cmbOrgName";
            this.cmbOrgName.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cmbOrgName.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            this.cmbOrgName.Size = new System.Drawing.Size(105, 24);
            this.cmbOrgName.TabIndex = 76;
            // 
            // labelControl7
            // 
            this.labelControl7.Location = new System.Drawing.Point(41, 15);
            this.labelControl7.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl7.Name = "labelControl7";
            this.labelControl7.Size = new System.Drawing.Size(30, 18);
            this.labelControl7.TabIndex = 75;
            this.labelControl7.Text = "公司";
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
            this.OrgName.VisibleIndex = 0;
            this.OrgName.Width = 90;
            // 
            // lblTitle
            // 
            this.lblTitle.Appearance.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.lblTitle.Appearance.ForeColor = System.Drawing.Color.Blue;
            this.lblTitle.Appearance.Options.UseFont = true;
            this.lblTitle.Appearance.Options.UseForeColor = true;
            this.lblTitle.Location = new System.Drawing.Point(1060, 32);
            this.lblTitle.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Size = new System.Drawing.Size(231, 24);
            this.lblTitle.TabIndex = 77;
            this.lblTitle.Text = "年度研发考勤情况汇总表";
            // 
            // RptYearAttenStat
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1314, 466);
            this.Controls.Add(this.splitContainerControl1);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.Name = "RptYearAttenStat";
            this.Text = "年度研发考勤情况汇总表";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.RptYearAttenStat_Load);
            ((System.ComponentModel.ISupportInitialize)(this.imageCollection1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            this.panelControl1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtEmpProjectInCount.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtEntryCount.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtQuitCount.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cmbYear.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtEmpTestCount.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtEmpAllCount.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtEmpProjectCount.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).EndInit();
            this.splitContainerControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemComboBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cmbOrgName.Properties)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private DevExpress.XtraBars.BarButtonItem btnExport;
        private DevExpress.Utils.ImageCollection imageCollection1;
        private DevExpress.XtraBars.BarManager barManager1;
        private DevExpress.XtraBars.Bar bar1;
        private DevExpress.XtraBars.BarButtonItem btnQuery;
        private DevExpress.XtraBars.BarDockControl barDockControlTop;
        private DevExpress.XtraBars.BarDockControl barDockControlBottom;
        private DevExpress.XtraBars.BarDockControl barDockControlLeft;
        private DevExpress.XtraBars.BarDockControl barDockControlRight;
        private DevExpress.XtraEditors.SplitContainerControl splitContainerControl1;
        private DevExpress.XtraEditors.PanelControl panelControl1;
        private DevExpress.XtraEditors.TextEdit txtEmpTestCount;
        private DevExpress.XtraEditors.LabelControl labelControl1;
        private DevExpress.XtraEditors.TextEdit txtEmpAllCount;
        private DevExpress.XtraEditors.LabelControl labelControl2;
        private DevExpress.XtraEditors.TextEdit txtEmpProjectCount;
        private DevExpress.XtraEditors.LabelControl labelControl3;
        public DevExpress.XtraGrid.GridControl gridControl1;
        public DevExpress.XtraGrid.Views.Grid.GridView gridView1;
        private DevExpress.XtraGrid.Columns.GridColumn FullName;
        private DevExpress.XtraGrid.Columns.GridColumn Sex;
        private DevExpress.XtraGrid.Columns.GridColumn IsFull;
        private DevExpress.XtraGrid.Columns.GridColumn JobContent;
        private DevExpress.XtraGrid.Columns.GridColumn ProjectNo;
        private DevExpress.XtraGrid.Columns.GridColumn ProjectName;
        private DevExpress.XtraGrid.Columns.GridColumn ProjectDays;
        private DevExpress.XtraGrid.Columns.GridColumn WorkDays;
        private DevExpress.XtraGrid.Columns.GridColumn YearRatio;
        private DevExpress.XtraGrid.Columns.GridColumn YearProjectDays;
        private DevExpress.XtraEditors.Repository.RepositoryItemDateEdit repositoryItemDateEdit1;
        private DevExpress.XtraEditors.Repository.RepositoryItemComboBox repositoryItemComboBox1;
        private DevExpress.XtraEditors.TextEdit txtEntryCount;
        private DevExpress.XtraEditors.LabelControl labelControl5;
        private DevExpress.XtraEditors.TextEdit txtQuitCount;
        private DevExpress.XtraEditors.LabelControl labelControl4;
        private DevExpress.XtraEditors.ComboBoxEdit cmbYear;
        private DevExpress.XtraEditors.LabelControl labelControl10;
        private DevExpress.XtraGrid.Columns.GridColumn QuitDate;
        private DevExpress.XtraEditors.TextEdit txtEmpProjectInCount;
        private DevExpress.XtraEditors.LabelControl labelControl6;
        private DevExpress.XtraEditors.ComboBoxEdit cmbOrgName;
        private DevExpress.XtraEditors.LabelControl labelControl7;
        private DevExpress.XtraGrid.Columns.GridColumn OrgName;
        private DevExpress.XtraEditors.LabelControl lblTitle;
    }
}
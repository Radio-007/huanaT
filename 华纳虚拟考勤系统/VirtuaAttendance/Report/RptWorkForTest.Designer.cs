namespace VirtuaAttendance.Report
{
    partial class RptWorkForTest
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(RptWorkForTest));
            this.btnQuery = new DevExpress.XtraBars.BarButtonItem();
            this.btnExport = new DevExpress.XtraBars.BarButtonItem();
            this.imageCollection1 = new DevExpress.Utils.ImageCollection(this.components);
            this.btnDelete = new DevExpress.XtraBars.BarButtonItem();
            this.panelControl1 = new DevExpress.XtraEditors.PanelControl();
            this.cmbOrgName = new DevExpress.XtraEditors.ComboBoxEdit();
            this.labelControl6 = new DevExpress.XtraEditors.LabelControl();
            this.labelControl2 = new DevExpress.XtraEditors.LabelControl();
            this.cmbMonth = new DevExpress.XtraEditors.ComboBoxEdit();
            this.labelControl4 = new DevExpress.XtraEditors.LabelControl();
            this.cmbYear = new DevExpress.XtraEditors.ComboBoxEdit();
            this.labelControl5 = new DevExpress.XtraEditors.LabelControl();
            this.labelControl10 = new DevExpress.XtraEditors.LabelControl();
            this.txtProjectName = new DevExpress.XtraEditors.TextEdit();
            this.labelControl1 = new DevExpress.XtraEditors.LabelControl();
            this.txtProjectNo = new DevExpress.XtraEditors.TextEdit();
            this.labelControl3 = new DevExpress.XtraEditors.LabelControl();
            this.splitContainerControl1 = new DevExpress.XtraEditors.SplitContainerControl();
            this.gridControl1 = new DevExpress.XtraGrid.GridControl();
            this.gridView1 = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.RowNo = new DevExpress.XtraGrid.Columns.GridColumn();
            this.ProjectNo = new DevExpress.XtraGrid.Columns.GridColumn();
            this.ProjectName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.StartDate = new DevExpress.XtraGrid.Columns.GridColumn();
            this.EndDate = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Charger = new DevExpress.XtraGrid.Columns.GridColumn();
            this.GroupLeader = new DevExpress.XtraGrid.Columns.GridColumn();
            this.sYear = new DevExpress.XtraGrid.Columns.GridColumn();
            this.sMonth = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemDateEdit1 = new DevExpress.XtraEditors.Repository.RepositoryItemDateEdit();
            this.repositoryItemComboBox1 = new DevExpress.XtraEditors.Repository.RepositoryItemComboBox();
            this.barDockControlLeft = new DevExpress.XtraBars.BarDockControl();
            this.barManager1 = new DevExpress.XtraBars.BarManager(this.components);
            this.bar1 = new DevExpress.XtraBars.Bar();
            this.btnAdd = new DevExpress.XtraBars.BarButtonItem();
            this.btnEdit = new DevExpress.XtraBars.BarButtonItem();
            this.barDockControlTop = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlBottom = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlRight = new DevExpress.XtraBars.BarDockControl();
            this.OrgName = new DevExpress.XtraGrid.Columns.GridColumn();
            ((System.ComponentModel.ISupportInitialize)(this.imageCollection1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cmbOrgName.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cmbMonth.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cmbYear.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectName.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectNo.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).BeginInit();
            this.splitContainerControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemComboBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            this.SuspendLayout();
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
            // btnDelete
            // 
            this.btnDelete.Caption = "删除";
            this.btnDelete.Id = 2;
            this.btnDelete.ImageOptions.ImageIndex = 3;
            this.btnDelete.ImageOptions.LargeImageIndex = 3;
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            // 
            // panelControl1
            // 
            this.panelControl1.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder;
            this.panelControl1.Controls.Add(this.cmbOrgName);
            this.panelControl1.Controls.Add(this.labelControl6);
            this.panelControl1.Controls.Add(this.labelControl2);
            this.panelControl1.Controls.Add(this.cmbMonth);
            this.panelControl1.Controls.Add(this.labelControl4);
            this.panelControl1.Controls.Add(this.cmbYear);
            this.panelControl1.Controls.Add(this.labelControl5);
            this.panelControl1.Controls.Add(this.labelControl10);
            this.panelControl1.Controls.Add(this.txtProjectName);
            this.panelControl1.Controls.Add(this.labelControl1);
            this.panelControl1.Controls.Add(this.txtProjectNo);
            this.panelControl1.Controls.Add(this.labelControl3);
            this.panelControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelControl1.Location = new System.Drawing.Point(0, 0);
            this.panelControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.panelControl1.Name = "panelControl1";
            this.panelControl1.Size = new System.Drawing.Size(1137, 49);
            this.panelControl1.TabIndex = 1;
            // 
            // cmbOrgName
            // 
            this.cmbOrgName.Cursor = System.Windows.Forms.Cursors.Default;
            this.cmbOrgName.EditValue = "";
            this.cmbOrgName.Location = new System.Drawing.Point(71, 13);
            this.cmbOrgName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbOrgName.Name = "cmbOrgName";
            this.cmbOrgName.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cmbOrgName.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            this.cmbOrgName.Size = new System.Drawing.Size(105, 24);
            this.cmbOrgName.TabIndex = 68;
            // 
            // labelControl6
            // 
            this.labelControl6.Location = new System.Drawing.Point(37, 16);
            this.labelControl6.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl6.Name = "labelControl6";
            this.labelControl6.Size = new System.Drawing.Size(30, 18);
            this.labelControl6.TabIndex = 67;
            this.labelControl6.Text = "公司";
            // 
            // labelControl2
            // 
            this.labelControl2.Location = new System.Drawing.Point(877, 17);
            this.labelControl2.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl2.Name = "labelControl2";
            this.labelControl2.Size = new System.Drawing.Size(15, 18);
            this.labelControl2.TabIndex = 66;
            this.labelControl2.Text = "月";
            // 
            // cmbMonth
            // 
            this.cmbMonth.Cursor = System.Windows.Forms.Cursors.Default;
            this.cmbMonth.EditValue = "";
            this.cmbMonth.Location = new System.Drawing.Point(816, 13);
            this.cmbMonth.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbMonth.Name = "cmbMonth";
            this.cmbMonth.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cmbMonth.Properties.Items.AddRange(new object[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12"});
            this.cmbMonth.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            this.cmbMonth.Size = new System.Drawing.Size(54, 24);
            this.cmbMonth.TabIndex = 65;
            // 
            // labelControl4
            // 
            this.labelControl4.Location = new System.Drawing.Point(795, 17);
            this.labelControl4.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl4.Name = "labelControl4";
            this.labelControl4.Size = new System.Drawing.Size(15, 18);
            this.labelControl4.TabIndex = 64;
            this.labelControl4.Text = "年";
            // 
            // cmbYear
            // 
            this.cmbYear.Cursor = System.Windows.Forms.Cursors.Default;
            this.cmbYear.EditValue = "";
            this.cmbYear.Location = new System.Drawing.Point(701, 13);
            this.cmbYear.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbYear.Name = "cmbYear";
            this.cmbYear.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cmbYear.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            this.cmbYear.Size = new System.Drawing.Size(88, 24);
            this.cmbYear.TabIndex = 63;
            // 
            // labelControl5
            // 
            this.labelControl5.Appearance.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.labelControl5.Appearance.ForeColor = System.Drawing.Color.Blue;
            this.labelControl5.Appearance.Options.UseFont = true;
            this.labelControl5.Appearance.Options.UseForeColor = true;
            this.labelControl5.Location = new System.Drawing.Point(928, 13);
            this.labelControl5.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl5.Name = "labelControl5";
            this.labelControl5.Size = new System.Drawing.Size(483, 24);
            this.labelControl5.TabIndex = 61;
            this.labelControl5.Text = "说明：双击某个项目编号，弹出该项目的考勤明细表";
            // 
            // labelControl10
            // 
            this.labelControl10.Location = new System.Drawing.Point(637, 16);
            this.labelControl10.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl10.Name = "labelControl10";
            this.labelControl10.Size = new System.Drawing.Size(60, 18);
            this.labelControl10.TabIndex = 62;
            this.labelControl10.Text = "统计月份";
            // 
            // txtProjectName
            // 
            this.txtProjectName.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtProjectName.Location = new System.Drawing.Point(480, 13);
            this.txtProjectName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtProjectName.Name = "txtProjectName";
            this.txtProjectName.Size = new System.Drawing.Size(133, 24);
            this.txtProjectName.TabIndex = 60;
            // 
            // labelControl1
            // 
            this.labelControl1.Location = new System.Drawing.Point(415, 15);
            this.labelControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl1.Name = "labelControl1";
            this.labelControl1.Size = new System.Drawing.Size(60, 18);
            this.labelControl1.TabIndex = 59;
            this.labelControl1.Text = "项目名称";
            // 
            // txtProjectNo
            // 
            this.txtProjectNo.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtProjectNo.Location = new System.Drawing.Point(278, 12);
            this.txtProjectNo.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtProjectNo.Name = "txtProjectNo";
            this.txtProjectNo.Size = new System.Drawing.Size(112, 24);
            this.txtProjectNo.TabIndex = 58;
            // 
            // labelControl3
            // 
            this.labelControl3.Location = new System.Drawing.Point(213, 14);
            this.labelControl3.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl3.Name = "labelControl3";
            this.labelControl3.Size = new System.Drawing.Size(60, 18);
            this.labelControl3.TabIndex = 57;
            this.labelControl3.Text = "项目编号";
            // 
            // splitContainerControl1
            // 
            this.splitContainerControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainerControl1.Horizontal = false;
            this.splitContainerControl1.Location = new System.Drawing.Point(0, 30);
            this.splitContainerControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.splitContainerControl1.Name = "splitContainerControl1";
            this.splitContainerControl1.Panel1.Controls.Add(this.panelControl1);
            this.splitContainerControl1.Panel1.Text = "Panel1";
            this.splitContainerControl1.Panel2.Controls.Add(this.gridControl1);
            this.splitContainerControl1.Panel2.Text = "Panel2";
            this.splitContainerControl1.Size = new System.Drawing.Size(1137, 431);
            this.splitContainerControl1.SplitterPosition = 49;
            this.splitContainerControl1.TabIndex = 7;
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
            this.gridControl1.Size = new System.Drawing.Size(1137, 370);
            this.gridControl1.TabIndex = 19;
            this.gridControl1.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gridView1});
            this.gridControl1.DoubleClick += new System.EventHandler(this.gridControl1_DoubleClick);
            // 
            // gridView1
            // 
            this.gridView1.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder;
            this.gridView1.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.RowNo,
            this.OrgName,
            this.ProjectNo,
            this.ProjectName,
            this.StartDate,
            this.EndDate,
            this.Charger,
            this.GroupLeader,
            this.sYear,
            this.sMonth});
            this.gridView1.DetailHeight = 450;
            this.gridView1.FixedLineWidth = 3;
            this.gridView1.GridControl = this.gridControl1;
            this.gridView1.Name = "gridView1";
            this.gridView1.OptionsView.ColumnAutoWidth = false;
            this.gridView1.OptionsView.ShowFooter = true;
            this.gridView1.OptionsView.ShowGroupPanel = false;
            // 
            // RowNo
            // 
            this.RowNo.AppearanceCell.Options.UseTextOptions = true;
            this.RowNo.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.RowNo.AppearanceHeader.Options.UseTextOptions = true;
            this.RowNo.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.RowNo.Caption = "序号";
            this.RowNo.FieldName = "RowNo";
            this.RowNo.MinWidth = 23;
            this.RowNo.Name = "RowNo";
            this.RowNo.OptionsColumn.AllowEdit = false;
            this.RowNo.OptionsColumn.ReadOnly = true;
            this.RowNo.OptionsFilter.AllowAutoFilter = false;
            this.RowNo.OptionsFilter.AllowFilter = false;
            this.RowNo.Visible = true;
            this.RowNo.VisibleIndex = 0;
            this.RowNo.Width = 78;
            // 
            // ProjectNo
            // 
            this.ProjectNo.AppearanceCell.Options.UseTextOptions = true;
            this.ProjectNo.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectNo.AppearanceHeader.Options.UseTextOptions = true;
            this.ProjectNo.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectNo.Caption = "项目编号";
            this.ProjectNo.FieldName = "ProjectNo";
            this.ProjectNo.MinWidth = 23;
            this.ProjectNo.Name = "ProjectNo";
            this.ProjectNo.OptionsColumn.AllowEdit = false;
            this.ProjectNo.OptionsColumn.ReadOnly = true;
            this.ProjectNo.OptionsFilter.AllowAutoFilter = false;
            this.ProjectNo.OptionsFilter.AllowFilter = false;
            this.ProjectNo.Summary.AddRange(new DevExpress.XtraGrid.GridSummaryItem[] {
            new DevExpress.XtraGrid.GridColumnSummaryItem(DevExpress.Data.SummaryItemType.Count, "ProjectNo", "共{0}条")});
            this.ProjectNo.Visible = true;
            this.ProjectNo.VisibleIndex = 2;
            this.ProjectNo.Width = 130;
            // 
            // ProjectName
            // 
            this.ProjectName.AppearanceHeader.Options.UseTextOptions = true;
            this.ProjectName.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectName.Caption = "项目名称";
            this.ProjectName.FieldName = "ProjectName";
            this.ProjectName.MinWidth = 23;
            this.ProjectName.Name = "ProjectName";
            this.ProjectName.OptionsColumn.AllowEdit = false;
            this.ProjectName.OptionsColumn.ReadOnly = true;
            this.ProjectName.OptionsFilter.AllowAutoFilter = false;
            this.ProjectName.OptionsFilter.AllowFilter = false;
            this.ProjectName.Visible = true;
            this.ProjectName.VisibleIndex = 3;
            this.ProjectName.Width = 300;
            // 
            // StartDate
            // 
            this.StartDate.AppearanceCell.Options.UseTextOptions = true;
            this.StartDate.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.StartDate.AppearanceHeader.Options.UseTextOptions = true;
            this.StartDate.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.StartDate.Caption = "研发起始时间";
            this.StartDate.DisplayFormat.FormatString = "d";
            this.StartDate.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.StartDate.FieldName = "StartDate";
            this.StartDate.MinWidth = 23;
            this.StartDate.Name = "StartDate";
            this.StartDate.OptionsColumn.AllowEdit = false;
            this.StartDate.OptionsColumn.ReadOnly = true;
            this.StartDate.OptionsFilter.AllowAutoFilter = false;
            this.StartDate.OptionsFilter.AllowFilter = false;
            this.StartDate.Visible = true;
            this.StartDate.VisibleIndex = 4;
            this.StartDate.Width = 110;
            // 
            // EndDate
            // 
            this.EndDate.AppearanceCell.Options.UseTextOptions = true;
            this.EndDate.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.EndDate.AppearanceHeader.Options.UseTextOptions = true;
            this.EndDate.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.EndDate.Caption = "研发终止时间";
            this.EndDate.DisplayFormat.FormatString = "d";
            this.EndDate.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.EndDate.FieldName = "EndDate";
            this.EndDate.MinWidth = 23;
            this.EndDate.Name = "EndDate";
            this.EndDate.OptionsColumn.AllowEdit = false;
            this.EndDate.OptionsColumn.ReadOnly = true;
            this.EndDate.OptionsFilter.AllowAutoFilter = false;
            this.EndDate.OptionsFilter.AllowFilter = false;
            this.EndDate.Visible = true;
            this.EndDate.VisibleIndex = 5;
            this.EndDate.Width = 110;
            // 
            // Charger
            // 
            this.Charger.AppearanceCell.Options.UseTextOptions = true;
            this.Charger.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Charger.AppearanceHeader.Options.UseTextOptions = true;
            this.Charger.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Charger.Caption = "项目负责人";
            this.Charger.FieldName = "Charger";
            this.Charger.MinWidth = 23;
            this.Charger.Name = "Charger";
            this.Charger.OptionsColumn.AllowEdit = false;
            this.Charger.OptionsColumn.ReadOnly = true;
            this.Charger.OptionsFilter.AllowAutoFilter = false;
            this.Charger.OptionsFilter.AllowFilter = false;
            this.Charger.Visible = true;
            this.Charger.VisibleIndex = 6;
            this.Charger.Width = 90;
            // 
            // GroupLeader
            // 
            this.GroupLeader.AppearanceCell.Options.UseTextOptions = true;
            this.GroupLeader.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.GroupLeader.AppearanceHeader.Options.UseTextOptions = true;
            this.GroupLeader.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.GroupLeader.Caption = "项目组组长";
            this.GroupLeader.FieldName = "GroupLeader";
            this.GroupLeader.MinWidth = 23;
            this.GroupLeader.Name = "GroupLeader";
            this.GroupLeader.OptionsColumn.AllowEdit = false;
            this.GroupLeader.OptionsColumn.ReadOnly = true;
            this.GroupLeader.OptionsFilter.AllowAutoFilter = false;
            this.GroupLeader.OptionsFilter.AllowFilter = false;
            this.GroupLeader.Visible = true;
            this.GroupLeader.VisibleIndex = 7;
            this.GroupLeader.Width = 90;
            // 
            // sYear
            // 
            this.sYear.AppearanceCell.Options.UseTextOptions = true;
            this.sYear.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.sYear.AppearanceHeader.Options.UseTextOptions = true;
            this.sYear.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.sYear.Caption = "统计年份";
            this.sYear.FieldName = "sYear";
            this.sYear.MinWidth = 23;
            this.sYear.Name = "sYear";
            this.sYear.OptionsColumn.AllowEdit = false;
            this.sYear.OptionsColumn.ReadOnly = true;
            this.sYear.OptionsFilter.AllowAutoFilter = false;
            this.sYear.OptionsFilter.AllowFilter = false;
            this.sYear.Visible = true;
            this.sYear.VisibleIndex = 8;
            this.sYear.Width = 80;
            // 
            // sMonth
            // 
            this.sMonth.AppearanceCell.Options.UseTextOptions = true;
            this.sMonth.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.sMonth.AppearanceHeader.Options.UseTextOptions = true;
            this.sMonth.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.sMonth.Caption = "统计月份";
            this.sMonth.FieldName = "sMonth";
            this.sMonth.MinWidth = 23;
            this.sMonth.Name = "sMonth";
            this.sMonth.OptionsColumn.AllowEdit = false;
            this.sMonth.OptionsColumn.ReadOnly = true;
            this.sMonth.OptionsFilter.AllowAutoFilter = false;
            this.sMonth.OptionsFilter.AllowFilter = false;
            this.sMonth.Visible = true;
            this.sMonth.VisibleIndex = 9;
            this.sMonth.Width = 80;
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
            // barDockControlLeft
            // 
            this.barDockControlLeft.CausesValidation = false;
            this.barDockControlLeft.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControlLeft.Location = new System.Drawing.Point(0, 30);
            this.barDockControlLeft.Manager = this.barManager1;
            this.barDockControlLeft.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlLeft.Size = new System.Drawing.Size(0, 431);
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
            // 
            // btnEdit
            // 
            this.btnEdit.Caption = "修改";
            this.btnEdit.Id = 1;
            this.btnEdit.ImageOptions.ImageIndex = 2;
            this.btnEdit.ImageOptions.LargeImageIndex = 2;
            this.btnEdit.Name = "btnEdit";
            this.btnEdit.PaintStyle = DevExpress.XtraBars.BarItemPaintStyle.CaptionGlyph;
            // 
            // barDockControlTop
            // 
            this.barDockControlTop.CausesValidation = false;
            this.barDockControlTop.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControlTop.Location = new System.Drawing.Point(0, 0);
            this.barDockControlTop.Manager = this.barManager1;
            this.barDockControlTop.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlTop.Size = new System.Drawing.Size(1137, 30);
            // 
            // barDockControlBottom
            // 
            this.barDockControlBottom.CausesValidation = false;
            this.barDockControlBottom.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControlBottom.Location = new System.Drawing.Point(0, 461);
            this.barDockControlBottom.Manager = this.barManager1;
            this.barDockControlBottom.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlBottom.Size = new System.Drawing.Size(1137, 0);
            // 
            // barDockControlRight
            // 
            this.barDockControlRight.CausesValidation = false;
            this.barDockControlRight.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControlRight.Location = new System.Drawing.Point(1137, 30);
            this.barDockControlRight.Manager = this.barManager1;
            this.barDockControlRight.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.barDockControlRight.Size = new System.Drawing.Size(0, 431);
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
            this.OrgName.VisibleIndex = 1;
            this.OrgName.Width = 90;
            // 
            // RptWorkForTest
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1137, 461);
            this.Controls.Add(this.splitContainerControl1);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "RptWorkForTest";
            this.Text = "月度试产人员考勤表";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.RptWorkForTest_Load);
            ((System.ComponentModel.ISupportInitialize)(this.imageCollection1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            this.panelControl1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cmbOrgName.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cmbMonth.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cmbYear.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectName.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectNo.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).EndInit();
            this.splitContainerControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemComboBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private DevExpress.XtraBars.BarButtonItem btnQuery;
        private DevExpress.XtraBars.BarButtonItem btnExport;
        private DevExpress.Utils.ImageCollection imageCollection1;
        private DevExpress.XtraBars.BarButtonItem btnDelete;
        private DevExpress.XtraEditors.PanelControl panelControl1;
        private DevExpress.XtraEditors.SplitContainerControl splitContainerControl1;
        public DevExpress.XtraGrid.GridControl gridControl1;
        public DevExpress.XtraGrid.Views.Grid.GridView gridView1;
        private DevExpress.XtraGrid.Columns.GridColumn RowNo;
        private DevExpress.XtraGrid.Columns.GridColumn ProjectNo;
        private DevExpress.XtraGrid.Columns.GridColumn ProjectName;
        private DevExpress.XtraGrid.Columns.GridColumn StartDate;
        private DevExpress.XtraGrid.Columns.GridColumn EndDate;
        private DevExpress.XtraGrid.Columns.GridColumn Charger;
        private DevExpress.XtraGrid.Columns.GridColumn GroupLeader;
        private DevExpress.XtraGrid.Columns.GridColumn sYear;
        private DevExpress.XtraGrid.Columns.GridColumn sMonth;
        private DevExpress.XtraEditors.Repository.RepositoryItemDateEdit repositoryItemDateEdit1;
        private DevExpress.XtraEditors.Repository.RepositoryItemComboBox repositoryItemComboBox1;
        private DevExpress.XtraBars.BarDockControl barDockControlLeft;
        private DevExpress.XtraBars.BarManager barManager1;
        private DevExpress.XtraBars.Bar bar1;
        private DevExpress.XtraBars.BarButtonItem btnAdd;
        private DevExpress.XtraBars.BarButtonItem btnEdit;
        private DevExpress.XtraBars.BarDockControl barDockControlTop;
        private DevExpress.XtraBars.BarDockControl barDockControlBottom;
        private DevExpress.XtraBars.BarDockControl barDockControlRight;
        private DevExpress.XtraEditors.ComboBoxEdit cmbOrgName;
        private DevExpress.XtraEditors.LabelControl labelControl6;
        private DevExpress.XtraEditors.LabelControl labelControl2;
        private DevExpress.XtraEditors.ComboBoxEdit cmbMonth;
        private DevExpress.XtraEditors.LabelControl labelControl4;
        private DevExpress.XtraEditors.ComboBoxEdit cmbYear;
        private DevExpress.XtraEditors.LabelControl labelControl5;
        private DevExpress.XtraEditors.LabelControl labelControl10;
        private DevExpress.XtraEditors.TextEdit txtProjectName;
        private DevExpress.XtraEditors.LabelControl labelControl1;
        private DevExpress.XtraEditors.TextEdit txtProjectNo;
        private DevExpress.XtraEditors.LabelControl labelControl3;
        private DevExpress.XtraGrid.Columns.GridColumn OrgName;
    }
}
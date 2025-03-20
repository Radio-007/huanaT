namespace VirtuaAttendance.JiandaoyunAPI
{
    partial class Projects
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Projects));
            DevExpress.XtraGrid.StyleFormatCondition styleFormatCondition1 = new DevExpress.XtraGrid.StyleFormatCondition();
            this.txtProjectNo = new DevExpress.XtraEditors.TextEdit();
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
            this.txtProjectName = new DevExpress.XtraEditors.TextEdit();
            this.labelControl1 = new DevExpress.XtraEditors.LabelControl();
            this.dtDate2 = new DevExpress.XtraEditors.DateEdit();
            this.dtDate1 = new DevExpress.XtraEditors.DateEdit();
            this.labelControl11 = new DevExpress.XtraEditors.LabelControl();
            this.labelControl10 = new DevExpress.XtraEditors.LabelControl();
            this.labelControl3 = new DevExpress.XtraEditors.LabelControl();
            this.gridControl1 = new DevExpress.XtraGrid.GridControl();
            this.gridView1 = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.ID = new DevExpress.XtraGrid.Columns.GridColumn();
            this.ProjectNo = new DevExpress.XtraGrid.Columns.GridColumn();
            this.OrgName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.ProjectName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.StartDate = new DevExpress.XtraGrid.Columns.GridColumn();
            this.EndDate = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Charger = new DevExpress.XtraGrid.Columns.GridColumn();
            this.GroupLeader = new DevExpress.XtraGrid.Columns.GridColumn();
            this.Status = new DevExpress.XtraGrid.Columns.GridColumn();
            this.CreateTime = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemDateEdit1 = new DevExpress.XtraEditors.Repository.RepositoryItemDateEdit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectNo.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemComboBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.imageCollection1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).BeginInit();
            this.splitContainerControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cmbOrgName.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectName.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtDate2.Properties.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtDate2.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtDate1.Properties.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtDate1.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1.CalendarTimeProperties)).BeginInit();
            this.SuspendLayout();
            // 
            // txtProjectNo
            // 
            this.txtProjectNo.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtProjectNo.Location = new System.Drawing.Point(284, 13);
            this.txtProjectNo.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtProjectNo.Name = "txtProjectNo";
            this.txtProjectNo.Size = new System.Drawing.Size(112, 24);
            this.txtProjectNo.TabIndex = 16;
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
            this.splitContainerControl1.TabIndex = 5;
            this.splitContainerControl1.Text = "splitContainerControl1";
            // 
            // panelControl1
            // 
            this.panelControl1.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder;
            this.panelControl1.Controls.Add(this.cmbOrgName);
            this.panelControl1.Controls.Add(this.labelControl9);
            this.panelControl1.Controls.Add(this.txtProjectName);
            this.panelControl1.Controls.Add(this.labelControl1);
            this.panelControl1.Controls.Add(this.dtDate2);
            this.panelControl1.Controls.Add(this.dtDate1);
            this.panelControl1.Controls.Add(this.labelControl11);
            this.panelControl1.Controls.Add(this.labelControl10);
            this.panelControl1.Controls.Add(this.txtProjectNo);
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
            this.cmbOrgName.Location = new System.Drawing.Point(73, 14);
            this.cmbOrgName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbOrgName.Name = "cmbOrgName";
            this.cmbOrgName.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cmbOrgName.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            this.cmbOrgName.Size = new System.Drawing.Size(105, 24);
            this.cmbOrgName.TabIndex = 43;
            // 
            // labelControl9
            // 
            this.labelControl9.Location = new System.Drawing.Point(39, 17);
            this.labelControl9.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl9.Name = "labelControl9";
            this.labelControl9.Size = new System.Drawing.Size(30, 18);
            this.labelControl9.TabIndex = 42;
            this.labelControl9.Text = "公司";
            // 
            // txtProjectName
            // 
            this.txtProjectName.Cursor = System.Windows.Forms.Cursors.Default;
            this.txtProjectName.Location = new System.Drawing.Point(506, 14);
            this.txtProjectName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtProjectName.Name = "txtProjectName";
            this.txtProjectName.Size = new System.Drawing.Size(112, 24);
            this.txtProjectName.TabIndex = 41;
            // 
            // labelControl1
            // 
            this.labelControl1.Location = new System.Drawing.Point(441, 16);
            this.labelControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl1.Name = "labelControl1";
            this.labelControl1.Size = new System.Drawing.Size(60, 18);
            this.labelControl1.TabIndex = 40;
            this.labelControl1.Text = "项目名称";
            // 
            // dtDate2
            // 
            this.dtDate2.EditValue = null;
            this.dtDate2.Location = new System.Drawing.Point(862, 15);
            this.dtDate2.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dtDate2.MenuManager = this.barManager1;
            this.dtDate2.Name = "dtDate2";
            this.dtDate2.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dtDate2.Properties.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dtDate2.Properties.DisplayFormat.FormatString = "yyyy-MM-dd";
            this.dtDate2.Properties.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.dtDate2.Size = new System.Drawing.Size(103, 24);
            this.dtDate2.TabIndex = 39;
            // 
            // dtDate1
            // 
            this.dtDate1.EditValue = null;
            this.dtDate1.Location = new System.Drawing.Point(742, 14);
            this.dtDate1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dtDate1.MenuManager = this.barManager1;
            this.dtDate1.Name = "dtDate1";
            this.dtDate1.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dtDate1.Properties.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dtDate1.Properties.DisplayFormat.FormatString = "yyyy-MM-dd";
            this.dtDate1.Properties.DisplayFormat.FormatType = DevExpress.Utils.FormatType.DateTime;
            this.dtDate1.Size = new System.Drawing.Size(103, 24);
            this.dtDate1.TabIndex = 38;
            // 
            // labelControl11
            // 
            this.labelControl11.Location = new System.Drawing.Point(848, 16);
            this.labelControl11.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl11.Name = "labelControl11";
            this.labelControl11.Size = new System.Drawing.Size(11, 18);
            this.labelControl11.TabIndex = 37;
            this.labelControl11.Text = "~";
            // 
            // labelControl10
            // 
            this.labelControl10.Location = new System.Drawing.Point(648, 17);
            this.labelControl10.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl10.Name = "labelControl10";
            this.labelControl10.Size = new System.Drawing.Size(90, 18);
            this.labelControl10.TabIndex = 36;
            this.labelControl10.Text = "研发起始时间";
            // 
            // labelControl3
            // 
            this.labelControl3.Location = new System.Drawing.Point(219, 15);
            this.labelControl3.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl3.Name = "labelControl3";
            this.labelControl3.Size = new System.Drawing.Size(60, 18);
            this.labelControl3.TabIndex = 5;
            this.labelControl3.Text = "立项编号";
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
            this.ProjectNo,
            this.OrgName,
            this.ProjectName,
            this.StartDate,
            this.EndDate,
            this.Charger,
            this.GroupLeader,
            this.Status,
            this.CreateTime});
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
            // ProjectNo
            // 
            this.ProjectNo.AppearanceCell.Options.UseTextOptions = true;
            this.ProjectNo.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectNo.AppearanceHeader.Options.UseTextOptions = true;
            this.ProjectNo.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectNo.Caption = "立项编号";
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
            this.ProjectNo.VisibleIndex = 1;
            this.ProjectNo.Width = 140;
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
            this.OrgName.VisibleIndex = 2;
            this.OrgName.Width = 90;
            // 
            // ProjectName
            // 
            this.ProjectName.AppearanceHeader.Options.UseTextOptions = true;
            this.ProjectName.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.ProjectName.Caption = "研发项目名称";
            this.ProjectName.FieldName = "ProjectName";
            this.ProjectName.MinWidth = 23;
            this.ProjectName.Name = "ProjectName";
            this.ProjectName.OptionsColumn.AllowEdit = false;
            this.ProjectName.OptionsColumn.ReadOnly = true;
            this.ProjectName.OptionsFilter.AllowAutoFilter = false;
            this.ProjectName.OptionsFilter.AllowFilter = false;
            this.ProjectName.Visible = true;
            this.ProjectName.VisibleIndex = 3;
            this.ProjectName.Width = 320;
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
            this.StartDate.MinWidth = 25;
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
            this.EndDate.DisplayFormat.FormatString = "yyyy-MM-dd";
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
            this.Charger.MinWidth = 25;
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
            this.GroupLeader.MinWidth = 25;
            this.GroupLeader.Name = "GroupLeader";
            this.GroupLeader.OptionsColumn.AllowEdit = false;
            this.GroupLeader.OptionsColumn.ReadOnly = true;
            this.GroupLeader.OptionsFilter.AllowAutoFilter = false;
            this.GroupLeader.OptionsFilter.AllowFilter = false;
            this.GroupLeader.Visible = true;
            this.GroupLeader.VisibleIndex = 7;
            this.GroupLeader.Width = 90;
            // 
            // Status
            // 
            this.Status.AppearanceCell.Options.UseTextOptions = true;
            this.Status.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Status.AppearanceHeader.Options.UseTextOptions = true;
            this.Status.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.Status.Caption = "项目状态";
            this.Status.FieldName = "Status";
            this.Status.MinWidth = 25;
            this.Status.Name = "Status";
            this.Status.OptionsColumn.AllowEdit = false;
            this.Status.OptionsColumn.ReadOnly = true;
            this.Status.OptionsFilter.AllowAutoFilter = false;
            this.Status.OptionsFilter.AllowFilter = false;
            this.Status.Visible = true;
            this.Status.VisibleIndex = 8;
            this.Status.Width = 94;
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
            this.CreateTime.VisibleIndex = 9;
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
            // Projects
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1152, 478);
            this.Controls.Add(this.splitContainerControl1);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.Name = "Projects";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "研究开发项目";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.Projects_Load);
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectNo.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemComboBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.imageCollection1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).EndInit();
            this.splitContainerControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            this.panelControl1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cmbOrgName.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtProjectName.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtDate2.Properties.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtDate2.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtDate1.Properties.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtDate1.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemDateEdit1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.TextEdit txtProjectNo;
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
        private DevExpress.XtraEditors.LabelControl labelControl3;
        public DevExpress.XtraGrid.GridControl gridControl1;
        public DevExpress.XtraGrid.Views.Grid.GridView gridView1;
        private DevExpress.XtraGrid.Columns.GridColumn ID;
        private DevExpress.XtraGrid.Columns.GridColumn ProjectNo;
        private DevExpress.XtraGrid.Columns.GridColumn OrgName;
        private DevExpress.XtraGrid.Columns.GridColumn ProjectName;
        private DevExpress.XtraGrid.Columns.GridColumn StartDate;
        private DevExpress.XtraGrid.Columns.GridColumn EndDate;
        private DevExpress.XtraGrid.Columns.GridColumn Charger;
        private DevExpress.XtraGrid.Columns.GridColumn GroupLeader;
        private DevExpress.XtraGrid.Columns.GridColumn CreateTime;
        private DevExpress.XtraEditors.Repository.RepositoryItemDateEdit repositoryItemDateEdit1;
        private DevExpress.Utils.ImageCollection imageCollection1;
        private DevExpress.XtraEditors.TextEdit txtProjectName;
        private DevExpress.XtraEditors.LabelControl labelControl1;
        private DevExpress.XtraEditors.DateEdit dtDate2;
        private DevExpress.XtraEditors.DateEdit dtDate1;
        private DevExpress.XtraEditors.LabelControl labelControl11;
        private DevExpress.XtraEditors.LabelControl labelControl10;
        private DevExpress.XtraGrid.Columns.GridColumn Status;
        private DevExpress.XtraEditors.ComboBoxEdit cmbOrgName;
        private DevExpress.XtraEditors.LabelControl labelControl9;
    }
}
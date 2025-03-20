namespace GxRadio.SysManage
{
    partial class SysUser
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
            this.gridControl1 = new DevExpress.XtraGrid.GridControl();
            this.gridView1 = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.ID = new DevExpress.XtraGrid.Columns.GridColumn();
            this.username = new DevExpress.XtraGrid.Columns.GridColumn();
            this.userPers = new DevExpress.XtraGrid.Columns.GridColumn();
            this.btnFind = new DevExpress.XtraEditors.SimpleButton();
            this.txtUserName = new DevExpress.XtraEditors.TextEdit();
            this.labelControl1 = new DevExpress.XtraEditors.LabelControl();
            this.btnAdd = new DevExpress.XtraEditors.SimpleButton();
            this.btnEdit = new DevExpress.XtraEditors.SimpleButton();
            this.btnDelete = new DevExpress.XtraEditors.SimpleButton();
            this.labelControl2 = new DevExpress.XtraEditors.LabelControl();
            this.listView1 = new System.Windows.Forms.ListView();
            this.columnHeader1 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader2 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.columnHeader3 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.txtUserPer = new DevExpress.XtraEditors.TextEdit();
            this.btnResetPass = new DevExpress.XtraEditors.SimpleButton();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtUserName.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtUserPer.Properties)).BeginInit();
            this.SuspendLayout();
            // 
            // gridControl1
            // 
            this.gridControl1.Cursor = System.Windows.Forms.Cursors.Default;
            this.gridControl1.EmbeddedNavigator.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.gridControl1.Location = new System.Drawing.Point(32, 78);
            this.gridControl1.MainView = this.gridView1;
            this.gridControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.gridControl1.Name = "gridControl1";
            this.gridControl1.Size = new System.Drawing.Size(431, 532);
            this.gridControl1.TabIndex = 0;
            this.gridControl1.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gridView1});
            // 
            // gridView1
            // 
            this.gridView1.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.ID,
            this.username,
            this.userPers});
            this.gridView1.DetailHeight = 450;
            this.gridView1.FixedLineWidth = 3;
            this.gridView1.GridControl = this.gridControl1;
            this.gridView1.Name = "gridView1";
            this.gridView1.OptionsView.ShowGroupPanel = false;
            this.gridView1.FocusedRowChanged += new DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventHandler(this.gridView1_FocusedRowChanged);
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
            this.ID.Visible = true;
            this.ID.VisibleIndex = 0;
            this.ID.Width = 69;
            // 
            // username
            // 
            this.username.AppearanceCell.Options.UseTextOptions = true;
            this.username.AppearanceCell.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.username.AppearanceHeader.Options.UseTextOptions = true;
            this.username.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.username.Caption = "用户名";
            this.username.FieldName = "username";
            this.username.MinWidth = 23;
            this.username.Name = "username";
            this.username.OptionsColumn.AllowEdit = false;
            this.username.OptionsColumn.ReadOnly = true;
            this.username.Visible = true;
            this.username.VisibleIndex = 1;
            this.username.Width = 91;
            // 
            // userPers
            // 
            this.userPers.AppearanceHeader.Options.UseTextOptions = true;
            this.userPers.AppearanceHeader.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.userPers.Caption = "用户权限";
            this.userPers.FieldName = "userPers";
            this.userPers.MinWidth = 23;
            this.userPers.Name = "userPers";
            this.userPers.OptionsColumn.AllowEdit = false;
            this.userPers.OptionsColumn.ReadOnly = true;
            this.userPers.Visible = true;
            this.userPers.VisibleIndex = 2;
            this.userPers.Width = 229;
            // 
            // btnFind
            // 
            this.btnFind.Location = new System.Drawing.Point(205, 21);
            this.btnFind.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnFind.Name = "btnFind";
            this.btnFind.Size = new System.Drawing.Size(59, 30);
            this.btnFind.TabIndex = 1;
            this.btnFind.Text = "查找";
            this.btnFind.Click += new System.EventHandler(this.btnFind_Click);
            // 
            // txtUserName
            // 
            this.txtUserName.Location = new System.Drawing.Point(83, 22);
            this.txtUserName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtUserName.Name = "txtUserName";
            this.txtUserName.Size = new System.Drawing.Size(114, 24);
            this.txtUserName.TabIndex = 2;
            // 
            // labelControl1
            // 
            this.labelControl1.Location = new System.Drawing.Point(37, 26);
            this.labelControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl1.Name = "labelControl1";
            this.labelControl1.Size = new System.Drawing.Size(45, 18);
            this.labelControl1.TabIndex = 3;
            this.labelControl1.Text = "用户名";
            // 
            // btnAdd
            // 
            this.btnAdd.Location = new System.Drawing.Point(271, 21);
            this.btnAdd.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(59, 30);
            this.btnAdd.TabIndex = 4;
            this.btnAdd.Text = "添加";
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnEdit
            // 
            this.btnEdit.Location = new System.Drawing.Point(337, 21);
            this.btnEdit.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnEdit.Name = "btnEdit";
            this.btnEdit.Size = new System.Drawing.Size(59, 30);
            this.btnEdit.TabIndex = 5;
            this.btnEdit.Text = "修改";
            this.btnEdit.Click += new System.EventHandler(this.btnEdit_Click);
            // 
            // btnDelete
            // 
            this.btnDelete.Location = new System.Drawing.Point(403, 21);
            this.btnDelete.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(59, 30);
            this.btnDelete.TabIndex = 6;
            this.btnDelete.Text = "删除";
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // labelControl2
            // 
            this.labelControl2.Location = new System.Drawing.Point(487, 60);
            this.labelControl2.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl2.Name = "labelControl2";
            this.labelControl2.Size = new System.Drawing.Size(180, 18);
            this.labelControl2.TabIndex = 7;
            this.labelControl2.Text = "该用户所对应的权限列表：";
            // 
            // listView1
            // 
            this.listView1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.listView1.CheckBoxes = true;
            this.listView1.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2,
            this.columnHeader3});
            this.listView1.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable;
            this.listView1.Location = new System.Drawing.Point(487, 86);
            this.listView1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.listView1.Name = "listView1";
            this.listView1.Size = new System.Drawing.Size(354, 524);
            this.listView1.TabIndex = 8;
            this.listView1.UseCompatibleStateImageBehavior = false;
            this.listView1.View = System.Windows.Forms.View.Details;
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "选择";
            this.columnHeader1.Width = 50;
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "权限代码";
            this.columnHeader2.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.columnHeader2.Width = 80;
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "权限名称";
            this.columnHeader3.Width = 140;
            // 
            // txtUserPer
            // 
            this.txtUserPer.Location = new System.Drawing.Point(37, 52);
            this.txtUserPer.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtUserPer.Name = "txtUserPer";
            this.txtUserPer.Properties.MaxLength = 100;
            this.txtUserPer.Size = new System.Drawing.Size(259, 24);
            this.txtUserPer.TabIndex = 54;
            this.txtUserPer.Visible = false;
            // 
            // btnResetPass
            // 
            this.btnResetPass.Location = new System.Drawing.Point(468, 22);
            this.btnResetPass.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnResetPass.Name = "btnResetPass";
            this.btnResetPass.Size = new System.Drawing.Size(80, 30);
            this.btnResetPass.TabIndex = 4;
            this.btnResetPass.Text = "重置密码";
            this.btnResetPass.Click += new System.EventHandler(this.btnResetPass_Click);
            // 
            // SysUser
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(894, 615);
            this.Controls.Add(this.txtUserPer);
            this.Controls.Add(this.listView1);
            this.Controls.Add(this.labelControl2);
            this.Controls.Add(this.btnDelete);
            this.Controls.Add(this.btnEdit);
            this.Controls.Add(this.btnResetPass);
            this.Controls.Add(this.btnAdd);
            this.Controls.Add(this.labelControl1);
            this.Controls.Add(this.txtUserName);
            this.Controls.Add(this.btnFind);
            this.Controls.Add(this.gridControl1);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "SysUser";
            this.Text = "用户管理";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.SysUser_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtUserName.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtUserPer.Properties)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraGrid.GridControl gridControl1;
        private DevExpress.XtraGrid.Views.Grid.GridView gridView1;
        private DevExpress.XtraGrid.Columns.GridColumn ID;
        private DevExpress.XtraGrid.Columns.GridColumn username;
        private DevExpress.XtraGrid.Columns.GridColumn userPers;
        private DevExpress.XtraEditors.SimpleButton btnFind;
        private DevExpress.XtraEditors.TextEdit txtUserName;
        private DevExpress.XtraEditors.LabelControl labelControl1;
        private DevExpress.XtraEditors.SimpleButton btnAdd;
        private DevExpress.XtraEditors.SimpleButton btnEdit;
        private DevExpress.XtraEditors.SimpleButton btnDelete;
        private DevExpress.XtraEditors.LabelControl labelControl2;
        private System.Windows.Forms.ListView listView1;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ColumnHeader columnHeader3;
        private DevExpress.XtraEditors.TextEdit txtUserPer;
        private DevExpress.XtraEditors.SimpleButton btnResetPass;
    }
}
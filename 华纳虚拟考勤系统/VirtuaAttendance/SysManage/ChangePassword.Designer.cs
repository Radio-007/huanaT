namespace GxRadio.SysManage
{
    partial class ChangePassword
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
            this.labelControl3 = new DevExpress.XtraEditors.LabelControl();
            this.txtOld = new DevExpress.XtraEditors.TextEdit();
            this.labelControl1 = new DevExpress.XtraEditors.LabelControl();
            this.txtUserName = new DevExpress.XtraEditors.TextEdit();
            this.labelControl2 = new DevExpress.XtraEditors.LabelControl();
            this.txtNew = new DevExpress.XtraEditors.TextEdit();
            this.labelControl4 = new DevExpress.XtraEditors.LabelControl();
            this.txtConfirm = new DevExpress.XtraEditors.TextEdit();
            this.btnClose = new DevExpress.XtraEditors.SimpleButton();
            this.btnSave = new DevExpress.XtraEditors.SimpleButton();
            ((System.ComponentModel.ISupportInitialize)(this.txtOld.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtUserName.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtNew.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtConfirm.Properties)).BeginInit();
            this.SuspendLayout();
            // 
            // labelControl3
            // 
            this.labelControl3.Location = new System.Drawing.Point(42, 70);
            this.labelControl3.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl3.Name = "labelControl3";
            this.labelControl3.Size = new System.Drawing.Size(45, 18);
            this.labelControl3.TabIndex = 5;
            this.labelControl3.Text = "旧密码";
            // 
            // txtOld
            // 
            this.txtOld.Location = new System.Drawing.Point(91, 67);
            this.txtOld.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtOld.Name = "txtOld";
            this.txtOld.Properties.PasswordChar = '*';
            this.txtOld.Size = new System.Drawing.Size(147, 24);
            this.txtOld.TabIndex = 4;
            // 
            // labelControl1
            // 
            this.labelControl1.Location = new System.Drawing.Point(42, 26);
            this.labelControl1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl1.Name = "labelControl1";
            this.labelControl1.Size = new System.Drawing.Size(45, 18);
            this.labelControl1.TabIndex = 7;
            this.labelControl1.Text = "用户名";
            // 
            // txtUserName
            // 
            this.txtUserName.Location = new System.Drawing.Point(91, 23);
            this.txtUserName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtUserName.Name = "txtUserName";
            this.txtUserName.Properties.ReadOnly = true;
            this.txtUserName.Size = new System.Drawing.Size(147, 24);
            this.txtUserName.TabIndex = 6;
            // 
            // labelControl2
            // 
            this.labelControl2.Location = new System.Drawing.Point(42, 113);
            this.labelControl2.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl2.Name = "labelControl2";
            this.labelControl2.Size = new System.Drawing.Size(45, 18);
            this.labelControl2.TabIndex = 9;
            this.labelControl2.Text = "新密码";
            // 
            // txtNew
            // 
            this.txtNew.Location = new System.Drawing.Point(91, 110);
            this.txtNew.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtNew.Name = "txtNew";
            this.txtNew.Properties.PasswordChar = '*';
            this.txtNew.Size = new System.Drawing.Size(147, 24);
            this.txtNew.TabIndex = 8;
            // 
            // labelControl4
            // 
            this.labelControl4.Location = new System.Drawing.Point(27, 156);
            this.labelControl4.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.labelControl4.Name = "labelControl4";
            this.labelControl4.Size = new System.Drawing.Size(60, 18);
            this.labelControl4.TabIndex = 11;
            this.labelControl4.Text = "确认密码";
            // 
            // txtConfirm
            // 
            this.txtConfirm.Location = new System.Drawing.Point(91, 153);
            this.txtConfirm.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtConfirm.Name = "txtConfirm";
            this.txtConfirm.Properties.PasswordChar = '*';
            this.txtConfirm.Size = new System.Drawing.Size(147, 24);
            this.txtConfirm.TabIndex = 10;
            // 
            // btnClose
            // 
            this.btnClose.Location = new System.Drawing.Point(152, 206);
            this.btnClose.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(86, 30);
            this.btnClose.TabIndex = 19;
            this.btnClose.Text = "关闭";
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(47, 206);
            this.btnSave.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(86, 30);
            this.btnSave.TabIndex = 18;
            this.btnSave.Text = "保存";
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // ChangePassword
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(316, 265);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.labelControl4);
            this.Controls.Add(this.txtConfirm);
            this.Controls.Add(this.labelControl2);
            this.Controls.Add(this.txtNew);
            this.Controls.Add(this.labelControl1);
            this.Controls.Add(this.txtUserName);
            this.Controls.Add(this.labelControl3);
            this.Controls.Add(this.txtOld);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.IconOptions.ShowIcon = false;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "ChangePassword";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "修改登录密码";
            this.Load += new System.EventHandler(this.ChangePassword_Load);
            ((System.ComponentModel.ISupportInitialize)(this.txtOld.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtUserName.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtNew.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtConfirm.Properties)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.LabelControl labelControl3;
        private DevExpress.XtraEditors.TextEdit txtOld;
        private DevExpress.XtraEditors.LabelControl labelControl1;
        private DevExpress.XtraEditors.TextEdit txtUserName;
        private DevExpress.XtraEditors.LabelControl labelControl2;
        private DevExpress.XtraEditors.TextEdit txtNew;
        private DevExpress.XtraEditors.LabelControl labelControl4;
        private DevExpress.XtraEditors.TextEdit txtConfirm;
        private DevExpress.XtraEditors.SimpleButton btnClose;
        private DevExpress.XtraEditors.SimpleButton btnSave;
    }
}
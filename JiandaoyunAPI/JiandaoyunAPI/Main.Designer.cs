namespace JiandaoyunAPI
{
    partial class Main
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Main));
            this.btnQuit = new System.Windows.Forms.Button();
            this.txtQuitPassword = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.timerHandle = new System.Windows.Forms.Timer(this.components);
            this.cmbFormName = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.rTxtLog = new System.Windows.Forms.RichTextBox();
            this.dtEnd = new System.Windows.Forms.DateTimePicker();
            this.dtStart = new System.Windows.Forms.DateTimePicker();
            this.SuspendLayout();
            // 
            // btnQuit
            // 
            this.btnQuit.Location = new System.Drawing.Point(336, 285);
            this.btnQuit.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.btnQuit.Name = "btnQuit";
            this.btnQuit.Size = new System.Drawing.Size(63, 26);
            this.btnQuit.TabIndex = 0;
            this.btnQuit.Text = "退出";
            this.btnQuit.UseVisualStyleBackColor = true;
            this.btnQuit.Click += new System.EventHandler(this.btnQuit_Click);
            // 
            // txtQuitPassword
            // 
            this.txtQuitPassword.Location = new System.Drawing.Point(248, 287);
            this.txtQuitPassword.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.txtQuitPassword.Name = "txtQuitPassword";
            this.txtQuitPassword.PasswordChar = '*';
            this.txtQuitPassword.Size = new System.Drawing.Size(86, 21);
            this.txtQuitPassword.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(195, 290);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(53, 12);
            this.label1.TabIndex = 2;
            this.label1.Text = "退出密码";
            // 
            // timerHandle
            // 
            this.timerHandle.Enabled = true;
            this.timerHandle.Interval = 1000;
            this.timerHandle.Tick += new System.EventHandler(this.timerHandle_Tick);
            // 
            // cmbFormName
            // 
            this.cmbFormName.FormattingEnabled = true;
            this.cmbFormName.Items.AddRange(new object[] {
            " ",
            "人员信息档案",
            "请休假",
            "研究开发项目计划书",
            "项目变更计划书",
            "研发试产单"});
            this.cmbFormName.Location = new System.Drawing.Point(248, 251);
            this.cmbFormName.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.cmbFormName.Name = "cmbFormName";
            this.cmbFormName.Size = new System.Drawing.Size(86, 20);
            this.cmbFormName.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(184, 254);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(65, 12);
            this.label2.TabIndex = 4;
            this.label2.Text = "简道云表单";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(337, 248);
            this.button1.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(93, 26);
            this.button1.TabIndex = 5;
            this.button1.Text = "手工获取数据";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // rTxtLog
            // 
            this.rTxtLog.Location = new System.Drawing.Point(18, 10);
            this.rTxtLog.Name = "rTxtLog";
            this.rTxtLog.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical;
            this.rTxtLog.Size = new System.Drawing.Size(374, 226);
            this.rTxtLog.TabIndex = 10;
            this.rTxtLog.Text = "";
            // 
            // dtEnd
            // 
            this.dtEnd.CustomFormat = "yyyy-MM-dd";
            this.dtEnd.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtEnd.Location = new System.Drawing.Point(95, 251);
            this.dtEnd.Name = "dtEnd";
            this.dtEnd.Size = new System.Drawing.Size(83, 21);
            this.dtEnd.TabIndex = 21;
            // 
            // dtStart
            // 
            this.dtStart.CustomFormat = "yyyy-MM-dd";
            this.dtStart.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtStart.ImeMode = System.Windows.Forms.ImeMode.Disable;
            this.dtStart.Location = new System.Drawing.Point(4, 251);
            this.dtStart.Name = "dtStart";
            this.dtStart.Size = new System.Drawing.Size(87, 21);
            this.dtStart.TabIndex = 20;
            // 
            // Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(444, 321);
            this.Controls.Add(this.dtEnd);
            this.Controls.Add(this.dtStart);
            this.Controls.Add(this.rTxtLog);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.cmbFormName);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtQuitPassword);
            this.Controls.Add(this.btnQuit);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.MaximizeBox = false;
            this.Name = "Main";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "简道云api中间件";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Main_FormClosing);
            this.Load += new System.EventHandler(this.Main_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnQuit;
        private System.Windows.Forms.TextBox txtQuitPassword;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Timer timerHandle;
        private System.Windows.Forms.ComboBox cmbFormName;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.RichTextBox rTxtLog;
        private System.Windows.Forms.DateTimePicker dtEnd;
        private System.Windows.Forms.DateTimePicker dtStart;
    }
}


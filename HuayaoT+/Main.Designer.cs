namespace HuayaoT
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
            this.label1 = new System.Windows.Forms.Label();
            this.txtQuitPassword = new System.Windows.Forms.TextBox();
            this.btnQuit = new System.Windows.Forms.Button();
            this.timerHandle = new System.Windows.Forms.Timer(this.components);
            this.rTxtLog = new System.Windows.Forms.RichTextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.cmbFormName = new System.Windows.Forms.ComboBox();
            this.dtStart = new System.Windows.Forms.DateTimePicker();
            this.dtEnd = new System.Windows.Forms.DateTimePicker();
            this.btGetPeriod = new System.Windows.Forms.Button();
            this.btClear = new System.Windows.Forms.Button();
            this.cmbmonth = new System.Windows.Forms.ComboBox();
            this.cmbYear = new System.Windows.Forms.ComboBox();
            this.button2 = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.cmbT = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(102, 363);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(53, 12);
            this.label1.TabIndex = 13;
            this.label1.Text = "退出密码";
            // 
            // txtQuitPassword
            // 
            this.txtQuitPassword.Location = new System.Drawing.Point(155, 360);
            this.txtQuitPassword.Margin = new System.Windows.Forms.Padding(2);
            this.txtQuitPassword.Name = "txtQuitPassword";
            this.txtQuitPassword.PasswordChar = '*';
            this.txtQuitPassword.Size = new System.Drawing.Size(86, 21);
            this.txtQuitPassword.TabIndex = 12;
            // 
            // btnQuit
            // 
            this.btnQuit.Location = new System.Drawing.Point(243, 358);
            this.btnQuit.Margin = new System.Windows.Forms.Padding(2);
            this.btnQuit.Name = "btnQuit";
            this.btnQuit.Size = new System.Drawing.Size(63, 26);
            this.btnQuit.TabIndex = 11;
            this.btnQuit.Text = "退出";
            this.btnQuit.UseVisualStyleBackColor = true;
            this.btnQuit.Click += new System.EventHandler(this.btnQuit_Click);
            // 
            // timerHandle
            // 
            this.timerHandle.Enabled = true;
            this.timerHandle.Interval = 1000;
            this.timerHandle.Tick += new System.EventHandler(this.timerHandle_Tick);
            // 
            // rTxtLog
            // 
            this.rTxtLog.Location = new System.Drawing.Point(27, 12);
            this.rTxtLog.Name = "rTxtLog";
            this.rTxtLog.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical;
            this.rTxtLog.Size = new System.Drawing.Size(374, 201);
            this.rTxtLog.TabIndex = 17;
            this.rTxtLog.Text = "";
            // 
            // button1
            // 
            this.button1.AllowDrop = true;
            this.button1.Location = new System.Drawing.Point(244, 258);
            this.button1.Margin = new System.Windows.Forms.Padding(2);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(126, 26);
            this.button1.TabIndex = 16;
            this.button1.Text = "从简道云拉取数据";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label2
            // 
            this.label2.AllowDrop = true;
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(29, 265);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(65, 12);
            this.label2.TabIndex = 15;
            this.label2.Text = "简道云表单";
            // 
            // cmbFormName
            // 
            this.cmbFormName.AllowDrop = true;
            this.cmbFormName.FormattingEnabled = true;
            this.cmbFormName.Items.AddRange(new object[] {
            " ",
            "华耀出库单-录入",
            "华耀出库单-修改",
            "上角山出库单-录入",
            "上角山出库单-修改",
            "增值税开票-录入",
            "删除多余的数据"});
            this.cmbFormName.Location = new System.Drawing.Point(98, 261);
            this.cmbFormName.Margin = new System.Windows.Forms.Padding(2);
            this.cmbFormName.Name = "cmbFormName";
            this.cmbFormName.Size = new System.Drawing.Size(141, 20);
            this.cmbFormName.TabIndex = 14;
            // 
            // dtStart
            // 
            this.dtStart.AllowDrop = true;
            this.dtStart.CustomFormat = "yyyy-MM-dd";
            this.dtStart.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtStart.ImeMode = System.Windows.Forms.ImeMode.Disable;
            this.dtStart.Location = new System.Drawing.Point(28, 225);
            this.dtStart.Name = "dtStart";
            this.dtStart.Size = new System.Drawing.Size(109, 21);
            this.dtStart.TabIndex = 18;
            // 
            // dtEnd
            // 
            this.dtEnd.AllowDrop = true;
            this.dtEnd.CustomFormat = "yyyy-MM-dd";
            this.dtEnd.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtEnd.Location = new System.Drawing.Point(145, 225);
            this.dtEnd.Name = "dtEnd";
            this.dtEnd.Size = new System.Drawing.Size(94, 21);
            this.dtEnd.TabIndex = 19;
            // 
            // btGetPeriod
            // 
            this.btGetPeriod.AllowDrop = true;
            this.btGetPeriod.Location = new System.Drawing.Point(244, 223);
            this.btGetPeriod.Margin = new System.Windows.Forms.Padding(2);
            this.btGetPeriod.Name = "btGetPeriod";
            this.btGetPeriod.Size = new System.Drawing.Size(112, 26);
            this.btGetPeriod.TabIndex = 20;
            this.btGetPeriod.Text = "获取发货月数据";
            this.btGetPeriod.UseVisualStyleBackColor = true;
            this.btGetPeriod.Click += new System.EventHandler(this.btGetPeriod_Click);
            // 
            // btClear
            // 
            this.btClear.AllowDrop = true;
            this.btClear.Location = new System.Drawing.Point(360, 223);
            this.btClear.Margin = new System.Windows.Forms.Padding(2);
            this.btClear.Name = "btClear";
            this.btClear.Size = new System.Drawing.Size(80, 26);
            this.btClear.TabIndex = 21;
            this.btClear.Text = "清空数据";
            this.btClear.UseVisualStyleBackColor = true;
            this.btClear.Click += new System.EventHandler(this.btClear_Click);
            // 
            // cmbmonth
            // 
            this.cmbmonth.AllowDrop = true;
            this.cmbmonth.FormattingEnabled = true;
            this.cmbmonth.Items.AddRange(new object[] {
            " ",
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
            this.cmbmonth.Location = new System.Drawing.Point(180, 294);
            this.cmbmonth.Margin = new System.Windows.Forms.Padding(2);
            this.cmbmonth.Name = "cmbmonth";
            this.cmbmonth.Size = new System.Drawing.Size(59, 20);
            this.cmbmonth.TabIndex = 32;
            // 
            // cmbYear
            // 
            this.cmbYear.AllowDrop = true;
            this.cmbYear.FormattingEnabled = true;
            this.cmbYear.Items.AddRange(new object[] {
            " ",
            "2024",
            "2025",
            "2026",
            "2027",
            "2028",
            "2029",
            "2030"});
            this.cmbYear.Location = new System.Drawing.Point(98, 293);
            this.cmbYear.Margin = new System.Windows.Forms.Padding(2);
            this.cmbYear.Name = "cmbYear";
            this.cmbYear.Size = new System.Drawing.Size(78, 20);
            this.cmbYear.TabIndex = 33;
            // 
            // button2
            // 
            this.button2.AllowDrop = true;
            this.button2.Location = new System.Drawing.Point(243, 318);
            this.button2.Margin = new System.Windows.Forms.Padding(2);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(113, 26);
            this.button2.TabIndex = 31;
            this.button2.Text = "运行推送凭证程序";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // label3
            // 
            this.label3.AllowDrop = true;
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(29, 325);
            this.label3.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(65, 12);
            this.label3.TabIndex = 30;
            this.label3.Text = "推送T+凭证";
            // 
            // cmbT
            // 
            this.cmbT.AllowDrop = true;
            this.cmbT.FormattingEnabled = true;
            this.cmbT.Items.AddRange(new object[] {
            " ",
            "销售-冲销上月暂估",
            "销售-当月发货当月开票",
            "销售-当月未开票暂估",
            "路畅-冲销上月暂估",
            "路畅-当月发货当月开票",
            "路畅-当月未开票暂估"});
            this.cmbT.Location = new System.Drawing.Point(98, 321);
            this.cmbT.Margin = new System.Windows.Forms.Padding(2);
            this.cmbT.Name = "cmbT";
            this.cmbT.Size = new System.Drawing.Size(141, 20);
            this.cmbT.TabIndex = 29;
            // 
            // label5
            // 
            this.label5.AllowDrop = true;
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(18, 296);
            this.label5.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(77, 12);
            this.label5.TabIndex = 28;
            this.label5.Text = "凭证会计期间";
            // 
            // Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(444, 402);
            this.Controls.Add(this.cmbmonth);
            this.Controls.Add(this.cmbYear);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.cmbT);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.btClear);
            this.Controls.Add(this.btGetPeriod);
            this.Controls.Add(this.dtEnd);
            this.Controls.Add(this.dtStart);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtQuitPassword);
            this.Controls.Add(this.btnQuit);
            this.Controls.Add(this.rTxtLog);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.cmbFormName);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "Main";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "简道云To财务T+";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Main_FormClosing);
            this.Load += new System.EventHandler(this.Main_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtQuitPassword;
        private System.Windows.Forms.Button btnQuit;
        private System.Windows.Forms.Timer timerHandle;
        private System.Windows.Forms.RichTextBox rTxtLog;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cmbFormName;
        private System.Windows.Forms.DateTimePicker dtStart;
        private System.Windows.Forms.DateTimePicker dtEnd;
        private System.Windows.Forms.Button btGetPeriod;
        private System.Windows.Forms.Button btClear;
        private System.Windows.Forms.ComboBox cmbmonth;
        private System.Windows.Forms.ComboBox cmbYear;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox cmbT;
        private System.Windows.Forms.Label label5;
    }
}


namespace MakeT_Voucher
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
            this.dtEnd = new System.Windows.Forms.DateTimePicker();
            this.dtStart = new System.Windows.Forms.DateTimePicker();
            this.button2 = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.cmbT = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.cmbYear = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.cmbmonth = new System.Windows.Forms.ComboBox();
            this.btnClear = new System.Windows.Forms.Button();
            this.txtCustomer = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(133, 395);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(53, 12);
            this.label1.TabIndex = 13;
            this.label1.Text = "退出密码";
            // 
            // txtQuitPassword
            // 
            this.txtQuitPassword.Location = new System.Drawing.Point(186, 392);
            this.txtQuitPassword.Margin = new System.Windows.Forms.Padding(2);
            this.txtQuitPassword.Name = "txtQuitPassword";
            this.txtQuitPassword.PasswordChar = '*';
            this.txtQuitPassword.Size = new System.Drawing.Size(86, 21);
            this.txtQuitPassword.TabIndex = 12;
            // 
            // btnQuit
            // 
            this.btnQuit.Location = new System.Drawing.Point(274, 390);
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
            this.timerHandle.Interval = 1000;
            this.timerHandle.Tick += new System.EventHandler(this.timerHandle_Tick);
            // 
            // rTxtLog
            // 
            this.rTxtLog.Location = new System.Drawing.Point(27, 12);
            this.rTxtLog.Name = "rTxtLog";
            this.rTxtLog.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical;
            this.rTxtLog.Size = new System.Drawing.Size(374, 224);
            this.rTxtLog.TabIndex = 17;
            this.rTxtLog.Text = "";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(307, 267);
            this.button1.Margin = new System.Windows.Forms.Padding(2);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(113, 26);
            this.button1.TabIndex = 16;
            this.button1.Text = "从简道云拉取数据";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(93, 274);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(65, 12);
            this.label2.TabIndex = 15;
            this.label2.Text = "简道云表单";
            // 
            // cmbFormName
            // 
            this.cmbFormName.FormattingEnabled = true;
            this.cmbFormName.Items.AddRange(new object[] {
            " ",
            "销售发货单-录入",
            "销售发货单-修改",
            "销售发货单-月录入",
            "销售退货单",
            "开增值税发票-录入",
            "开增值税发票-修改",
            "开增值税发票-月录入",
            "删除多余的数据",
            "磅差处理单-录入",
            "往月库存商品单价-录入",
            "采购入库单-录入",
            "采购入库单-修改",
            "采购入库单-月录入",
            "采购开票-录入",
            "采购开票-修改",
            "采购开票-月录入",
            "采购退货冲红-录入"});
            this.cmbFormName.Location = new System.Drawing.Point(162, 270);
            this.cmbFormName.Margin = new System.Windows.Forms.Padding(2);
            this.cmbFormName.Name = "cmbFormName";
            this.cmbFormName.Size = new System.Drawing.Size(140, 20);
            this.cmbFormName.TabIndex = 14;
            // 
            // dtEnd
            // 
            this.dtEnd.CustomFormat = "yyyy-MM-dd";
            this.dtEnd.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtEnd.Location = new System.Drawing.Point(253, 242);
            this.dtEnd.Name = "dtEnd";
            this.dtEnd.Size = new System.Drawing.Size(83, 21);
            this.dtEnd.TabIndex = 23;
            // 
            // dtStart
            // 
            this.dtStart.CustomFormat = "yyyy-MM-dd";
            this.dtStart.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtStart.ImeMode = System.Windows.Forms.ImeMode.Disable;
            this.dtStart.Location = new System.Drawing.Point(162, 242);
            this.dtStart.Name = "dtStart";
            this.dtStart.Size = new System.Drawing.Size(87, 21);
            this.dtStart.TabIndex = 22;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(306, 357);
            this.button2.Margin = new System.Windows.Forms.Padding(2);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(113, 26);
            this.button2.TabIndex = 26;
            this.button2.Text = "运行推送凭证程序";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(92, 364);
            this.label3.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(65, 12);
            this.label3.TabIndex = 25;
            this.label3.Text = "推送T+凭证";
            // 
            // cmbT
            // 
            this.cmbT.FormattingEnabled = true;
            this.cmbT.Items.AddRange(new object[] {
            " ",
            "销售-有凭证冲红重开票",
            "销售-无凭证冲红重开票",
            "销售-无凭证冲红不开票",
            "销售-冲销上月暂估",
            "销售-当月发货当月开票",
            "销售-当月未开票暂估",
            "采购五金-冲销上月暂估",
            "采购五金-当月入库当月开票",
            "采购五金-当月未开票暂估",
            "采购原料-冲销上月暂估",
            "采购原料-当月入库当月开票",
            "采购原料-当月未开票暂估",
            "零星采购-当月入库当月开票",
            "零星采购-当月未开票暂估"});
            this.cmbT.Location = new System.Drawing.Point(161, 360);
            this.cmbT.Margin = new System.Windows.Forms.Padding(2);
            this.cmbT.Name = "cmbT";
            this.cmbT.Size = new System.Drawing.Size(141, 20);
            this.cmbT.TabIndex = 24;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(71, 247);
            this.label4.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(89, 12);
            this.label4.TabIndex = 15;
            this.label4.Text = "简道云提交时间";
            // 
            // cmbYear
            // 
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
            this.cmbYear.Location = new System.Drawing.Point(161, 332);
            this.cmbYear.Margin = new System.Windows.Forms.Padding(2);
            this.cmbYear.Name = "cmbYear";
            this.cmbYear.Size = new System.Drawing.Size(78, 20);
            this.cmbYear.TabIndex = 27;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(81, 335);
            this.label5.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(77, 12);
            this.label5.TabIndex = 15;
            this.label5.Text = "凭证会计期间";
            // 
            // cmbmonth
            // 
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
            this.cmbmonth.Location = new System.Drawing.Point(243, 333);
            this.cmbmonth.Margin = new System.Windows.Forms.Padding(2);
            this.cmbmonth.Name = "cmbmonth";
            this.cmbmonth.Size = new System.Drawing.Size(59, 20);
            this.cmbmonth.TabIndex = 27;
            // 
            // btnClear
            // 
            this.btnClear.Location = new System.Drawing.Point(7, 266);
            this.btnClear.Margin = new System.Windows.Forms.Padding(2);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(69, 26);
            this.btnClear.TabIndex = 16;
            this.btnClear.Text = "清空数据";
            this.btnClear.UseVisualStyleBackColor = true;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // txtCustomer
            // 
            this.txtCustomer.Location = new System.Drawing.Point(162, 302);
            this.txtCustomer.Name = "txtCustomer";
            this.txtCustomer.Size = new System.Drawing.Size(176, 21);
            this.txtCustomer.TabIndex = 28;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(104, 305);
            this.label6.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(53, 12);
            this.label6.TabIndex = 15;
            this.label6.Text = "客户名称";
            // 
            // Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(444, 438);
            this.Controls.Add(this.txtCustomer);
            this.Controls.Add(this.cmbmonth);
            this.Controls.Add(this.cmbYear);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.cmbT);
            this.Controls.Add(this.dtEnd);
            this.Controls.Add(this.dtStart);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtQuitPassword);
            this.Controls.Add(this.btnQuit);
            this.Controls.Add(this.rTxtLog);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
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
        private System.Windows.Forms.DateTimePicker dtEnd;
        private System.Windows.Forms.DateTimePicker dtStart;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox cmbT;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox cmbYear;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ComboBox cmbmonth;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.TextBox txtCustomer;
        private System.Windows.Forms.Label label6;
    }
}


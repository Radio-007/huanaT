using System;
using System.Data;
using System.Windows.Forms;
using GxRadio.Common;

namespace VirtuaAttendance.Attendance
{
    public partial class OnWorkRecAdd : DevExpress.XtraEditors.XtraForm
    {
        private OnWorkRec pForm;
        public int RecordID = 0;
        public OnWorkRecAdd(OnWorkRec parentForm)
        {
            InitializeComponent();
            this.pForm = parentForm;
        }

        #region 检查权限

        private void CheckRight()
        {
            btnSave.Visible = false;
            if (AccessController.HasPerByCode("02"))  //上班录入
            {
                btnSave.Visible = true;
            }
        }
        #endregion

        #region 数据绑定

        private void DataBound()
        {
            DataSet ds = SqlHelper.ExecuteDs("select a.*,b.OrgName,b.Department from OnWorkRec a inner join Employees b on b.EmployeeNo=a.EmployeeNo where a.ID=" + this.RecordID);
            if (ds.Tables[0].Rows.Count == 0) return;
            
            cmbOrgName.SelectedIndex = cmbOrgName.Properties.Items.IndexOf(Convert.ToString(ds.Tables[0].Rows[0]["OrgName"]));
            SharePro.cmbSelectDeparment(cmbOrgName.Text, cmbDepartment);
            cmbDepartment.Text = Convert.ToString(ds.Tables[0].Rows[0]["Department"]);

            cmbPeriod.SelectedIndex = cmbPeriod.Properties.Items.IndexOf(Convert.ToString(ds.Tables[0].Rows[0]["Period"]));
            cmbOnDesc.SelectedIndex = cmbOnDesc.Properties.Items.IndexOf(Convert.ToString(ds.Tables[0].Rows[0]["OnDesc"]));
            txtDays.Text = Convert.ToString(ds.Tables[0].Rows[0]["Days"]);
            txtRemark.Text = Convert.ToString(ds.Tables[0].Rows[0]["Remark"]);
            dtWorkDate.Text = Convert.ToString(ds.Tables[0].Rows[0]["WorkDate"]);
            cmbFullName.Text = Convert.ToString(ds.Tables[0].Rows[0]["FullName"]) + "-" + Convert.ToString(ds.Tables[0].Rows[0]["EmployeeNo"]);
            txtFullName.Text = Convert.ToString(ds.Tables[0].Rows[0]["FullName"]);
            txtEmployeeNo.Text = Convert.ToString(ds.Tables[0].Rows[0]["EmployeeNo"]);
        }
        #endregion

        #region 验证表单

        private bool validata()
        {
            if (cmbOrgName.Text.Trim() == "")
            {
                MessageBox.Show("公司不能为空！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            if (cmbDepartment.Text.Trim() == "")
            {
                MessageBox.Show("部门不能为空！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            if (cmbFullName.Text.Trim() == "")
            {
                MessageBox.Show("姓名不能为空！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            if (cmbPeriod.Text.Trim() == "")
            {
                MessageBox.Show("时段不能为空！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            if (dtWorkDate.Text.Trim() == "")
            {
                MessageBox.Show("日期不能为空！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            if (cmbOnDesc.Text.Trim() == "")
            {
                MessageBox.Show("出勤情况不能为空！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            string t = cmbFullName.Text.Trim();
            int pos = t.IndexOf("-");
            txtEmployeeNo.Text = t.Substring(pos + 1);
            txtFullName.Text = t.Substring(0, pos);

            string strSql = "select count(*) from OnWorkRec where EmployeeNo='" + txtEmployeeNo.Text + "' and WorkDate='" + dtWorkDate.Text + "' and Period='" + cmbPeriod.Text + "' and ID!=" + Convert.ToString(this.RecordID);
            DataSet ds = SqlHelper.ExecuteDs(strSql);
            if (Convert.ToInt32(ds.Tables[0].Rows[0][0]) > 0)
            {
                MessageBox.Show("该人员的上班记录已经存在！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            if (cmbOnDesc.Text == "√")
                txtDays.Text = "0.5";
            else
                txtDays.Text = "0";

            return true;
        }
        #endregion

        private void GoToOrOffWorkAdd_Load(object sender, EventArgs e)
        {
            cmbOrgName.Properties.Items.Clear();
            cmbOrgName.Properties.Items.Add("");
            DataSet ds = SqlHelper.ExecuteDs("select distinct OrgName from v_Department");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                cmbOrgName.Properties.Items.Add(Convert.ToString(ds.Tables[0].Rows[i][0]));
            }
            
            this.CheckRight(); //检查权限
            this.DataBound();  //数据绑定
        }

        private void cmbCompany_SelectedValueChanged(object sender, EventArgs e)
        {
            cmbDepartment.Text = "";
            cmbDepartment.Properties.Items.Clear();
            cmbDepartment.Properties.Items.Add("");
            DataSet ds = SqlHelper.ExecuteDs("select Department from v_Department where OrgName='" + cmbOrgName.Text + "'");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                cmbDepartment.Properties.Items.Add(Convert.ToString(ds.Tables[0].Rows[i][0]));
            }

            SharePro.cmbSelectDeparment(cmbOrgName.Text, cmbDepartment);
        }

        private void cmbDepartment_SelectedValueChanged(object sender, EventArgs e)
        {
            cmbFullName.Properties.Items.Clear();
            cmbFullName.Properties.Items.Add("");
            DataSet ds = SqlHelper.ExecuteDs("select distinct EmployeeNo,FullName from Employees where OrgName='" + cmbOrgName.Text + "' and Department='" + cmbDepartment.Text + "'");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                cmbFullName.Properties.Items.Add(Convert.ToString(ds.Tables[0].Rows[i][1]) + "-" + Convert.ToString(ds.Tables[0].Rows[i][0]));
            }
            cmbFullName.SelectedIndex = 0;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.validata()) return;

            if (this.RecordID == 0)
            {
                string strSql = "insert into OnWorkRec(EmployeeNo, FullName, WorkDate, Period, Days, OnDesc, Remark, Status, Creator, CreateTime) values('";
                strSql += txtEmployeeNo.Text + "','" + txtFullName.Text + "','" + dtWorkDate.Text + "','" + cmbPeriod.Text + "',";
                strSql += txtDays.Text + ",'" + cmbOnDesc.Text + "','" + txtRemark.Text.Trim() + "',2,'" + AccessController.CurrentUser.UserName + "',getdate())";
                SqlHelper.ExecuteSql(strSql);
                MessageBox.Show("添加成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                string strSql = "UPDATE OnWorkRec SET FullName='" + txtFullName.Text + "',Days=" + txtDays.Text + ",OnDesc='" + cmbOnDesc.Text + "',Remark='" + txtRemark.Text.Trim() + "'";
                strSql += ",Updater='" + AccessController.CurrentUser.UserName + "',UpdateTime=getdate() where ID=" + this.RecordID;
                SqlHelper.ExecuteSql(strSql);
                MessageBox.Show("修改成功", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            pForm.BindDataSource(this.RecordID); //重新绑定数据
            this.Close();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
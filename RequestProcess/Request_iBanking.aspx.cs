using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
namespace RequestProcess
{
    public partial class Request_iBanking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Title = "iBanking Request - Trust Bank";
            if (!IsPostBack)
                //DetailsView1.ChangeMode(DetailsViewMode.Edit);
                HyperLinkShowRequst.NavigateUrl = string.Format("Request_Show.aspx?email={0}&reqid={1}&keycode={2}", Request.QueryString["email"], Request.QueryString["reqid"], Request.QueryString["keycode"]);
                txtAccountNo.Focus();

            SqlConnection.ClearAllPools();
            if (grdvAccountList.Rows.Count> 0)
            {
                PanelLinkedAccount.Visible = true;
                btnNextStep.Text = "Next Step";
                //foreach (GridViewRow row in grdvAccountList.Rows)
                //{
                //    CheckBox chk = (CheckBox)row.Cells[3].Controls[0];

                //    string a = chk.Checked.ToString();
                //}
            }
            if (gdvUsedAccount.Rows.Count > 0)
            {
                panelUsedAcc.Visible = true;
               
            }
           // LoadDataToGridView();
        }



      

        //public void ClientMsg(string MsgTxt, Control focusControl)
        //{
        //    string script1 = "";
        //    if (focusControl != null)
        //        script1 = "$('#" + focusControl.ClientID + "').focus();";
        //    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "clientScript", "jAlert('" + MsgTxt + "','Trust Bank', function(r){" + script1 + "});", true);
        //}

        //public void ClientMsg(string MsgTxt)
        //{
        //    ClientMsg(MsgTxt, null);
        //}

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {

        }

        //string ReqType = "ADD";

        protected void cmdAddAccount_Click1(object sender, EventArgs e)
        {
            if (txtAccountNo.Text.Trim().Length != 15)
            {
                CommonControl1.ClientMsg("Please enter your valid account number.", txtAccountNo);
                return;
            }

          
            int TransferLimit = int.Parse(Common.getValueOfKey("TransferLimit"));
            int UtilityLimit = int.Parse(Common.getValueOfKey("UtilityLimit"));
            int DailyTransactionLimit = int.Parse(Common.getValueOfKey("DailyTransactionLimit"));
            int MonthlyTransactionLimit = int.Parse(Common.getValueOfKey("MonthlyTransactionLimit"));
            int PerDayNoOfTransaction = int.Parse(Common.getValueOfKey("PerDayNoOfTransaction"));
            int PerMonthNoOfTransaction = int.Parse(Common.getValueOfKey("PerMonthNoOfTransaction"));

            if (
                    TransferLimit < int.Parse(txtTransferLimit.Text.Trim() == "" ? "0" : txtTransferLimit.Text.Trim())
                    || UtilityLimit < int.Parse(txtUtilityLimit.Text.Trim() == "" ? "0" : txtUtilityLimit.Text.Trim())
                    || DailyTransactionLimit < int.Parse(txtDailyTransactionLimit.Text.Trim() == "" ? "0" : txtDailyTransactionLimit.Text.Trim())
                    || MonthlyTransactionLimit < int.Parse(txtMonthlyTransactionLimit.Text.Trim() == "" ? "0" : txtMonthlyTransactionLimit.Text.Trim())
                    || PerDayNoOfTransaction < int.Parse(txtPerDayNoOfTransaction.Text.Trim() == "" ? "0" : txtPerDayNoOfTransaction.Text.Trim())
                    || PerMonthNoOfTransaction < int.Parse(txtPerMonthNoOfTransaction.Text.Trim() == "" ? "0" : txtPerMonthNoOfTransaction.Text.Trim())
                )
            {
                CommonControl1.ClientMsg("Invalid Limits.");
                return;
            }
            int fTransferLimit = 0;
            int fUtilityLimit = 0;
            int fDailyTransactionLimit = 0;
            int fMonthlyTransactionLimit = 0;
            int fPerDayNoOfTransaction = 0;
            int fPerMonthNoOfTransaction = 0;
            
            if (chkFundTransfer.Checked)
            {
                fTransferLimit = int.Parse(txtTransferLimit.Text.Trim() == "" ? "0" : txtTransferLimit.Text.Trim());
                fUtilityLimit = int.Parse(txtUtilityLimit.Text.Trim() == "" ? "0" : txtUtilityLimit.Text.Trim());
                fDailyTransactionLimit = int.Parse(txtDailyTransactionLimit.Text.Trim() == "" ? "0" : txtDailyTransactionLimit.Text.Trim());

                fMonthlyTransactionLimit = int.Parse(txtMonthlyTransactionLimit.Text.Trim() == "" ? "0" : txtMonthlyTransactionLimit.Text.Trim());
                fPerDayNoOfTransaction=int.Parse(txtPerDayNoOfTransaction.Text.Trim() == "" ? "0" : txtPerDayNoOfTransaction.Text.Trim());
                fPerMonthNoOfTransaction = int.Parse(txtPerMonthNoOfTransaction.Text.Trim() == "" ? "0" : txtPerMonthNoOfTransaction.Text.Trim());

                if (fTransferLimit == 0 && fUtilityLimit == 0)
                {                   
                    CommonControl1.ClientMsg("Transfer Limit or Utility Limit per transaction must be greater than zero.");
                    return;                    
                }

                if (fTransferLimit > fDailyTransactionLimit)
                {
                    CommonControl1.ClientMsg("Transfer Limit can not be greater than Daily Transaction Limit.");
                    return;
                }

                if (fUtilityLimit > fDailyTransactionLimit)
                {
                    CommonControl1.ClientMsg("Utility Limit can not be greater than Daily Transaction Limit.");
                    return;
                }

                if (fDailyTransactionLimit > fMonthlyTransactionLimit)
                {
                    CommonControl1.ClientMsg("Daily Transaction Limit can not be greater than Monthly Transaction Limit.");
                    return;
                }

                if (fPerDayNoOfTransaction > fPerMonthNoOfTransaction)
                {
                    CommonControl1.ClientMsg("No. of Transaction Per Day can not be greater than No. of Transaction Per Month.");
                    return;
                }
            }

            string Msg = "";
            bool isVerified = false;
            string Query = "s_iBanking_Req_Insert";
           
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["Request_ProcessConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@SlNo", System.Data.SqlDbType.Int).Value = hidSlNo.Value==""?"0":hidSlNo.Value;
                    cmd.Parameters.Add("@ReqID", System.Data.SqlDbType.BigInt).Value = Request.QueryString["reqid"];
                    cmd.Parameters.Add("@Accountno", System.Data.SqlDbType.VarChar).Value = txtAccountNo.Text.Trim();
                    cmd.Parameters.Add("@TransferLimit", System.Data.SqlDbType.Money).Value = fTransferLimit;
                    cmd.Parameters.Add("@UtilityLimit", System.Data.SqlDbType.Money).Value = fUtilityLimit;
                    cmd.Parameters.Add("@DailyTransactionLimit", System.Data.SqlDbType.Money).Value = fDailyTransactionLimit;

                    cmd.Parameters.Add("@MonthlyTransactionLimit", System.Data.SqlDbType.Money).Value = fMonthlyTransactionLimit;
                    cmd.Parameters.Add("@PerDayNoOfTransaction", System.Data.SqlDbType.Money).Value = fPerDayNoOfTransaction;
                    cmd.Parameters.Add("@PerMonthNoOfTransaction", System.Data.SqlDbType.Money).Value = fPerMonthNoOfTransaction;
                    if (cmdAddAccount.Text == "Add Account" || cmdAddAccount.Text == "Update Account")
                        cmd.Parameters.Add("@ReqType", System.Data.SqlDbType.VarChar).Value = "ADD";
                    if (cmdAddAccount.Text == "Modify Account")
                        cmd.Parameters.Add("@ReqType", System.Data.SqlDbType.VarChar).Value = "MODIFY";
                    cmd.Parameters.Add("@AllowFund", System.Data.SqlDbType.Bit).Value = chkFundTransfer.Checked;
                    SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                    cmd.Parameters.Add("@Email", System.Data.SqlDbType.VarChar).Value = Request.QueryString["email"];
                    SQL_Msg.Direction = ParameterDirection.InputOutput;
                    SQL_Msg.Value = Msg;
                    cmd.Parameters.Add(SQL_Msg);

                    SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    SQL_Done.Direction = ParameterDirection.InputOutput;
                    SQL_Done.Value = isVerified;
                    cmd.Parameters.Add(SQL_Done);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();

                    isVerified = (bool)SQL_Done.Value;
                    Msg = string.Format("{0}", SQL_Msg.Value);

                }

            }
            if (isVerified)
            {
                ClearAccInfo();
                CommonControl1.ClientMsg(Msg);
               
                grdvAccountList.DataBind();
                PanelLinkedAccount.Visible = true;
              
               // LoadDataToGridView();
               
            }
            else
            {
                CommonControl1.ClientMsg(Msg);
            }

        }

        private void ClearAccInfo()
        {
            txtAccountNo.Text = "";
            txtAccountNo.Enabled = true;
            cmdAddAccount.Text = "Add Account";
            chkFundTransfer.Checked = false;
            GetDefaultValueFromWebconfig();
            btnNewAcc.Visible = false;
            gdvUsedAccount.SelectedIndex = -1;
            grdvAccountList.SelectedIndex = -1;
            if (grdvAccountList.Rows.Count > 0)
            {
                PanelLinkedAccount.Visible = true;
                btnNextStep.Text = "Next Step";
            }
            //if (gdvUsedAccount.Rows.Count > 0)
            //    panelUsedAcc.Visible = true;
        }

        protected void DetailsView1_DataBound(object sender, EventArgs e)
        {
            if (DetailsView1.Rows.Count < 3)
            {
                  Response.Write("Invalid Request");
                  Response.End();
            }
        }

        private void GetDefaultValueFromWebconfig()
        {

           txtTransferLimit.Text = Common.getValueOfKey("dTransferLimit");
           txtUtilityLimit.Text = Common.getValueOfKey("dUtilityLimit");
           txtDailyTransactionLimit.Text = Common.getValueOfKey("dDailyTransactionLimit");
           txtMonthlyTransactionLimit.Text = Common.getValueOfKey("dMonthlyTransactionLimit");
           txtPerDayNoOfTransaction.Text = Common.getValueOfKey("dPerDayNoOfTransaction");
           txtPerMonthNoOfTransaction.Text = Common.getValueOfKey("dPerMonthNoOfTransaction");
        }

       

        protected void lnkSelect_Click(object sender, EventArgs e)
        {
            //GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;
            //txtAccountNo.Text = row.Cells[2].Text;
            ////chkFundTransfer.Text = ((CheckBox)row.Cells[3].Controls[0]).Checked.ToString();
            //txtTransferLimit.Text = row.Cells[4].Text;
            //txtUtilityLimit.Text = row.Cells[5].Text;
            //txtDailyTransactionLimit.Text = row.Cells[6].Text;
            //txtMonthlyTransactionLimit.Text = row.Cells[7].Text;
            //txtPerDayNoOfTransaction.Text = row.Cells[8].Text;
            //txtPerMonthNoOfTransaction.Text = row.Cells[9].Text;
            ////txtTransferLimit.Text = ((TextBox)grdvAccountList.SelectedRow.Cells[4].Controls[0]).Text.ToString(); 

        }

        protected void lblDelteExisting_Click(object sender, EventArgs e)
        {
           
            GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;
            Label lblAcc = (Label)row.FindControl("lblAccountNo");
            string Msg = "";
            bool isVerified = false;
            string Query = "[s_iBanking_Req_Delete]";

            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["Request_ProcessConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {

                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ReqID", System.Data.SqlDbType.BigInt).Value = Request.QueryString["reqid"];
                    cmd.Parameters.Add("@Accountno", System.Data.SqlDbType.VarChar).Value = lblAcc.Text.Trim();
                    cmd.Parameters.Add("@Email", System.Data.SqlDbType.VarChar).Value = Request.QueryString["email"];
                    cmd.Parameters.Add("@KeyCode", System.Data.SqlDbType.VarChar).Value = Request.QueryString["keycode"];
                   
                    SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                   
                    SQL_Msg.Direction = ParameterDirection.InputOutput;
                    SQL_Msg.Value = Msg;
                    cmd.Parameters.Add(SQL_Msg);

                    SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    SQL_Done.Direction = ParameterDirection.InputOutput;
                    SQL_Done.Value = isVerified;
                    cmd.Parameters.Add(SQL_Done);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();

                    isVerified = (bool)SQL_Done.Value;
                    Msg = string.Format("{0}", SQL_Msg.Value);

                }

            }
            if (isVerified)
            {
              
                CommonControl1.ClientMsg(Msg);

                grdvAccountList.DataBind();
                PanelLinkedAccount.Visible = true;

              

            }
            else
            {
                CommonControl1.ClientMsg(Msg);
            }
        }

        protected void grdvAccountList_SelectedIndexChanged(object sender, EventArgs e)
        {
           
            GridViewRow row = grdvAccountList.SelectedRow;
            Label lblSL = (Label)row.FindControl("lblSL");
            hidSlNo.Value = lblSL.Text;
            txtAccountNo.Text = row.Cells[2].Text;
          //  chkFundTransfer.Text = ((CheckBox)grdvAccountList.SelectedRow.Cells[3].Controls[0]).Checked.ToString();
            if (((CheckBox)grdvAccountList.SelectedRow.Cells[3].Controls[0]).Checked)
            {
                chkFundTransfer.Checked=true;
             
            }
            else
                chkFundTransfer.Checked = false;

            LoadDatatoTextBox(row);
            cmdAddAccount.Text = "Update Account";
            txtAccountNo.Enabled = false;
            btnNewAcc.Visible = true;
            if (chkFundTransfer.Checked == false)
            {
                GetDefaultValueFromWebconfig();
            }
            gdvUsedAccount.SelectedIndex = -1;

          
                      
        }

        private void LoadDatatoTextBox(GridViewRow row)
        {
            Label lblTransferLimitv = (Label)row.FindControl("lblTransferLimit");
            txtTransferLimit.Text = lblTransferLimitv.Text.Replace(",", "");

            Label lblUtilityLimit = (Label)row.FindControl("lblUtilityLimit");
            txtUtilityLimit.Text = lblUtilityLimit.Text.Replace(",", "");
            Label lblDailyTrans = (Label)row.FindControl("lblDailyTrans");
            txtDailyTransactionLimit.Text = lblDailyTrans.Text.Replace(",", "");
            Label lblMonthly = (Label)row.FindControl("lblMonthly");
            txtMonthlyTransactionLimit.Text = lblMonthly.Text.Replace(",", "");
            Label lblPerDayTrans = (Label)row.FindControl("lblPerDayTrans");
            txtPerDayNoOfTransaction.Text = lblPerDayTrans.Text;
            Label lblPerMonthTrans = (Label)row.FindControl("lblPerMonthTrans");
            txtPerMonthNoOfTransaction.Text = lblPerMonthTrans.Text;
        }

        protected void grdvAccountList_RowCommand(object sender, GridViewCommandEventArgs e)
        {


                if (e.CommandName == "Select")
                {
                    //GridViewRow row = grdvAccountList.Rows[0];
                // //   GridViewRow row = grdvAccountList.SelectedRow;
                   //// txtAccountNo.Text = ((CheckBox)row.Cells[3].Controls[0]).Checked.ToString();
                  //  int index = Convert.ToInt32(e.CommandArgument);
                   //txtAccountNo.Text = DataBinder.Eval(row.DataItem, "Accountno").ToString();
                  //  txtTransferLimit.Text = grdvAccountList.Rows[index].Cells[4].Text;
                  //  txtUtilityLimit.Text = grdvAccountList.Rows[index].Cells[5].Text;
                  //  txtDailyTransactionLimit.Text = grdvAccountList.Rows[index].Cells[6].Text;
                  //  txtMonthlyTransactionLimit.Text = grdvAccountList.Rows[index].Cells[7].Text;
                  //  txtPerDayNoOfTransaction.Text = grdvAccountList.Rows[index].Cells[8].Text;
                  //  txtPerMonthNoOfTransaction.Text = grdvAccountList.Rows[index].Cells[9].Text;

                  //  chkFundTransfer.Text = grdvAccountList.Rows[index].Cells[3].Text;
                  ////  GridViewRow row   = grdvAccountList.Rows[index];
                  //  //string StrRecordID = grdvAccountList.Rows[index].Cells[2].Text;
                    
                }
            
        }

        protected void SqlDataSourceAddAcc_Deleted(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
                CommonControl1.ClientMsg("Deleted Successfully.");
            else
                CommonControl1.ClientMsg("Delete not Completed.Please try again.");
            GetDefaultValueFromWebconfig();
            chkFundTransfer.Checked = false;
            txtAccountNo.Text = "";
            grdvAccountList.DataBind();
            cmdAddAccount.Text = "Add Account";
            
        }

        protected void grdvAccountList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
              
             
                if (e.Row.Cells[10].Text.Contains("DELETE"))
                {
                    LinkButton lnkBtn = (LinkButton)e.Row.FindControl("lnkSelect");
                    lnkBtn.Visible = false;
                }
                
               // string a= e.Row.Cells[10].Text;
                //if (e.Row.Cells[6].Text.Contains(1))
                //{
                //     checkTransPre ++;
                //}

                //if (checkTransPre > 0)
                //{
                //    panelTransferMode.Visible = true;
                //}
            }
            //if(e.Row.)
            //txtAccountNo.Text = DataBinder.Eval(e.Row.DataItem, "Accountno").ToString();
        }

        protected void btnNewAcc_Click(object sender, EventArgs e)
        {
            ClearAccInfo();
        }

        protected void gdvUsedAccount_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = gdvUsedAccount.SelectedRow;
                Label lblAcc = (Label)row.FindControl("lblAccountNo");
                txtAccountNo.Text = lblAcc.Text;
                //  txtAccountNo.Text = row.Cells[1].Text;
                if (((CheckBox)gdvUsedAccount.SelectedRow.Cells[2].Controls[0]).Checked)
                {
                    chkFundTransfer.Checked = true;
                }
                else
                    chkFundTransfer.Checked = false;

                LoadDatatoTextBox(row);
                cmdAddAccount.Text = "Modify Account";
                txtAccountNo.Enabled = false;
                btnNewAcc.Visible = true;
                if (chkFundTransfer.Checked == false)
                {
                    GetDefaultValueFromWebconfig();
                }
                grdvAccountList.SelectedIndex = -1;
            }
            catch (Exception) { }
        }

        protected void btnNextStep_Click(object sender, EventArgs e)
        {
            //Response.Redirect("Request_Show.aspx");
            if (panelTransferMode.Visible)
            {
                if (InsertTransactionPrivilageOption())


                    Response.Redirect(string.Format("Request_Show.aspx?email={0}&reqid={1}&keycode={2}", Request.QueryString["email"], Request.QueryString["reqid"], Request.QueryString["keycode"]), true);
                else
                {
                    CommonControl1.ClientMsg("Try Again.");
                }
            }
            else
            {
                Response.Redirect(string.Format("Request_Show.aspx?email={0}&reqid={1}&keycode={2}", Request.QueryString["email"], Request.QueryString["reqid"], Request.QueryString["keycode"]), true);
            }
        }

        protected void grdvAccountList_DataBound(object sender, EventArgs e)
        {
            int chkFund = 0;
            try
            {
                foreach (GridViewRow row in grdvAccountList.Rows)
                {
                    CheckBox chk = (CheckBox)row.Cells[3].Controls[0];
                    if (chk.Checked)
                        chkFund++;
                }

                if (chkFund > 0)
                {
                    panelTransferMode.Visible = true;
                }
                else
                {
                    panelTransferMode.Visible = false;
                }
            }
            catch (Exception ex)
            {
                chkFund = 0;
            }
        }

        protected void SqlDataSourceAddAcc_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                PanelLinkedAccount.Visible = true;
                btnNextStep.Text = "Next Step";
                btnNextStep.Visible = true;
            }
            else
            {
                PanelLinkedAccount.Visible = false;
                btnNextStep.Text = "Skip & Next Step";
                btnNextStep.Visible = false;
            }            
        }


        private Boolean InsertTransactionPrivilageOption()
        {
            string Msg = "";
            bool isVerified = false;
            string Query = "[s_iBankingReqOptionPrivilege]";

            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["Request_ProcessConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {

                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ReqID", System.Data.SqlDbType.BigInt).Value = Request.QueryString["reqid"];
                    cmd.Parameters.Add("@Email", System.Data.SqlDbType.VarChar).Value = Request.QueryString["email"];
                    cmd.Parameters.Add("@TransactionPrivilege", System.Data.SqlDbType.VarChar).Value = ddlTranPrevilage.SelectedValue.ToString();
                    cmd.Parameters.Add("@OtpGoThrough", System.Data.SqlDbType.VarChar).Value = ddlOtp.Text.Trim().ToString();
                  
                    SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);

                    SQL_Msg.Direction = ParameterDirection.InputOutput;
                    SQL_Msg.Value = Msg;
                    cmd.Parameters.Add(SQL_Msg);

                    SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    SQL_Done.Direction = ParameterDirection.InputOutput;
                    SQL_Done.Value = isVerified;
                    cmd.Parameters.Add(SQL_Done);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();

                    isVerified = (bool)SQL_Done.Value;
                    Msg = string.Format("{0}", SQL_Msg.Value);

                }

            }

            return isVerified;
           
        }

        private void CheckPrivilege()
        {

        }

        //protected void SqlDataSourceTaggedAcc_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        //{
        //    string Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        //    bool Done = (bool)e.Command.Parameters["@Done"].Value;
         
        //    gdvUsedAccount.DataBind();
        //    CommonControl1.ClientMsg(string.Format("{0}", Msg));
        //}       
    }
}
using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI;


    public partial class Email_Notification : System.Web.UI.Page
    {
        string AccNo = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();
            Title = "Email Notification";
            txtAcc.Focus();
            if (!IsPostBack)
            {
                AccNo = string.Format("{0}", Request.QueryString["acc"]);
                txtAcc.Text = AccNo;
                Title = string.Format("{0} - Email Notification", AccNo);
                litTitle.Text = string.Format("Email Notification of {0}", AccNo);
            }
        }

        protected void cmdOK_Click(object sender, EventArgs e)
        {
            bool Done = false;
            string Msg = "";
            string CRs = "";
            string DRs = "";
            string Emails = "";

            for (int r = 0; r < GridView2.Rows.Count; r++)
            {
                if (((CheckBox)(GridView2.Rows[r].FindControl("chkCR"))).Checked)
                    CRs += GridView2.Rows[r].Cells[0].Text.Trim() + ",";

                if (((CheckBox)(GridView2.Rows[r].FindControl("chkDR"))).Checked)
                    DRs += GridView2.Rows[r].Cells[0].Text.Trim() + ",";
            }

            Emails = lblEmails.Text.Trim().Replace(" ", "");
            if (Emails.Length < 7)
                Emails = txtEmail.Text.Trim();

            if (Emails.Length < 7)
            {
                TrustControl1.ClientMsg("Please enter Email Address.");
                txtEmail.Focus();
                return;
            }

            if (txtRemarks.Text.Trim().Length == 0)
            {
                TrustControl1.ClientMsg("Please enter Reference.");
                txtRemarks.Focus();
                return;
            }

            if (Emails.EndsWith(";"))
                Emails = Emails.Substring(0, Emails.Length - 1);

            //TrustControl1.ClientMsg(Emails);
            //return;


            SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SMSConnectionString"].ConnectionString);
            SqlCommand oCommand = new SqlCommand("s_EmailNotificationPermissionInsert", oConn);
            oCommand.CommandType = CommandType.StoredProcedure;

            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            oCommand.Parameters.Add("@AccountNo", SqlDbType.VarChar).Value = txtAcc.Text.Trim();
            oCommand.Parameters.Add("@Emails", SqlDbType.VarChar).Value = Emails;
            oCommand.Parameters.Add("@InsertBy", SqlDbType.VarChar).Value = Session["EMPID"].ToString();
            oCommand.Parameters.Add("@Reference", SqlDbType.VarChar).Value = txtRemarks.Text.Trim();
            oCommand.Parameters.Add("@CRs", SqlDbType.VarChar).Value = CRs.Trim().Replace(" ", "");
            oCommand.Parameters.Add("@DRs", SqlDbType.VarChar).Value = DRs.Trim().Replace(" ", "");


            SqlParameter sql_Done = new SqlParameter("@Done", SqlDbType.Bit);
            sql_Done.Value = Done;
            sql_Done.Direction = ParameterDirection.InputOutput;
            oCommand.Parameters.Add(sql_Done);

            SqlParameter sql_Msg = new SqlParameter("@Msg", SqlDbType.VarChar);
            sql_Msg.Size = 255;
            sql_Msg.Value = Msg;
            sql_Msg.Direction = ParameterDirection.InputOutput;
            oCommand.Parameters.Add(sql_Msg);

            oCommand.ExecuteNonQuery();

            Msg = string.Format("<br />{0}<br />", sql_Msg.Value);
            Done = (bool)sql_Done.Value;

            oConn.Close();

            TrustControl1.ClientMsg(Msg);

            if (Done)
            {
                DetailsView3.DataBind();
                GridView1.DataBind();
                GridView2.DataBind();
            }

            //Response.Write(ROW_AFFECTED.ToString());            
        }

        protected void txtAcc_TextChanged(object sender, EventArgs e)
        {
            //SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Florabank_OnlineConnectionString"].ConnectionString);
            //SqlCommand oCommand = new SqlCommand("SELECT acname FROM dbo.cus_ac_1 WITH ( NOLOCK ) WHERE accountno = @Account", oConn);

            //if (oConn.State == ConnectionState.Closed)
            //    oConn.Open();
            //oCommand.Parameters.Add("@Account", SqlDbType.VarChar).Value = txtAcc.Text.Trim();

            //SqlDataReader oReader = oCommand.ExecuteReader();

            //if (oReader.HasRows)
            //    while (oReader.Read())
            //    {
            //        lblAccName.Text = oReader["acname"].ToString();
            //    }
            //else
            //    lblAccName.Text = "A/C Not Found.";

            //oReader.Close();
            //oConn.Close();

            //SqlDataSource1.DataBind();
        }

        protected void cmdShow_Click(object sender, EventArgs e)
        {
            RedirectRefresh();
        }

        private void RedirectRefresh()
        {
            Response.Redirect(string.Format("Email_Notification.aspx?acc={0}", txtAcc.Text), true);
        }

        protected void cmdEmail_Click(object sender, EventArgs e)
        {
            string Email = txtEmail.Text.Trim();
            if (Email.Length == 0)
            {
                txtEmail.Focus(); 
                return;
            }
            if (Common.isEmailAddress(Email))
            {
                string Emails = ";" + lblEmails.Text;
                if (Emails.Contains(";" + Email + ";") == false)
                {
                    lblEmails.Text += Email.Trim() + "; ";
                    lblEmails.Text = lblEmails.Text.Replace(";;", ";");
                }
                txtEmail.Text = "";
                txtEmail.Focus();
            }
            else
            {
                TrustControl1.ClientMsg("Invalid Email Address.");
            }
        }

        protected void cmdEmailRemove_Click(object sender, EventArgs e)
        {
            string Email = txtEmail.Text.Trim();
            if (Email.Length == 0)
            {
                txtEmail.Focus();
                return;
            }
            
            string Emails = lblEmails.Text;
            Emails = Emails.Replace(Email + ";", "");
            {
                lblEmails.Text = Emails.Replace("  ", " ");
            }
            txtEmail.Text = "";
            txtEmail.Focus();
            
        }

        protected void DetailsView3_DataBound(object sender, EventArgs e)
        {
            if (DetailsView3.CurrentMode == DetailsViewMode.ReadOnly)
            {
                //for (int i = 1; i < DetailsView3.Rows.Count; i++)
                {
                    string Emails = string.Format("{0}", DataBinder.Eval(DetailsView3.DataItem, "Email"));
                    Emails = Emails.Trim();

                    if (!Emails.EndsWith(";") && Emails.Length > 0) Emails += ";";

                    string[] DBEmails = Emails.Split(';');
                    foreach (string DBEmail in DBEmails)
                        if (Common.isEmailAddress(DBEmail))
                            lblEmails.Text += DBEmail + "; ";

                    //lblEmails.Text = Emails.Replace(";", "; ");

            //        if (DetailsView3.Rows[i].Cells.Count == 2)
            //        {
            //            string value = DetailsView3.Rows[i].Cells[1].Text.Trim().Replace("&nbsp;", "");


            //            if (DetailsView3.Rows[i].Cells[1].HasControls())
            //            {
            //                try
            //                {
            //                    value = ((DataBoundLiteralControl)DetailsView3.Rows[i].Cells[1].Controls[0]).Text.Trim().Replace("&nbsp;", "");
            //                }
            //                catch (Exception) { }
            //            }

            //            if (value == string.Empty)
            //            {
            //                DetailsView3.Rows[i].Visible = false;
            //            }
            //        }
                }
            }
        }

        protected void SqlDataSource3_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
                cmdOK.Enabled = true;
        }

        protected void txtAcc_TextChanged1(object sender, EventArgs e)
        {
            RedirectRefresh();
        }


    }

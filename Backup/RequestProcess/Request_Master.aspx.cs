using System;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;
namespace RequestProcess
{
    public partial class Request_Master : System.Web.UI.Page
    {
        bool Done = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            Title = "eService Request Entry Form - Trust Bank";

            if (!IsPostBack)
                DetailsView1.ChangeMode(DetailsViewMode.Edit);

            SqlConnection.ClearAllPools();
        }

        protected void dboDivision2_SelectedIndexChanged1(object sender, EventArgs e)
        {
            DropDownList dboDistrict2 = ((DropDownList)DetailsView1.FindControl("dboDistrict2"));
            dboDistrict2.Items.Clear();
            dboDistrict2.DataBind();
        }

        protected void dboDistrict2_DataBound(object sender, EventArgs e)
        {
            DropDownList dboDistrict2 = ((DropDownList)DetailsView1.FindControl("dboDistrict2"));
            String District = ((HiddenField)(DetailsView1.FindControl("hidDistrict"))).Value;

            try
            {
                foreach (ListItem LI in dboDistrict2.Items)
                    if (LI.Value == District)
                        LI.Selected = true;
                    else
                        LI.Selected = false;
            }
            catch (Exception) { }

            DropDownList dboThana2 = ((DropDownList)DetailsView1.FindControl("dboThana2"));
            dboThana2.Items.Clear();
            dboThana2.DataBind();
        }

        protected void dboDistrict2_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList dboThana2 = ((DropDownList)DetailsView1.FindControl("dboThana2"));
            dboThana2.Items.Clear();
            dboThana2.DataBind();

            String Thana = ((HiddenField)(DetailsView1.FindControl("hidThana"))).Value;

            try
            {
                foreach (ListItem LI in dboThana2.Items)
                    if (LI.Value == Thana)
                        LI.Selected = true;
                    else
                        LI.Selected = false;
            }
            catch (Exception) { }
        }
        protected void dboThana2_DataBound(object sender, EventArgs e)
        {
            DropDownList dbo = (DropDownList)sender;
            String Thana2 = ((HiddenField)(DetailsView1.FindControl("hidThana"))).Value;

            try
            {
                foreach (ListItem LI in dbo.Items)
                    if (LI.Value == Thana2)
                        LI.Selected = true;
                    else
                        LI.Selected = false;
            }
            catch (Exception)
            {
                //dbo.Items[0].Value = Thana;
            }
        }
        protected void SqlDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            string title = string.Format("{0}", e.Command.Parameters["@Title"].Value);
            string firstName = string.Format("{0}", e.Command.Parameters["@FirstName"].Value);
            string middleName = string.Format("{0}", e.Command.Parameters["@MiddleName"].Value);
            string lastName = string.Format("{0}", e.Command.Parameters["@LastName"].Value);
         //   CommonControl1.ClientMsg("Canceled" + title);
            string fullName=title.Trim() + " " +firstName.Trim() + " " + middleName.Trim() +" " + " "+ lastName.Trim();
           
            try
            {
                e.Command.Parameters["@ContactThanaID"].Value = ((DropDownList)DetailsView1.FindControl("dboThana2")).SelectedItem.Value;

                //string displayName = ((DropDownList)DetailsView1.FindControl("dboThana2")).SelectedItem.Value; ;
                if (GetName(fullName))
                {
                    e.Cancel = true;
                    CommonControl1.ClientMsg("Name <b>" + fullName + "</b> contains repeated words.<br>Please enter your correct full name.");
                }
                
            }
            catch (Exception)
            {
                //e.Command.Parameters["@ContactThanaID"].Value = "";
            }
        }

        private bool GetName(string fullNames)
        {
          //  string sources = "My name is Marco and I'm from Italy marco";
            string fullName = fullNames.ToUpper();
            string[] stringSeparators = new string[] { " " };
            var arrayList = fullName.Split(stringSeparators, StringSplitOptions.None);
            List<string> vals = new List<string>();
            bool returnValue = false;
            foreach (string ss in arrayList)
            {
                string s = ss.Replace(".", "").Replace(",", "").Replace("-", "").Trim();
                if (s.Trim() == "") continue;
                if (vals.Contains(s))
                {
                    returnValue = true;
                    break;
                }
                vals.Add(s);
            }


            return returnValue;
        }

        protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            //e.ExceptionHandled = true;
            Done = (bool)e.Command.Parameters["@Done"].Value;
            bool OTP_Sent = (bool)e.Command.Parameters["@OTP_Sent"].Value;
            string RetVal = e.Command.Parameters["@Msg"].Value.ToString();


            if (Done)
            {
                if (OTP_Sent)
                {
                    PanelOtp.Visible = true;
                    CommonControl1.ClientMsg(RetVal.ToString(), txtOTP);
                }
                else
                {
                    ShowNextPanel();
                    CommonControl1.ClientMsg(RetVal.ToString(), cmdNextStep);
                }
            }
            else
            {
                if (RetVal.Trim().Length > 0)
                    CommonControl1.ClientMsg(RetVal.ToString());
            }

            //ClientMsg(Done.ToString());
            //if(Done)
            //DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
        }
        protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (!Done)
            {
                e.KeepInEditMode = true;                
                return;
            }

            else
            {
                DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
            }
        }
        protected void DropDownListCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool showLocation = false;
            if (((DropDownList)DetailsView1.FindControl("DropDownListCountry")).SelectedItem.Value == "BD")
                showLocation = true;

            ((Panel)DetailsView1.FindControl("PanelLocation")).Visible = showLocation;
        }
        protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            string MobileNo = e.NewValues["MobileNo"].ToString();
            e.NewValues["MobileNo"] = getOnlyNumbers(MobileNo);

            //if(MobileNo.StartsWith("+880")|| MobileNo.StartsWith("880")
            // e.Cancel = true;
        }

        private string getOnlyNumbers(string FullText)
        {
            string RetVal = FullText.Trim();

            //if (RetVal.EndsWith(".00"))
            //    RetVal = RetVal.Substring(0, RetVal.Length - 3);

            Regex rgx = new Regex("[^0-9]");   //take only numbers 
            RetVal = rgx.Replace(RetVal, "");
            return RetVal;
        }
        protected void cmdOTPVerify_Click(object sender, EventArgs e)
        {
            //ClientMsg(DetailsView1.SelectedValue.ToString());
            string Msg = "";
            bool isVerified = false;

            using (SqlConnection conn = new SqlConnection())
            {
                string Query = "s_OTP_Verify";

                conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["Request_ProcessConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@OTP", System.Data.SqlDbType.VarChar).Value = txtOTP.Text.Trim();
                    cmd.Parameters.Add("@ReqID", System.Data.SqlDbType.BigInt).Value = DetailsView1.SelectedValue;

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

            if (!isVerified)
            {
                txtOTP.Text = "";
                CommonControl1.ClientMsg(Msg, txtOTP);
            }
            else
            {
                //OTP Verified
                PanelOtp.Visible = false;
                ShowNextPanel();
                CommonControl1.ClientMsg(Msg);
            }
        }

        private void ShowNextPanel()
        {
            DetailsView1.DataBind();
            DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
            PanelNext.Visible = true;
        }
        protected void cmdEditAgain_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("Request_Master.aspx?email={0}&keycode={1}", Request.QueryString["email"], Request.QueryString["keycode"]), true);
        }
        protected void cmdNextStep_Click(object sender, EventArgs e)
        {

            long ReqID = 0;

            using (SqlConnection conn = new SqlConnection())
            {
                string Query = "s_Request_Master_Submitted_Insert";

                conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["Request_ProcessConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter SQL_ReqID = new SqlParameter("@ReqID", SqlDbType.BigInt, 255);
                    SQL_ReqID.Direction = ParameterDirection.InputOutput;
                    SQL_ReqID.Value = ReqID;

                    cmd.Parameters.Add("@Email", System.Data.SqlDbType.VarChar).Value = Request.QueryString["email"];
                    cmd.Parameters.Add("@KeyCode", System.Data.SqlDbType.VarChar).Value = Request.QueryString["keycode"];
                    cmd.Parameters.Add("@IP", System.Data.SqlDbType.VarChar).Value = CommonControl1.getIPAddress();
                    //cmd.Parameters.Add("@ReqBrowser", System.Data.SqlDbType.VarChar).Value = CommonControl1.getBrowserInfo();
                    cmd.Parameters.Add("@ReqBrowser", System.Data.SqlDbType.Text).Value = Request.UserAgent.ToString();
                    cmd.Parameters.Add(SQL_ReqID);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();

                    ReqID = (long)SQL_ReqID.Value;

                    CommonControl1.ClientMsg(ReqID.ToString());

                }
            }
            Response.Redirect(string.Format("Request_iBanking.aspx?email={0}&reqid={2}&keycode={1}", Request.QueryString["email"], Request.QueryString["keycode"], ReqID), true);
        }
    }
}
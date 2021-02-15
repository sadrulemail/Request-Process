using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
namespace RequestProcess
{
    public partial class Request: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Title = "eService Request - Trust Bank";
            if (!IsPostBack)
            {
                litMsg.Text = string.Format("{0}", Request.QueryString["msg"]);
                if (litMsg.Text.Trim() == "")
                    PanelMsg.Visible = false;
            }


            SqlConnection.ClearAllPools();
            if (grdvAccountList.Rows.Count == 0)
                PanelLinkedAccount.Visible = false;
          
        }

      

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {

        }

      

      

     

        protected void DetailsView1_DataBound(object sender, EventArgs e)
        {
            if (DetailsView1.Rows.Count < 3)
            {
                Response.Write("Invalid Request");
                Response.End();
            }
            else
            {
                string Keycode = string.Format("{0}", Request.QueryString["keycode"]);
                string Email = string.Format("{0}", Request.QueryString["email"]);
                string ReqID = string.Format("{0}", Request.QueryString["reqid"]);
                string PrintURL = "Request_Print.aspx";

                hypDownload.NavigateUrl = string.Format("{0}?reqid={1}&email={2}&keycode={3}&type=download", PrintURL, ReqID, Email, Keycode);
                hypPrint.NavigateUrl = string.Format("{0}?reqid={1}&email={2}&keycode={3}&type=print", PrintURL, ReqID, Email, Keycode);


                if ((int)DataBinder.Eval(DetailsView1.DataItem, "Status") == 2)
                {
                    hypDownload.Visible = true;
                    hypPrint.Visible = true;
                }
                else
                {
                    hypDownload.Visible = false;
                    hypPrint.Visible = false;
                }
            }

          
           

        }

    

        protected void grdvAccountList_SelectedIndexChanged(object sender, EventArgs e)
        {

         
                      
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
      

        protected void grdvAccountList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
                if (e.CommandName == "Select")
                {
                 
                    
                }
            
        }


        protected void grdvAccountList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if(e.Row.)
            //txtAccountNo.Text = DataBinder.Eval(e.Row.DataItem, "Accountno").ToString();
        }

        //private void GetPrintOrDownload(string result)
        //{
        //    string Msg = "";
        //    bool isDone = false;
        //    string Keycode = "";
        //    string Query = "[s_Request_Final_Submit]";


        //    string Url_Email_Verify = Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port + Request.ApplicationPath + "/Request_Print.aspx";
        //    Url_Email_Verify = Url_Email_Verify.Replace(":80/", "/");

        //    using (SqlConnection conn = new SqlConnection())
        //    {
        //        conn.ConnectionString = System.Configuration.ConfigurationManager
        //                        .ConnectionStrings["Request_ProcessConnectionString"].ConnectionString;

        //        using (SqlCommand cmd = new SqlCommand(Query, conn))
        //        {
        //            cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //            cmd.Parameters.Add("@ReqID", System.Data.SqlDbType.BigInt).Value = Request.QueryString["reqid"];
        //            cmd.Parameters.Add("@Email", System.Data.SqlDbType.VarChar).Value = Request.QueryString["email"];
        //            cmd.Parameters.Add("@Url_Email_Verify", System.Data.SqlDbType.VarChar).Value = Url_Email_Verify;
        //            SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
        //            SqlParameter SQL_KeyCode = new SqlParameter("@KeyCode", SqlDbType.VarChar, 64);

        //            SQL_Msg.Direction = ParameterDirection.InputOutput;
        //            SQL_Msg.Value = Msg;
        //            cmd.Parameters.Add(SQL_Msg);

        //            SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
        //            SQL_Done.Direction = ParameterDirection.InputOutput;
        //            SQL_Done.Value = isDone;
        //            cmd.Parameters.Add(SQL_Done);

        //            SQL_KeyCode.Direction = ParameterDirection.InputOutput;
        //            SQL_KeyCode.Value = Request.QueryString["keycode"];
        //            cmd.Parameters.Add(SQL_KeyCode);

        //            cmd.Connection = conn;
        //            conn.Open();

        //            cmd.ExecuteNonQuery();

        //            isDone = (bool)SQL_Done.Value;
        //            Msg = string.Format("{0}", SQL_Msg.Value);
        //            Keycode = string.Format("{0}", SQL_KeyCode.Value);
        //        }
        //    }
        //    if (isDone)
        //    {
        //        Response.Redirect(string.Format("{0}?reqid={1}&email={2}&keycode={3}",
        //            Url_Email_Verify,
        //            Request.QueryString["reqid"],
        //            Request.QueryString["email"],
        //            Keycode), result, true);
        //    }
        //    else
        //    {
        //        CommonControl1.ClientMsg(Msg);
        //    }
        //}

       
       
    }
}
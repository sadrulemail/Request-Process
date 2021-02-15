using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Request_iBanking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Title = "iBanking Request - Trust Bank";
        if (!IsPostBack)
            //DetailsView1.ChangeMode(DetailsViewMode.Edit);

            txtAccountNo.Focus();

        SqlConnection.ClearAllPools();
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

    protected void cmdAddAccount_Click1(object sender, EventArgs e)
    {
        if (txtAccountNo.Text.Length != 15)
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
                TransferLimit < int.Parse(txtTransferLimit.Text)
                || UtilityLimit < int.Parse(txtUtilityLimit.Text)
                || DailyTransactionLimit < int.Parse(txtDailyTransactionLimit.Text)
                || MonthlyTransactionLimit < int.Parse(txtMonthlyTransactionLimit.Text)
                || PerDayNoOfTransaction < int.Parse(txtPerDayNoOfTransaction.Text)
                || PerMonthNoOfTransaction < int.Parse(txtPerMonthNoOfTransaction.Text)
            )
        {
            CommonControl1.ClientMsg("Invalid Limits.");
            return;
        }

        string Query = "s_iBanking_Req_Insert";

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["Request_ProcessConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@ReqID", System.Data.SqlDbType.BigInt).Value = Request.QueryString["reqid"];
                cmd.Parameters.Add("@Accountno", System.Data.SqlDbType.VarChar).Value = txtAccountNo.Text.Trim();
                cmd.Parameters.Add("@TransferLimit", System.Data.SqlDbType.Money).Value = TransferLimit;
                cmd.Parameters.Add("@UtilityLimit", System.Data.SqlDbType.Money).Value =UtilityLimit ;
                cmd.Parameters.Add("@DailyTransactionLimit", System.Data.SqlDbType.Money).Value = DailyTransactionLimit;

                cmd.Parameters.Add("@MonthlyTransactionLimit", System.Data.SqlDbType.Money).Value = MonthlyTransactionLimit;
                cmd.Parameters.Add("@PerDayNoOfTransaction", System.Data.SqlDbType.Money).Value = PerDayNoOfTransaction;
                cmd.Parameters.Add("@PerMonthNoOfTransaction", System.Data.SqlDbType.Money).Value = PerMonthNoOfTransaction;
                cmd.Parameters.Add("@ReqType", System.Data.SqlDbType.VarChar).Value = "ADD";

                //SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                //SQL_Msg.Direction = ParameterDirection.InputOutput;
                //SQL_Msg.Value = Msg;
                //cmd.Parameters.Add(SQL_Msg);

                cmd.Connection = conn;
                conn.Open();

                cmd.ExecuteNonQuery();
               

            }
        }


    }
    protected void DetailsView1_DataBound(object sender, EventArgs e)
    {
        if (DetailsView1.Rows.Count < 3)
        {
            Response.Write("Invalid Request");
            Response.End();
        }
    }
}
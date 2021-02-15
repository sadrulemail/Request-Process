using System;
using System.Data.SqlClient;
using System.Data;


    public partial class SMS_Exclude : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();
            Title = "SMS Alert Exclude";
            txtAcc.Focus();
        }

        protected void cmdOK_Click(object sender, EventArgs e)
        {
            bool Done = false;
            string Msg = "";

            SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SMSConnectionString"].ConnectionString);
            SqlCommand oCommand = new SqlCommand("SMSExclude", oConn);
            oCommand.CommandType = CommandType.StoredProcedure;

            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            oCommand.Parameters.Add("@Account", SqlDbType.VarChar).Value = txtAcc.Text.Trim();
            oCommand.Parameters.Add("@ExcludeBy", SqlDbType.VarChar).Value = Session["EMPID"].ToString();
            oCommand.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = txtRemarks.Text.Trim();            


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
                txtAcc.Text = "";
                lblAccName.Text = "";
            }

            //Response.Write(ROW_AFFECTED.ToString());            
        }

        protected void txtAcc_TextChanged(object sender, EventArgs e)
        {
            SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Florabank_OnlineConnectionString"].ConnectionString);
            SqlCommand oCommand = new SqlCommand("SELECT acname FROM dbo.cus_ac_1 WITH ( NOLOCK ) WHERE accountno = @Account", oConn);

            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            oCommand.Parameters.Add("@Account", SqlDbType.VarChar).Value = txtAcc.Text.Trim();

            SqlDataReader oReader = oCommand.ExecuteReader();

            if (oReader.HasRows)
                while (oReader.Read())
                {
                    lblAccName.Text = oReader["acname"].ToString();
                }
            else
                lblAccName.Text = "A/C Not Found.";

            oReader.Close();
            oConn.Close();
        }
    }

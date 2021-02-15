using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;


    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //try
            //{
            //    string ApplicationID = System.Configuration.ConfigurationManager.AppSettings["ApplicationID"].ToString();
            //    string CookieName = "Login_" + ApplicationID;
            //    HttpCookie cookie = Request.Cookies.Get(CookieName);
            //    Response.Write(cookie.Values["Password"].ToString());

            //    SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TblUserDBConnectionString"].ConnectionString);
            //    SqlCommand oCommand = new SqlCommand("SELECT cast(PASSWORD as varbinary) as PASSWORD  FROM EMP_Password WHERE EMPID = 951", oConn);

            //    if (oConn.State == ConnectionState.Closed)
            //        oConn.Open();

            //    SqlDataReader oReader = oCommand.ExecuteReader();

            //    while (oReader.Read())
            //    {
            //        Response.Write("<BR>" + BitConverter.ToString(((byte [])(oReader["PASSWORD"]))));
            //    }
            //    oConn.Close();
            //}
            //catch (Exception) { }
            //Response.Write("<BR>" + EncodePassword("offoff"));
            TrustControl1.getUserRoles();

            this.Title = ((Label)this.Page.Master.FindControl("ApplicationName")).Text;

            if (!IsPostBack)
            {
                if (Session["BRANCHID"].ToString() != "1")
                {
                    browse.Visible = false;
                }
                else
                {
                    browse.Visible = true;
                }
            }

            string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["Request_ProcessConnectionString"].ConnectionString;
            using (SqlConnection oConn = new SqlConnection(oConnString))
            {
                if (oConn.State == ConnectionState.Closed) oConn.Open();

                SqlCommand oCommand = new SqlCommand("s_iBanking_Signature_Verify_Pending_Count", oConn);
                oCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter sql_Total = new SqlParameter("@Total", SqlDbType.Int);
                sql_Total.Direction = ParameterDirection.Output;

                oCommand.Parameters.Add(sql_Total);
                oCommand.Parameters.AddWithValue("@BranchID", Session["BRANCHID"].ToString());

                oCommand.ExecuteNonQuery();

                lblError.Text = sql_Total.Value.ToString();
                if (sql_Total.Value.ToString() == "0") PanelError.Visible = false;
            }
        }
        public string EncodePassword(string originalPassword)
        {
            //Declarations
            Byte[] originalBytes;
            Byte[] encodedBytes;
            MD5 md5;

            //Instantiate MD5CryptoServiceProvider, get bytes for original password and compute hash (encoded password)
            md5 = new MD5CryptoServiceProvider();
            originalBytes = ASCIIEncoding.Default.GetBytes(originalPassword);
            encodedBytes = md5.ComputeHash(originalBytes);

            //Convert encoded bytes back to a 'readable' string
            //return BitConverter.ToString(encodedBytes);
            return BitConverter.ToString(encodedBytes);


            string S = "";
            for (int i = 0; i < encodedBytes.Length; i++)
                S += ((char)(encodedBytes[i])).ToString();
            return S;
        }
        protected void cboBranch_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
                try
                {
                    for (int i = 0; i < cboBranch.Items.Count; i++)
                        if (cboBranch.Items[i].Value == Session["BRANCHID"].ToString())
                        {
                            cboBranch.SelectedIndex = i;
                        }
                }
                catch (Exception) { }
        }
        protected void cboDept_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
                try
                {
                    for (int i = 0; i < cboDept.Items.Count; i++)
                        if (cboDept.Items[i].Value == Session["DEPTID"].ToString())
                        {
                            cboDept.SelectedIndex = i;
                        }
                }
                catch (Exception) { }
        }
    }


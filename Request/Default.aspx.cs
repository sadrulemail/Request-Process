using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Title = "Trust Bank Service Request";

        if (!IsPostBack)
        {
            PanelStatus.Visible = false;
            //ImgChallenge.Src = "captcha.ashx?rand=" + RandomNumer() + RandomNumer();
        }

        SqlConnection.ClearAllPools();


        //Facebook Random iFrame
        try
        {
            string FBPages = Common.getValueOfKey("FbPages");
            string[] names = FBPages.Split(',');
            Random random = new Random();
            int index = random.Next(names.Length);

            FB_iFrame.Text = string.Format("<iframe src='//www.facebook.com/plugins/likebox.php?href=https%3A%2F%2Fwww.facebook.com%2F{0}&amp;width=340px&amp;height=290&amp;colorscheme=light&amp;show_faces=true&amp;header=true&amp;stream=false&amp;show_border=true&amp;appId=111198355565695' scrolling='no' frameborder='0' style='border:none; overflow:hidden; width:340px; height:290px;' allowTransparency='true'></iframe>"
                , names[index]);
        }
        catch (Exception) { }
    }

    protected string RandomNumer()
    {
        return (new Random().Next()).ToString();
    }

    protected void cmd_Click(object sender, EventArgs e)
    {
        //ClientMsg(Request.Url.OriginalString.Split('?')[0]);
        string Url_Email_Verify = Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port + Request.ApplicationPath + "/Email_Verify.aspx";
        //ClientMsg(Url_Email_Verify);
        //return;

        if (!Common.isEmailAddress(txtEmail.Text))
        {
            txtCaptcha.Text = "";
            CommonControl1.ClientMsg("Enter a valid email address.", txtEmail);
            //txtEmail.Focus();

            return;
        }

        TrustCaptcha captcha = new TrustCaptcha();
        if (txtCaptcha.Text != string.Format("{0}", Session[TrustCaptcha.SESSION_CAPTCHA]))
        {
            //txtCaptcha.Focus();
            txtCaptcha.Text = "";
            CommonControl1.ClientMsg("Enter correct Challenge Key.", txtCaptcha);
            return;
        }

        string Msg = "";

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_Email_Varify_Insert";

            conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["Request_ProcessConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Email", System.Data.SqlDbType.VarChar).Value = txtEmail.Text;
                cmd.Parameters.Add("@Type", System.Data.SqlDbType.Int).Value = dboReqType.SelectedItem.Value;
                cmd.Parameters.Add("@Url_Email_Verify", System.Data.SqlDbType.VarChar).Value = Url_Email_Verify;

                SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                SQL_Msg.Direction = ParameterDirection.InputOutput;
                SQL_Msg.Value = Msg;

                cmd.Parameters.Add(SQL_Msg);

                cmd.Connection = conn;
                conn.Open();

                cmd.ExecuteNonQuery();
                //{
                //    if (sdr.HasRows)
                //    {
                //        while (sdr.Read())
                //        {
                //            //KeyCode = string.Format("{0}", sdr["KeyCode"]);
                //        }
                //    }
                //}

                Msg = string.Format("{0}", SQL_Msg.Value);

                CommonControl1.ClientMsg(Msg);
                Panel1.Visible = false;
                PanelFacebook.Visible = true;
            }
        }
    }
}
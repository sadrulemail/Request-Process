using System;
using System.Web.UI;
using System.Web.UI.WebControls;


    public partial class RequestShowAtHO : System.Web.UI.Page
    {       

        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();
            Page.Title = "iBanking Request";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            grdvAccountList.DataBind();
        }

        protected void SqlDataSourceAddAcc_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblStatus.Text = string.Format("Total: <b>{0}</b>", e.AffectedRows);
        }       
    }

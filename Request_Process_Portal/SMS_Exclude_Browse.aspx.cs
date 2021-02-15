using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


    public partial class SMS_Exclude_Browse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();
            Title = "Browse SMS Alert Exclude";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //grdvAccountList.DataBind();
        }

        protected void SqlDataSourceExcludeAcc_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblStatus.Text = string.Format("Total: <b>{0}</b>", e.AffectedRows);
        }    
    }

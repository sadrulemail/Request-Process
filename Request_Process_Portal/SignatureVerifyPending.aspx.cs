using System;
using System.Web.UI.WebControls;


    public partial class SignatureVerifyPending : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();
            Title = "Signature Verification Pending";
        }
        protected void SqlDataSourceAddAcc_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblStatus.Text = string.Format("Total: <b>{0}</b>", e.AffectedRows);
        }

        protected void ddlBranch_DataBound(object sender, EventArgs e)
        {
            foreach (ListItem LI in ddlBranch.Items)
                LI.Selected = false;
            

            if (Session["BRANCHID"].ToString() != "1")
            {
                foreach (ListItem ii in ddlBranch.Items)
                {
                    if (ii.Value == Session["BRANCHID"].ToString())
                        ii.Selected = true;
                    else
                        ii.Enabled = false;
                }
            }
        }
    }

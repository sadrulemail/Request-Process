using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


    public partial class iBanking_Flora : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();
            Page.Title = "iBanking Flora Search";
            if (!IsPostBack)
            {
                txtAccNo.Text = string.Format("{0}", Request.QueryString["s"]);
                txtAccNo.Focus();

                if (txtAccNo.Text.Trim().Length > 0)
                    this.Title = string.Format("{0} - iBanking Flora Search", Request.QueryString["s"]);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect("iBanking_Flora.aspx?s=" + txtAccNo.Text.Trim(), true);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            if (DataBinder.Eval(e.Row.DataItem, "Status").ToString() != "OPERATIVE")
                e.Row.ForeColor = System.Drawing.Color.Silver;
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblStatus.Text = string.Format("Total: <b>{0:N0}</b>", e.AffectedRows);
        }
    }

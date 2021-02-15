using System;
using System.Web.UI.WebControls;

public partial class Email_Statement_Map : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        Title = "eStatement Email Mapping";
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        RefreshData();
    }

    private void RefreshData()
    {
        if (TabContainer1.ActiveTab == tab1)
        {
            GridView1.DataBind();
        }
        else if (TabContainer1.ActiveTab == tab2)
        {
            GridView2.DataBind();
        }
        else if (TabContainer1.ActiveTab == tab3)
        {
            GridView3.DataBind();
        }
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Authorize Pending: <b>{0:N0}</b>", e.AffectedRows);
    }

    protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        Label2.Text = string.Format("Total Customer with No Email Address: <b>{0:N0}</b>", e.AffectedRows);
    }

    protected void SqlDataSource3_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        Label3.Text = string.Format("Total Authorised Email Address: <b>{0:N0}</b>", e.AffectedRows);
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RefreshData();
    }

    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
        if (Session["BRANCHID"].ToString() != "1")
            foreach (ListItem LI in DropDownList1.Items)
                if (LI.Value == "*") LI.Enabled = false;

        //cmdShow.Text = Session["BRANCHID"].ToString();
        if (!IsPostBack)
        {
            try
            {
                //if (Request.QueryString["branch"].ToString() != "")
                for (int i = 0; i < DropDownList1.Items.Count; i++)
                {
                    if (int.Parse(DropDownList1.Items[i].Value) == int.Parse(Session["BRANCHID"].ToString()))
                    {
                        DropDownList1.Items[i].Selected = true;
                    }
                    else
                    {
                        DropDownList1.Items[i].Selected = false;
                    }
                }
            }
            catch (Exception) { }
        }
        //GridView1.Visible = (DropDownList1.SelectedItem.Value != "");
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string Email1 = string.Format("{0}", e.Row.Cells[3].Text.Trim());
            string Email2 = string.Format("{0}", e.Row.Cells[4].Text.Trim());
            bool isError = false;

            if (!Common.isEmailAddress(Email1))
            {
                if (Email1 != "&nbsp;" && Email1.Length > 0)
                {
                    ((Label)e.Row.Cells[5].FindControl("Label1")).Text = "<div>Email1 is invalid</div>";
                    ((Panel)e.Row.Cells[5].FindControl("PanelApprove")).Visible = false;
                    isError = true;
                }
            }

            if (!Common.isEmailAddress(Email2))
            {
                if (Email2 != "&nbsp;" && Email2.Length > 0)
                {
                    ((Label)e.Row.Cells[5].FindControl("Label1")).Text += "<div>Email2 is invalid</div>";
                    ((Panel)e.Row.Cells[5].FindControl("PanelApprove")).Visible = false;
                    isError = true;
                }
            }


            if (isError)
                ((Panel)e.Row.Cells[5].FindControl("PanelApprove")).Visible = false;
        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Authorize")
        {
            //TrustControl1.ClientMsg(e.);
        }
    }
    protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        TrustControl1.ClientMsg(e.Command.Parameters["@Msg"].Value.ToString());
    }
}

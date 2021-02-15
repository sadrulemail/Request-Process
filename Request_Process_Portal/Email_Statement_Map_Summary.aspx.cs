using System;
using System.Web.UI.WebControls;

public partial class Email_Statement_Map_Summary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        Title = "eStatement Email Mapping Summary";
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        RefreshData();
    }

    private void RefreshData()
    {
        GridView1.DataBind();        
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Row: <b>{0:N0}</b>", e.AffectedRows);
    }

    
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RefreshData();
    }

    
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
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

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        long Total = 0;
        long AuthorizedPending = 0;
        long NoEmail = 0;
        long TotalAuthorized = 0;

        for (int r = 0; r < GridView1.Rows.Count; r++)
        {
            if (GridView1.Rows[r].RowType == DataControlRowType.DataRow)
            {
                Total += long.Parse(GridView1.Rows[r].Cells[2].Text.Replace(",", ""));
                AuthorizedPending += long.Parse(GridView1.Rows[r].Cells[3].Text.Replace(",", ""));
                NoEmail += long.Parse(GridView1.Rows[r].Cells[4].Text.Replace(",", ""));
                TotalAuthorized += long.Parse(GridView1.Rows[r].Cells[5].Text.Replace(",", ""));
            }
        }

        GridView1.FooterRow.Cells[2].Text = string.Format("{0:N0}", Total);
        GridView1.FooterRow.Cells[3].Text = string.Format("{0:N0}", AuthorizedPending);
        GridView1.FooterRow.Cells[4].Text = string.Format("{0:N0}", NoEmail);
        GridView1.FooterRow.Cells[5].Text = string.Format("{0:N0}", TotalAuthorized);
    }
}

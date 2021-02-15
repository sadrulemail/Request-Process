using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


    public partial class RequestShow : System.Web.UI.Page
    {
        string branch;
        string CurrectStatus = "";
        bool HideDetailViewFields = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();
            Page.Title = "iBanking Request Verification";
            if(!IsPostBack)
            {
                txtRequestID.Text = string.Format("{0}", Request.QueryString["reqid"]);
                txtRequestID.Focus();

                if (Session["BRANCHID"].ToString()=="1")
                hiddenFieldBranch.Value = "HO";
                else
                    hiddenFieldBranch.Value = "BR";

                if (grdvAccountList.Rows.Count >0)
                {
                    panel2.Visible = true;
                }
                else

                    panel2.Visible = false;
            }
            //hidAppCode.Value = TrustControl1.getValueOfKey("ApplicationID");
        }
        protected void SqlDataSourceAddAcc_Deleted(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
                 TrustControl1.ClientMsg(string.Format("{0}", "Deleted Successfully."));
              
            else
                TrustControl1.ClientMsg(string.Format("{0}","Delete not Completed.Please try again."));

            //if (grdvAccountList.Rows.Count == 0)
            //    PanelLinkedAccount.Visible = false;
        }

        protected void grdvAccountList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "SELECT")
            {
                CurrectStatus = e.CommandArgument.ToString();
                

                DetailsViewforModal.DataBind();
                
                //modal.Show();
            }
            
        }

        protected void grdvAccountList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (((CurrectStatus == "3" || CurrectStatus == "0") && hiddenFieldBranch.Value == "HO")
                ||
                ((CurrectStatus == "2" || CurrectStatus == "3" || CurrectStatus == "") && hiddenFieldBranch.Value == "BR")
                )
            {
                DetailsViewforModal.ChangeMode(DetailsViewMode.Edit);
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 1].Visible = true ;
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 2].Visible = true;
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 3].Visible = true;
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 4].Visible = true;
            }
            else
            {
                DetailsViewforModal.ChangeMode(DetailsViewMode.ReadOnly);
                //DetailsViewforModal.DataBind();
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 1].Visible = false;
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 2].Visible = false;
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 3].Visible = false;
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 4].Visible = false;
            }

            modal.Show();
           
        }

       

        protected void SqlDataSource3_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
           
        }

        protected void DetailsViewforModal_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
            modal.Show();
        }

        protected void SqlDataSource3_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            string Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
            bool Done = (bool)e.Command.Parameters["@Done"].Value;

            if (Done)
            {
                DetailsViewforModal.ChangeMode(DetailsViewMode.ReadOnly);
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 1].Visible = false;
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 2].Visible = false;
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 3].Visible = false;
                DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 4].Visible = false;

                gdvChangeStatusList.DataBind();
            }


            TrustControl1.ClientMsg(string.Format("{0}", Msg));
            grdvAccountList.DataBind();
        }

        protected void DetailsViewforModal_DataBound(object sender, EventArgs e)
        {
           
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect("RequestShowAtBranch.aspx?reqid=" + txtRequestID.Text.Trim(), true);
          
        }

       

      
      
    }

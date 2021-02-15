using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


public partial class iBankingRequestShowDetails1 : System.Web.UI.Page
{
    string branch;
    string CurrectStatus = "";
    bool HideDetailViewFields = false;


    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        Page.Title = "iBanking Request Verification";
        if (!IsPostBack)
        {
            //txtRequestID.Text = string.Format("{0}", Request.QueryString["reqid"]);
            //txtRequestID.Focus();

            //if (txtRequestID.Text.Length > 0)
            //{
            try
            {
                //long reqid = long.Parse(txtRequestID.Text);
                //Page.Title = string.Format("{0} - iBanking Request Verification", reqid);
                Page.Title = string.Format("iBanking Request Verification");
            }
            catch (Exception)
            {
                Response.Write("Invalid Request.");
                Response.End();
                return;
            }
            //}
            //else
            //{
            //    DetailsView1.Visible = false;
            //    PanelUpload.Visible = false;
            //    PanelRequestStatus.Visible = false;
            //}

            //if (txtRequestID.Text == "")
            //    PanelRequester.Visible = false;

            //if (Session["BRANCHID"].ToString() == "1")
            //    hiddenFieldBranch.Value = "HO";
            //else
            //    hiddenFieldBranch.Value = "BR";

            if (grdvAccountList.Rows.Count > 0)
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
            TrustControl1.ClientMsg(string.Format("{0}", "Delete not Completed.Please try again."));

        //if (grdvAccountList.Rows.Count == 0)
        //    PanelLinkedAccount.Visible = false;
    }

    protected void grdvAccountList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "SELECT")
        {
            CurrectStatus = e.CommandArgument.ToString();


            //DetailsViewforModal.DataBind();

            //modal.Show();
        }
    }

    protected void DetailsViewforModal_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
        // modal.Show();
    }

    public void InsertData(byte[] content, string FileName, string ContentType, int fileSize, string FileKey)
    {
        content = Common.Compress(content);

        SqlConnection objConn = null;
        SqlCommand objCom = null;
        try
        {
            objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Request_ProcessConnectionString"].ConnectionString);
            objCom = new SqlCommand("s_Attachments_Add", objConn);
            objCom.CommandType = CommandType.StoredProcedure;


            objCom.Parameters.Add("@InsertBy", SqlDbType.VarChar).Value = Session["EMPID"].ToString();
            objCom.Parameters.Add("@Attachment", SqlDbType.Image).Value = content;
            objCom.Parameters.Add("@FileName", SqlDbType.VarChar).Value = FileName;
            objCom.Parameters.Add("@ContentType", SqlDbType.VarChar).Value = ContentType;
            objCom.Parameters.Add("@FileSize", SqlDbType.Int).Value = fileSize;
            objCom.Parameters.Add("@FileKey", SqlDbType.VarChar).Value = FileKey;
            //objCom.Parameters.Add("@ReqID", SqlDbType.BigInt).Value = ReqID;

            objConn.Open();
            int i = objCom.ExecuteNonQuery();
            //objConn.Close();

            //lblUploadStatus.Text = "File Uploadted and Saved as: <a href=\"Attachment.aspx?a="+ i.ToString() +"\">" + i.ToString() + "." + Extension + "</a>";
        }
        catch (Exception)
        {
            //ClientMsg("Error: " + ex.Message);
        }
        finally
        {
            objConn.Close();
        }
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows != 1)
        {
            //PanelRequestStatus.Visible = false;
            //PanelUpload.Visible = false;
        }
    }

    protected void SqlDataSourceAttachment_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows == 0)
        {
            //cmdSubmitAttach.Visible = false;
        }
    }

    protected void cmdSubmitAttach_Click(object sender, EventArgs e)
    {
        SqlConnection objConn = null;
        SqlCommand objCom = null;
        string Msg = "";
        bool Done = false;

        try
        {
            string ReqID = string.Format("{0}", Request.QueryString["reqid"]);

            objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Request_ProcessConnectionString"].ConnectionString);
            objCom = new SqlCommand("s_Attachment_Submit", objConn);
            objCom.CommandType = CommandType.StoredProcedure;

            objCom.Parameters.Add("@ReqID", SqlDbType.BigInt).Value = ReqID;
            objCom.Parameters.Add("@EmpID", SqlDbType.VarChar).Value = Session["EMPID"].ToString();
            objCom.Parameters.Add("@BranchID", SqlDbType.VarChar).Value = Session["BRANCHID"].ToString();

            SqlParameter Sql_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
            Sql_Msg.Direction = ParameterDirection.InputOutput;
            Sql_Msg.Value = Msg;
            objCom.Parameters.Add(Sql_Msg);

            SqlParameter Sql_Done = new SqlParameter("@Done", SqlDbType.Bit);
            Sql_Done.Direction = ParameterDirection.InputOutput;
            Sql_Done.Value = Done;
            objCom.Parameters.Add(Sql_Done);

            objConn.Open();
            int i = objCom.ExecuteNonQuery();
            Msg = string.Format("{0}", Sql_Msg.Value);
            Done = (bool)Sql_Done.Value;
            objConn.Close();

            if (Done)
            {
                //GridViewAttachment.DataBind();
                //PanelUpload.Visible = false;

            }
            //{
            //    //PanelUpload.Visible = false; 
            //    hidFileID.Value = "";
            //    cmdSubmitAttach.Visible = true;
            //}
            //else
            //{
            TrustControl1.ClientMsg(Msg);
            //}

            DetailsView1.DataBind();
            //GridViewAttachment.DataBind();

            //lblUploadStatus.Text = "File Uploadted and Saved as: <a href=\"Attachment.aspx?a="+ i.ToString() +"\">" + i.ToString() + "." + Extension + "</a>";
        }
        catch (Exception)
        {
            //ClientMsg("Error: " + ex.Message);
        }
    }

    public bool isHideDelete()
    {
        return !HideDetailViewFields;
    }
}
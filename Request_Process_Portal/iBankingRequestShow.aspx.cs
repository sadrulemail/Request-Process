using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


    public partial class iBankingRequestShow : System.Web.UI.Page
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
                txtRequestID.Text = string.Format("{0}", Request.QueryString["reqid"]);
                txtRequestID.Focus();

                if (txtRequestID.Text.Length > 0)
                {
                    try
                    {
                        long reqid = long.Parse(txtRequestID.Text);
                        Page.Title = string.Format("{0} - iBanking Request Verification", reqid);
                    }
                    catch (Exception)
                    {
                        Response.Write("Invalid Request.");
                        Response.End();
                        return;
                    }
                }
                else
                {
                    DetailsView1.Visible = false;
                    PanelUpload.Visible = false;
                    PanelRequestStatus.Visible = false;
                }

                if (txtRequestID.Text == "")
                    PanelRequester.Visible = false;

                if (Session["BRANCHID"].ToString() == "1")
                    hiddenFieldBranch.Value = "HO";
                else
                    hiddenFieldBranch.Value = "BR";

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


                DetailsViewforModal.DataBind();

                //modal.Show();
            }

        }

        protected void grdvAccountList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!TrustControl1.isRole("USER", "ADMIN"))
            {
                //TrustControl1.ClientMsg("You are not permitted to execute this option.");
                DetailsViewforModal.ChangeMode(DetailsViewMode.ReadOnly);
                IsVisibleDetailsViewforModal(false);
                modal.Show();
                return;
            }

            if (((CurrectStatus == "3" || CurrectStatus == "0" || CurrectStatus == "6" || CurrectStatus == "100") && hiddenFieldBranch.Value == "HO")
                ||
                ((CurrectStatus == "2" || CurrectStatus == "3" || CurrectStatus == "" || CurrectStatus == "6" || CurrectStatus == "100") && hiddenFieldBranch.Value == "BR") //if status cancel not view cause a mail will be sent to customer.
                )
            {
                DetailsViewforModal.ChangeMode(DetailsViewMode.Edit);

                IsVisibleDetailsViewforModal(true);
               
            }   
            else
            {
                DetailsViewforModal.ChangeMode(DetailsViewMode.ReadOnly);
                IsVisibleDetailsViewforModal(false);
               
            }

            if (hiddenFieldSubmittedRequest.Value == "1")
            {
                DetailsViewforModal.ChangeMode(DetailsViewMode.ReadOnly);
                IsVisibleDetailsViewforModal(false);
             
            }

            modal.Show();

        }

        private void IsVisibleDetailsViewforModal(bool result)
        {

            DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 1].Visible = result;
            DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 2].Visible = result;
            DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 3].Visible = result;
            DetailsViewforModal.Fields[DetailsViewforModal.Fields.Count - 4].Visible = result;
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
                DetailsView1.DataBind();
            }


            TrustControl1.ClientMsg(string.Format("{0}", Msg));
            grdvAccountList.DataBind();
        }

        protected void DetailsViewforModal_DataBound(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect("iBankingRequestShow.aspx?reqid=" + txtRequestID.Text.Trim(), true);

        }

        protected void DetailsView1_DataBound(object sender, EventArgs e)
        {
            hiddenFieldSubmittedRequest.Value = string.Format("{0}", DataBinder.Eval(DetailsView1.DataItem, "Status"));
            string AttachSubmit = string.Format("{0}", DataBinder.Eval(DetailsView1.DataItem, "AttachSubmit"));

            string LastOpendBy = string.Format("{0}", DataBinder.Eval(DetailsView1.DataItem, "LastOpendBy"));
            try
            {
                HideDetailViewFields = (bool)(DataBinder.Eval(DetailsView1.DataItem, "AttachSubmit"));
            }
            catch (Exception) { }

            if (LastOpendBy.Length>0 && LastOpendBy != Session["EMPID"].ToString())
            {
                PanelRequestStatus.Visible = true;
                lblRequestStatus.Text = string.Format("Please wait, this Request is processing by Emp: <a target='_blank' href='../Profile.aspx?ID={0}' class='link'>{0}</a>", LastOpendBy);
            }
            else
            {
                PanelRequestStatus.Visible = false;
            }

            if(AttachSubmit == "True")
                PanelUpload.Visible = false;

           
        }

        protected void AjaxFileUpload1_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            try
            {
                InsertData(e.GetContents(), e.FileName, e.ContentType, e.FileSize, e.FileId);
            }
            catch (Exception) { }
        }

        protected void cmdUpload_Click(object sender, EventArgs e)
        {
            SqlConnection objConn = null;
            SqlCommand objCom = null;
            string Msg = "";

            try
            {
                string ReqID = string.Format("{0}", Request.QueryString["reqid"]);

                objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Request_ProcessConnectionString"].ConnectionString);
                objCom = new SqlCommand("s_Attachment_Attach", objConn);
                objCom.CommandType = CommandType.StoredProcedure;

                objCom.Parameters.Add("@FileKeys", SqlDbType.VarChar).Value = hidFileID.Value;
                objCom.Parameters.Add("@ReqID", SqlDbType.BigInt).Value = ReqID;

                SqlParameter Sql_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                Sql_Msg.Direction = ParameterDirection.InputOutput;
                Sql_Msg.Value = Msg;
                objCom.Parameters.Add(Sql_Msg);

                objConn.Open();
                int i = objCom.ExecuteNonQuery();
                Msg = string.Format("{0}", Sql_Msg.Value);
                objConn.Close();

                if (Msg == "")
                {
                    //PanelUpload.Visible = false; 
                    hidFileID.Value = "";
                    cmdSubmitAttach.Visible = true;
                }
                else
                {
                    TrustControl1.ClientMsg(Msg);
                }

                GridViewAttachment.DataBind();

                //lblUploadStatus.Text = "File Uploadted and Saved as: <a href=\"Attachment.aspx?a="+ i.ToString() +"\">" + i.ToString() + "." + Extension + "</a>";
            }
            catch (Exception)
            {
                //ClientMsg("Error: " + ex.Message);
            }
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
                PanelRequestStatus.Visible = false;
                PanelUpload.Visible = false;
            }
        }

        protected void SqlDataSourceAttachment_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows == 0)
            {
                cmdSubmitAttach.Visible = false;
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
                    GridViewAttachment.DataBind();
                    PanelUpload.Visible = false;
                    
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
                GridViewAttachment.DataBind();

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

        public bool isVisibleShowDetails()
        {
            if (Session["BRANCHID"].ToString() == "1" && Session["DEPTID"].ToString() == "7")
                return true;

            return false;
        }
    }

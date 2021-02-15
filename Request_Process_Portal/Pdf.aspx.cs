using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using Ghostscript.NET;

namespace Request_Process_Portal
{
    public partial class PdfViewer : System.Web.UI.Page
    {
        string AID = "";
        string KEY = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hidCurrentPage.Value))
                hidCurrentPage.Value = "1";

            if (String.IsNullOrEmpty(Request.QueryString["AID"]) || String.IsNullOrEmpty(Request.QueryString["KEY"]))
            {
                Response.End();
            }
            else
            {
                AID = Request.QueryString["AID"].ToString().Trim();
                KEY = Request.QueryString["KEY"].ToString().Trim();

                if (!IsPostBack)
                {
                    SqlConnection objConn = null;
                    SqlCommand objCom = null;
                    try
                    {
                        objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Request_ProcessConnectionString"].ConnectionString);
                        objCom = new SqlCommand("s_Attachments_View", objConn);
                        objCom.CommandType = CommandType.StoredProcedure;
                        objCom.Parameters.Add("@AID", SqlDbType.Int).Value = AID;
                        objCom.Parameters.Add("@FileKEY", SqlDbType.VarChar).Value = KEY;

                        objConn.Open();

                        SqlDataReader oR = objCom.ExecuteReader();
                        if (!oR.HasRows)
                        {
                            Response.Write("<h1>Invalid URL</h1><span style='color:White'>");
                            Response.End();
                        }
                        else
                        {
                            while (oR.Read())
                            {
                                if (oR.HasRows)
                                {
                                    //string Extension = oR["ContentType"].ToString();
                                    string FileName = oR["FileName"].ToString();
                                    byte[] content = (byte[])oR["Attachment"];
                                    DownloadLink.Text = oR["FileName"].ToString();
                                    lblSize.Text = Common.FileSize(oR["FileSize"]);

                                        content = Common.Decompress(content);

                                    this.Title = oR["FileName"].ToString();
                                    Stream str = new MemoryStream(content);

                                    //PDFLibNet.PDFWrapper _pdfDoc = new PDFLibNet.PDFWrapper();
                                    //_pdfDoc.LoadPDF(str);

                                    //hidTotalPage.Value = _pdfDoc.Pages.Count.ToString();

                                    using (Ghostscript.NET.Rasterizer.GhostscriptRasterizer _rasterizer = new Ghostscript.NET.Rasterizer.GhostscriptRasterizer())
                                    {
                                        _rasterizer.Open(str,
                                                GhostscriptVersionInfo.GetLastInstalledVersion(GhostscriptLicense.GPL | GhostscriptLicense.AFPL, GhostscriptLicense.GPL),
                                                true);
                                        hidTotalPage.Value = _rasterizer.PageCount.ToString();
                                    }
                                }
                            }

                            objConn.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write("Error: " + ex.Message);
                    }

                    LoadPdfLeftPanel(AID, KEY);

                    cmdDownloadImage.NavigateUrl = string.Format("Attachment.ashx?aid={0}&key={1}", AID, KEY);


                }
                else
                {
                    LoadPdfLeftPanel();
                }
            }
        }
        protected void ZoomFactor_TextChanged(object sender, EventArgs e)
        {
            LoadMainImagePage(hidCurrentPage.Value);
        }

        private void LoadPdfLeftPanel()
        {
            //string AID = Request.QueryString["AID"].ToString().Trim();
            //string KEY = Request.QueryString["KEY"].ToString().Trim();
            LoadPdfLeftPanel(AID, KEY);
        }
        private void LoadPdfLeftPanel(string AID, string KEY)
        {
            try
            {
                int TotalPageInPDF = int.Parse(hidTotalPage.Value);
                if (TotalPageInPDF > 0)
                {
                    for (int i = 1; i <= TotalPageInPDF; i++)
                    {
                        ImageButton img = new ImageButton();
                        img.ImageUrl = "Images/Loading.gif";
                        img.Attributes.Add("LoadImg", "ShowImage.ashx?AID=" + AID + "&KEY=" + KEY + "&W=110&P=" + i);
                        img.CssClass = "AttachmentThumb";
                        img.ToolTip = "Page " + i;
                        img.CommandArgument = i.ToString();
                        img.Click += this.img_Click;
                        img.EnableViewState = true;

                        LinkButton lnk = new LinkButton();
                        lnk.Click += this.lnk_Click;
                        lnk.CommandArgument = i.ToString();
                        lnk.Text = "Page " + i;
                        lnk.EnableViewState = true;

                        Panel1.Controls.Add(img);
                        Panel1.Controls.Add(new LiteralControl("<br>"));
                        Panel1.Controls.Add(lnk);
                        Panel1.Controls.Add(new LiteralControl("<br><br>"));
                    }
                }
                if (TotalPageInPDF == 1)
                {
                    //Panel1.Visible = false;
                }

                LoadMainImagePage(hidCurrentPage.Value);
            }
            catch (Exception) { }
        }

        private void LoadMainImagePage()
        {
            LoadMainImagePage(hidCurrentPage.Value);
        }
        private void LoadMainImagePage(string PageToLoad)
        {
            SelectLeftThumb(int.Parse(PageToLoad));
            try
            {
                int TotalPageInPDF = int.Parse(hidTotalPage.Value);
                hidCurrentPage.Value = PageToLoad;

                //TrustControl1.ClientMsg(hidCurrentPage.Value + " CurrentPage, " + hidTotalPage.Value + " Total Page");
                lblPageXofY.Text = "Page " + PageToLoad;
                if (TotalPageInPDF > 1)
                    lblPageXofY.Text = "Page " + PageToLoad + " of " + TotalPageInPDF.ToString();
                lblPageXofY2.Text = lblPageXofY.Text;

                Next1.Enabled = true;
                Next2.Enabled = true;
                Previous1.Enabled = true;
                Previous2.Enabled = true;

                if (PageToLoad == "1")
                {
                    Previous1.Enabled = false;
                    Previous2.Enabled = false;
                }
                else if (PageToLoad == TotalPageInPDF.ToString())
                {
                    Next1.Enabled = false;
                    Next2.Enabled = false;
                }

                if (TotalPageInPDF == 1)
                {
                    Next1.Visible = false;
                    Next2.Visible = false;
                    Previous1.Visible = false;
                    Previous2.Visible = false;
                }

                //string AID = Request.QueryString["AID"].ToString().Trim();
                //string KEY = Request.QueryString["KEY"].ToString().Trim();
                //imgMain.ImageUrl =
                string url = "ShowImage.ashx?AID=" + AID + "&KEY=" + KEY + "&W=" + (10 * int.Parse(ZoomFactor.Text.Trim())).ToString() + "&P=" + PageToLoad;
                imgMain.Attributes.Add("LoadImg", url);
            }
            catch (Exception ex)
            {
                //TrustControl1.ClientMsg(ex.Message);
            }
        }
        protected void img_Click(object sender, EventArgs e)
        {
            ImageButton img = (ImageButton)(sender);
            LoadMainImagePage(img.CommandArgument);
        }
        protected void lnk_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)(sender);
            LoadMainImagePage(lnk.CommandArgument);
        }
        protected void Next1_Click(object sender, EventArgs e)
        {
            hidCurrentPage.Value = (int.Parse(hidCurrentPage.Value.ToString()) + 1).ToString();
            //TrustControl1.ClientMsg(hidCurrentPage.Value.ToString());
            LoadMainImagePage((int.Parse(hidCurrentPage.Value.ToString()).ToString()));
        }
        protected void Previous1_Click(object sender, EventArgs e)
        {
            hidCurrentPage.Value = (int.Parse(hidCurrentPage.Value.ToString()) - 1).ToString();
            //TrustControl1.ClientMsg(hidCurrentPage.Value.ToString());
            LoadMainImagePage((int.Parse(hidCurrentPage.Value.ToString()).ToString()));
        }
        private void SelectLeftThumb(int SL)
        {
            for (int i = 1; i < Panel1.Controls.Count; i++)
                try
                {
                    ((ImageButton)Panel1.Controls[i]).CssClass = "AttachmentThumb";
                    //((ImageButton)Panel1.Controls[i]).BorderWidth = Unit.Pixel(1);
                    //((ImageButton)Panel1.Controls[i]).BorderStyle = BorderStyle.Solid;
                }
                catch (Exception) { }
            SL = (SL * 4) - 3;
            try
            {
                ImageButton img = (ImageButton)(Panel1.Controls[SL]);
                img.CssClass = "AttachmentThumbSelected";
                //img.BorderWidth = Unit.Point(3);
                //img.BorderColor = System.Drawing.Color.LightGreen;
                //img.BorderStyle = BorderStyle.Groove;
                LinkButton lnk = (LinkButton)(Panel1.Controls[SL + 2]);
                lnk.Focus();
            }
            catch (Exception) { }
        }
    }

}
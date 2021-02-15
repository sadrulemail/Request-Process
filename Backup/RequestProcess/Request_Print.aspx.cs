using System;
using System.Web.UI.WebControls;
using System.Web;
using System.IO;

namespace RequestProcess
{
    public partial class Request_Print : System.Web.UI.Page
    {
        string ContentType = "";
        string ReqType = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Title = "eService Request Print - Trust Bank";

            string reqid = string.Format("{0}", Request.QueryString["reqid"]);
            ReqType = string.Format("{0}", Request.QueryString["type"]);
            //TrustBarcode.Barcode bc = new TrustBarcode.Barcode();
            //CrystalReportSource1.Report.Parameters[0].DefaultValue = bc.Convert_128C(Barcode);
        }

        protected void CrystalReportViewer1_AfterRender(object source, CrystalDecisions.Web.HtmlReportRender.AfterRenderEvent e)
        {
            ExportToPdf();
        }      

        private void ExportToPdf()
        {

            if (ReqType.ToLower() == "print") ContentType = "inline";
            else if (ReqType.ToLower() == "download") ContentType = "attachment";

            //Output to PDF
            try
            {
                using (Stream oStream = (Stream)CrystalReportSource1.ReportDocument.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat))
                {
                    using (MemoryStream ms = new MemoryStream())
                    {
                        //SqlDataSourcePrintLog_Insert.Select(DataSourceSelectArguments.Empty);
                        oStream.CopyTo(ms);
                        Response.Clear();
                        Response.ClearContent();
                        Response.ClearHeaders();
                        Response.Buffer = true;
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("Content-Disposition", string.Format("{1};filename=Request_{0}.pdf", Request.QueryString["reqid"], ContentType));
                        Response.Cache.SetCacheability(HttpCacheability.NoCache);
                        Response.BinaryWrite(ms.ToArray());
                        Response.End();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void SqlDataSource1_Selected1(object sender, SqlDataSourceStatusEventArgs e)
        {
            if ((bool)e.Command.Parameters["@Done"].Value == false)
            {
                lblErrorMsg.Text = e.Command.Parameters["@Msg"].Value.ToString();
                CrystalReportViewer1.Visible = false;
            }
        }
    }
}
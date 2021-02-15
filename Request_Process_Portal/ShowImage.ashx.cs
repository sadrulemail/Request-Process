using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

namespace Request_Process_Portal
{
    /// <summary>
    /// Summary description for ShowImage
    /// </summary>
    public class ShowImage : IHttpHandler
    {

        int Width = 0;
        int Height = 0;
        bool Zoom = true;
        bool AcceptRatio = false;
        int PageNo = 1;
        string FileName = "";

        public void ProcessRequest(HttpContext context)
        {
            if (!String.IsNullOrEmpty(context.Request.QueryString["AID"]))
            {
                string AID = "";
                string KEY = "";

                //try
                {
                    //HttpCachePolicy cachePolicy = context.Response.Cache;
                    //cachePolicy.SetCacheability(HttpCacheability.ServerAndPrivate);
                    //cachePolicy.VaryByParams["AID"] = true;
                    //cachePolicy.VaryByParams["W"] = true;
                    //cachePolicy.VaryByParams["H"] = true;
                    //cachePolicy.VaryByParams["KEY"] = true;
                    //cachePolicy.VaryByParams["Z"] = true;
                    //cachePolicy.VaryByParams["P"] = true;
                    //cachePolicy.SetOmitVaryStar(true);
                    //cachePolicy.SetExpires(DateTime.Now + TimeSpan.FromMinutes(5));
                    //cachePolicy.SetValidUntilExpires(true);



                    AID = context.Request.QueryString["AID"];
                    KEY = context.Request.QueryString["KEY"];
                    PageNo = Convert.ToInt32(context.Request.QueryString["P"]);



                    try
                    {
                        Width = int.Parse(context.Request.QueryString["W"].ToString());
                    }
                    catch (Exception) { }
                    try
                    {
                        Height = int.Parse(context.Request.QueryString["H"].ToString());
                    }
                    catch (Exception) { }
                    try
                    {
                        Zoom = string.Format("{0}", context.Request.QueryString["Z"]) == "1" ? true : false;
                    }
                    catch (Exception) { }
                    try
                    {
                        AcceptRatio = string.Format("{0}", context.Request.QueryString["R"]) == "1" ? true : false;
                    }
                    catch (Exception) { }

                    string Query = string.Format("exec dbo.s_Attachments_View '{0}', '{1}'", AID, KEY);

                    byte[] logo = fetchScalar(Query, Width, Height, context, Zoom, AcceptRatio);
                    context.Response.ContentType = "Image/JPEG";
                    context.Response.AddHeader("Content-Length", logo.Length.ToString());
                    context.Response.AddHeader("Content-Disposition", "inline;filename=\"" + FileName + "\"");
                    context.Response.BinaryWrite(logo);
                }
                //catch (Exception)
                //{
                //    context.Response.ContentType = "Image/JPEG";
                //    try
                //    {
                //        context.Response.ContentType = "Image/JPEG";
                //        string NoImageFile = ConfigurationManager.AppSettings["AttachmentImage"].ToString();
                //        //byte[] noimage = File.ReadAllBytes(NoImageFile);
                //        Bitmap b = new Bitmap(NoImageFile);
                //        MemoryStream ms = GetImage(Width, Height, b);

                //        context.Response.BinaryWrite(ms.ToArray());
                //    }
                //    catch (Exception) { }
                //}
            }
        }

        private byte[] fetchScalar(string query, int Width, int Height, HttpContext context, bool Zoom, bool AcceptRatio)
        {
            bool Compressed = true;
            string Extension = "";
            MemoryStream ms = null;
            byte[] RetVal = null;

            SqlConnection.ClearAllPools();

            try
            {
                // connect to data source
                SqlConnection myConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Request_ProcessConnectionString"].ConnectionString);

                // initialize command object with query
                SqlCommand myCmd = new SqlCommand(query, myConn);

                // open connection
                if (myConn.State == ConnectionState.Closed)
                    myConn.Open();

                // get scalar
                byte[] scalar = null;
                SqlDataReader reader = myCmd.ExecuteReader();
                if (reader.HasRows)
                    while (reader.Read())
                    {
                        scalar = (byte[])reader["Attachment"];
                        Extension = string.Format("{0}", reader["ContentType"]);
                        FileName = string.Format("{0}", reader["FileName"]);
                    }

                if (Compressed)
                    scalar = Common.Decompress(scalar);


                // close connection
                myConn.Close();

                Bitmap b;

                using (MemoryStream str = new MemoryStream(scalar))
                {


                    if (Extension.ToUpper().Trim() == ".PDF")
                    {
                        System.Drawing.Image img1;

                        using (Ghostscript.NET.Rasterizer.GhostscriptRasterizer _rasterizer
                            = new Ghostscript.NET.Rasterizer.GhostscriptRasterizer())
                        {
                            _rasterizer.Open(str,
                                Ghostscript.NET.GhostscriptVersionInfo.GetLastInstalledVersion(
                                    Ghostscript.NET.GhostscriptLicense.GPL | Ghostscript.NET.GhostscriptLicense.AFPL, Ghostscript.NET.GhostscriptLicense.GPL)
                                    , true);

                            img1 = _rasterizer.GetPage(Width, Height, PageNo);

                            using (MemoryStream msOut = new MemoryStream())
                            {
                                img1.Save(msOut, ImageFormat.Jpeg);
                                scalar = msOut.ToArray();
                            }
                        }
                    }

                    b = (Bitmap)Bitmap.FromStream(new MemoryStream(scalar));
                    ms = GetImage(Width, Height, b, Zoom, AcceptRatio);

                    //ms = new MemoryStream(scalar);
                    //Stream str = new MemoryStream(scalar);
                    //PDFLibNet.PDFWrapper _pdfDoc = new PDFLibNet.PDFWrapper();
                    //_pdfDoc.LoadPDF(str);

                    //Bitmap _backbuffer = null;
                    //System.Drawing.Image img;

                    //try
                    //{
                    //    if (_pdfDoc.Pages.Count > 0)
                    //    {
                    //        _backbuffer = _pdfDoc.Pages[PageNo].GetBitmap(Width / 10, true);
                    //        ms = GetImage(Width, Height, _backbuffer, Zoom, AcceptRatio);
                    //    }

                    //}
                    //catch (Exception ex)
                    //{
                    //    throw new Exception(_pdfDoc.Pages.Count.ToString() + ", " + ex.Message);
                    //}

                    //img = (System.Drawing.Image)_backbuffer;
                    //img.Save(ms, ImageFormat.Jpeg);

                    //}
                    //else
                    //{
                    //    b = (Bitmap)Bitmap.FromStream(new MemoryStream(scalar));
                    //    ms = GetImage(Width, Height, b, Zoom, AcceptRatio);
                    //}
                }
            }
            catch (Exception ex)
            {
                context.Response.Write(ex.Message);
                context.Response.End();
            }

            RetVal = ms.ToArray();
            ms.Close();
            return RetVal;
        }

        private static MemoryStream GetImage(int Width, int Height, Bitmap b, bool Zoom, bool AcceptRatio)
        {
            Size size = new Size(Width, Height);
            Bitmap output = b;
            var xRatio = (double)Width / b.Width;
            var yRatio = (double)Height / b.Height;
            var ratio = Math.Min(xRatio, yRatio);
            if (!Zoom && ratio >= 1)
            {
                output = b;
                goto OutputProcess;
            }
            if (AcceptRatio)
            {
                var newSize = new Size(Math.Min(size.Width, (int)Math.Round(b.Width * ratio, MidpointRounding.AwayFromZero)), Math.Min(size.Height, (int)Math.Round(b.Height * ratio, MidpointRounding.AwayFromZero)));
                output = new Bitmap(b, newSize.Width, newSize.Height);
                goto OutputProcess;
            }

            if (Width == 0 && Height == 0)
            {
                output = b;
            }
            else if (Zoom)
            {
                if (Height == 0)
                {
                    double newHeight = ((double)Width * (double)b.Height / (double)b.Width);
                    output = new Bitmap(b, new Size(Width, (int)newHeight));
                }
                else if (Width == 0)
                {
                    double newWidth = ((double)Height * (double)b.Width / (double)b.Height);
                    output = new Bitmap(b, new Size((int)newWidth, Height));
                }
                else
                    output = new Bitmap(b, new Size(Width, Height));
            }
            else
            {
                if (Height == 0)
                {
                    double newHeight = ((double)Width * (double)b.Height / (double)b.Width);
                    if (newHeight <= (double)b.Height)
                        output = new Bitmap(b, new Size(Width, (int)newHeight));
                    else
                        output = b;
                }
                else if (Width == 0)
                {
                    double newWidth = ((double)Height * (double)b.Width / (double)b.Height);
                    if (newWidth <= (double)b.Width)
                        output = new Bitmap(b, new Size((int)newWidth, Height));
                    else
                        output = b;
                }
                else
                {
                    if (Height <= (double)b.Height && Width <= (double)b.Width)
                        output = new Bitmap(b, new Size(Width, Height));
                    else
                        output = b;
                }
            }

        OutputProcess:
            MemoryStream ms = new MemoryStream();
            output.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
            return ms;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
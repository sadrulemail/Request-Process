<%@ WebHandler Language="C#" Class="Signature" %>


using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.IO;


    /// <summary>
    /// Summary description for Signature
    /// </summary>
    public class Signature : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                //HttpCachePolicy cachePolicy = context.Response.Cache;
                //cachePolicy.SetCacheability(HttpCacheability.ServerAndPrivate);
                //cachePolicy.VaryByParams["EMPID"] = true;
                //cachePolicy.VaryByParams["W"] = true;
                //cachePolicy.VaryByParams["H"] = true;
                //cachePolicy.VaryByParams["imgid"] = true;
                //cachePolicy.SetOmitVaryStar(true);
                //cachePolicy.SetExpires(DateTime.Now + TimeSpan.FromHours(6));
                //cachePolicy.SetValidUntilExpires(true);
                //cachePolicy.SetLastModified(new DateTime(2010,03,02,12,0,0));



                string AccountNo = context.Request.QueryString["account"];

                int Width = 0;
                int Height = 0;

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

                string Query = "SELECT TOP 1 signature FROM dbo.v_cus_AC_signature";
                Query += " WHERE Accountno='" + AccountNo + "'";
                byte[] logo = (byte[])fetchScalar(Query, Width, Height);
                context.Response.ContentType = "Image/JPEG";
                context.Response.BinaryWrite(logo);
            }
            catch (Exception ex)
            {
                context.Response.Clear();
                //context.Response.ContentType = "Image/JPEG";
                //try
                //{
                //    Response.BinaryWrite(new byte[] { });
                //}
                //catch (Exception)
                //{
                //try
                //{
                //string NoImageFile = ConfigurationManager.AppSettings["NoImageFile"].ToString();
                //byte[] noimage = File.ReadAllBytes(NoImageFile);
                //context.Response.Redirect("~/Images/NoFace.jpg");
                //}
                //catch (Exception) { }
                //}


                context.Response.Write(ex.Message);
            }
        }

        object fetchScalar(string query, int Width, int Height)
        {
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
                object scalar = myCmd.ExecuteScalar();

                // close connection
                myConn.Close();
                File.WriteAllText("C:\\A\\1.jpg", string.Format("{0}", scalar));
                Bitmap b = (Bitmap)Bitmap.FromStream(new MemoryStream((byte[])scalar));

               

                Bitmap output;
                if (Width == 0)
                    output = b;
                else if (Height == 0)
                {
                    double newHeight = ((double)Width * (double)b.Height / (double)b.Width);
                    output = new Bitmap(b, new Size(Width, (int)newHeight));
                }
                else
                    output = new Bitmap(b, new Size(Width, Height));

                MemoryStream ms = new MemoryStream();
                output.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                return ms.ToArray();
            }
            catch (Exception ex)
            {                
                return null;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

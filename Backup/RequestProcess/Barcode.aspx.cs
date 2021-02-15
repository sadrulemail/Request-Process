using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace RequestProcess
{
    public partial class Barcode1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ID = string.Format("{0}", Request.QueryString["id"]);

            if (ID == "")
                Response.Redirect("Barcode.aspx?id=1234", true);

            CrystalReportSource1.Report.Parameters[0].DefaultValue = ID;
            

            try
            {
                long l = long.Parse(ID);
                CrystalReportSource1.Report.Parameters[1].DefaultValue = Encode_128C(ID);
                CrystalReportSource1.Report.Parameters[2].DefaultValue = Encode_128C(ID);
            }
            catch(Exception)
            {
                CrystalReportSource1.Report.Parameters[1].DefaultValue = Encode_128A(ID);
                CrystalReportSource1.Report.Parameters[2].DefaultValue = Encode_128A(ID);
            }


            //for (int II = 10001; II <= 10099; II++)
            //{
            //    string _ID =  II.ToString();
            //    //_ID = _ID.Substring(_ID.Length - 5, 5);

            //    ObjectDataSource1.UpdateParameters["ID"].DefaultValue = _ID;
            //    ObjectDataSource1.UpdateParameters["Original_ID"].DefaultValue = _ID;
            //    ObjectDataSource1.UpdateParameters["Barcode"].DefaultValue = Encode_128C(_ID);

            //    ObjectDataSource1.Update();
            //}



            CrystalReportViewer1.RefreshReport();
            
        }

        protected void CrystalReportViewer1_AfterRender(object source, CrystalDecisions.Web.HtmlReportRender.AfterRenderEvent e)
        {
            ExportToPdf();
        }

        

        public string Encode_128A(string chaine)
        {
            string RetVal = "";
            //TrustBarcode.Barcode bc = new TrustBarcode.Barcode();
            //RetVal = bc.Convert_128A(chaine);
            return RetVal;
        }

        public string Encode_128B(string chaine)
        {
            string RetVal = "";
            //TrustBarcode.Barcode bc = new TrustBarcode.Barcode();
            //RetVal = bc.Convert_128B(chaine);
            return RetVal;
        }

        public string Encode_128C(string chaine)
        {
            string RetVal = "";
            //TrustBarcode.Barcode bc = new TrustBarcode.Barcode();
            //RetVal = bc.Convert_128C(chaine);
            return RetVal;
        }


        //public String Encode128C(String chaine)
        //{
        //    if (chaine.Length % 2 != 0) chaine = "0" + chaine; 

        //    int ind = 1;
        //    int checksum = 0;
        //    int mini;
        //    int dummy;
        //    bool tableB;
        //    String code128;
        //    int longueur;

        //    code128 = "";
        //    longueur = chaine.Length;

        //    if (longueur == 0)
        //    {
        //        //Console.WriteLine("\n chaine vide");
        //    }
        //    else
        //    {
        //        for (ind = 0; ind < longueur; ind++)
        //        {
        //            if ((chaine[ind] < 32) || (chaine[ind] > 126))
        //            {
        //                //Console.WriteLine("\n chaine invalide");
        //            }
        //        }
        //    }

        //    tableB = true;
        //    ind = 0;

        //    while (ind < longueur)
        //    {
        //        if (tableB == true)
        //        {
        //            if ((ind == 0) || (ind + 3 == longueur - 1))
        //            {
        //                mini = 4;
        //            }
        //            else
        //            {
        //                mini = 6;
        //            }

        //            mini = mini - 1;

        //            if ((ind + mini) <= longueur - 1)
        //            {
        //                while (mini >= 0)
        //                {
        //                    if ((chaine[ind + mini] < 48) || (chaine[ind + mini] > 57))
        //                    {
        //                        Console.WriteLine("\n exit");
        //                        break;
        //                    }
        //                    mini = mini - 1;
        //                }
        //            }

        //            if (mini < 0)
        //            {
        //                if (ind == 0)
        //                {
        //                    code128 = Char.ToString((char)205);

        //                }
        //                else
        //                {
        //                    code128 = code128 + Char.ToString((char)199);

        //                }
        //                tableB = false;
        //            }
        //            else
        //            {

        //                if (ind == 0)
        //                {
        //                    code128 = Char.ToString((char)204);
        //                }
        //            }
        //        }

        //        if (tableB == false)
        //        {
        //            mini = 2;
        //            mini = mini - 1;
        //            if (ind + mini < longueur)
        //            {
        //                while (mini >= 0)
        //                {

        //                    if (((chaine[ind + mini]) < 48) || ((chaine[ind]) > 57))
        //                    {
        //                        break;
        //                    }
        //                    mini = mini - 1;
        //                }
        //            }
        //            if (mini < 0)
        //            {
        //                dummy = Int32.Parse(chaine.Substring(ind, 2));

        //                //Console.WriteLine("\n  dummy ici : " + dummy);

        //                if (dummy < 95)
        //                {
        //                    dummy = dummy + 32;
        //                }
        //                else
        //                {
        //                    dummy = dummy + 100;
        //                }
        //                code128 = code128 + (char)(dummy);

        //                ind = ind + 2;
        //            }
        //            else
        //            {
        //                code128 = code128 + Char.ToString((char)200);
        //                tableB = true;
        //            }
        //        }
        //        if (tableB == true)
        //        {

        //            code128 = code128 + chaine[ind];
        //            ind = ind + 1;
        //        }
        //    }

        //    for (ind = 0; ind <= code128.Length - 1; ind++)
        //    {
        //        dummy = code128[ind];
        //        //Console.WriteLine("\n  et voila dummy : " + dummy);
        //        if (dummy < 127)
        //        {
        //            dummy = dummy - 32;
        //        }
        //        else
        //        {
        //            dummy = dummy - 100;
        //        }
        //        if (ind == 0)
        //        {
        //            checksum = dummy;
        //        }
        //        checksum = (checksum + (ind) * dummy) % 103;
        //    }

        //    if (checksum < 95)
        //    {
        //        checksum = checksum + 32;
        //    }
        //    else
        //    {
        //        checksum = checksum + 100;
        //    }
        //    code128 = code128 + Char.ToString((char)checksum) + Char.ToString((char)206);

        //    return code128.Replace(" ", "Â");
        //}

        private void ExportToPdf()
        {
            try
            {
                using (MemoryStream oStream = (MemoryStream)CrystalReportSource1.ReportDocument.ExportToStream(
                        CrystalDecisions.Shared.ExportFormatType.PortableDocFormat))
                {
                    //SqlDataSourcePrintLog_Insert.Select(DataSourceSelectArguments.Empty);
                    Response.Clear();
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.Buffer = true;
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-Disposition", string.Format("inline;filename=Barcode_{0}.pdf", "1"));
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.BinaryWrite(oStream.ToArray());
                    Response.End();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        } 
    }
}
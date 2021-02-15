using System.Web.Services;
using System.Data.SqlClient;
using System.Data;

namespace RequestProcess
{
    /// <summary>
    /// Summary description for UserAccountService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    //[System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]


    public class UserAccountService : System.Web.Services.WebService
    {
        [WebMethod]
        public string getAccountInfo(string contextKey)
        {
            //System.Threading.Thread.Sleep(5000);

            SqlConnection.ClearAllPools();
            string Retval = "";
            SqlDataAdapter adapt = new SqlDataAdapter("s_FloraAccInfo", BbConnector.Connection);
            adapt.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapt.SelectCommand.Parameters.Add(new SqlParameter("@AccountNo", SqlDbType.VarChar, 50)).Value = contextKey;
            DataTable dt = new DataTable();
            adapt.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                Retval += string.Format("<b>{0}</b><br><i>{1}</i><br>{2}", dt.Rows[0]["acname"], dt.Rows[0]["glhead"], dt.Rows[0]["BranchName"]);
            }

            return Retval;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


    public partial class Test_Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();

            this.Title = ((Label)this.Page.Master.FindControl("ApplicationName")).Text;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            CrystalReportViewer1.DataBind();
        }
    }

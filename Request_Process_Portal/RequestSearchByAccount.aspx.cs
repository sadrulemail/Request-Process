using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


    public partial class RequestSearchByAccount : System.Web.UI.Page
    {
           

        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();
            Page.Title = "Request Search By Account";
          
        }
      

      

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            grdvAccountList.DataBind();

        }

    

      
      
    }

using System;


    public partial class iBanking_Req_Status_Count_Branch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();

            if (!IsPostBack)
            {
                txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
                txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            }

            Title = "iBanking Service Request Browse Branch wise";
        }

        protected void grdiBanking_Req_Status_Count_DataBound(object sender, EventArgs e)
        {
            try
            {
                int SignatureVerified = 0;
                int VerifiedByBranch = 0;
                int SignatureNotMatched = 0;
                int DeclinedByBranch = 0;
                int Total = 0;

                for (int i = 0; i < grdiBanking_Req_Status_Count.Rows.Count; i++)
                {
                    SignatureVerified += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[2].Text);
                    VerifiedByBranch += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[3].Text);
                    SignatureNotMatched += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[4].Text);                    
                    DeclinedByBranch += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[5].Text);
                    Total += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[6].Text);
                }

                grdiBanking_Req_Status_Count.FooterRow.Cells[2].Text = SignatureVerified.ToString();                
                grdiBanking_Req_Status_Count.FooterRow.Cells[3].Text = VerifiedByBranch.ToString();
                grdiBanking_Req_Status_Count.FooterRow.Cells[4].Text = SignatureNotMatched.ToString();
                grdiBanking_Req_Status_Count.FooterRow.Cells[5].Text = DeclinedByBranch.ToString();
                grdiBanking_Req_Status_Count.FooterRow.Cells[6].Text = Total.ToString();
            }
            catch (Exception) { }
        }

        protected void cmdPreviousDay_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime DT = DateTime.Parse(txtDateFrom.Text);
                txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(-1));
                txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(-1));
                //RefreshData();
            }
            catch (Exception) { }
        }

        protected void cmdNextDay_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime DT = DateTime.Parse(txtDateFrom.Text);
                txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(1));
                txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(1));
                //RefreshData();
            }
            catch (Exception) { }
        }
    }

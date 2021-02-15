using System;


    public partial class iBanking_Req_Status_Count : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TrustControl1.getUserRoles();

            if (!IsPostBack)
            {
                txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
                txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            }

            Title = "iBanking Service Request Browse";
        }

        protected void grdiBanking_Req_Status_Count_DataBound(object sender, EventArgs e)
        {
            try
            {
                int Completed = 0;
                int RejectByITDivision = 0;
                int SignatureVerified = 0;                
                int VerifiedByBranch = 0;
                int SignatureNotMatched = 0;
                int DeclinedByBranch = 0;
                int Total = 0;

                for (int i = 0; i < grdiBanking_Req_Status_Count.Rows.Count; i++)
                {
                    Completed += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[4].Text);
                    RejectByITDivision += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[5].Text);
                    SignatureVerified += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[6].Text);                    
                    VerifiedByBranch += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[7].Text);
                    SignatureNotMatched += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[8].Text);
                    DeclinedByBranch += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[9].Text);
                    Total += int.Parse(grdiBanking_Req_Status_Count.Rows[i].Cells[10].Text);
                }

                grdiBanking_Req_Status_Count.FooterRow.Cells[4].Text = Completed.ToString();
                grdiBanking_Req_Status_Count.FooterRow.Cells[5].Text = RejectByITDivision.ToString();
                grdiBanking_Req_Status_Count.FooterRow.Cells[6].Text = SignatureVerified.ToString();                
                grdiBanking_Req_Status_Count.FooterRow.Cells[7].Text = VerifiedByBranch.ToString();
                grdiBanking_Req_Status_Count.FooterRow.Cells[8].Text = SignatureNotMatched.ToString();
                grdiBanking_Req_Status_Count.FooterRow.Cells[9].Text = DeclinedByBranch.ToString();
                grdiBanking_Req_Status_Count.FooterRow.Cells[10].Text = Total.ToString();
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

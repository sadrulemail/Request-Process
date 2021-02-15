using System;


namespace Request_Process_Portal
{
    public partial class MyControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string ToItclPhone(string PhoneNumber)
        {
            try
            {
                string RetVal = PhoneNumber.Trim();
                if (RetVal.Length > 0)
                    RetVal = RetVal.Substring(0, 3) + "(" + RetVal.Substring(3, 5) + ")" + RetVal.Substring(8);
                return RetVal;
            }
            catch (Exception)
            { return ""; }
        }
    }
}
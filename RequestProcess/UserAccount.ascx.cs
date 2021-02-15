using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RequestProcess
{
    public partial class UserAccount : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string AccountNo
        {
            set
            {
                lblUserID.Text = string.Format("{0}", value);
                HoverMenuExtenderlblUserID.DynamicContextKey = value;
            }
            get
            {
                return lblUserID.Text.Trim().Replace("&nbsp;", "");
            }
        }

        public string Position
        {
            set
            {
                try
                {
                    if (value.ToString().ToUpper() == "LEFT")
                        HoverMenuExtenderlblUserID.PopupPosition = AjaxControlToolkit.HoverMenuPopupPosition.Left;
                }
                catch (Exception)
                {
                    HoverMenuExtenderlblUserID.PopupPosition = AjaxControlToolkit.HoverMenuPopupPosition.Right;
                    //UserInfo.Width = Unit.Empty;
                }
            }
        }
    }
}
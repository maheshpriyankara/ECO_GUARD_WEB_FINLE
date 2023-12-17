using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bbq
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var dd = Session["userID"];
            var df = Session["userType"];
            if (Session["userID"] != null && Session["userType"] != null)
            {
                if (!Session["userType"].ToString().Equals("Admin"))
                {
                    Response.Redirect("login.aspx");
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
}
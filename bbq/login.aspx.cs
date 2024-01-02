using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bbq
{
    public partial class login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
   WebConfigurationManager.ConnectionStrings["conn"].ConnectionString);

        SqlConnection con2 = new SqlConnection(
  WebConfigurationManager.ConnectionStrings["conn"].ConnectionString);
        db db;
        SqlDataReader reader, reader2;

        TimeSpan payCutValue = TimeSpan.Parse("00:00");
        bool oneToEnd, pastToPresent;
        DateTime dateIns, dateOutS;
        ArrayList dates, dates2, dateList, datesNight;
        Int32 tempMonth = 0;
        void getDateList(string empId, string month, string year, SqlConnection conn, SqlDataReader reader_)
        {

            try
            {

                dateList = new ArrayList();
                oneToEnd = false;
                pastToPresent = false;
                conn.Open();
                reader_ = new SqlCommand("select a.*  from shiftsalaryPeriod  as a,emp as b where  b.id='" + empId + "' and b.jobCategory=a.name ", conn).ExecuteReader();
                if (reader_.Read())
                {
                    oneToEnd = reader_.GetBoolean(1);
                    pastToPresent = reader_.GetBoolean(2);
                }
                conn.Close();

                if (oneToEnd)
                {
                    //  MessageBox.Show("sa1sasa");
                    for (int i = 1; i <= DateTime.DaysInMonth(Int32.Parse(year), Int32.Parse(month)); i++)
                    {
                        dateList.Add(year + "-" + month + "-" + i);
                    }
                }
                else if (pastToPresent)
                {
                    tempMonth = new DateTime(Int32.Parse(year), Int32.Parse(month), 1).AddMonths(-1).Month;
                    string Year2 = new DateTime(Int32.Parse(year), Int32.Parse(month), 1).AddMonths(-1).Year + "";
                    for (int i = 26; i <= DateTime.DaysInMonth(Int32.Parse(year), Int32.Parse(month)); i++)
                    {
                        dateList.Add(Year2 + "-" + tempMonth + "-" + i);
                    }
                    for (int i = 1; i <= 25; i++)
                    {
                        dateList.Add(year + "-" + month + "-" + i);
                    }
                }
            }
            catch (Exception a)
            {
                var sss = a.Message;
                conn.Close();
            }
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            Session["userID"] = null;
            Session["userType"] = null;
            Response.Redirect("login.aspx");
        }

        protected void bt_requestOtP_Click(object sender, EventArgs e)
        {
            
        }

        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {





                Session["userID"] = null;
                //Session["userType"] = null;
                if (Request.QueryString["userID"] != null)
                {
                    Session["userID"] = Request.QueryString["userID"];
                }
                else if (Session["userID"] == null || Session["userID"].ToString().Equals(""))
                {
                    Session["userID"] = null;
                    Session["userType"] = null;
                }
                var aa = Session["userID"];
               

            }

        }


        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        protected void Button1_Click1(object sender, EventArgs e)
        {


        }

        protected void Button1_Click2(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
        }

        protected void Button1_Click3(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }
    }
}
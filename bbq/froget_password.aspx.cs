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
    public partial class frogetpassword : System.Web.UI.Page
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


                //con.Open();
                //reader = new SqlCommand("select * from emp where resgin='false'", con).ExecuteReader();
                //while (reader.Read())
                //{
                //    var tot_allowance = 0.0;

                //    try
                //    {
                //        con2.Open();
                //        reader2 = new SqlCommand("select sum(amount) from fixedallownces where empid='"+reader[0]+"'", con2).ExecuteReader();
                //        if (reader2.Read())
                //        {
                //            tot_allowance = reader2.GetDouble(0);
                //        }
                //        con2.Close();
                //    }
                //    catch (Exception)
                //    {
                //        con2.Close();
                //    }
                //    con2.Open();
                //    new SqlCommand("update emp set allowances='" + tot_allowance + "' where id='" + reader[0] + "'", con2).ExecuteReader();
                //    con2.Close();
                //}
                //con.Close();

                //+++++++++++++++++++++++++++++++++empbackup refernce set

                //con.Open();
                //reader = new SqlCommand("select id,bankNo,branchNo,acno,name from emp", con).ExecuteReader();
                //while (reader.Read())
                //{
                //    con2.Open();
                //    new SqlCommand("update empbackup set bankcode='" + reader[1] + "',branchcode='" + reader[2] + "',lastname='" + reader[4] + "',acno='" + reader[3] + "' where id='" + reader[0] + "'", con2).ExecuteNonQuery();
                //    con2.Close();
                //}
                //con.Close();


                /// +++++++++++++++++++++++++++++++  misattendance check
                var empid = "";
                bool check_ = false;
                //con.Open();
                //reader = new SqlCommand("select id,empid,epfno,type from emp where resgin='false'",con).ExecuteReader();
                //while (reader.Read())
                //{
                //    getDateList(reader[0].ToString(), "05", "2023",con2,reader2);
                //    empid = reader[1] + "";
                //    con_clock.Open();
                //    reader2 = new SqlCommand("select clock from ras_AttRecord  where din='" + empid + "'   and clock between '" + dateList[0] + " 00:00:00.000" + "' and '" + dateList[dateList.Count - 1] + " 23:59:00.000" + "' order by clock", con_clock).ExecuteReader();
                //    if (reader2.Read())
                //    {
                //        check_ = true;
                //    }
                //    con_clock.Close();
                //    if (!empid.Equals(reader[2].ToString()) && !check_)
                //    {
                //        empid = reader[2] + "";
                //        con_clock.Open();
                //        reader2 = new SqlCommand("select clock from ras_AttRecord  where din='" + empid + "'   and clock between '" + dateList[0] + " 00:00:00.000" + "' and '" + dateList[dateList.Count - 1] + " 23:59:00.000" + "' order by clock", con_clock).ExecuteReader();
                //        if (reader2.Read())
                //        {
                //            check_ = true;
                //        }
                //        con_clock.Close();
                //    }
                //    if (!empid.Equals(reader[3].ToString()) && !check_)
                //    {
                //        empid = reader[3] + "";
                //        con_clock.Open();
                //        reader2 = new SqlCommand("select clock from ras_AttRecord  where din='" + empid + "'   and clock between '" + dateList[0] + " 00:00:00.000" + "' and '" + dateList[dateList.Count-1] + " 23:59:00.000" + "' order by clock", con_clock).ExecuteReader();
                //        if (reader2.Read())
                //        {
                //            check_ = true;
                //        }
                //        con_clock.Close();
                //    }
                //    if (!check_)
                //    {
                //        con2.Open();
                //        new SqlCommand("insert into att_missed_check values ('"+ "2023/May" + "','"+reader[0]+ "','" + reader[1] + "','" + reader[2] + "','" + reader[3] + "','" + DateTime.Now + "')", con2).ExecuteNonQuery();
                //        con2.Close();
                //    }
                //}
                //con.Close();
                //++++++++++++++++++++++++++++++++++++++++++ paysheet down 2023/April
                //con.Open();
                //new SqlCommand("delete from paysheet where month_2='2023/April'", con).ExecuteNonQuery();
                //con.Close();

                //con_temp.Open();
                //reader = new SqlCommand("select * from paysheet where month_2='2023/April'", con_temp).ExecuteReader();
                //while (reader.Read())
                //{
                //    con.Open();
                //    new SqlCommand("insert into paysheet values ('" + reader[1] + "','" + reader[2] + "','" + reader[3] + "','" + reader[4] + "','" + reader[5] + "','" + reader[6] + "','" + reader[7] + "','" + reader[8] + "','" + reader[9] + "','" + reader[10] + "','" + reader[11] + "','" + reader[12] + "','" + reader[13] + "','" + reader[14] + "','" + reader[15] + "','" + reader[16] + "','" + reader[17] + "','" + reader[18] + "','" + reader[19] + "','" + reader[20] + "','" + reader[21] + "','" + reader[22] + "','" + reader[23] + "','" + reader[24] + "','" + reader[25] + "','" + reader[26] + "','" + reader[27] + "','" + reader[28] + "','" + reader[29] + "','" + reader[30] + "','" + reader[31] + "','" + reader[32] + "','" + reader[33] + "','" + reader[34] + "','" + reader[35] + "','" + reader[36] + "','" + reader[37] + "','" + reader[38] + "','" + reader[39] + "','" + reader[40] + "','" + reader[41] + "','" + reader[42] + "','" + reader[43] + "','" + reader[44] + "','" + reader[45] + "','" + reader[46] + "','" + reader[47] + "','" + reader[48] + "','" + reader[49] + "','" + reader[50] + "')", con).ExecuteNonQuery();
                //    con.Close();
                //}
                //con_temp.Close();

                //con.Open();
                //new SqlCommand("delete from timesheet where indate_3 between '2023-03-26' and '2023-04-25'", con).ExecuteNonQuery();
                //con.Close();

                //con_temp.Open();
                //reader = new SqlCommand("select * from timesheet where indate_3 between '2023-03-26' and '2023-04-25'", con_temp).ExecuteReader();
                //while (reader.Read())
                //{
                //    con.Open();
                //    new SqlCommand("insert into timesheet values ('" + reader[1] + "','" + reader[2] + "','" + reader[3] + "','" + reader[4] + "','" + reader[5] + "','" + reader[6] + "','" + reader[7] + "','" + reader[8] + "','" + reader[9] + "','" + reader[10] + "','" + reader[11] + "','" + reader[12] + "','" + reader[13] + "','" + reader[14] + "','" + reader[15] + "','" + reader[16] + "','" + reader[17] + "','" + reader[18] + "','" + reader[19] + "','" + reader[20] + "','" + reader[21] + "','" + reader[22] + "','" + reader[23] + "','" + reader[24] + "','" + reader[25] + "')", con).ExecuteNonQuery();
                //    con.Close();
                //}
                //con_temp.Close();

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
           //     Button1.Text = "Request OTP";
                db = new db();
                try
                {
                    con.Open();
                    reader = new SqlCommand("select nic,mobilenumber,title,firstname from emp where id='" + Session["userID"] + "'", con).ExecuteReader();

                    if (reader.Read())
                    {
                        con2.Open();
                        reader2 = new SqlCommand("select * from user_Admin where empid='" + Session["userID"] + "'", con2).ExecuteReader();
                        if (reader2.Read())
                        {
                            Session["userType"] = "Admin";
                        }
                        else
                        {
                            Session["userType"] = "User";

                        }
                        con2.Close();
                        var a = Session["userID"];
                        Session["mobile"] = reader[1] + "";
                        //txt_name.InnerText = "Welcome Back, " + reader[2] + " " + reader[3];
                        text_nic.Value = reader[0] + "";
                        //text_otp.Attributes["placeholder"] = "OTP Sent To : 07XXXXX" + reader.GetString(1).Substring(reader.GetString(1).Length - 4); ;
                        text_nic.Attributes["readonly"] = "readonly";
                        var otp = (DateTime.Now.Hour * DateTime.Now.Minute) - DateTime.Now.Second + DateTime.Now.Year;
                        var body = "Hello, your One-Time Password (OTP) for HRIS login is " + otp + ". Please enter this OTP within 24 Hours to complete your login. Thank you!";

                        con2.Open();
                        reader2 = new SqlCommand("select * from otp_request where empid='" + Session["userID"] + "' and requset_date between '" + db.getSysDateTime().ToShortDateString() + " 00:00:00" + "' and '" + db.getSysDateTime().ToShortDateString() + " 23:59:00" + "'", con2).ExecuteReader();
                        if (!reader2.Read())
                        {
                            con2.Close();
                            con2.Open();
                            new SqlCommand("insert into otp_request values('" + Session["userID"] + "','" + reader[1] + "','" + db.GetLocalIPAddress() + "','" + otp + "','" + db.getSysDateTime() + "')", con2).ExecuteNonQuery();

                            new SqlCommand("insert into sms_queue values('" + Session["userID"] + "','" + reader[1] + "','" + body + "','" + db.getSysDateTime() + "','" + db.GetLocalIPAddress() + "','" + Session["userID"] + "','" + false + "','" + false + "','" + db.getSysDateTime() + "','" + db.getSysDateTime() + "','" + "" + "')", con2).ExecuteNonQuery();
                            con2.Close();
                        }
                        con2.Close();

                        //Button1.Text = "Verify OTP";
                    }
                    con.Close();
                }
                catch (Exception aaa)
                {
                    var ss = aaa.Message;
                    Session["userID"] = null;
                    con.Close();
                }
                if (text_nic.Value.ToString().Equals(""))
                {
                    //Button1.Text = "SIGN IN";
                }

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
          
        }
    }
}
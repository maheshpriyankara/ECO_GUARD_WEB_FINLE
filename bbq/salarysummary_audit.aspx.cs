using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bbq
{
    public partial class salarysummary_audit : System.Web.UI.Page
    {
        static SqlConnection conn = new SqlConnection(
        WebConfigurationManager.ConnectionStrings["conn"].ConnectionString);

        static SqlConnection conn2 = new SqlConnection(
   WebConfigurationManager.ConnectionStrings["conn"].ConnectionString);

        static SqlConnection conn_main;
        SqlDataReader reader2;
        static SqlDataReader reader;
        db db;
        DateTime sys_date;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["period"]!=null && Request.QueryString["list_paymode"] != null && Request.QueryString["list_epf"] != null)
            {
                var result_ = Request.QueryString["period"].ToString();
                var list_paymode_= Request.QueryString["list_paymode"].ToString();
                var list_epf_ = Request.QueryString["list_epf"].ToString();

                var year = result_.Split('/')[0].ToString();
                var month = result_.Split('/')[1].ToString();

                var list_paymode = Int32.Parse(list_paymode_);
                var list_epf = Int32.Parse(list_epf_);

                try
                {



                    db db = new db();

                   
                    {
                        DataSet ds = new DataSet();

                        DataTable dt = new DataTable();
                        dt.Columns.Add("NO", typeof(int));
                        dt.Columns.Add("EMPLOYEE NUMBER", typeof(int));
                        dt.Columns.Add("NAME", typeof(string));
                        dt.Columns.Add("BASIC", typeof(float));
                        dt.Columns.Add("BUDJ. ALLOW.", typeof(float));
                        dt.Columns.Add("PH ALLOW.", typeof(float));
                        dt.Columns.Add("LATE", typeof(float));
                        dt.Columns.Add("NO PAY", typeof(float));
                        dt.Columns.Add("WAGES FOR EPF", typeof(float));
                        dt.Columns.Add("TOTAL ALLOW.", typeof(float));
                        dt.Columns.Add("OT HOURS", typeof(float));
                        dt.Columns.Add("OT", typeof(float));
                        dt.Columns.Add("GROSS", typeof(float));
                        dt.Columns.Add("EPF 8%", typeof(float));
                        dt.Columns.Add("PAYEE", typeof(float));
                        dt.Columns.Add("LOAN", typeof(float));
                        dt.Columns.Add("OTHER DED.", typeof(float));
                        dt.Columns.Add("TOTAL DED.", typeof(float));
                        dt.Columns.Add("NET SALARY", typeof(float));
                        dt.Columns.Add("EPF 12%", typeof(float));
                        dt.Columns.Add("ETF 3%", typeof(float));
                        dt.Columns.Add("EPF 20%", typeof(float));
                        dt.Columns.Add("LINE", typeof(string));
                        dt.Columns.Add("2", typeof(float));
                        dt.Columns.Add("3", typeof(float));
                        dt.Columns.Add("4", typeof(float));
                        dt.Columns.Add("5", typeof(float));
                        dt.Columns.Add("6", typeof(float));
                        dt.Columns.Add("7", typeof(float));
                        dt.Columns.Add("8", typeof(float));
                        dt.Columns.Add("9", typeof(float));
                        dt.Columns.Add("10", typeof(float));
                        dt.Columns.Add("11", typeof(float));

                        dt.Columns.Add("count", typeof(float));
                        var tempkl = "";
                        conn.Open();
                        if (list_paymode == 0)
                        {
                            if (list_epf == 0)
                            {
                                reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and d.month='" + year + "/" + month + "' and d.id=b.id order by b.tempepfno", conn).ExecuteReader();
                                tempkl = "ALL EMPLOYEES " + year + "-" + month + " ( Bank ,Cash ,EPF Pay ,EPF Not Pay ) ";

                            }
                            else if (list_epf == 1)
                            {
                                reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='true' order by b.tempepfno", conn).ExecuteReader();
                                tempkl = "ALL EMPLOYEES " + year + "-" + month + " ( Bank | Cash | EPF Pay ) ";

                            }
                            else if (list_epf == 2)
                            {
                                reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='false' order by b.tempepfno", conn).ExecuteReader();
                                tempkl = "ALL EMPLOYEES " + year + "-" + month + " ( Bank | Cash | EPF Not Pay ) ";

                            }
                        }
                        else
                        if (list_paymode == 1)
                        {
                            if (list_epf == 0)
                            {
                                reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + true + "' and d.month='" + year + "/" + month + "' and d.id=b.id order by b.tempepfno", conn).ExecuteReader();
                                tempkl = "BANK PAY EMPLOYEES " + year + "-" + month + " ( EPF Pay | EPF Not Pay )";

                            }
                            else if (list_epf == 1)
                            {
                                reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + true + "' and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='true' order by b.tempepfno", conn).ExecuteReader();
                                tempkl = "BANK PAY EMPLOYEES " + year + "-" + month + " ( EPF Pay Only )";

                            }
                            else if (list_epf == 2)
                            {
                                reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + true + "' and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='false' order by b.tempepfno", conn).ExecuteReader();
                                tempkl = "BANK PAY EMPLOYEES " + year + "-" + month + " ( EPF Not Pay Only )";

                            }
                        }
                        else if (list_paymode == 2)
                        {
                            if (list_epf == 0)
                            {
                                reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + false + "' and d.month='" + year + "/" + month + "' and d.id=b.id order by b.tempepfno", conn).ExecuteReader();
                                tempkl = "CASH PAY EMPLOYEES " + year + "-" + month + " ( EPF Pay | EPF Not Pay )";

                            }
                            else if (list_epf == 1)
                            {
                                reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + false + "' and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='true' order by b.tempepfno", conn).ExecuteReader();
                                tempkl = "CASH PAY EMPLOYEES " + year + "-" + month + " ( EPF Pay Only )";

                            }
                            else if (list_epf == 2)
                            {
                                reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + false + "' and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='false' order by b.tempepfno", conn).ExecuteReader();
                                tempkl = "CASH PAY EMPLOYEES " + year + "-" + month + " ( EPF Not Pay Only )";

                            }

                        }
                        var cc = 0;
                        while (reader.Read())
                        {


                            cc++;
                            dt.Rows.Add(1, reader[52], reader[51].ToString().ToUpper(), reader[3], reader[4], reader[31], reader[24], reader[25], reader[6], (reader.GetDouble(19) + reader.GetDouble(17) + reader.GetDouble(18) + reader.GetDouble(36) + reader.GetDouble(32) + reader.GetDouble(30) + reader.GetDouble(16) + reader.GetDouble(20) + reader.GetDouble(31) + reader.GetDouble(47) + reader.GetDouble(48) + reader.GetDouble(49) + reader.GetDouble(50)), (int)((reader.GetDouble(9) + reader.GetDouble(13)) / 60 / 60) + "." + (int)(((reader.GetDouble(9) + reader.GetDouble(13)) / 60) % 60), (reader.GetDouble(11) + reader.GetDouble(14)), reader[22], reader[29], reader[46], (reader.GetDouble(33) + reader.GetDouble(34)), ((reader.GetDouble(38)) - (reader.GetDouble(24) + reader.GetDouble(29) + reader.GetDouble(35) + reader.GetDouble(33) + reader.GetDouble(34) + reader.GetDouble(46))), (reader.GetDouble(38)), Math.Round(reader.GetDouble(39), 2), reader[43], reader[44], (reader.GetDouble(43) + reader.GetDouble(29)), reader[53].ToString(), reader.GetDouble(35));
                        }
                        conn.Close();
                        ds.Tables.Add(dt);
                        salarySummeryViewLessons paySheet = new salarySummeryViewLessons();
                        paySheet.SetDataSource(ds);
                        paySheet.SetParameterValue("name", year + " " + month);
                        paySheet.SetParameterValue("name1", "");

                        salary_summary_audit.ReportSource = paySheet;

                      

                    }




                }
                catch (Exception a)
                {
                    Response.Write("<script>alert('" + a.InnerException + "')</script>");
                    Response.Write("<script>alert('" + a.StackTrace + "')</script>");
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
}
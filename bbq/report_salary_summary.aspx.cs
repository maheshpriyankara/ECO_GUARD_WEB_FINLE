﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;

using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Collections;
using System.Drawing;
using System.Web.Services;
using System.IO;
using CrystalDecisions.Shared;
using bbq.reports_;
using System.Net.Http;
using Newtonsoft.Json.Linq;

namespace bbq
{
    public partial class report_salary_summary : System.Web.UI.Page
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
            if (Session["userID"] != null && Session["userType"] != null)
            {
                if (!Page.IsPostBack)
                {
                    loadList(list_date, conn, reader, "list_years", 0, "name");

                    Session["processPeriod"] = new db().getCurrentSalaryPeriod(conn, reader);
                    var temp = Session["processPeriod"].ToString();
                    list_date.Text = temp.Split('/')[0].ToString();
                    list_month.Value = temp.Split('/')[1].ToString();

                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }

        }
        void loadList(DropDownList list, SqlConnection conn, SqlDataReader reader, String table, int index, String orderBy)
        {
            try
            {
                conn.Open();
                reader = new SqlCommand("select * from " + table + " order by " + orderBy, conn).ExecuteReader();
                while (reader.Read())
                {
                    list.Items.Add(reader[index].ToString());
                }
                conn.Close();
            }
            catch (Exception a)
            {
                var tt = a.Message;
                conn.Close();
            }

        }

        public int CheckEmployeeAll(string period_)
        {
            int status = 0;
            SqlConnection conn = new SqlConnection(
    WebConfigurationManager.ConnectionStrings["conn"].ConnectionString);
            SqlDataReader reader = null;
            try
            {

                conn.Open();
                reader = new SqlCommand("select lock from empbackup where month='" + period_ + "'", conn).ExecuteReader();
                if (reader.Read())
                {
                    if (reader.GetBoolean(0))
                    {
                        status = 1;
                    }
                    else
                    {
                        conn.Close();
                        conn.Open();
                        reader = new SqlCommand("select id from process_queue where period_='" + period_ + "' and process_end='" + false + "'", conn).ExecuteReader();
                        if (reader.Read())
                        {
                            status = 2;
                        }
                        conn.Close();
                    }


                }
                conn.Close();

                if (status != 0 && status != 2)
                {
                    try
                    {
                        conn.Open();
                        reader = new SqlCommand("SELECT empid, month, COUNT(*) as duplicate_count FROM empbackup where month = '" + period_ + "' GROUP BY empid, month HAVING COUNT(*) > 1", conn).ExecuteReader();
                        if (reader.Read())
                        {
                            status = 3;
                        }
                        conn.Close();
                    }
                    catch (Exception)
                    {
                        conn.Close();
                    }
                }
                if (status != 0 && status != 2)
                {
                    try
                    {
                        conn.Open();
                        reader = new SqlCommand("SELECT empID_1, month_2, COUNT(*) as duplicate_count FROM paySheet where month_2 = '" + period_ + "' GROUP BY empID_1, month_2 HAVING COUNT(*) > 1", conn).ExecuteReader();
                        if (reader.Read())
                        {
                            status = 3;
                        }
                        conn.Close();
                    }
                    catch (Exception)
                    {
                        conn.Close();
                    }
                }
                if (status != 0 && status != 2 && status != 1)
                {
                    try
                    {
                        conn.Open();
                        reader = new SqlCommand("select * from emp where resgin='false' and id not in (select id from empbackup where month='" + period_ + "')", conn).ExecuteReader();
                        if (reader.Read())
                        {
                            status = 3;
                        }
                        conn.Close();
                    }
                    catch (Exception)
                    {
                        conn.Close();
                    }
                }
                if (status != 0 && status != 2 && status != 1)
                {
                    try
                    {
                        conn.Open();
                        reader = new SqlCommand("select * from emp where resgin='false' and id  not in (select empid_1 from paysheet where month_2='" + period_ + "'))", conn).ExecuteReader();
                        if (reader.Read())
                        {
                            status = 3;
                        }
                        conn.Close();
                    }
                    catch (Exception)
                    {
                        conn.Close();
                    }
                }

            }
            catch (Exception)
            {
                status = 0;
                conn.Close();
            }
            return status;
        }
        protected void btn_export_Click(object sender, EventArgs e)
        {
            try
            {



                db db = new db();
                var year = list_date.Text;
                var month = list_month.Value;
                var result = CheckEmployeeAll(year + "/" + month);

                if (result == 2)
                {

                    Response.Write("<script>alert('" + "Selected Period Processing......Cannot Export" + "')</script>");
                }
                else if (result == 3)
                {

                    Response.Write("<script>alert('" + "Selected Period Have Un-Sucessfull Processed Profiles. Please Request on Settings > Un-Successfull Process Request ,and try again.." + "')</script>");
                }
                else
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
                    if (list_paymode.SelectedIndex == 0)
                    {
                        if (list_epf.SelectedIndex == 0)
                        {
                            reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and d.month='" + year + "/" + month + "' and d.id=b.id order by b.id", conn).ExecuteReader();
                            tempkl = "ALL EMPLOYEES " + year + "-" + month + " ( Bank ,Cash ,EPF Pay ,EPF Not Pay ) ";

                        }
                        else if (list_epf.SelectedIndex == 1)
                        {
                            reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='true' order by b.id", conn).ExecuteReader();
                            tempkl = "ALL EMPLOYEES " + year + "-" + month + " ( Bank | Cash | EPF Pay ) ";

                        }
                        else if (list_epf.SelectedIndex == 2)
                        {
                            reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='false' order by b.id", conn).ExecuteReader();
                            tempkl = "ALL EMPLOYEES " + year + "-" + month + " ( Bank | Cash | EPF Not Pay ) ";

                        }
                    }
                    else
                    if (list_paymode.SelectedIndex == 1)
                    {
                        if (list_epf.SelectedIndex == 0)
                        {
                            reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + true + "' and d.month='" + year + "/" + month + "' and d.id=b.id order by b.id", conn).ExecuteReader();
                            tempkl = "BANK PAY EMPLOYEES " + year + "-" + month + " ( EPF Pay | EPF Not Pay )";

                        }
                        else if (list_epf.SelectedIndex == 1)
                        {
                            reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + true + "' and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='true' order by b.id", conn).ExecuteReader();
                            tempkl = "BANK PAY EMPLOYEES " + year + "-" + month + " ( EPF Pay Only )";

                        }
                        else if (list_epf.SelectedIndex == 2)
                        {
                            reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + true + "' and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='false' order by b.id", conn).ExecuteReader();
                            tempkl = "BANK PAY EMPLOYEES " + year + "-" + month + " ( EPF Not Pay Only )";

                        }
                    }
                    else if (list_paymode.SelectedIndex == 2)
                    {
                        if (list_epf.SelectedIndex == 0)
                        {
                            reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + false + "' and d.month='" + year + "/" + month + "' and d.id=b.id order by b.id", conn).ExecuteReader();
                            tempkl = "CASH PAY EMPLOYEES " + year + "-" + month + " ( EPF Pay | EPF Not Pay )";

                        }
                        else if (list_epf.SelectedIndex == 1)
                        {
                            reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + false + "' and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='true' order by b.id", conn).ExecuteReader();
                            tempkl = "CASH PAY EMPLOYEES " + year + "-" + month + " ( EPF Pay Only )";

                        }
                        else if (list_epf.SelectedIndex == 2)
                        {
                            reader = new SqlCommand("select a.*,b.name,d.epfno,d.line from paysheet as a,emp as b,empbackup as d where a.month_2='" + year + "/" + month + "' and a.empID_1=b.id and b.isBankPay='" + false + "' and d.month='" + year + "/" + month + "' and d.id=b.id and d.isepf='false' order by b.id", conn).ExecuteReader();
                            tempkl = "CASH PAY EMPLOYEES " + year + "-" + month + " ( EPF Not Pay Only )";

                        }

                    }
                    var cc = 0;
                    while (reader.Read())
                    {


                        cc++;
                        dt.Rows.Add(1, reader[52], reader[51].ToString().ToUpper(), (reader.GetDouble(3)+reader.GetDouble(4)), reader[19], (int)((reader.GetDouble(23) ) / 60 / 60) + "." + (int)(((reader.GetDouble(23)) / 60) % 60)+"", reader[24], reader[25], reader[20], (reader.GetDouble(19) + reader.GetDouble(17) + reader.GetDouble(18) + reader.GetDouble(36) + reader.GetDouble(32) + reader.GetDouble(30) + reader.GetDouble(16)  + reader.GetDouble(47) + reader.GetDouble(48) + reader.GetDouble(49) + reader.GetDouble(50)), (int)((reader.GetDouble(9) + reader.GetDouble(13)) / 60 / 60) + "." + (int)(((reader.GetDouble(9) + reader.GetDouble(13)) / 60) % 60)+"", (reader.GetDouble(11) + reader.GetDouble(14)), reader[22], reader[29], reader[8], (reader.GetDouble(33) + reader.GetDouble(34)), ((reader.GetDouble(38)) - (reader.GetDouble(24)+ reader.GetDouble(25) + reader.GetDouble(29) + reader.GetDouble(35) + reader.GetDouble(33) + reader.GetDouble(34) + reader.GetDouble(46) + reader.GetDouble(45))), (reader.GetDouble(38)), Math.Round(reader.GetDouble(39), 2), reader[43], reader[44], (reader.GetDouble(43) + reader.GetDouble(29)), reader[53].ToString(), reader.GetDouble(35), reader.GetDouble(45));
                    }
                    conn.Close();
                    ds.Tables.Add(dt);
                    salarySummeryViewLessons paySheet = new salarySummeryViewLessons();http://localhost:1485/report_salary_summary.aspx.cs
                    paySheet.SetDataSource(ds);
                    paySheet.SetParameterValue("name", year + " " + month);
                    paySheet.SetParameterValue("name1", "");

                    string tempFilePath = Path.GetTempFileName();
                    paySheet.ExportToDisk(ExportFormatType.PortableDocFormat, tempFilePath);

                    // Read the temporary file into a MemoryStream
                    byte[] fileBytes = File.ReadAllBytes(tempFilePath);
                    MemoryStream pdfStream = new MemoryStream(fileBytes);

                    // Delete the temporary file
                    File.Delete(tempFilePath);

                    // Set the response headers

                    paySheet.Close();
                    paySheet.Dispose();
                    paySheet = null;
                    ds.Clear();
                    ds.Dispose();

                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "inline;filename=SalarySummary" + year + month + ".pdf");

                    // Write the PDF stream to the response
                    Response.BinaryWrite(pdfStream.ToArray());

                    // End the response
                    Response.End();

                }




            }
            catch (Exception a)
            {
                conn.Close();
                var tt = a.Message;
                Response.Write("<script>alert('" + a.InnerException + "')</script>");
                Response.Write("<script>alert('" + a.StackTrace + "')</script>");
            }
        }

        protected void btn_exportaudit_Click(object sender, EventArgs e)
        {
            try
            {



                db db = new db();
                var year = list_date.Text;
                var month = list_month.Value;
                var result = CheckEmployeeAll(year + "/" + month);

                if (result == 2)
                {

                    Response.Write("<script>alert('" + "Selected Period Processing......Cann't Export" + "')</script>");
                }
                else if (result == 3)
                {

                    Response.Write("<script>alert('" + "Selected Period Have Un-Sucessfull Processed Profile's. Please Request on Settings > Un-Successfull Process Request ,and try again.." + "')</script>");
                }
                else
                {
                    //   Response.Redirect("salarysummary_audit.aspx?period="+result+ "&list_paymode=" + list_paymode.SelectedIndex+ "&list_epf="+ list_epf.SelectedIndex);
                    string redirectUrl = "salarysummary_audit.aspx?period=" + year+"/"+month + "&list_paymode=" + list_paymode.SelectedIndex + "&list_epf=" + list_epf.SelectedIndex;
                    string script = "window.open('" + redirectUrl + "', '_blank');";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "OpenNewTab", script, true);

                }




            }
            catch (Exception a)
            {
                Response.Write("<script>alert('" + a.InnerException + "')</script>");
                Response.Write("<script>alert('" + a.StackTrace + "')</script>");
            }
        }
    }
}
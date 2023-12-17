using System;
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
using System.Text.RegularExpressions;

namespace bbq
{
    public partial class profile_employee : System.Web.UI.Page
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
        string userID_;
        static ArrayList nicList;
        static List<string> empResult;
        int category_id;
        [WebMethod]
        public static List<string> getEmployee(string empName)
        {
            empResult = new List<string>();
            try
            {
                conn.Close();

                conn.Open();
                reader = new SqlCommand("select name,epfno,empid from emp where name like '%" + empName + "%' or epfno like '" + empName + "%' or empid like '" + empName + "%'", conn).ExecuteReader();
                while (reader.Read())
                {
                    //var epfNo = "<span style='color:red'>" + "EPF No-" + reader[1].ToString() + "</span>";
                    //var empNo = "<span style='color:green'>" + "Employer No-" + reader[2].ToString() + "</span>";
                    //string empResultText = reader.GetString(0) + " ( " + epfNo + ", " + empNo + ")";
                    //string encodedEmpResultText = HttpUtility.HtmlEncode(empResultText);
                    //  empResult.Add(empResultText);
                    empResult.Add(reader.GetString(0) + " (" + "EPF No-" + reader[1].ToString() + "," + "Employer No-" + reader[2].ToString() + ")");
                }
                conn.Close();
            }
            catch (Exception)
            {
                conn.Close();
            }

            return empResult;
        }
        [WebMethod]
        public static string employeeSelected(string empName)
        {
            var result = "";
            var result_name = "";
            var result_epfNo = "";
            var result_empNo = "";



            try
            {

                result_name = empName.Split('(')[0].ToString().Remove(empName.Split('(')[0].ToString().Length - 1);
                result = empName.Split('(')[1].ToString();
                result = result.Split(')')[0].ToString();
                result_epfNo = result.Split(',')[0].ToString().Split('-')[1];
                result_empNo = result.Split(',')[1].ToString().Split('-')[1];
            }
            catch (Exception)
            {
            }
            //var str = "foo_bar_baz";
            //string[] parts = str.Split(new[] { "bar" }, StringSplitOptions.None);
            return result_name + "_" + result_epfNo + "_" + result_empNo;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userID"] != null && Session["userType"] != null)
            {
                if (IsPostBack != true)
                {
                    loadList(list_department, conn, reader, "line", 1, "name");
                    loadList(list_designation, conn, reader, "desegnation", 0, "name");
                  //  loadList(list_company, conn, reader, "company", 0, "name");
                    loadList(list_shiftBlock, conn, reader, "shiftValue", 0, "name_0");
                    try
                    {
                        list_company.Items.Clear();
                        conn.Open();
                        reader = new SqlCommand("select id,name from company", conn).ExecuteReader();
                        while (reader.Read())
                        {
                            list_company.Items.Add(reader[0].ToString()+"_"+reader[1]);
                        }
                        conn.Close();
                    }
                    catch (Exception)
                    {
                        conn.Close();
                    }
                    sys_date = new db().getSysDateTime();
                    btn_clear_Click(null, null);
                }
                if (Session["userID"] == null)
                {
                    Session["userID"] = "System";
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
                list.Items.Clear();
                conn.Open();
                reader = new SqlCommand("select * from " + table + " order by " + orderBy, conn).ExecuteReader();
                while (reader.Read())
                {
                    list.Items.Add(reader[index].ToString());
                }
                conn.Close();
            }
            catch (Exception)
            {
                conn.Close();
            }

        }
        protected void Page_Unload(object sender, EventArgs e)
        {
            // Session["userID"] = null;
        }

        protected void grid_allowances_RowEditing(object sender, GridViewEditEventArgs e)
        {

            //  BindGridData();
        }

        string empNO = "";
        protected void btn_loadEmployee_Click(object sender, EventArgs e)
        {
            var aaaaaaaaaaaaaaaa = IsPostBack;
            if (text_epfNoSearch.Text.Equals("") && text_empNo.Text.Equals(""))
            {
                Response.Write("<script>alert('Please Input Employee EPF No / Employeer No to Load Profile')</script>");
            }
            else
            {

                try
                {
                    conn.Open();
                    if (!text_epfNoSearch.Text.Equals(""))
                    {
                        reader = new SqlCommand("select * from emp where epfno='" + text_epfNoSearch.Text.ToString() + "'", conn).ExecuteReader();
                    }
                    else
                    {
                        reader = new SqlCommand("select * from emp where empid='" + text_empNo.Text.ToString() + "'", conn).ExecuteReader();
                    }
                    if (reader.Read())
                    {

                        text_landNo.Value = reader[29] + "";
                        text_emContactPerson.Value = reader[24] + "";
                        text_emContactNumber.Value = reader[25] + "";
                        text_emAddress.Value = reader[26] + "";
                        text_emRelationship.Value = reader[27] + "";
                        text_firstName_.Value = reader[59] + "";
                        text_LastName.Value = reader[60] + "";
                        text_attendance.Value = reader.GetDouble(43).ToString("0.00");
                        text_initial.Value = reader[61] + "";
                        date_resginedDate.Text = reader.GetDateTime(57).ToString("yyyy-MM-dd");
                        //tempLoadNo = Int32.Parse(reader[50] + "");
                        if (reader.GetBoolean(56))
                        {
                            radio_otCircleDayBased.Checked = true;
                        }
                        else
                        {
                            radio_otCircle180Hours.Checked = true;
                        }
                        check_defaultRoaster.Checked = reader.GetBoolean(55);

                        try
                        {
                            text_branchCode.Value = reader[54] + "";
                        }
                        catch (Exception)
                        {
                        }
                        try
                        {
                            text_bankCode.Value = reader[53] + "";
                        }
                        catch (Exception)
                        {
                        }
                        radio_bankPay.Checked = reader.GetBoolean(52);
                        check_epfPay.Checked = reader.GetBoolean(51);
                        //checkiSliST.Checked = reader.GetBoolean(49);
                        check_resgined.Checked = reader.GetBoolean(47);
                        if (check_resgined.Checked)
                        {
                            date_resginedDate.Enabled = false;
                            date_resginedDate.ForeColor = Color.Red;
                        }
                        check_blocked.Checked = reader.GetBoolean(48);
                        Session["empNo"] = reader[0] + "";
                        empNO = reader[0] + "";
                        //dateCheck = reader.GetDateTime(33).ToString();
                        text_firstName.Value = reader.GetString(1);
                        date_DOB.Text = reader.GetDateTime(2).ToString("yyyy-MM-dd");
                        list_gender.Value = reader.GetString(3);
                        list_title.Value = reader.GetString(4);
                        list_maritalStatus.Value = reader.GetString(5);
                        try
                        {
                            list_designation.Text = reader.GetString(17).ToUpper();
                        }
                        catch (Exception)
                        {
                        }

                        text_AccountNo.Value = reader[42] + "";
                        //attdanceAllowances.Text = reader[43] + "";
                        list_bloodGroup.Value = reader.GetString(6);
                        text_nic.Value = reader.GetString(7);
                        text_drivingLicence.Value = reader.GetString(9);
                        list_department.Text = reader.GetString(46).ToString();
                        list_religion.Value = reader.GetString(11);
                        list_nationality.Value = reader.GetString(12);
                        list_race.Value = reader.GetString(13);
                        //for (int i = 0; i < company.Items.Count; i++)
                        //{
                        //    if (company.Items[i].ToString().Split('_')[0].ToString().Equals(reader.GetString(15)))
                        //    {
                        //        company.SelectedIndex = i;
                        //    }

                        //}

                        list_shiftBlock.Text = reader.GetString(16);
                        ////  fixallowances.Text = reader.GetString(18);
                        date_DOA.Text = reader.GetDateTime(19).ToString("yyyy-MM-dd");
                        var aa = reader.GetString(20);
                        text_address.Text = aa.ToString();
                        text_contactNo.Value = reader.GetString(23);
                        text_mobileNo.Value = reader.GetString(22);
                        //checkBoxPaySlip.Checked = reader.GetBoolean(58);

                        text_attendanceID.Value = reader[35].ToString();
                        text_basic.Value = reader.GetDouble(37).ToString("0.00");
                        ////  holidayEpf.Checked = reader.GetBoolean(38);
                        ////maxOtHour.Text = reader[39].ToString();
                        text_budgetary.Value = reader.GetDouble(45).ToString("0.00");
                        text_epfNo.Value = reader[40].ToString();


                        conn.Close();
                        conn.Open();
                        reader2 = new SqlCommand("select amount,name from fixedAllownces where empid='" + empNO + "'", conn).ExecuteReader();
                        while (reader2.Read())
                        {
                            if (reader2.GetString(1).Equals("1"))
                            {
                                text_fixedAllowances.Value = reader2.GetDouble(0).ToString("0.00");
                            }
                            else if (reader2.GetString(1).Equals("2"))
                            {
                                text_mealAllowances.Value = reader2.GetDouble(0).ToString("0.00");
                            }
                            else if (reader2.GetString(1).Equals("3"))
                            {
                                text_specialAllowances.Value = reader2.GetDouble(0).ToString("0.00");
                            }
                            else if (reader2.GetString(1).Equals("4"))
                            {
                                text_theaterAllowances.Value = reader2.GetDouble(0).ToString("0.00");
                            }
                            else if (reader2.GetString(1).Equals("5"))
                            {
                                text_icuAllowances.Value = reader2.GetDouble(0).ToString("0.00");
                            }
                            else if (reader2.GetString(1).Equals("6"))
                            {
                                text_transportAllowances.Value = reader2.GetDouble(0).ToString("0.00");
                            }
                            else if (reader2.GetString(1).Equals("7"))
                            {
                                text_accommodationAllowances.Value = reader2.GetDouble(0).ToString("0.00");
                            }
                            else if (reader2.GetString(1).Equals("8"))
                            {
                                text_fuelAllowances.Value = reader2.GetDouble(0).ToString("0.00");
                            }
                            else if (reader2.GetString(1).Equals("9"))
                            {
                                text_allowances2.Value = reader2.GetDouble(0).ToString("0.00");
                            }

                        }
                        conn.Close();
                        if (check_defaultRoaster.Checked)
                        {
                            conn.Close();
                            conn.Open();
                            reader2 = new SqlCommand("select * from defaultRoaster where id='" + empNO + "'", conn).ExecuteReader();
                            if (reader2.Read())
                            {
                                time_deafultRosterFirstShiftInTime.Text = reader2.GetTimeSpan(1).ToString("hh\\:mm");
                                list_defaultRoasterFirstShiftInDate.Value = reader2.GetString(2);
                                time_deafultRosterFirstShiftOutTime.Text = reader2.GetTimeSpan(3).ToString("hh\\:mm");
                                list_defaultRoasterFirstShiftOutDate.Value = reader2.GetString(4);

                                time_deafultRosterSecondShiftInTime.Text = reader2.GetTimeSpan(5).ToString("hh\\:mm");
                                var gt = reader2.GetString(6);

                                list_deafultRosterSecondShiftInDate.Value = reader2.GetString(6);
                                time_deafultRosterSecondShiftOutTime.Text = reader2.GetTimeSpan(7).ToString("hh\\:mm");
                                list_deafultRosterSecondShiftOutDate.Value = reader2.GetString(8);
                            }
                            conn.Close();

                        }
                        conn.Close();
                        conn.Open();
                        reader2 = new SqlCommand("select * from leaveExtraHours_ where empid='" + empNO + "'", conn).ExecuteReader();
                        while (reader2.Read())
                        {
                            check_leaveExtra06Hours.Checked = reader2.GetBoolean(1);
                            check_leaveExtra06Hourshalf.Checked = reader2.GetBoolean(2);
                            check_leaveExtra08Hours.Checked = reader2.GetBoolean(3);
                            check_leaveExtra08HoursHalf.Checked = reader2.GetBoolean(4);
                        }
                        conn.Close();
                    }
                    conn.Close();
                }
                catch (Exception a)
                {
                    var aaa = a.Message;
                    conn.Close();
                }
            }
        }

        protected void grid_allowances_RowEditing1(object sender, GridViewEditEventArgs e)
        {
        }

        protected void check_defaultRoaster_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {

        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {

                var a = IsPostBack;

                {
                    if (text_budgetary.Value.Equals(""))
                    {
                        Response.Write("<script>alert('Sorry, Budgetary Allowance Cannot be Zero')</script>");
                    }
                    else if (check_epfPay.Checked && text_epfNo.Value.Equals(""))
                    {
                        Response.Write("<script>alert('Sorry, Please Input EPF no for EPF Payble Employee')</script>");
                    }
                    else if (!check_epfPay.Checked && !text_epfNo.Value.Equals("") && !text_epfNo.Value.Equals("0"))
                    {
                        Response.Write("<script>alert('Sorry, Please Check EPF Payble for EPF No Added Employee')</script>");
                    }
                    else if (text_basic.Value.Equals(""))
                    {
                        Response.Write("<script>alert('Sorry, Basic Salary Cannot be Zero')</script>");
                    }
                    else if (list_company.SelectedIndex == -1)
                    {
                        Response.Write("<script>alert('Sorry, Please Select a Company')</script>");
                    }
                    else if (list_shiftBlock.SelectedIndex == -1)
                    {
                        Response.Write("<script>alert('Sorry, Please Select a Job Category')</script>");
                    }
                    else if (list_designation.SelectedIndex == -1)
                    {
                        Response.Write("<script>alert('Sorry, Please Select a Designation')</script>");
                    }
                    else if (list_department.SelectedIndex == -1)
                    {
                        Response.Write("<script>alert('Sorry, Please Select a Department')</script>");
                    }
                    else if (text_attendanceID.Value.Equals(""))
                    {
                        Response.Write("<script>alert('Sorry, Please Input Attendance ID')</script>");
                    }
                    else
                    {

                        sys_date = new db().getSysDateTime();
                        empNO = Session["empNo"].ToString();
                        conn.Close();
                        var process = false;
                        var updateMOde = false;
                        var tempID = "";
                        if (text_epfNo.Value.Equals("") || text_epfNo.Value.Equals("0"))
                        {
                            tempID = text_attendanceID.Value;
                        }
                        else
                        {
                            tempID = text_epfNo.Value;
                        }
                        if (check_resgined.Checked)
                        {
                            tempID = "";
                        }
                        if (empNO.Equals(""))
                        {
                            updateMOde = true;
                            getEmpID();
                            conn.Close();
                            conn.Open();
                            reader = new SqlCommand("select id from emp where empid='" + tempID + "'", conn).ExecuteReader();
                            if (!reader.Read())
                            {
                                process = true;
                            }
                            else
                            {
                                Response.Write("<script>alert('Sorry, You Have Enterd Duplicate Epf No or M-No ,please Check and Try agian')</script>");
                            }
                        }
                        else
                        {
                            updateMOde = false;
                            if (!check_resgined.Checked)
                            {
                                conn.Close();
                                conn.Open();
                                reader = new SqlCommand("select id from emp where empid='" + tempID + "' and id='" + empNO + "' ", conn).ExecuteReader();
                                if (reader.Read())
                                {
                                    process = true;
                                }
                                else
                                {
                                    Response.Write("<script>alert('Sorry, You Have Enterd Duplicate Epf No or M-No ,please Check and Try agian')</script>");
                                }
                            }
                            else
                            {
                                process = true;
                            }

                        }


                        if (process)
                        {
                            conn.Close();
                            var tot_allwance = 0.0;
                            try
                            {
                                tot_allwance = tot_allwance + Double.Parse(text_fixedAllowances.Value.ToString());
                            }
                            catch (Exception)
                            {
                            }
                            try
                            {
                                tot_allwance = tot_allwance + Double.Parse(text_mealAllowances.Value.ToString());
                            }
                            catch (Exception)
                            {
                            }

                            try
                            {
                                tot_allwance = tot_allwance + Double.Parse(text_specialAllowances.Value.ToString());
                            }
                            catch (Exception)
                            {
                            }
                            try
                            {
                                tot_allwance = tot_allwance + Double.Parse(text_theaterAllowances.Value.ToString());
                            }
                            catch (Exception)
                            {
                            }
                            try
                            {
                                tot_allwance = tot_allwance + Double.Parse(text_icuAllowances.Value.ToString());
                            }
                            catch (Exception)
                            {
                            }
                            try
                            {
                                tot_allwance = tot_allwance + Double.Parse(text_transportAllowances.Value.ToString());
                            }
                            catch (Exception)
                            {
                            }
                            try
                            {
                                tot_allwance = tot_allwance + Double.Parse(text_accommodationAllowances.Value.ToString());
                            }
                            catch (Exception)
                            {
                            }
                            try
                            {
                                tot_allwance = tot_allwance + Double.Parse(text_fuelAllowances.Value.ToString());
                            }
                            catch (Exception)
                            {
                            }
                            try
                            {
                                tot_allwance = tot_allwance + Double.Parse(text_allowances2.Value.ToString());
                            }
                            catch (Exception)
                            {
                            }
                            conn.Open();
                            if (updateMOde)
                            {
                                new SqlCommand("insert into emp values ('" + text_firstName.Value.ToString() + "','" + date_DOB.Text + "','" + list_gender.Value + "','" + list_title.Value + "','" + list_maritalStatus.Value + "','" + list_bloodGroup.Value + "','" + text_nic.Value + "','" + "" + "','" + text_drivingLicence.Value + "','" + sys_date + "','" + list_religion.Value + "','" + list_nationality.Value + "','" + list_race.Value + "','" + "" + "','" + list_company.Text.ToString().Split('_')[0].ToString() + "','" + list_shiftBlock.Text + "','" + list_designation.Text + "','" + tot_allwance + "','" + date_DOA.Text + "','" + text_address.Text + "','" + text_address2.Text + "','" + text_mobileNo.Value + "','" + text_contactNo.Value + "','" + text_emContactPerson.Value + "','" + text_emContactNumber.Value + "','" + text_emAddress.Value + "','" + text_emRelationship.Value + "','" + "" + "','" + text_landNo.Value + "','" + "" + "','" + sys_date + "','" + sys_date + "','" + sys_date + "','" + "" + "','" + text_attendanceID.Value + "','" + tempID + "','" + text_basic.Value + "','" + true + "','" + 0 + "','" + text_epfNo.Value + "','" + true + "','" + text_AccountNo.Value + "','" + text_attendance.Value + "','" + false + "','" + text_budgetary.Value + "','" + list_department.Text + "','" + check_resgined.Checked + "','" + check_blocked.Checked + "','" + true + "','" + text_epfNo.Value + "','" + check_epfPay.Checked + "','" + radio_bankPay.Checked + "','" + text_bankCode.Value + "','" + text_branchCode.Value + "','" + check_defaultRoaster.Checked + "','" + radio_otCircleDayBased.Checked + "','" + date_resginedDate.Text + "','" + true + "','" + text_firstName_.Value + "','" + text_LastName.Value + "','" + text_initial.Value + "')", conn).ExecuteNonQuery();
                                new SqlCommand("insert into emp_logs values ('" + empNO + "','" + text_firstName.Value.ToString() + "','" + date_DOB.Text + "','" + list_gender.Value + "','" + list_title.Value + "','" + list_maritalStatus.Value + "','" + list_bloodGroup.Value + "','" + text_nic.Value + "','" + "" + "','" + text_drivingLicence.Value + "','" + sys_date + "','" + list_religion.Value + "','" + list_nationality.Value + "','" + list_race.Value + "','" + "" + "','" + list_company.Text.ToString().Split('_')[0].ToString() + "','" + list_shiftBlock.Text + "','" + list_designation.Text + "','" + tot_allwance + "','" + date_DOA.Text + "','" + text_address.Text + "','" + text_address2.Text + "','" + text_mobileNo.Value + "','" + text_contactNo.Value + "','" + text_emContactPerson.Value + "','" + text_emContactNumber.Value + "','" + text_emAddress.Value + "','" + text_emRelationship.Value + "','" + "" + "','" + text_landNo.Value + "','" + "" + "','" + sys_date + "','" + sys_date + "','" + sys_date + "','" + "" + "','" + text_attendanceID.Value + "','" + tempID + "','" + text_basic.Value + "','" + true + "','" + 0 + "','" + text_epfNo.Value + "','" + true + "','" + text_AccountNo.Value + "','" + text_attendance.Value + "','" + false + "','" + text_budgetary.Value + "','" + list_department.Text + "','" + check_resgined.Checked + "','" + check_blocked.Checked + "','" + true + "','" + text_epfNo.Value + "','" + check_epfPay.Checked + "','" + radio_bankPay.Checked + "','" + text_bankCode.Value + "','" + text_branchCode.Value + "','" + check_defaultRoaster.Checked + "','" + radio_otCircleDayBased.Checked + "','" + date_resginedDate.Text + "','" + true + "','" + text_firstName_.Value + "','" + text_LastName.Value + "','" + text_initial.Value + "','" + "New" + "','" + "New" + "','" + sys_date + "','" + Session["userID"] + "')", conn).ExecuteNonQuery();

                            }
                            else
                            {
                                var yyyy = sys_date;
                                new SqlCommand("update emp set  allowances='" + tot_allwance + "',ECRelationShip='" + text_emRelationship.Value + "',ECMobileNumber='" + text_emContactNumber.Value + "',ECAddress='" + text_emAddress.Value + "',ECName='" + text_emContactPerson.Value + "',SpouseMobileNumber='" + text_landNo.Value + "',initials='" + text_initial.Value + "',lastName='" + text_LastName.Value + "',firstName='" + text_firstName_.Value + "',ispaySlip='" + true + "',resginDate='" + date_resginedDate.Text + "',otCircle='" + radio_otCircleDayBased.Checked + "',isDefaultRoaster='" + check_defaultRoaster.Checked + "',branchNo='" + text_branchCode.Value + "',bankNo='" + text_bankCode.Value + "',isBankPay='" + radio_bankPay.Checked + "',isEpf='" + check_epfPay.Checked + "',tempEpfNo='" + text_epfNo.Value + "',ISLIST='" + true + "',RESGIN='" + check_resgined.Checked + "',BLOCK='" + check_blocked.Checked + "',line='" + list_department.Text + "', budj='" + text_budgetary.Value + "',staff='" + false + "',attendanceAllowance='" + text_attendance.Value + "',acno='" + text_AccountNo.Value + "',isPaySheet='" + false + "',epfno='" + text_epfNo.Value + "',maxothour='" + 0 + "',otepfpay='" + false + "',Basic='" + text_basic.Value + "',empid='" + tempID + "',type='" + text_attendanceID.Value + "',name='" + text_firstName.Value + "',DOB='" + date_DOB.Text + "',gender='" + list_gender.Value + "',title='" + list_title.Value + "',marital='" + list_maritalStatus.Value + "',blood='" + list_bloodGroup.Value + "',nic='" + text_nic.Value + "',passport='" + "" + "',drivingLicence='" + text_drivingLicence.Value + "',passportExpiry='" + sys_date + "',religion='" + list_religion.Value + "',nationality='" + list_nationality.Value + "',race='" + list_race.Value + "',groupC='" + "" + "',company='" + list_company.Text.ToString().Split('_')[0] + "',jobCategory='" + list_shiftBlock.Text + "',desgination='" + list_designation.Text + "',dateOfAppoinmant='" + date_DOA.Text + "',residentialAddress='" + text_address.Text + "',PermanetAddress='" + text_address2.Text + "',homeNumber='" + text_mobileNo.Value + "',mobileNUmber='" + text_contactNo.Value + "',SpouseName='" + "" + "',SpouseAddress='" + "" + "',SpouseDOB='" + "" + "',SpouseAnniversary='" + sys_date + "',date='" + sys_date + "',image='" + "" + "' where id='" + empNO + "'", conn).ExecuteNonQuery();
                                new SqlCommand("insert into emp_logs select *,'" + "Update" + empNO + "','" + "Old" + "','" + sys_date + "','" + Session["userID"] + "' from emp where id='" + empNO + "'", conn).ExecuteNonQuery();
                                new SqlCommand("insert into emp_logs values ('" + empNO + "','" + text_firstName.Value.ToString() + "','" + date_DOB.Text + "','" + list_gender.Value + "','" + list_title.Value + "','" + list_maritalStatus.Value + "','" + list_bloodGroup.Value + "','" + text_nic.Value + "','" + "" + "','" + text_drivingLicence.Value + "','" + sys_date + "','" + list_religion.Value + "','" + list_nationality.Value + "','" + list_race.Value + "','" + "" + "','" + list_company.Text.ToString().Split('_')[0].ToString() + "','" + list_shiftBlock.Text + "','" + list_designation.Text + "','" + tot_allwance + "','" + date_DOA.Text + "','" + text_address.Text + "','" + text_address2.Text + "','" + text_mobileNo.Value + "','" + text_contactNo.Value + "','" + text_emContactPerson.Value + "','" + text_emContactNumber.Value + "','" + text_emAddress.Value + "','" + text_emRelationship.Value + "','" + "" + "','" + text_landNo.Value + "','" + "" + "','" + sys_date + "','" + sys_date + "','" + sys_date + "','" + "" + "','" + text_attendanceID.Value + "','" + tempID + "','" + text_basic.Value + "','" + true + "','" + 0 + "','" + text_epfNo.Value + "','" + true + "','" + text_AccountNo.Value + "','" + text_attendance.Value + "','" + false + "','" + text_budgetary.Value + "','" + list_department.Text + "','" + check_resgined.Checked + "','" + check_blocked.Checked + "','" + true + "','" + text_epfNo.Value + "','" + check_epfPay.Checked + "','" + radio_bankPay.Checked + "','" + text_bankCode.Value + "','" + text_branchCode.Value + "','" + check_defaultRoaster.Checked + "','" + radio_otCircleDayBased.Checked + "','" + date_resginedDate.Text + "','" + true + "','" + text_firstName_.Value + "','" + text_LastName.Value + "','" + text_initial.Value + "','" + "Update" + empNO + "','" + "New" + "','" + sys_date + "','" + Session["userID"] + "')", conn).ExecuteNonQuery();

                            }

                            new SqlCommand("delete from leaveExtraHours_ where empid='" + empNO + "'", conn).ExecuteNonQuery();

                            new SqlCommand("insert into leaveExtraHours_ values ('" + empNO + "','" + check_leaveExtra06Hours.Checked + "','" + check_leaveExtra06Hourshalf.Checked + "','" + check_leaveExtra08Hours.Checked + "','" + check_leaveExtra08HoursHalf.Checked + "')", conn).ExecuteNonQuery();

                            new SqlCommand("delete from defaultRoaster where id='" + empNO + "'", conn).ExecuteNonQuery();
                            new SqlCommand("insert into defaultRoaster values('" + empNO + "','" + time_deafultRosterFirstShiftInTime.Text + "','" + list_defaultRoasterFirstShiftInDate.Value + "','" + time_deafultRosterFirstShiftOutTime.Text + "','" + list_defaultRoasterFirstShiftOutDate.Value + "','" + time_deafultRosterSecondShiftInTime.Text + "','" + list_deafultRosterSecondShiftInDate.Value + "','" + time_deafultRosterSecondShiftOutTime.Text + "','" + list_deafultRosterSecondShiftOutDate.Value + "')", conn).ExecuteNonQuery();
                            conn.Close();


                            conn.Close();
                            conn.Open();


                            new SqlCommand("delete from fixedAllownces where empid='" + empNO + "'", conn).ExecuteNonQuery();
                            new SqlCommand("insert into fixedallownces values ('" + empNO + "','" + "1" + "','" + text_fixedAllowances.Value + "')", conn).ExecuteNonQuery();
                            new SqlCommand("insert into fixedallownces values ('" + empNO + "','" + "2" + "','" + text_mealAllowances.Value + "')", conn).ExecuteNonQuery();
                            new SqlCommand("insert into fixedallownces values ('" + empNO + "','" + "3" + "','" + text_specialAllowances.Value + "')", conn).ExecuteNonQuery();
                            new SqlCommand("insert into fixedallownces values ('" + empNO + "','" + "4" + "','" + text_theaterAllowances.Value + "')", conn).ExecuteNonQuery();
                            new SqlCommand("insert into fixedallownces values ('" + empNO + "','" + "5" + "','" + text_icuAllowances.Value + "')", conn).ExecuteNonQuery();
                            new SqlCommand("insert into fixedallownces values ('" + empNO + "','" + "6" + "','" + text_transportAllowances.Value + "')", conn).ExecuteNonQuery();
                            new SqlCommand("insert into fixedallownces values ('" + empNO + "','" + "7" + "','" + text_accommodationAllowances.Value + "')", conn).ExecuteNonQuery();
                            new SqlCommand("insert into fixedallownces values ('" + empNO + "','" + "8" + "','" + text_fuelAllowances.Value + "')", conn).ExecuteNonQuery();
                            new SqlCommand("insert into fixedallownces values ('" + empNO + "','" + "9" + "','" + text_allowances2.Value + "')", conn).ExecuteNonQuery();



                            conn.Close();
                            if (updateMOde)
                            {
                                Response.Write("<script>alert('New Employee Profile Created Succesfully')</script>");
                            }
                            else
                            {
                                Response.Write("<script>alert('Selected Employee Updated Succesfully')</script>");
                            }
                            Session["processPeriod"] = new db().getCurrentSalaryPeriod(conn2, reader2);
                            var temp = Session["processPeriod"].ToString();

                            new db().PushEmployee(empNO, temp, "Employee Profile", Session["userID"].ToString(), "_");
                            btn_clear_Click(null, null);



                            Response.Write("<script>window.history.replaceState({}, document.title, window.location.href);</script>");
                        }
                    }

                }
            }
            catch (Exception s)
            {
                var ff = s.Message;
                Response.Write("<script>alert('Sorry, Internel Error')</script>");
            }
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            text_landNo.Value = "";
            text_emRelationship.Value = "";
            text_emAddress.Value = "";
            text_emContactNumber.Value = "";
            text_emContactPerson.Value = "";

            check_blocked.Checked = false;
            Session["empNo"] = "";
            text_attendance.Value = "";
            date_resginedDate.Text = sys_date.ToString("yyyy-MM-dd");
            radio_otCircleDayBased.Checked = false;
            check_defaultRoaster.Checked = false;
            text_branchCode.Value = "";
            text_initial.Value = "";
            text_LastName.Value = "";
            text_firstName_.Value = "";
            text_bankCode.Value = "";
            radio_bankPay.Checked = false;
            check_epfPay.Checked = false;
            //checkiSliST.Checked = reader.GetBoolean(49);
            check_resgined.Checked = false;
            date_resginedDate.Enabled = true;
            date_resginedDate.ForeColor = Color.Black;
            //BLOCK.Checked = reader.GetBoolean(48);
            empNO = "";
            //dateCheck = reader.GetDateTime(33).ToString();
            text_firstName.Value = "";
            date_DOB.Text = sys_date.ToString("yyyy-MM-dd");
            list_gender.SelectedIndex = -1;
            list_title.SelectedIndex = -1;
            list_maritalStatus.SelectedIndex = -1;
            list_designation.SelectedIndex = -1;

            text_AccountNo.Value = "";
            //attdanceAllowances.Text = reader[43] + "";
            list_bloodGroup.SelectedIndex = -1;
            text_nic.Value = "";
            text_drivingLicence.Value = "";
            list_department.SelectedIndex = -1;
            list_religion.SelectedIndex = -1;
            list_nationality.SelectedIndex = -1;
            list_race.SelectedIndex = -1;

            list_shiftBlock.SelectedIndex = -1;
            ////  fixallowances.Text = reader.GetString(18);
            date_DOA.Text = sys_date.ToString("yyyy-MM-dd");
            text_address.Text = "";
            text_contactNo.Value = "";
            text_mobileNo.Value = "";
            //checkBoxPaySlip.Checked = reader.GetBoolean(58);

            text_attendanceID.Value = "";
            text_basic.Value = "";
            ////  holidayEpf.Checked = reader.GetBoolean(38);
            ////maxOtHour.Text = reader[39].ToString();
            text_budgetary.Value = "";
            text_epfNo.Value = "";
            text_fixedAllowances.Value = "";
            text_mealAllowances.Value = "";
            text_specialAllowances.Value = "";
            text_theaterAllowances.Value = "";
            text_icuAllowances.Value = "";
            text_transportAllowances.Value = "";
            text_allowances2.Value = "";
            text_accommodationAllowances.Value = "";
            text_fuelAllowances.Value = "";
            time_deafultRosterFirstShiftInTime.Text = TimeSpan.Parse("00:00").ToString("hh\\:mm");
            list_defaultRoasterFirstShiftInDate.SelectedIndex = -1;
            time_deafultRosterFirstShiftOutTime.Text = TimeSpan.Parse("00:00").ToString("hh\\:mm");
            list_defaultRoasterFirstShiftOutDate.SelectedIndex = -1;
            time_deafultRosterSecondShiftInTime.Text = TimeSpan.Parse("00:00").ToString("hh\\:mm");
            list_deafultRosterSecondShiftInDate.SelectedIndex = -1;
            time_deafultRosterSecondShiftOutTime.Text = TimeSpan.Parse("00:00").ToString("hh\\:mm");
            list_deafultRosterSecondShiftOutDate.SelectedIndex = -1;
            check_leaveExtra06Hours.Checked = false;
            check_leaveExtra06Hourshalf.Checked = false;
            check_leaveExtra08Hours.Checked = false;
            check_leaveExtra08HoursHalf.Checked = false;

            text_empNo.Text = "";
            text_epfNoSearch.Text = "";
            text_employee.Text = "";
        }

        Int32 empIDDB;
        void getEmpID()
        {
            try
            {
                conn.Open();
                reader = new SqlCommand("select max(id) from emp", conn).ExecuteReader();
                if (reader.Read())
                {
                    empIDDB = reader.GetInt32(0);
                }
                conn.Close();
                empIDDB++;
                empNO = empIDDB + "";
            }
            catch (Exception)
            {
                conn.Close();
                empIDDB = 1;
                empNO = empIDDB + "";
            }
        }

        protected void btn_sendweblogin_Click(object sender, EventArgs e)
        {
            if (text_epfNoSearch.Text.ToString().Equals(""))
            {
                Response.Write("<script>alert('Please Select Employee First')</script>");
            }
            else
            {
                db db = new db();
                conn.Open();
                reader = new SqlCommand("select id,title,firstname,mobileNumber from emp where epfno='" + text_epfNoSearch.Text+"'",conn).ExecuteReader();
                if (reader.Read())
                {
                    
                    var temp = "http://geryjdakdai-001-site9.atempurl.com/login.aspx?userid=" + reader[0].ToString() + "";
                    var body = "Hello " + reader[1] + " " + reader[2] + ", Your Web Login For the HRIS System Here. Thank You, " + "Open it here: " + temp + "";

                    conn2.Open();
                    new SqlCommand("insert into sms_queue values ('" + reader[0] + "','" + reader[3] + "','" + body + "','" + db.getSysDateTime() + "','" + "-" + "','" + "-" + "','" + false + "','" + false + "','" + db.getSysDateTime() + "','" + db.getSysDateTime() + "','" + "" + "')", conn2).ExecuteNonQuery();
                    conn2.Close();

                    Response.Write("<script>alert('Web Login Successfully Send')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Invalied Employee')</script>");
                }
                conn.Close();
            }
               
        }

        protected void btn_loadEmployeeDetail_Click(object sender, EventArgs e)
        {
            btn_loadEmployee_Click(null, null);
            Session["empNo"] = "";
            text_epfNo.Value = "";
            text_attendanceID.Value = "";
        }
    }
}
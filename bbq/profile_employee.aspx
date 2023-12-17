<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile_employee.aspx.cs" MaintainScrollPositionOnPostback="true" Inherits="bbq.profile_employee" EnableEventValidation="false" %>

<!DOCTYPE html>
<head>
    <title>HRIS</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" id="theme" href="css/theme-default.css" />

    <link href="jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="jquery-ui.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/bootstrap-min.js"></script>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script>
        document.addEventListener("keydown", function (event) {
            if (event.key === "Enter") {
                event.preventDefault();
            }
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            SearchText();
        });
        window.onpopstate = function (event) {
            // Clear the session variable using AJAX or other client-side techniques
            // For example, using AJAX with jQuery:
            $.ajax({
                url: 'ClearSession.aspx', // Replace with the actual URL or endpoint to clear the session variable
                method: 'POST',
                data: { variable: 'userID' }, // Replace 'userID' with the session variable you want to clear
                success: function (response) {
                    // Session variable cleared successfully
                },
                error: function (xhr, status, error) {
                    // Handle error if any
                }
            });
        };
        function SearchText() {

            $("#text_employee").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "profile_employee.aspx/getEmployee",
                        data: "{'empName':'" + document.getElementById('text_employee').value + "'}",
                        dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                },
                focus: function (event, ui) {

                    return false; // prevent the default behavior of the focus event
                },
                select: function (event, ui) {

                    $.ajax({
                        type: "POST",
                        url: "profile_employee.aspx/employeeSelected",
                        data: "{'empName':'" + ui.item.value + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var result = data.d
                            var result_name = result.split('_')[0]
                            var result_epf = result.split('_')[1]
                            var result_empno = result.split('_')[2]
                            document.getElementById('text_employee').value = result_name
                            document.getElementById('text_epfNoSearch').value = result_epf
                            document.getElementById('text_empNo').value = result_empno
                        },
                        error: function (result) {
                            // Handle the error
                        }
                    });
                }
            });
        }
    </script>

</head>
<body>
    <!-- START PAGE CONTAINER -->
    <form runat="server">
        <div class="page-container">

            <!-- START PAGE SIDEBAR -->
            <div class="page-sidebar">
                <!-- START X-NAVIGATION -->
                <ul class="x-navigation">
                    <li class="xn-logo">
                        <a href="index.html">HRIS</a>
                        <a href="#" class="x-navigation-control"></a>
                    </li>
                    <li class="xn-profile">
                        <a href="#" class="profile-mini">
                            <img src="assets/images/users/avatar.jpg" alt="John Doe" />
                        </a>
                        <div class="profile">
                            <div class="profile-image">
                                <img src="assets/images/users/avatar.jpg" alt="John Doe" />
                            </div>
                            <div class="profile-data">
                                <div class="profile-data-name">Sadali Perera</div>
                                <div class="profile-data-title">HR Admin</div>
                            </div>
                            <div class="profile-controls">
                                <a href="pages-profile.html" class="profile-control-left"><span class="fa fa-info"></span></a>
                                <a href="pages-messages.html" class="profile-control-right"><span class="fa fa-envelope"></span></a>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="home.aspx"><span class="fa fa-desktop"></span><span class="xn-text">Dashboard</span></a>
                    </li>
                    <li class="xn-openable active">
                        <a href="#"><span class="fa fa-files-o"></span><span class="xn-text">Profiles</span></a>
                        <ul>
                            <li class="active"><a href="profile_employee.aspx"><span class="fa fa-image"></span>Employee Master</a></li>

                        </ul>
                    </li>
                    <li>
                        <a href="payroll.aspx"><span class="fa fa-file-text-o"></span><span class="xn-text">Payroll</span></a>

                    </li>
                    <li class="xn-openable">
                        <a href="#"><span class="fa fa-file-text-o"></span><span class="xn-text">Time & Attendance</span></a>
                        <ul>
                            <li><a href="attendance.aspx"><span class="fa fa-heart"></span>Attendance</a></li>
                            <li><a href="roaster.aspx"><span class="fa fa-cogs"></span>Roaster</a></li>
                        </ul>
                    </li>
                    <li class="xn-openable">
                        <a href="#"><span class="fa fa-cogs"></span><span class="xn-text">On-Going Function</span></a>
                        <ul>
                            <li><a href="deduction.aspx"><span class="fa fa-heart"></span>Deductions & Allowances</a></li>
                            <li><a href="leave.aspx"><span class="fa fa-square-o"></span>Leave</a></li>

                        </ul>
                    </li>
                    <li class="xn-openable">
                        <a href="#"><span class="fa fa-pencil"></span><span class="xn-text">Reports</span></a>
                        <ul>
                            <li><a href="report_salary_summary.aspx"><span class="fa fa-file-text-o"></span>Salary Summary (Employee)</a></li>
                            <li><a href="advance_reports.aspx"><span class="fa fa-file-text-o"></span>Other Reports</a></li>
                        </ul>
                    </li>
                    <li class="xn-openable">
                        <a href="#"><span class="fa fa-table"></span><span class="xn-text">Settings</span></a>
                        <ul>
                            <li><a href="settings_.aspx"><span class="fa fa-align-justify"></span>Settings</a></li>
                        </ul>
                    </li>


                </ul>
                <!-- END X-NAVIGATION -->
            </div>
            <!-- END PAGE SIDEBAR -->

            <!-- PAGE CONTENT -->
            <div class="page-content">

                <!-- START X-NAVIGATION VERTICAL -->
                <ul class="x-navigation x-navigation-horizontal x-navigation-panel">
                    <!-- TOGGLE NAVIGATION -->
                    <li class="xn-icon-button">
                        <a href="#" class="x-navigation-minimize"><span class="fa fa-dedent"></span></a>
                    </li>
                    <!-- END TOGGLE NAVIGATION -->
                    <!-- SEARCH -->
                    <li class="xn-search">
                        <form role="form">
                            <input type="text" name="search" placeholder="Search..." />
                        </form>
                    </li>
                    <!-- END SEARCH -->
                    <!-- SIGN OUT -->
                    <li class="xn-icon-button pull-right">
                        <a href="#" class="mb-control" data-box="#mb-signout"><span class="fa fa-sign-out"></span></a>
                    </li>
                    <!-- END SIGN OUT -->
                    <!-- MESSAGES -->
                    <li class="xn-icon-button pull-right"></li>
                    <!-- END MESSAGES -->
                    <!-- TASKS -->
                    <li class="xn-icon-button pull-right"></li>
                    <!-- END TASKS -->
                </ul>
                <!-- END X-NAVIGATION VERTICAL -->

                <!-- START BREADCRUMB -->
                <ul class="breadcrumb">
                    <li><a href="#">Home</a></li>
                    <li class="active">Dashboard</li>
                </ul>
                <!-- END BREADCRUMB -->

                <!-- PAGE CONTENT WRAPPER -->
                <div class="page-content-wrap">

                    <div class="row">
                        <div class="col-md-12">

                            <div class="block">

                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <label class="control-label">EPF No</label>
                                        <asp:TextBox ID="text_epfNoSearch" runat="server" CssClass="form-control" Placeholder="001"> </asp:TextBox>
                                    </div>

                                </div>
                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <label class="control-label">Employee No</label>
                                        <asp:TextBox ID="text_empNo" runat="server" CssClass="form-control" Placeholder="001"> </asp:TextBox>
                                    </div>

                                </div>
                                <div class="col-md-6">
                                    <div class="form-group has-success">
                                        <label class="control-label">Employee Name</label>
                                        <asp:TextBox ID="text_employee" runat="server" CssClass="form-control" Placeholder="Search Employee here...."> </asp:TextBox>
                                    </div>

                                </div>
                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <label class="control-label" style="color: white">.</label>
                                        <asp:Button CssClass="form-control" runat="server" ID="btn_loadEmployee" Text="LOAD" BackColor="#ff9900" ForeColor="White" Font-Bold="true" OnClick="btn_loadEmployee_Click" />
                                    </div>

                                </div>

                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <label class="control-label" style="color: white">.</label>
                                        <asp:Button CssClass="form-control" runat="server" ID="btn_clear" Text="CLEAR" BackColor="#339933" ForeColor="White" Font-Bold="true" OnClick="btn_clear_Click" />
                                    </div>

                                </div>
                                <div class="col-md-2">
                                    <div class="form-group has-success">
                                        <label class="control-label" style="color: white">.</label>
                                        <asp:Button CssClass="form-control" runat="server" ID="btn_sendweblogin" Text="SEND WEB LOGIN" BackColor="Salmon" ForeColor="White" Font-Bold="true" OnClick="btn_sendweblogin_Click" />
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">

                            <panel class="form-horizontal">

                                <div class="panel panel-default tabs">
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li class="active"><a href="#tab-first" role="tab" data-toggle="tab">Personal Data</a></li>
                                        <li><a href="#tab-second" role="tab" data-toggle="tab">Payroll Data</a></li>
                                        <li><a href="#tab-third" role="tab" data-toggle="tab">Bank Detail's</a></li>
                                        <li><a href="#tab-four" role="tab" data-toggle="tab">Roaster Detail's</a></li>
                                        <li><a href="#tab-five" role="tab" data-toggle="tab">Qulification</a></li>
                                        <li><a href="#tab-six" role="tab" data-toggle="tab">Experience</a></li>
                                        <li><a href="#tab-seven" role="tab" data-toggle="tab">Emergency Contact</a></li>
                                    </ul>
                                    <div class="panel-body tab-content">
                                        <div class="tab-pane active" id="tab-first">
                                            <p style="color: #ff6a00">This information is collected and maintained by the employer for various purposes, including payroll, benefits administration, and compliance with legal and regulatory requirements. In some cases, personal data may also include sensitive information such as medical information, criminal history, and financial information. It's important that the employer handle this data with care, and ensure it is kept confidential and secure.</p>

                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Title *</label>
                                                        <div class="col-md-2">
                                                            <select class="form-control" id="list_title" runat="server">
                                                                <option></option>
                                                                <option>Mr.</option>
                                                                <option>Mrs.</option>
                                                                <option>Ms.</option>
                                                                <option>Miss.</option>
                                                                <option>Dr.</option>
                                                                <option>Madam.</option>
                                                                <option>Professor.</option>
                                                            </select>
                                                        </div>

                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">initial *</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_initial" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">First Name *</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_firstName_" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Full Name *</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_LastName" runat="server" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">System Name </label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_firstName" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label">DOB *</label>
                                                        <div class="col-md-3">

                                                            <asp:TextBox ID="date_DOB" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Gender *</label>
                                                        <div class="col-md-2">
                                                            <select class="form-control" id="list_gender" runat="server">
                                                                <option></option>
                                                                <option>Male</option>
                                                                <option>FeMale</option>
                                                                <option>Other</option>

                                                            </select>
                                                        </div>

                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">NIC *</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_nic" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">

                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Marital Status</label>
                                                        <div class="col-md-3">
                                                            <select class="form-control" id="list_maritalStatus" runat="server">
                                                                <option></option>
                                                                <option>Single</option>
                                                                <option>Married</option>
                                                                <option>Divocerd</option>
                                                                <option>Other</option>
                                                            </select>
                                                        </div>

                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Blood Group</label>
                                                        <div class="col-md-3">
                                                            <select class="form-control" id="list_bloodGroup" runat="server">
                                                                <option></option>
                                                                <option>A+</option>
                                                                <option>A-</option>
                                                                <option>B+</option>
                                                                <option>B-</option>
                                                                <option>AB+</option>
                                                                <option>AB-</option>
                                                                <option>O+</option>
                                                                <option>O-</option>
                                                            </select>
                                                        </div>

                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Driving Licence No</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_drivingLicence" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Religion</label>
                                                        <div class="col-md-3">
                                                            <select class="form-control" id="list_religion" runat="server">
                                                                <option></option>
                                                                <option>Buddhism</option>
                                                                <option>Burgher</option>
                                                                <option>Chirstian</option>
                                                                <option>Hindu</option>
                                                                <option>Islam</option>
                                                                <option>Roman Catholic</option>
                                                                <option>Other</option>
                                                            </select>
                                                        </div>

                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Nationality</label>
                                                        <div class="col-md-3">
                                                            <select class="form-control" id="list_nationality" runat="server">
                                                                <option></option>
                                                                <option>Sri Lankan</option>
                                                                <option>Indian</option>
                                                                <option>Other</option>
                                                            </select>
                                                        </div>

                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Race</label>
                                                        <div class="col-md-3">
                                                            <select class="form-control" id="list_race" runat="server">
                                                                <option></option>
                                                                <option>Sinhalese</option>
                                                                <option>Thamil</option>
                                                                <option>Burgher</option>
                                                                <option>Other</option>
                                                            </select>
                                                        </div>

                                                    </div>
                                                </div>
                                                <br />
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Mobile Number</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_mobileNo" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Land Number</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_landNo" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Payslip Send Number</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_contactNo" runat="server" title="" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Residental Address</label>
                                                        <div class="col-md-8 col-xs-12">
                                                            <asp:TextBox ID="text_address" runat="server" Class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Permanet Address</label>
                                                        <div class="col-md-8 col-xs-12">
                                                            <asp:TextBox ID="text_address2" runat="server" Class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="panel-footer">
                                                <asp:Button ID="btn_save" class="btn btn-primary pull-right" Text="Save Changes" runat="server" OnClick="btn_save_Click" />
                                            </div>

                                        </div>
                                        <div class="tab-pane" id="tab-second">
                                            <p style="color: #ff6a00">This information is used by the employer to calculate and process an employee's wages, taxes, and other deductions. It may also be used to generate reports and records for compliance with legal and regulatory requirements.</p>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Company</label>
                                                        <div class="col-md-6 col-xs-12">

                                                            <asp:DropDownList CssClass="form-control" ID="list_company" runat="server" AutoPostBack="false">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Designation </label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <asp:DropDownList CssClass="form-control" ID="list_designation" runat="server" AutoPostBack="false">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Department </label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <asp:DropDownList CssClass="form-control" ID="list_department" runat="server" AutoPostBack="false">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Shift Block</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <asp:DropDownList CssClass="form-control" ID="list_shiftBlock" runat="server" AutoPostBack="false">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Date of Appointment</label>
                                                        <div class="col-md-4 col-xs-12">
                                                            <asp:TextBox ID="date_DOA" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
                                                        </div>

                                                    </div>

                                                </div>
                                                <div class="col-md-6">

                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Basic Salary</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_basic" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Budgetary Allowance</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_budgetary" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Attendance Allowance</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_attendance" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Attendance ID</label>
                                                        <div class="col-md-2">
                                                            <input type="text" class="form-control" value="" id="text_attendanceID" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label">EPF Pay</label>
                                                        <div class="col-md-9">
                                                            <label class="check">
                                                                <asp:CheckBox ID="check_epfPay" Text="" runat="server" />
                                                            </label>

                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">EPF No</label>
                                                        <div class="col-md-2">
                                                            <input type="text" class="form-control" value="" runat="server" id="text_epfNo" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label">Resigned</label>
                                                        <div class="col-md-9">
                                                            <label class="check">
                                                                <asp:CheckBox ID="check_resgined" Text="" runat="server" />
                                                            </label>

                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Resigned Date</label>
                                                        <div class="col-md-4">
                                                            <asp:TextBox ID="date_resginedDate" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label">No Attendance</label>
                                                        <div class="col-md-9">
                                                            <label class="check">
                                                                <asp:CheckBox ID="check_blocked" Text="" runat="server" />
                                                            </label>

                                                        </div>
                                                    </div>
                                                    <div class="panel-body">
                                                        <p style="color: coral">Fixed Allowances</p>
                                                        <div class="form-group">
                                                            <label class="col-md-3 col-xs-12 control-label">Fixed Allowance</label>
                                                            <div class="col-md-6 col-xs-12">
                                                                <input type="text" class="form-control" value="" id="text_fixedAllowances" runat="server" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-md-3 col-xs-12 control-label">Meal Allowance</label>
                                                            <div class="col-md-6 col-xs-12">
                                                                <input type="text" class="form-control" value="" id="text_mealAllowances" runat="server" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-md-3 col-xs-12 control-label">Speacil Allowance</label>
                                                            <div class="col-md-6 col-xs-12">
                                                                <input type="text" class="form-control" value="" id="text_specialAllowances" runat="server" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-md-3 col-xs-12 control-label">Theater Allwoance</label>
                                                            <div class="col-md-6 col-xs-12">
                                                                <input type="text" class="form-control" value="" id="text_theaterAllowances" runat="server" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-md-3 col-xs-12 control-label">ICU Allowance</label>
                                                            <div class="col-md-6 col-xs-12">
                                                                <input type="text" class="form-control" value="" id="text_icuAllowances" runat="server" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-md-3 col-xs-12 control-label">Transport Allowance</label>
                                                            <div class="col-md-6 col-xs-12">
                                                                <input type="text" class="form-control" value="" id="text_transportAllowances" runat="server" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-md-3 col-xs-12 control-label">Accommodation Alowance </label>
                                                            <div class="col-md-6 col-xs-12">
                                                                <input type="text" class="form-control" value="" id="text_accommodationAllowances" runat="server" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-md-3 col-xs-12 control-label">Fuel Allowance</label>
                                                            <div class="col-md-6 col-xs-12">
                                                                <input type="text" class="form-control" value="" id="text_fuelAllowances" runat="server" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-md-3 col-xs-12 control-label">Allowances 02</label>
                                                            <div class="col-md-6 col-xs-12">
                                                                <input type="text" class="form-control" value="" id="text_allowances2" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>


                                            <div class="panel-footer">
                                                <asp:Button ID="Button1" class="btn btn-primary pull-right" Text="Save Changes" runat="server" OnClick="btn_save_Click" />
                                            </div>

                                        </div>
                                        <div class="tab-pane" id="tab-third">

                                            <div class="form-group" style="color: coral">
                                                <label class="col-md-3 col-xs-12 control-label">Cash Pay</label>
                                                <asp:RadioButton ID="radio_cashPay" Checked="true" class="form-control" runat="server" GroupName="bankpay" />
                                                <label class="col-md-3 col-xs-12 control-label">Bank Pay</label>
                                                <asp:RadioButton ID="radio_bankPay" class="form-control" runat="server" GroupName="bankpay" />
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Account No</label>
                                                <div class="col-md-2 col-xs-12">
                                                    <input type="text" class="form-control" id="text_AccountNo" runat="server" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Bank Code</label>
                                                <div class="col-md-2 col-xs-12">
                                                    <input type="text" class="form-control" id="text_bankCode" runat="server" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Branch Code</label>
                                                <div class="col-md-2 col-xs-12">
                                                    <input type="text" class="form-control" id="text_branchCode" runat="server" />
                                                </div>
                                            </div>
                                            <div class="panel-footer">
                                                <asp:Button ID="Button3" class="btn btn-primary pull-right" Text="Save Changes" runat="server" OnClick="btn_save_Click" />
                                            </div>


                                        </div>
                                        <div class="tab-pane" id="tab-four">
                                            <asp:CheckBox ID="check_defaultRoaster" Text="Default Roaster" runat="server" />
                                            <br />
                                            <br />
                                            <asp:Panel ID="panel_defaultRoaster" runat="server">
                                                <div class="col-md-6">

                                                    <p style="color: orange">First Shift</p>
                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">In Time</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <asp:TextBox ID="time_deafultRosterFirstShiftInTime" runat="server" TextMode="Time"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">In Date</label>
                                                        <div class="col-md-2 col-xs-12">
                                                            <select class="form-control" id="list_defaultRoasterFirstShiftInDate" runat="server">
                                                                <option></option>
                                                                <option>A</option>
                                                                <option>B</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <br />
                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Out Time</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <asp:TextBox ID="time_deafultRosterFirstShiftOutTime" runat="server" TextMode="Time"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Out Date</label>
                                                        <div class="col-md-2 col-xs-12">
                                                            <select class="form-control" id="list_defaultRoasterFirstShiftOutDate" runat="server">
                                                                <option></option>
                                                                <option>A</option>
                                                                <option>B</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="col-md-6">

                                                    <p style="color: orange">Second Shift</p>
                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">In Time</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <asp:TextBox ID="time_deafultRosterSecondShiftInTime" runat="server" TextMode="Time"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">In Date</label>
                                                        <div class="col-md-2 col-xs-12">
                                                            <select class="form-control" id="list_deafultRosterSecondShiftInDate" runat="server">
                                                                <option></option>
                                                                <option>A</option>
                                                                <option>B</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <br />
                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Out Time</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <asp:TextBox ID="time_deafultRosterSecondShiftOutTime" runat="server" TextMode="Time"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Out Date</label>
                                                        <div class="col-md-2 col-xs-12">
                                                            <select class="form-control" id="list_deafultRosterSecondShiftOutDate" runat="server">
                                                                <option></option>
                                                                <option>A</option>
                                                                <option>B</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                </div>
                                            </asp:Panel>
                                            <br />
                                            <br />
                                            <div class="col-md-6">
                                                <br />
                                                <br />

                                                <div class="form-group">
                                                    <div class="col-md-2 col-xs-12">
                                                        <asp:RadioButton ID="radio_otCircleDayBased" runat="server" Text="OT CIRCLE TO DAY BASED" GroupName="otcircle"></asp:RadioButton>

                                                    </div>
                                                    <div class="col-md-2 col-xs-12">
                                                        <asp:RadioButton ID="radio_otCircle180Hours" runat="server" Text="OT CIRCLE 180 HOURS BASED" GroupName="otcircle"></asp:RadioButton>

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-10 col-xs-12">
                                                        <asp:CheckBox ID="check_leaveExtra06Hours" Text="LEAVE EXTRA 06 HOURS" runat="server" />

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-10 col-xs-12">
                                                        <asp:CheckBox ID="check_leaveExtra06Hourshalf" Text="LEAVE EXTRA 06 HOURS  HALF ( 03 HOURS )" runat="server" />

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-10 col-xs-12">
                                                        <asp:CheckBox ID="check_leaveExtra08Hours" Text="LEAVE EXTRA 08 HOURS" runat="server" />

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-md-10 col-xs-12">
                                                        <asp:CheckBox ID="check_leaveExtra08HoursHalf" Text="LEAVE EXTRA 08 HOURS  HALF ( 04 HOURS )" runat="server" />

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="panel-footer">
                                                <asp:Button ID="Button4" class="btn btn-primary pull-right" Text="Save Changes" runat="server" OnClick="btn_save_Click" />
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="tab-five">

                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Qulification Name</label>
                                                <div class="col-md-6 col-xs-12">
                                                    <input type="text" class="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Institute Name</label>
                                                <div class="col-md-6 col-xs-12">
                                                    <input type="text" class="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Year</label>
                                                <div class="col-md-2 col-xs-12">
                                                    <input type="text" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Month</label>
                                                <div class="col-md-2 col-xs-12">
                                                    <input type="text" class="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Descrption</label>
                                                <div class="col-md-6 col-xs-12">
                                                    <textarea class="form-control" rows="5"></textarea>
                                                </div>
                                            </div>
                                            <div class="panel-footer">
                                                <asp:Button ID="Button2" class="btn btn-primary pull-right" Text="Save Changes" runat="server" OnClick="btn_save_Click" />
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">

                                                    <!-- START TIMELINE -->
                                                    <div class="timeline">

                                                        <!-- START TIMELINE ITEM -->
                                                        <div class="timeline-item timeline-main">
                                                            <div class="timeline-date">2021</div>
                                                        </div>
                                                        <!-- END TIMELINE ITEM -->

                                                        <!-- START TIMELINE ITEM -->
                                                        <div class="timeline-item">
                                                            <div class="timeline-item-info">2021 March</div>
                                                            <div class="timeline-item-icon"><span class="fa fa-globe"></span></div>
                                                            <div class="timeline-item-content">
                                                                <div class="timeline-heading">
                                                                    <img src="assets/images/users/nibm.png" />
                                                                    <a href="#">Diploma in Hardware & Networking </a>in <a href="#">NIBM</a>
                                                                </div>
                                                                <div class="timeline-body">

                                                                    <p>Identify Hardware Components</p>
                                                                    <p>Motherboard Components & Bus Architecture</p>
                                                                    <p>The CPU Evolution & Architecture</p>
                                                                    <p>Assembling and Disassembling of different types of PCs different types of Expansion cards</p>
                                                                    <p>Preparing the hard disk drive to install system software</p>
                                                                    <p>Installing and configuring Windows XP, Windows 2008, Windows 7 & Linux</p>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <!-- END TIMELINE ITEM -->

                                                        <!-- START TIMELINE ITEM -->
                                                        <div class="timeline-item timeline-item-right">
                                                            <div class="timeline-item-info">2019 Jan</div>
                                                            <div class="timeline-item-icon"><span class="fa fa-image"></span></div>
                                                            <div class="timeline-item-content">
                                                                <div class="timeline-heading">
                                                                    <img src="assets/images/users/ucsc.png" />
                                                                    <a href="#">Certificate in Office Package </a>in <a href="#">Univercity of Colombo</a>

                                                                </div>

                                                                <div class="timeline-body">

                                                                    <p>Identify Hardware Components</p>
                                                                    <p>Motherboard Components & Bus Architecture</p>
                                                                    <p>The CPU Evolution & Architecture</p>
                                                                    <p>Assembling and Disassembling of different types of PCs different types of Expansion cards</p>
                                                                    <p>Preparing the hard disk drive to install system software</p>
                                                                    <p>Installing and configuring Windows XP, Windows 2008, Windows 7 & Linux</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- END TIMELINE ITEM -->

                                                        <!-- START TIMELINE ITEM -->
                                                        <div class="timeline-item">
                                                            <div class="timeline-item-info">2017 Decmber</div>
                                                            <div class="timeline-item-icon"><span class="fa fa-star"></span></div>
                                                            <div class="timeline-item-content">
                                                                <div class="timeline-heading" style="padding-bottom: 10px;">
                                                                    <img src="assets/images/users/wijaya.png" />
                                                                    <a href="#">Certificate in Graphic Desiging</a> in <a href="#">Wijaya Graphic Center</a>
                                                                </div>
                                                                <div class="timeline-body">

                                                                    <p>Identify Hardware Components</p>
                                                                    <p>Motherboard Components & Bus Architecture</p>
                                                                    <p>The CPU Evolution & Architecture</p>
                                                                    <p>Assembling and Disassembling of different types of PCs different types of Expansion cards</p>
                                                                    <p>Preparing the hard disk drive to install system software</p>
                                                                    <p>Installing and configuring Windows XP, Windows 2008, Windows 7 & Linux</p>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <!-- END TIMELINE ITEM -->
                                                        <!-- START TIMELINE ITEM -->
                                                        <div class="timeline-item timeline-item-right">
                                                            <div class="timeline-item-info">2015 Jan</div>
                                                            <div class="timeline-item-icon"><span class="fa fa-image"></span></div>
                                                            <div class="timeline-item-content">
                                                                <div class="timeline-heading">
                                                                    <img src="assets/images/users/ucsc.png" />
                                                                    <a href="#">Certificate in Office Package </a>in <a href="#">Univercity of Colombo</a>

                                                                </div>

                                                                <div class="timeline-body">

                                                                    <p>Identify Hardware Components</p>
                                                                    <p>Motherboard Components & Bus Architecture</p>
                                                                    <p>The CPU Evolution & Architecture</p>
                                                                    <p>Assembling and Disassembling of different types of PCs different types of Expansion cards</p>
                                                                    <p>Preparing the hard disk drive to install system software</p>
                                                                    <p>Installing and configuring Windows XP, Windows 2008, Windows 7 & Linux</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- END TIMELINE ITEM -->









                                                    </div>
                                                    <!-- END TIMELINE -->

                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="tab-six">

                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Position Name</label>
                                                <div class="col-md-6 col-xs-12">
                                                    <input type="text" class="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Company Name</label>
                                                <div class="col-md-6 col-xs-12">
                                                    <input type="text" class="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">From ( Year/ Month )</label>
                                                <div class="col-md-2 col-xs-12">
                                                    <input type="text" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">To ( Year/ Month )</label>
                                                <div class="col-md-2 col-xs-12">
                                                    <input type="text" class="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">Descrption</label>
                                                <div class="col-md-6 col-xs-12">
                                                    <textarea class="form-control" rows="5"></textarea>
                                                </div>
                                            </div>
                                            <div class="panel-footer">
                                                <asp:Button ID="Button5" class="btn btn-primary pull-right" Text="Save Changes" runat="server" OnClick="btn_save_Click" />
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">

                                                    <!-- START TIMELINE -->
                                                    <div class="timeline">

                                                        <!-- START TIMELINE ITEM -->
                                                        <div class="timeline-item timeline-main">
                                                            <div class="timeline-date">2019</div>
                                                        </div>
                                                        <!-- END TIMELINE ITEM -->

                                                        <!-- START TIMELINE ITEM -->
                                                        <div class="timeline-item">
                                                            <div class="timeline-item-info">2019 Jan - Present</div>
                                                            <div class="timeline-item-icon"><span class="fa fa-globe"></span></div>
                                                            <div class="timeline-item-content">
                                                                <div class="timeline-heading">
                                                                    <img src="assets/images/users/leesons.png" />
                                                                    <a href="#">HR Executive</a> at <a href="#">Harsha Tailors PVT Ltd</a>
                                                                </div>
                                                                <div class="timeline-body">

                                                                    <p>Design compensation and benefits packages</p>
                                                                    <p>Implement performance review procedures</p>
                                                                    <p>Develop fair HR policies and ensure employees understand and comply with them</p>
                                                                    <p>Implement effective sourcing, screening and interviewing techniques</p>
                                                                    <p>Assess training needs and coordinate learning and development initiatives for all employees</p>
                                                                    <p>Monitor HR department’s budget</p>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <!-- END TIMELINE ITEM -->

                                                        <!-- START TIMELINE ITEM -->
                                                        <div class="timeline-item timeline-item-right">
                                                            <div class="timeline-item-info">2015 Jan - 2019 Jan</div>
                                                            <div class="timeline-item-icon"><span class="fa fa-image"></span></div>
                                                            <div class="timeline-item-content">
                                                                <div class="timeline-heading">
                                                                    <img src="assets/images/users/microimage.png" />
                                                                    <a href="#">HR Assistant </a>at <a href="#">HCM MicroImage PVT Ltd</a>

                                                                </div>

                                                                <div class="timeline-body">

                                                                    <p>Manage employees’ grievances</p>
                                                                    <p>Create and run referral bonus programs</p>
                                                                    <p>Review current HR technology and recommend more effective software (including HRIS and ATS)</p>
                                                                    <p>Measure employee retention and turnover rates</p>
                                                                    <p>Oversee daily operations of the HR department</p>
                                                                    <p>Assist with the recruitment process by identifying candidates, performing reference checks, and issuing employment contracts.</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- END TIMELINE ITEM -->

                                                        <!-- START TIMELINE ITEM -->
                                                        <div class="timeline-item">
                                                            <div class="timeline-item-info">2012 August - 2014 July</div>
                                                            <div class="timeline-item-icon"><span class="fa fa-star"></span></div>
                                                            <div class="timeline-item-content">
                                                                <div class="timeline-heading" style="padding-bottom: 10px;">
                                                                    <img src="assets/images/users/javasolution.png" />
                                                                    <a href="#">Internship in HR Assistant </a>at <a href="#">Java Solution PVt Ltd</a>
                                                                </div>
                                                                <div class="timeline-body">

                                                                    <p>Updating company databases by inputting new employee contact information and employment details.</p>
                                                                    <p>Screening potential employees' resumes and application forms to identify suitable candidates to fill company job vacancies.</p>
                                                                    <p>Organizing interviews with shortlisted candidates.</p>
                                                                    <p>Posting job advertisements to job boards and social media platforms.</p>
                                                                    <p>Removing job advertisements from job boards and social media platforms once vacancies have been filled.</p>
                                                                    <p>Assisting the HR staff in gathering market salary information.</p>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <!-- END TIMELINE ITEM -->

                                                    </div>
                                                    <!-- END TIMELINE -->

                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="tab-seven">

                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Contact Person</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_emContactPerson" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Contact Number</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_emContactNumber" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Adress</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_emAddress" runat="server" title="" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Relationship</label>
                                                        <div class="col-md-8 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_emRelationship" runat="server" title="" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="panel-footer">
                                                <asp:Button ID="Button6" class="btn btn-primary pull-right" Text="Save Changes" runat="server" OnClick="btn_save_Click" />
                                            </div>

                                        </div>

                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group has-success">
                                        <label class="control-label" style="color: white">.</label>
                                        <asp:Button CssClass="form-control" runat="server" ID="btn_loadEmployeeDetail" Text="LOAD DETAIL ONLY" BackColor="CadetBlue" ForeColor="White" Font-Bold="true" OnClick="btn_loadEmployeeDetail_Click" />
                                    </div>

                                </div>
                            </panel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>


    <!-- MESSAGE BOX-->
    <div class="message-box animated fadeIn" data-sound="alert" id="mb-signout">
        <div class="mb-container">
            <div class="mb-middle">
                <div class="mb-title"><span class="fa fa-sign-out"></span>Log <strong>Out</strong> ?</div>
                <div class="mb-content">
                    <p>Are you sure you want to log out?</p>
                    <p>Press No if youwant to continue work. Press Yes to logout current user.</p>
                </div>
                <div class="mb-footer">
                    <div class="pull-right">
                        <a href="pages-login.html" class="btn btn-success btn-lg">Yes</a>
                        <button class="btn btn-default btn-lg mb-control-close">No</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <audio id="audio-alert" src="audio/alert.mp3" preload="auto"></audio>
    <audio id="audio-fail" src="audio/fail.mp3" preload="auto"></audio>
    <!-- END PRELOADS -->

    <!-- START SCRIPTS -->
    <!-- START PLUGINS -->
    <!-- END PLUGINS -->

    <!-- START THIS PAGE PLUGINS-->
    <script type='text/javascript' src='js/plugins/icheck/icheck.min.js'></script>
    <script type="text/javascript" src="js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>
    <script type="text/javascript" src="js/plugins/scrolltotop/scrolltopcontrol.js"></script>

    <script type="text/javascript" src="js/plugins/morris/raphael-min.js"></script>
    <script type="text/javascript" src="js/plugins/morris/morris.min.js"></script>
    <script type="text/javascript" src="js/plugins/rickshaw/d3.v3.js"></script>
    <script type="text/javascript" src="js/plugins/rickshaw/rickshaw.min.js"></script>
    <script type='text/javascript' src='js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js'></script>
    <script type='text/javascript' src='js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js'></script>
    <script type='text/javascript' src='js/plugins/bootstrap/bootstrap-datepicker.js'></script>
    <script type="text/javascript" src="js/plugins/owl/owl.carousel.min.js"></script>

    <script type="text/javascript" src="js/plugins/moment.min.js"></script>
    <script type="text/javascript" src="js/plugins/daterangepicker/daterangepicker.js"></script>
    <!-- END THIS PAGE PLUGINS-->

    <!-- START TEMPLATE -->
    <script type="text/javascript" src="js/settings.js"></script>

    <script type="text/javascript" src="js/plugins.js"></script>
    <script type="text/javascript" src="js/actions.js"></script>
    <script type="text/javascript" src="js/demo_charts_morris.js"></script>
    <script type="text/javascript" src="js/demo_dashboard.js"></script>

</body>


﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="payroll.aspx.cs" Inherits="bbq.payroll" %>


<!DOCTYPE html>

<html lang="en">
<head>
    <title>HRIS</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <!-- END META SECTION -->
    <link rel="stylesheet" type="text/css" id="theme" href="css/theme-default.css" />

    <link href="jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="css/styleloading.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/bootstrap-min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript">

        function myMethod4() {

            if (document.getElementById('text_epfNo_').value != '' || document.getElementById('text_attendanceId').value != '') {


                $.ajax({
                    url: "http://geryjdakdai-001-site12.atempurl.com/api/ProcessSalary/getProcessQueueTimesheetUser?empname=" + document.getElementById('text_epfNo_').value + "&empid=" + document.getElementById('text_attendanceId').value,
                    success: function (data) {
                        const label = document.getElementById("label_status");
                        const label2 = document.getElementById("label_status2");

                        label.innerHTML = "Process Completed";
                        label.style.color = "blue";
                        label2.innerHTML = "Process Completed";
                        label2.style.color = "orange";

                        $.each(data, function (index, value) {

                            if (value.Line == 'Single') {
                                label.innerHTML = "Process Required...";
                                label.style.color = "red";

                            } else if (value.Line == 'Full') {
                                label2.innerHTML = "Full Month Processing....";
                                label2.style.color = "red";

                            }
                        });

                    },
                    complete: function () {
                        $("#loading").css("visibility", "hidden");
                    }
                });

            }
        }
        window.onload = function () {
            myMethod4();
            setInterval(myMethod4, 1000);
        };
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            SearchText();
        });
        function SearchText() {

            $("#text_employee").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "payroll.aspx/getEmployee",
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
                    var result2_ = ui.item.value.split('(')[1];
                    var epfno2_ = result2_.split(',')[0].split('-')[1];
                    $.ajax({
                        beforeSend: function () {
                            $("#loading").css("visibility", "visible");
                        },
                        url: "http://geryjdakdai-001-site12.atempurl.com/api/ProcessSalary/CheckEmployee?epfno=" + epfno2_ + "&period=" + document.getElementById('date_search').value + "/" + document.getElementById('list_month').value + "&empid=" + document.getElementById('text_attendanceId').value,

                        success: function (data) {
                            if (data != 2) {
                                loadPaysheet(ui.item.value)
                            } else if (data == 2) {
                                alert("Selected Employee Processing.......")
                                $("#loading").css("visibility", "hidden");
                                document.getElementById('text_employee').value = ""
                                clear2()
                            }

                        },
                        complete: function () {

                        }
                    });

                }
            });
        }
    </script>
    <script type="text/javascript">
        function clear() {
            document.getElementById('text_department').value = ""
            document.getElementById('text_workDays').value = ""
            document.getElementById('text_nopayDays').value = ""
            document.getElementById('text_basic').value = ""
            document.getElementById('text_budj').value = ""
            document.getElementById('text_totalBasic').value = ""
            document.getElementById('text_salaryForEPF').value = ""
            document.getElementById('text_OT15').value = ""
            document.getElementById('text_OT15Hours').value = ""
            document.getElementById('text_extraOT').value = ""
            document.getElementById('text_extraOTHours').value = ""
            document.getElementById('text_allowICU').value = ""
            document.getElementById('text_allowCases').value = ""
            document.getElementById('text_allowNight').value = ""
            document.getElementById('text_allowFixed').value = ""
            document.getElementById('text_allowMeal').value = ""
            document.getElementById('text_allowSpecial').value = ""
            document.getElementById('text_allowTheater').value = ""
            document.getElementById('text_allowOther').value = ""
            document.getElementById('text_allowPH').value = ""
            document.getElementById('text_allowTransport').value = ""
            document.getElementById('text_allowAccommodation').value = ""
            document.getElementById('text_allowFuel').value = ""
            document.getElementById('text_allowAllowances02').value = ""
            document.getElementById('text_coinBF').value = ""
            document.getElementById('text_totalEarning').value = ""
            document.getElementById('text_payCut').value = ""
            document.getElementById('text_payCutHours').value = ""
            document.getElementById('text_noPay').value = ""
            document.getElementById('text_epf8').value = ""
            document.getElementById('text_deduAdvanced').value = ""
            document.getElementById('text_deduPayee').value = ""
            document.getElementById('text_deduOther').value = ""
            document.getElementById('text_deduRDB').value = ""
            document.getElementById('text_deduStaff').value = ""
            document.getElementById('text_deduCashShort').value = ""
            document.getElementById('text_coinCF').value = ""
            document.getElementById('text_totalDeduction').value = ""
            document.getElementById('text_grossPayment').value = ""
            document.getElementById('text_netSalary').value = ""
            document.getElementById('text_totalPayble').value = ""
            document.getElementById('text_epf12').value = ""
            document.getElementById('text_etf3').value = ""
        }
        function clear2() {
            document.getElementById('text_workDays').value = ""
            document.getElementById('text_nopayDays').value = ""
            document.getElementById('text_basic').value = ""
            document.getElementById('text_budj').value = ""
            document.getElementById('text_totalBasic').value = ""
            document.getElementById('text_salaryForEPF').value = ""
            document.getElementById('text_OT15').value = ""
            document.getElementById('text_OT15Hours').value = ""
            document.getElementById('text_extraOT').value = ""
            document.getElementById('text_extraOTHours').value = ""
            document.getElementById('text_allowICU').value = ""
            document.getElementById('text_allowCases').value = ""
            document.getElementById('text_allowNight').value = ""
            document.getElementById('text_allowFixed').value = ""
            document.getElementById('text_allowMeal').value = ""
            document.getElementById('text_allowSpecial').value = ""
            document.getElementById('text_allowTheater').value = ""
            document.getElementById('text_allowOther').value = ""
            document.getElementById('text_allowPH').value = ""
            document.getElementById('text_allowTransport').value = ""
            document.getElementById('text_allowAccommodation').value = ""
            document.getElementById('text_allowFuel').value = ""
            document.getElementById('text_allowAllowances02').value = ""
            document.getElementById('text_coinBF').value = ""
            document.getElementById('text_totalEarning').value = ""
            document.getElementById('text_payCut').value = ""
            document.getElementById('text_payCutHours').value = ""
            document.getElementById('text_noPay').value = ""
            document.getElementById('text_epf8').value = ""
            document.getElementById('text_deduAdvanced').value = ""
            document.getElementById('text_deduPayee').value = ""
            document.getElementById('text_deduOther').value = ""
            document.getElementById('text_deduRDB').value = ""
            document.getElementById('text_deduStaff').value = ""
            document.getElementById('text_deduCashShort').value = ""
            document.getElementById('text_coinCF').value = ""
            document.getElementById('text_totalDeduction').value = ""
            document.getElementById('text_grossPayment').value = ""
            document.getElementById('text_netSalary').value = ""
            document.getElementById('text_totalPayble').value = ""
            document.getElementById('text_epf12').value = ""
            document.getElementById('text_etf3').value = ""
        }
    </script>
    <script type="text/javascript">
        function loadPaysheet(epfno) {
            $.ajax({
                type: "POST",
                beforeSend: function () {
                    $("#loading").css("visibility", "visible");
                },
                url: "payroll.aspx/employeeSelected",
                data: "{'empName':'" + epfno + "','year':'" + document.getElementById('date_search').value + "','month':'" + document.getElementById('list_month').value + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '') {
                        clear()
                        alert('Sorry, Salary not Processed for Selected Employee')
                        document.getElementById('text_employee').value = epfno.split('(')[0]
                        $("#loading").css("visibility", "hidden");
                    } else {

                        var result = data.d.split('_')
                        document.getElementById('text_employee').value = ""

                        $.ajax({

                            url: "http://geryjdakdai-001-site12.atempurl.com/api/ProcessSalary/CheckEmployee?epfno=" + result[0] + "&period=" + document.getElementById('date_search').value + "/" + document.getElementById('list_month').value + "&empid=" + document.getElementById('text_attendanceId').value,

                            success: function (data) {
                                if (data != 2) {
                                    document.getElementById('text_epfNo_').value = result[0]
                                    document.getElementById('text_attendanceId').value = result[1]
                                    document.getElementById('text_employeeName').value = result[2]
                                    document.getElementById('text_department').value = result[3]
                                    document.getElementById('text_workDays').value = result[4]
                                    document.getElementById('text_nopayDays').value = result[5]
                                    document.getElementById('text_basic').value = result[6]
                                    document.getElementById('text_budj').value = result[7]
                                    document.getElementById('text_totalBasic').value = result[8]
                                    document.getElementById('text_salaryForEPF').value = result[9]
                                    document.getElementById('text_OT15').value = result[10]
                                    document.getElementById('text_OT15Hours').value = result[11]
                                    document.getElementById('text_extraOT').value = result[12]
                                    document.getElementById('text_extraOTHours').value = result[13]
                                    document.getElementById('text_allowICU').value = result[14]
                                    document.getElementById('text_allowCases').value = result[15]
                                    document.getElementById('text_allowNight').value = result[16]
                                    document.getElementById('text_allowFixed').value = result[17]
                                    document.getElementById('text_allowMeal').value = result[18]
                                    document.getElementById('text_allowSpecial').value = result[19]
                                    document.getElementById('text_allowTheater').value = result[20]
                                    document.getElementById('text_allowOther').value = result[21]
                                    document.getElementById('text_allowPH').value = result[22]
                                    document.getElementById('text_allowTransport').value = result[23]
                                    document.getElementById('text_allowAccommodation').value = result[24]
                                    document.getElementById('text_allowFuel').value = result[25]
                                    document.getElementById('text_allowAllowances02').value = result[26]
                                    document.getElementById('text_coinBF').value = result[27]
                                    document.getElementById('text_totalEarning').value = result[28]
                                    document.getElementById('text_payCut').value = result[29]
                                    document.getElementById('text_payCutHours').value = result[30]
                                    document.getElementById('text_noPay').value = result[31]
                                    document.getElementById('text_epf8').value = result[32]
                                    document.getElementById('text_deduAdvanced').value = result[33]
                                    document.getElementById('text_deduPayee').value = result[34]
                                    document.getElementById('text_deduOther').value = result[35]
                                    document.getElementById('text_deduRDB').value = result[36]
                                    document.getElementById('text_deduStaff').value = result[37]
                                    document.getElementById('text_deduCashShort').value = result[38]
                                    document.getElementById('text_coinCF').value = result[39]
                                    document.getElementById('text_totalDeduction').value = result[40]
                                    document.getElementById('text_grossPayment').value = result[41]
                                    document.getElementById('text_netSalary').value = result[42]
                                    document.getElementById('text_totalPayble').value = result[43]
                                    document.getElementById('text_epf12').value = result[44]
                                    document.getElementById('text_etf3').value = result[45]
                                } else if (data == 2) {
                                    alert("Selected Employee Processing.......")
                                    clear()
                                }

                            },
                            complete: function () {
                                $("#loading").css("visibility", "hidden");
                            }
                        });

                    }
                },
                error: function (result) {

                }
            });
        }
    </script>
</head>
<body>
    <form runat="server">
        <div class="page-container">
            <div class="page-sidebar">
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
                    <li class="xn-openable">
                        <a href="#"><span class="fa fa-files-o"></span><span class="xn-text">Profiles</span></a>
                        <ul>
                            <li><a href="profile_employee.aspx"><span class="fa fa-image"></span>Employee Master</a></li>

                        </ul>
                    </li>
                    <li class="active">
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
                            <li><a href="report_employee.aspx"><span class="fa fa-file-text-o"></span>Employee Report</a></li>
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
            </div>
            <div class="page-content">
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
                    <li class="xn-icon-button pull-right">
                        <a href="#"><span class="fa fa-comments"></span></a>
                        <div class="informer informer-danger">4</div>
                        <div class="panel panel-primary animated zoomIn xn-drop-left xn-panel-dragging">
                            <div class="panel-heading">
                                <h3 class="panel-title"><span class="fa fa-comments"></span>Messages</h3>
                                <div class="pull-right">
                                    <span class="label label-danger">4 new</span>
                                </div>
                            </div>
                            <div class="panel-body list-group list-group-contacts scroll" style="height: 200px;">
                                <a href="#" class="list-group-item">
                                    <div class="list-group-status status-online"></div>
                                    <img src="assets/images/users/user2.jpg" class="pull-left" alt="John Doe" />
                                    <span class="contacts-title">John Doe</span>
                                    <p>Praesent placerat tellus id augue condimentum</p>
                                </a>
                                <a href="#" class="list-group-item">
                                    <div class="list-group-status status-away"></div>
                                    <img src="assets/images/users/user.jpg" class="pull-left" alt="Dmitry Ivaniuk" />
                                    <span class="contacts-title">Dmitry Ivaniuk</span>
                                    <p>Donec risus sapien, sagittis et magna quis</p>
                                </a>
                                <a href="#" class="list-group-item">
                                    <div class="list-group-status status-away"></div>
                                    <img src="assets/images/users/user3.jpg" class="pull-left" alt="Nadia Ali" />
                                    <span class="contacts-title">Nadia Ali</span>
                                    <p>Mauris vel eros ut nunc rhoncus cursus sed</p>
                                </a>
                                <a href="#" class="list-group-item">
                                    <div class="list-group-status status-offline"></div>
                                    <img src="assets/images/users/user6.jpg" class="pull-left" alt="Darth Vader" />
                                    <span class="contacts-title">Darth Vader</span>
                                    <p>I want my money back!</p>
                                </a>
                            </div>
                            <div class="panel-footer text-center">
                                <a href="pages-messages.html">Show all messages</a>
                            </div>
                        </div>
                    </li>
                    <!-- END MESSAGES -->
                    <!-- TASKS -->
                    <li class="xn-icon-button pull-right">
                        <a href="#"><span class="fa fa-tasks"></span></a>
                        <div class="informer informer-warning">3</div>
                        <div class="panel panel-primary animated zoomIn xn-drop-left xn-panel-dragging">
                            <div class="panel-heading">
                                <h3 class="panel-title"><span class="fa fa-tasks"></span>Tasks</h3>
                                <div class="pull-right">
                                    <span class="label label-warning">3 active</span>
                                </div>
                            </div>
                            <div class="panel-body list-group scroll" style="height: 200px;">
                                <a class="list-group-item" href="#">
                                    <strong>Phasellus augue arcu, elementum</strong>
                                    <div class="progress progress-small progress-striped active">
                                        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 50%;">50%</div>
                                    </div>
                                    <small class="text-muted">John Doe, 25 Sep 2014 / 50%</small>
                                </a>
                                <a class="list-group-item" href="#">
                                    <strong>Aenean ac cursus</strong>
                                    <div class="progress progress-small progress-striped active">
                                        <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%;">80%</div>
                                    </div>
                                    <small class="text-muted">Dmitry Ivaniuk, 24 Sep 2014 / 80%</small>
                                </a>
                                <a class="list-group-item" href="#">
                                    <strong>Lorem ipsum dolor</strong>
                                    <div class="progress progress-small progress-striped active">
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="95" aria-valuemin="0" aria-valuemax="100" style="width: 95%;">95%</div>
                                    </div>
                                    <small class="text-muted">John Doe, 23 Sep 2014 / 95%</small>
                                </a>
                                <a class="list-group-item" href="#">
                                    <strong>Cras suscipit ac quam at tincidunt.</strong>
                                    <div class="progress progress-small">
                                        <div class="progress-bar" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">100%</div>
                                    </div>
                                    <small class="text-muted">John Doe, 21 Sep 2014 /</small><small class="text-success"> Done</small>
                                </a>
                            </div>
                            <div class="panel-footer text-center">
                                <a href="pages-tasks.html">Show all tasks</a>
                            </div>
                        </div>
                    </li>
                    <!-- END TASKS -->
                </ul>
                <ul class="breadcrumb">
                    <li><a href="home.aspx">Dashboard</a></li>
                    <li class="active">Paysheet</li>
                </ul>
                <div class="page-content-wrap">

                    <div class="row">
                        <div class="col-md-12">

                            <div class="block">

                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <asp:DropDownList runat="server" ID="date_search" CssClass="form-control" Width="100px" onchange="loadAfterListMonth()">
                                        </asp:DropDownList>
                                        <script type="text/javascript">
                                            function loadAfterListMonth() {
                                                var epfno = document.getElementById('text_employeeName').value + " (EPF No-" + document.getElementById('text_epfNo_').value + ",Employer No-" + document.getElementById('text_attendanceId').value + ")"
                                                if (document.getElementById('text_epfNo_').value != "") {
                                                    $.ajax({
                                                        beforeSend: function () {
                                                            $("#loading").css("visibility", "visible");
                                                        },
                                                        url: "http://geryjdakdai-001-site12.atempurl.com/api/ProcessSalary/CheckEmployee?epfno=" + epfno + "&period=" + document.getElementById('date_search').value + "/" + document.getElementById('list_month').value + "&empid=" + document.getElementById('text_attendanceId').value,

                                                        success: function (data) {
                                                            if (data != 2) {
                                                                loadPaysheet(epfno)
                                                            } else if (data == 2) {
                                                                alert("Selected Employee Processing.......")
                                                                $("#loading").css("visibility", "hidden");
                                                                document.getElementById('text_employee').value = ""
                                                                clear2()
                                                            }

                                                        },
                                                        complete: function () {

                                                        }
                                                    });

                                                }
                                            }
                                        </script>

                                    </div>

                                </div>
                                <div class="col-md-2">
                                    <div class="form-group has-success">

                                        <select class="form-control select" data-style="btn-success" id="list_month" runat="server" onchange="loadAfterListMonth();">
                                            <option>January</option>
                                            <option>February</option>
                                            <option>March</option>
                                            <option>April</option>
                                            <option>May</option>
                                            <option>June</option>
                                            <option>July</option>
                                            <option>August</option>
                                            <option>September</option>
                                            <option>October</option>
                                            <option>November</option>
                                            <option>December</option>
                                        </select>
                                    </div>
                                    <script type="text/javascript">
                                        function loadAfterListMonth() {
                                            var epfno = document.getElementById('text_employeeName').value + " (EPF No-" + document.getElementById('text_epfNo_').value + ",Employer No-" + document.getElementById('text_attendanceId').value + ")"
                                            if (document.getElementById('text_epfNo_').value != "") {
                                                var epfno = document.getElementById('text_employeeName').value + " (EPF No-" + document.getElementById('text_epfNo_').value + ",Employer No-" + document.getElementById('text_attendanceId').value + ")"
                                                if (document.getElementById('text_epfNo_').value != "") {
                                                    $.ajax({
                                                        beforeSend: function () {
                                                            $("#loading").css("visibility", "visible");
                                                        },
                                                        url: "http://geryjdakdai-001-site12.atempurl.com/api/ProcessSalary/CheckEmployee?epfno=" + epfno + "&period=" + document.getElementById('date_search').value + "/" + document.getElementById('list_month').value + "&empid=" + document.getElementById('text_attendanceId').value,,

                                                        success: function (data) {
                                                            if (data != 2) {
                                                                loadPaysheet(epfno)
                                                            } else if (data == 2) {
                                                                alert("Selected Employee Processing.......")
                                                                $("#loading").css("visibility", "hidden");
                                                                document.getElementById('text_employee').value = ""
                                                                clear2()
                                                            }

                                                        },
                                                        complete: function () {

                                                        }
                                                    });

                                                }
                                            }
                                        }
                                    </script>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group has-success">
                                        <asp:TextBox ID="text_employee" runat="server" CssClass="form-control" Text="" Placeholder="Search Employee here...." />
                                    </div>

                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="control-label" id="label_status" runat="server"></label>

                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="control-label" id="label_status2" runat="server"></label>

                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="block">

                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <label class="control-label">EPF No</label>
                                        <input type="text" class="form-control" value="" id="text_epfNo_" runat="server" readonly style="color: Green" />
                                    </div>

                                </div>
                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <label class="control-label">Employee No</label>
                                        <input type="text" class="form-control" value="" id="text_attendanceId" runat="server" readonly style="color: Green" />
                                    </div>

                                </div>
                                <div class="col-md-4">
                                    <div class="form-group has-success">
                                        <label class="control-label">Employee Name</label>
                                        <input type="text" class="form-control" value="" id="text_employeeName" runat="server" readonly style="color: Green" />
                                    </div>

                                </div>
                                <div class="col-md-2">
                                    <div class="form-group has-success">
                                        <label class="control-label">Department</label>
                                        <input type="text" class="form-control" value="" id="text_department" runat="server" readonly style="color: Green" />
                                    </div>

                                </div>
                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <label class="control-label">Working Days</label>
                                        <input type="text" class="form-control" value="" id="text_workDays" runat="server" readonly style="color: Green" />
                                    </div>

                                </div>
                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <label class="control-label">Nopay Days</label>
                                        <input type="text" class="form-control" value="" id="text_nopayDays" runat="server" readonly style="color: Green" />
                                    </div>

                                </div>
                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <label class="control-label">.</label>
                                        <asp:Button ID="Previous" runat="server" Text="Previous" CssClass="form-control" BackColor="#ff9900" ForeColor="White" Font-Bold="true" OnClick="Previous_Click"></asp:Button>
                                    </div>

                                </div>
                                <div class="col-md-1">
                                    <div class="form-group has-success">
                                        <label class="control-label">.</label>
                                        <asp:Button ID="Next" runat="server" Text="Next" CssClass="form-control" BackColor="#009933" ForeColor="White" Font-Bold="true" OnClick="Next_Click"></asp:Button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">


                            <panel class="form-horizontal">

                                <div class="panel panel-default">

                                    <div class="panel-body ">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Basic Salary</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_basic" runat="server" readonly style="color: orange" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Budj. Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_budj" runat="server" readonly style="color: orange" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Total Basic</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_totalBasic" runat="server" readonly style="color: orange" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Salary For EPF</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_salaryForEPF" runat="server" readonly style="color: orange" />
                                                    </div>
                                                </div>



                                            </div>
                                            <div class="col-md-3">

                                                <div class="form-group">
                                                    <label class="col-md-6 control-label">Over Time Pay ( 1.5 )</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_OT15" runat="server" readonly style="color: darkblue" />
                                                        <input type="text" class="form-control" value="" id="text_OT15Hours" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Extra Over Time</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_extraOT" runat="server" readonly style="color: darkblue" />
                                                        <input type="text" class="form-control" value="" id="text_extraOTHours" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">I.C.U Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowICU" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Attendance Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowCases" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Night Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowNight" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Fixed Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowFixed" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Meal Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowMeal" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Special Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowSpecial" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Theater Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowTheater" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Other Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowOther" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">PH Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowPH" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Transport Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowTransport" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Accommodation Allowance</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowAccommodation" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Fuel Allowances</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowFuel" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Allowances 02</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_allowAllowances02" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Coin B/F</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_coinBF" runat="server" readonly style="color: darkblue" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label" style="color: darkblue">Total Earning</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_totalEarning" runat="server" readonly style="color: darkblue; font-weight: 900" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="col-md-6 control-label">Pay Cut </label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_payCut" runat="server" readonly style="color: red" />
                                                        <input type="text" class="form-control" value="" id="text_payCutHours" runat="server" readonly style="color: red" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">No Pay</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_noPay" runat="server" readonly style="color: red" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">EPF 8%</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_epf8" runat="server" readonly style="color: red" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Advanced Deduction</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_deduAdvanced" runat="server" readonly style="color: red" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Payee Deduction</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_deduPayee" runat="server" readonly style="color: red" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Other Deduction</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_deduOther" runat="server" readonly style="color: red" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">RDB Loan</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_deduRDB" runat="server" readonly style="color: red" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Staff Loan</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_deduStaff" runat="server" readonly style="color: red" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Cash Short</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_deduCashShort" runat="server" readonly style="color: red" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Coin C/F</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_coinCF" runat="server" readonly style="color: red" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label" style="color: darkblue">Total Deduction</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_totalDeduction" runat="server" readonly style="color: red; font-weight: 900" />
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </panel>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">


                            <panel class="form-horizontal">

                                <div class="panel panel-default">

                                    <div class="panel-body ">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label" style="color: chocolate">Gross Payment</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_grossPayment" runat="server" readonly style="color: chocolate; font-weight: 900" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label" style="color: chocolate">Net Salary</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_netSalary" runat="server" readonly style="color: chocolate; font-weight: 900" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label" style="color: chocolate">Total Payble</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_totalPayble" runat="server" readonly style="color: chocolate; font-weight: 900" />
                                                    </div>
                                                </div>





                                            </div>
                                            <div class="col-md-3">

                                                <div class="form-group">
                                                    <label class="col-md-6 control-label" style="color: darkolivegreen">EPF 12%</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_epf12" runat="server" readonly style="color: darkolivegreen; font-weight: 900">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label" style="color: darkolivegreen">ETF 3%</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <input type="text" class="form-control" value="" id="text_etf3" runat="server" readonly style="color: darkolivegreen; font-weight: 900" />
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                    </div>

                                </div>

                            </panel>
                        </div>
                    </div>
                    <div class="panel-footer">

                        <div>
                            <asp:Button class="btn btn-primary pull-right" runat="server" ID="btn_print" OnClick="btn_print_Click" Text="Print Paysheet" />
                        </div>


                    </div>
                    <br />
                    <br />

                    <div class="row">
                        <div class="col-md-12">


                            <panel class="form-horizontal">

                                <div class="panel panel-default">

                                    <div class="panel-body ">
                                        <div class="row">
                                            <p style="color: coral; font-weight: bolder">Advance Export</p>
                                            <div class="col-md-3">
                                                <p style="color: burlywood; font-weight: 700">Export Period</p>
                                                <label class="col-md-6 col-xs-12 control-label">From Year</label>
                                                <div class="form-group">
                                                    <div class="col-md-2 col-xs-12 control-label">
                                                        <asp:DropDownList runat="server" ID="year_from" CssClass="form-control" Width="100px">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <label class="col-md-6 col-xs-12 control-label">From Month</label>
                                                <div class="form-group">

                                                    <div class="col-md-6 col-xs-12 control-label">
                                                        <div class="form-group has-success">

                                                            <select class="form-control select" data-style="btn-success" id="month_from" runat="server">
                                                                <option>January</option>
                                                                <option>February</option>
                                                                <option>March</option>
                                                                <option>April</option>
                                                                <option>May</option>
                                                                <option>June</option>
                                                                <option>July</option>
                                                                <option>August</option>
                                                                <option>September</option>
                                                                <option>October</option>
                                                                <option>November</option>
                                                                <option>December</option>
                                                            </select>
                                                        </div>

                                                    </div>
                                                </div>
                                                <hr width="100%" color="red" align="center">
                                                <label class="col-md-6 col-xs-12 control-label">To Year</label>
                                                <div class="form-group">
                                                    <div class="col-md-2 col-xs-12 control-label">
                                                        <asp:DropDownList runat="server" ID="year_to" CssClass="form-control" Width="100px">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <label class="col-md-6 col-xs-12 control-label">To Month</label>
                                                <div class="form-group">

                                                    <div class="col-md-6 col-xs-12 control-label">
                                                        <div class="form-group has-success">

                                                            <select class="form-control select" data-style="btn-success" id="month_to" runat="server">
                                                                <option>January</option>
                                                                <option>February</option>
                                                                <option>March</option>
                                                                <option>April</option>
                                                                <option>May</option>
                                                                <option>June</option>
                                                                <option>July</option>
                                                                <option>August</option>
                                                                <option>September</option>
                                                                <option>October</option>
                                                                <option>November</option>
                                                                <option>December</option>
                                                            </select>
                                                        </div>

                                                    </div>
                                                </div>


                                            </div>
                                            <div class="col-md-3">
                                                <p style="color: burlywood; font-weight: 700">Export Type</p>
                                                <div class="form-group">
                                                    <label class="col-md-6 col-xs-12 control-label">Employee</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <asp:DropDownList CssClass="form-control" runat="server" ID="list_search">
                                                            <asp:ListItem>Selected Employee</asp:ListItem>
                                                            <asp:ListItem>All Employee</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>

                                                </div>
                                                <div>
                                                    <asp:Button class="btn btn-primary pull-right" runat="server" ID="export_paysheetAdvance" OnClick="export_paysheetAdvance_Click" Text="Export Paysheets" />
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </panel>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div id="loading" runat="server">
            <img src="images/Loading_2.gif" alt="Loading...">
        </div>
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
        <script type='text/javascript' src='js/plugins/icheck/icheck.min.js'></script>
        <script type="text/javascript" src="js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>

        <script type="text/javascript" src="js/plugins/bootstrap/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="js/plugins/bootstrap/bootstrap-timepicker.min.js"></script>
        <script type="text/javascript" src="js/plugins/bootstrap/bootstrap-colorpicker.js"></script>
        <script type="text/javascript" src="js/plugins/bootstrap/bootstrap-file-input.js"></script>
        <script type="text/javascript" src="js/plugins/bootstrap/bootstrap-select.js"></script>
        <script type="text/javascript" src="js/plugins/tagsinput/jquery.tagsinput.min.js"></script>
        <script type="text/javascript" src="js/settings.js"></script>
        <script>
            nload = function () {

                // the date/time being edited
                var theDate = new Date();

                // create InputDate control
                var inputDate = new wijmo.input.InputDate('#theInputDate', {
                    min: new Date(2014, 8, 1),
                    format: 'yyyy',
                    selectionMode: 2,
                    value: theDate,
                    isDroppedDownChanged: function (s, e) {
                        setTimeout(function () {
                            var _hdr = s.dropDown.querySelector(".wj-calendar-year tr.wj-header td");
                            console.log(_hdr)
                            _hdr.click();
                        }, 100)
                    }
                });
            }
        </script>
        <script type="text/javascript" src="js/plugins.js"></script>
        <script type="text/javascript" src="js/actions.js"></script>
    </form>
</body>
</html>

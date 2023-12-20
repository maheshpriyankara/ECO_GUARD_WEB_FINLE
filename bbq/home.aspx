<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="bbq.home" %>


<!DOCTYPE html>

<html lang="en">
<head>
    <title>ECO GUARD</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" id="theme" href="css/theme-default.css" />

    <link href="jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="css/styleloading.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/bootstrap-min.js"></script>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript">

        function myMethod() {
            $.ajax({
                beforeSend: function () {
                    $("#loading").css("visibility", "visible");
                },
                url: "http://geryjdakdai-001-site12.atempurl.com/api/attendance/GetDayAttendance",
                success: function (data) {
                    $.each(data, function (index, value) {
                        document.getElementById('text_present').innerText = value.Present
                        document.getElementById('text_absent').innerText = value.Absent
                        document.getElementById('text_newcomers').innerText = value.NewComers
                    });
                },
                complete: function () {
                    $("#loading").css("visibility", "hidden");
                }
            });
        }
        function myMethod2() {
            $.ajax({
                url: "http://geryjdakdai-001-site12.atempurl.com/api/attendance/GetDayAttendanceLine",
                success: function (data) {
                    var table = $("#table tbody");
                    table.empty();

                    $.each(data, function (index, value) {
                        var row = $("<tr>");
                        row.append($("<td>").text(value.Name));
                        row.append($("<td>").text(value.Count + " Employee's"));
                        if (value.Status == 'Completed') {
                            var statusColumn = $("<td>").text(value.Status);
                            statusColumn.addClass("label label-success"); // Add the class to the second column
                            row.append(statusColumn);
                        } else {
                            var statusColumn = $("<td>").text(value.Status);
                            statusColumn.addClass("label label-danger"); // Add the class to the second column
                            row.append(statusColumn);
                        }



                        table.append(row);
                    });


                },
                complete: function () {
                    $("#loading").css("visibility", "hidden");
                }
            });
        }
        function myMethod3() {
            $.ajax({
                url: "http://geryjdakdai-001-site12.atempurl.com/api/ProcessSalary/getProcessQueue",
                success: function (data) {

                    var table2 = $("#table2 tbody");
                    table2.empty();
                    if (data.length > 0) {
                        var lastRow = data[data.length - 1]; // Get the last row of the data

                        // Create the last row as the first row in the table
                        var firstRow = $("<tr>");
                        firstRow.append($("<td>").text(lastRow.Period));
                        firstRow.append($("<td>").text(lastRow.Line));
                        firstRow.append($("<td>").text(lastRow.Count));
                        table2.prepend(firstRow);

                        // Iterate over the remaining rows in the original order
                        $.each(data.slice(0, data.length - 1), function (index, value) {
                            var row = $("<tr>");
                            row.append($("<td>").text(value.Period));
                            row.append($("<td>").text(value.Line));
                            row.append($("<td>").text(value.Count));
                            table2.append(row);
                        });
                    }



                },
                complete: function () {
                    $("#loading").css("visibility", "hidden");
                }
            });
        }
        function myMethod4() {
            $.ajax({
                url: "http://geryjdakdai-001-site12.atempurl.com/api/ProcessSalary/getProcessQueueTimesheet",
                success: function (data) {



                    var table3 = $("#table3 tbody");
                    table3.empty();
                    if (data.length > 0) {
                        var lastRow = data[data.length - 1]; // Get the last row of the data

                        // Create the last row as the first row in the table
                        var firstRow = $("<tr>");
                        firstRow.append($("<td>").text(lastRow.Period));
                        firstRow.append($("<td>").text(lastRow.Line));
                        firstRow.append($("<td>").text(lastRow.Count));
                        table3.prepend(firstRow);

                        // Iterate over the remaining rows in the original order
                        $.each(data.slice(0, data.length - 1), function (index, value) {
                            var row = $("<tr>");
                            row.append($("<td>").text(value.Period));
                            row.append($("<td>").text(value.Line));
                            row.append($("<td>").text(value.Count));
                            table3.append(row);
                        });
                    }



                },
                complete: function () {
                    $("#loading").css("visibility", "hidden");
                }
            });
        }
        function myMethod5() {
            $.ajax({
                url: "http://geryjdakdai-001-site12.atempurl.com/api/ProcessSalary/getProcessQueueTimesheetMonth",
                success: function (data) {



                    var table4 = $("#table4 tbody");
                    table4.empty();
                    if (data.length > 0) {
                        var lastRow = data[data.length - 1]; // Get the last row of the data

                        // Create the last row as the first row in the table
                        var firstRow = $("<tr>");
                        firstRow.append($("<td>").text(lastRow.Period));
                        firstRow.append($("<td>").text(lastRow.Line));
                        firstRow.append($("<td>").text(lastRow.Count));
                        table4.prepend(firstRow);

                        // Iterate over the remaining rows in the original order
                        $.each(data.slice(0, data.length - 1), function (index, value) {
                            var row = $("<tr>");
                            row.append($("<td>").text(value.Period));
                            row.append($("<td>").text(value.Line));
                            row.append($("<td>").text(value.Count));
                            table4.append(row);
                        });
                    }



                },
                complete: function () {
                    $("#loading").css("visibility", "hidden");
                }
            });
        }
        window.onload = function () {
            myMethod();
            myMethod2();
            myMethod3();
            myMethod4();
            myMethod5();
            setInterval(myMethod, 5000);
            setInterval(myMethod2, 5000);
            setInterval(myMethod3, 1000);
            setInterval(myMethod4, 1000);
            setInterval(myMethod5, 1000);
        };
    </script>
</head>
<body>
    <!-- START PAGE CONTAINER -->
    <div class="page-container">

        <!-- START PAGE SIDEBAR -->
        <div class="page-sidebar">
            <!-- START X-NAVIGATION -->
            <ul class="x-navigation">
                <li class="xn-logo">
                    <a href="home.aspx">ECO GUARD</a>
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
                            <div class="profile-data-title">Admin</div>
                        </div>
                        <div class="profile-controls">
                            <a href="pages-profile.html" class="profile-control-left"><span class="fa fa-info"></span></a>
                            <a href="pages-messages.html" class="profile-control-right"><span class="fa fa-envelope"></span></a>
                        </div>
                    </div>
                </li>
                <li class="active" id="menu" runat="server">
                    <a href="home.aspx"><span class="fa fa-desktop"></span><span class="xn-text">Dashboard</span></a>
                </li>
                <li class="xn-openable" id="menu2" runat="server">
                    <a href="#"><span class="fa fa-files-o"></span><span class="xn-text">Complaint</span></a>
                    <ul>
                        <li><a href="profile_employee.aspx"><span class="fa fa-image"></span>Create New</a></li>
                        <li><a href="profile_employee.aspx"><span class="fa fa-image"></span>History</a></li>

                    </ul>
                </li>
                <li class="xn-openable" id="menu7" runat="server">
                    <a href="tables.html"><span class="fa fa-table"></span><span class="xn-text">Settings</span></a>
                    <ul>
                        <li><a href="settings_.aspx"><span class="fa fa-align-justify"></span>Users</a></li>
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
                                <p>Wildlife poaching</p>
                            </a>
                            <a href="#" class="list-group-item">
                                <div class="list-group-status status-away"></div>
                                <img src="assets/images/users/user.jpg" class="pull-left" alt="Dmitry Ivaniuk" />
                                <span class="contacts-title">Dmitry Ivaniuk</span>
                                <p>Invasive species impact</p>
                            </a>
                            <a href="#" class="list-group-item">
                                <div class="list-group-status status-away"></div>
                                <img src="assets/images/users/user3.jpg" class="pull-left" alt="Nadia Ali" />
                                <span class="contacts-title">Nadia Ali</span>
                                <p>Logging road damage</p>
                            </a>
                            <a href="#" class="list-group-item">
                                <div class="list-group-status status-offline"></div>
                                <img src="assets/images/users/user6.jpg" class="pull-left" alt="Darth Vader" />
                                <span class="contacts-title">Darth Vader</span>
                                <p>Wildlife poaching</p>
                            </a>
                        </div>
                        <div class="panel-footer text-center">
                            <a href="pages-messages.html">Show all Notifications</a>
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
            <!-- END X-NAVIGATION VERTICAL -->

            <!-- START BREADCRUMB -->
            <ul class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li class="active">Dashboard</li>
            </ul>
            <!-- END BREADCRUMB -->

            <!-- PAGE CONTENT WRAPPER -->
            <div class="page-content-wrap">

                <!-- START WIDGETS -->
                <div class="row">
                    <div class="col-md-3">

                        <!-- START WIDGET SLIDER -->
                        <div class="widget widget-default widget-carousel">
                            <div class="owl-carousel" id="owl-example">
                                <div>
                                    <div class="widget-title">Total Cases</div>
                                    <div class="widget-subtitle">Today</div>
                                    <div class="widget-int" id="text_present" runat="server"></div>
                                </div>
                                <div>
                                    <div class="widget-title">New Cases</div>
                                    <div class="widget-subtitle">Today</div>
                                    <div class="widget-int" id="text_absent" runat="server"></div>
                                </div>
                                <div>
                                    <div class="widget-title">Pending</div>
                                    <div class="widget-subtitle">Today</div>
                                    <div class="widget-int" id="text_newcomers" runat="server"></div>
                                </div>
                            </div>
                            <div class="widget-controls">
                                <a href="#" class="widget-control-right widget-remove" data-toggle="tooltip" data-placement="top" title="Remove Widget"><span class="fa fa-times"></span></a>
                            </div>
                        </div>
                        <!-- END WIDGET SLIDER -->

                    </div>
                    <div class="col-md-2">

                        <!-- START WIDGET MESSAGES -->
                        <div class="widget widget-default widget-item-icon" onclick="location.href='pages-messages.html';">
                            <div class="widget-item-left">
                                <span class="fa fa-envelope"></span>
                            </div>
                            <div class="widget-data">
                                <div class="widget-int num-count">48</div>
                                <div class="widget-title"><a href="massages.aspx">New messages</a></div>
                            </div>
                            <div class="widget-controls">
                                <a href="#" class="widget-control-right widget-remove" data-toggle="tooltip" data-placement="top" title="Remove Widget"><span class="fa fa-times"></span></a>
                            </div>
                        </div>
                        <!-- END WIDGET MESSAGES -->

                    </div>
                    <div class="col-md-2">

                        <!-- START WIDGET REGISTRED -->
                        <div class="widget widget-default widget-item-icon" onclick="location.href='pages-address-book.html';">
                            <div class="widget-item-left">
                                <span class="fa fa-user"></span>
                            </div>
                            <div class="widget-data">
                                <div class="widget-int num-count">18</div>
                                <div class="widget-title"><a href="leave_authorization.aspx">Urgent Requsets</a></div>
                            </div>
                            <div class="widget-controls">
                                <a href="#" class="widget-control-right widget-remove" data-toggle="tooltip" data-placement="top" title="Remove Widget"><span class="fa fa-times"></span></a>
                            </div>
                        </div>
                        <!-- END WIDGET REGISTRED -->

                    </div>
                    <div class="col-md-2">

                        <!-- START WIDGET REGISTRED -->
                        <div class="widget widget-default widget-item-icon" onclick="location.href='pages-address-book.html';">
                            <div class="widget-item-left">
                                <span class="fa fa-user"></span>
                            </div>
                            <div class="widget-data">
                                <div class="widget-int num-count">10</div>
                                <div class="widget-title"><a href="advance_authorization.aspx">Ongoing Cases</a></div>
                            </div>
                            <div class="widget-controls">
                                <a href="#" class="widget-control-right widget-remove" data-toggle="tooltip" data-placement="top" title="Remove Widget"><span class="fa fa-times"></span></a>
                            </div>
                        </div>
                        <!-- END WIDGET REGISTRED -->

                    </div>
                    <div class="col-md-3">

                        <!-- START WIDGET CLOCK -->
                        <div class="widget widget-info widget-padding-sm">
                            <div class="widget-big-int plugin-clock">00:00</div>
                            <div class="widget-subtitle plugin-date">Loading...</div>
                            <div class="widget-controls">
                                <a href="#" class="widget-control-right widget-remove" data-toggle="tooltip" data-placement="left" title="Remove Widget"><span class="fa fa-times"></span></a>
                            </div>
                            <div class="widget-buttons widget-c3">
                                <div class="col">
                                    <a href="#"><span class="fa fa-clock-o"></span></a>
                                </div>
                                <div class="col">
                                    <a href="#"><span class="fa fa-bell"></span></a>
                                </div>
                                <div class="col">
                                    <a href="#"><span class="fa fa-calendar"></span></a>
                                </div>
                            </div>
                        </div>
                        <!-- END WIDGET CLOCK -->

                    </div>
                </div>
                <!-- END WIDGETS -->

                <div class="row">
                    <div class="col-md-4">

                        <!-- START USERS ACTIVITY BLOCK -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="panel-title-box">
                                    <h3>Cases ( Last Week )</h3>
                                    <span>Completed vs Pending</span>
                                </div>
                                <ul class="panel-controls" style="margin-top: 2px;">
                                    <li><a href="#" class="panel-fullscreen"><span class="fa fa-expand"></span></a></li>
                                    <li><a href="#" class="panel-refresh"><span class="fa fa-refresh"></span></a></li>
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="fa fa-cog"></span></a>
                                        <ul class="dropdown-menu">
                                            <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span>Collapse</a></li>
                                            <li><a href="#" class="panel-remove"><span class="fa fa-times"></span>Remove</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="panel-body padding-0">
                                <div class="chart-holder" id="dashboard-bar-1" style="height: 200px;"></div>
                            </div>
                        </div>
                        <!-- END USERS ACTIVITY BLOCK -->

                    </div>
                    <div class="col-md-4">

                        <!-- START VISITORS BLOCK -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="panel-title-box">
                                    <h3>Cases Summary</h3>
                                    <span>Today</span>
                                </div>
                                <ul class="panel-controls" style="margin-top: 2px;">
                                    <li><a href="#" class="panel-fullscreen"><span class="fa fa-expand"></span></a></li>
                                    <li><a href="#" class="panel-refresh"><span class="fa fa-refresh"></span></a></li>
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="fa fa-cog"></span></a>
                                        <ul class="dropdown-menu">
                                            <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span>Collapse</a></li>
                                            <li><a href="#" class="panel-remove"><span class="fa fa-times"></span>Remove</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="panel-body padding-0">
                                <div class="chart-holder" id="dashboard-donut-1" style="height: 200px;"></div>
                            </div>
                        </div>
                        <!-- END VISITORS BLOCK -->

                    </div>

                    <div class="col-md-4">

                        <!-- START PROJECTS BLOCK -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="panel-title-box">
                                    <h3>Cases Report By Location</h3>
                                    <span>Past 06 Month</span>
                                </div>
                            </div>
                            <div class="panel-body panel-body-table">

                                <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                                    <table class="tabl" id="table" runat="server">
                                        <thead>
                                            <tr>
                                                <th width="50%"></th>
                                                <th width="20%"></th>
                                                <th width="30%"></th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                        <!-- END PROJECTS BLOCK -->

                    </div>
                </div>

                <!-- START DASHBOARD CHART -->
                <div class="chart-holder" id="dashboard-area-1" style="height: 200px;"></div>
                <div class="block-full-width">
                </div>
                <!-- END DASHBOARD CHART -->

            </div>
            <!-- END PAGE CONTENT WRAPPER -->
        </div>
        <!-- END PAGE CONTENT -->
    </div>
    <!-- END PAGE CONTAINER -->

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
    <!-- END MESSAGE BOX-->

    <!-- START PRELOADS -->
    <audio id="audio-alert" src="audio/alert.mp3" preload="auto"></audio>
    <audio id="audio-fail" src="audio/fail.mp3" preload="auto"></audio>
    <!-- END PRELOADS -->

    <!-- START SCRIPTS -->
    <!-- START PLUGINS -->
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/bootstrap-min.js"></script>
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
    <script type="text/javascript" src="js/demo.js"></script>
    <!-- END TEMPLATE -->
    <!-- END SCRIPTS -->
</body>
</html>

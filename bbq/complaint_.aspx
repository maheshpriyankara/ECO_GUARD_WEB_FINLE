<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="complaint_.aspx.cs" Inherits="bbq.complaint_" %>

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
                        <a href="index.html">ECO GUARD</a>
                        <a href="#" class="x-navigation-control"></a>
                    </li>
                    <li class="xn-profile">
                        <a href="#" class="profile-mini">
                            <img src="assets/images/users/logo.png" alt="John Doe" />
                        </a>
                        <div class="profile">
                            <div class="profile-image">
                                <img src="assets/images/users/logo.png" alt="John Doe" />
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="default.aspx"><span class="fa fa-desktop"></span><span class="xn-text">Home</span></a>
                    </li>
                    <li class="xn-openable active">
                        <a href="#"><span class="fa fa-files-o"></span><span class="xn-text">Complaint</span></a>
                        <ul>
                            <li class="active"><a href="profile_employee.aspx"><span class="fa fa-image"></span>Report New</a></li>

                        </ul>
                    </li>

                </ul>
                <!-- END X-NAVIGATION -->
            </div>
            <!-- END PAGE SIDEBAR -->

            <!-- PAGE CONTENT -->
            <div class="page-content">

                <div class="page-content-wrap">

                    <div class="row">
                        <div class="col-md-12">

                            <panel class="form-horizontal">

                                <div class="panel panel-default tabs">
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li class="active"><a href="#tab-first" role="tab" data-toggle="tab">Reporter Inforamtion</a></li>
                                        <li><a href="#tab-second" role="tab" data-toggle="tab">Complaint Information</a></li>
                                    </ul>
                                    <div class="panel-body tab-content">
                                        <div class="tab-pane active" id="tab-first">
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
                                                            <input type="text" class="form-control" value="" id="text_firstName" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">last Name </label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_LastName" runat="server" />
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">NIC </label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_nic" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Mobile Number *</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_mobileNo" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">whats-up Number</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_WPNo" runat="server" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Address</label>
                                                        <div class="col-md-8 col-xs-12">
                                                            <asp:TextBox ID="text_address" runat="server" Class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <div class="panel-footer">
                                                <asp:Button ID="btn_save" class="btn btn-primary pull-right" Text="Create Complaint" runat="server" />
                                            </div>

                                        </div>
                                        <div class="tab-pane" id="tab-second">
                                            <div class="row">
                                                <div class="col-md-6">

                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Date of Incident</label>
                                                        <div class="col-md-4 col-xs-12">
                                                            <asp:TextBox ID="text_date" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
                                                        </div>

                                                    </div>

                                                </div>
                                                <div class="col-md-6">

                                                    <div class="form-group">
                                                        <label class="col-md-2 col-xs-12 control-label">Time of Incident</label>
                                                        <div class="col-md-4 col-xs-12">
                                                            <asp:TextBox ID="text_time" CssClass="form-control" runat="server" TextMode="Time"></asp:TextBox>
                                                        </div>

                                                    </div>

                                                </div>

                                                <br />
                                                <br />
                                                <div class="col-md-6">

                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Location</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_location" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Area</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_area" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 col-xs-12 control-label">Compaint Brief</label>
                                                        <div class="col-md-6 col-xs-12">
                                                            <input type="text" class="form-control" value="" id="text_complaint" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <br />
                                            <div class="panel-footer">
                                                <asp:Button ID="btn_save2" class="btn btn-primary pull-right" Text="Create Complaint" runat="server" />
                                                <script>
                                                    const button2 = document.querySelector("#btn_save2");

                                                    button2.addEventListener("click", function () {
                                                        myMethod();
                                                        event.preventDefault();
                                                    });

                                                    function myMethod() {

                                                        var title = document.getElementById('list_title').value;
                                                        var initials = document.getElementById('text_initial').value;
                                                        var firstname = document.getElementById('text_firstName').value;
                                                        var mobilenumber = document.getElementById('text_mobileNo').value;
                                                        var location = document.getElementById('text_location').value;
                                                        var area = document.getElementById('text_area').value;
                                                        var complaintBrief = document.getElementById('text_complaint').value;


                                                        var lastname = document.getElementById('text_LastName').value;
                                                        var nic = document.getElementById('text_nic').value;
                                                        var wpNo = document.getElementById('text_WPNo').value;
                                                        var address = document.getElementById('text_address').value;
                                                        var date = document.getElementById('text_date').value;
                                                        var time = document.getElementById('text_time').value;

                                                        if (title == "")  {

                                                            alert("Please input Title to Create Complaint")
                                                        } else if (initials == "")  {

                                                            alert("Please input Initials to Create Complaint")
                                                        } else if (firstname == "") {

                                                            alert("Please input First Name to Create Complaint")
                                                        } else if (mobilenumber == "") {

                                                            alert("Please input Mobile Number to Create Complaint")
                                                        } else if (location == "") {

                                                            alert("Please input Location to Create Complaint")
                                                        } else if (area == "") {

                                                            alert("Please input Area to Create Complaint")
                                                        } else if (complaintBrief == "") {

                                                            alert("Please input Compalint Briefly to Create Complaint")
                                                        }
                                                        else {

                                                            $.ajax({
                                                                beforeSend: function () {
                                                                    $("#loading").css("visibility", "visible");
                                                                },
                                                                url: "http://geryjdakdai-001-site30.atempurl.com/api/Complaint/CreateNewComplaint?title=" + title + "&intial=" + initials + "&firstName=" + firstname + "&lastname=" + lastname + "&nic=" + nic + "&mobileNumber=" + mobilenumber + "&wpNumber=" + mobilenumber + "&address=" + address + "&date=" + date + "&time=" + time + "&location=" + location + "&area=" + area + "&complaintBrief=" + complaintBrief,
                                                                type: "GET",
                                                                success: function (data) {
                                                                    $.each(data, function (index, value) {
                                                                        if (value.Status_ == 'Complaint Created Successfully') {
                                                                            alert("New Complaint Created Successfully ");
                                                                            document.getElementById('list_title').value = '';
                                                                            document.getElementById('text_initial').value='';
                                                                            document.getElementById('text_firstName').value='';
                                                                            document.getElementById('text_mobileNo').value='';
                                                                           document.getElementById('text_location').value='';
                                                                            document.getElementById('text_area').value='';
                                                                            document.getElementById('text_complaint').value='';


                                                                            document.getElementById('text_LastName').value='';
                                                                            document.getElementById('text_nic').value='';
                                                                            document.getElementById('text_WPNo').value='';
                                                                            document.getElementById('text_address').value='';
                                                                            document.getElementById('text_date').value='';
                                                                            document.getElementById('text_time').value='';

                                                                        } else {
                                                                            alert(value.Status_);
                                                                        }

                                                                    });

                                                                },
                                                                error: function (xhr, textStatus, errorThrown) {
                                                                    if (xhr.status == 400) {
                                                                        alert("Duplicate entry found");
                                                                    } else {
                                                                        alert("Error adding record. Please try again." + xhr.status);
                                                                    }
                                                                },
                                                                complete: function () {
                                                                    $("#loading").css("visibility", "hidden");
                                                                }
                                                            });
                                                        }

                                                    }
                                                </script>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group has-success">
                                        <label class="control-label" style="color: white">.</label>
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

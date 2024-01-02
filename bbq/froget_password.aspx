﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="froget_password.aspx.cs" Inherits="bbq.frogetpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ECO GUARD</title>
    <!-- Meta-Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    <meta name="keywords" content="Ripley and BBK, Ripley & Marshall,BBK Partnership">
    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }
    </script>
    <!-- //Meta-Tags -->
    <!-- Index-Page-CSS -->
    <link rel="stylesheet" href="css/style_frogetpassword.css" type="text/css" media="all">
    <!-- //Custom-Stylesheet-Links -->
    <!--fonts -->
    <link href="//fonts.googleapis.com/css?family=Mukta+Mahee:200,300,400,500,600,700,800" rel="stylesheet">
    <!-- //fonts -->
    <!-- Font-Awesome-File -->
    <link rel="stylesheet" href="css/font-awesome.css" type="text/css" media="all">
</head>

<body>

    <div class="content-w3ls">
        <div class="agileits-grid">
            <div class="content-top-agile" style="background: #000000">
                <h2 style="text-align: center">FROGET PASSWORD</h2>
            </div>
            <div class="content-bottom">
                <form id="Form1" action="#" method="post" runat="server">
                    <div id="Div1" class="field_w3ls" runat="server">
                        <div id="Div2" class="field-group" runat="server">
                            <input runat="server" name="userID" id="text_id" type="text" value="" placeholder="type your email | nic" />
                        </div>
                        <div class="field-group">
                            <input runat="server" id="text_password_current" type="password" class="form-control" name="password" value="" placeholder="type your current password here..." />

                            <span id="Span3" runat="server" toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                        </div>
                        <div class="field-group">
                            <input runat="server" id="text_password_new" type="password" class="form-control" name="password" value="" placeholder="type your new password here..." />

                            <span id="Span1" runat="server" toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                        </div>
                        <div class="field-group">
                            <input runat="server" id="text_password_new2" type="password" class="form-control" name="password" value="" placeholder="re-type your new password here..." />

                            <span id="Span2" runat="server" toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                        </div>
                    </div>

                    <div class="wthree-field">
                        <asp:Button ID="btn_reset" runat="server" Text="PASSWORD RESET" />
                        <script>
                            const button2 = document.querySelector("#btn_reset");

                            button2.addEventListener("click", function () {
                                myMethod();
                                event.preventDefault();
                            });

                            function myMethod() {

                                var userid = document.getElementById('text_id').value;
                                var password_current = document.getElementById('text_password_current').value;
                                var new_password1 = document.getElementById('text_password_new').value;
                                var new_password2 = document.getElementById('text_password_new2').value;

                                if (userid == "" || password_current == "" || new_password1 == "" || new_password2 == "") {

                                    alert("Please type valied Username and Password's")
                                } else if (new_password1 != new_password2) {

                                    alert("Sorry, Both New Password's are not Matching..");
                                }
                                else {

                                    $.ajax({
                                        beforeSend: function () {
                                            $("#loading").css("visibility", "visible");
                                        },
                                        url: "https://localhost:44354/api/Login/CheckLogin?userid=" + userid + "&password=" + password_current,
                                        type: "GET",
                                        success: function (data) {
                                            $.each(data, function (index, value) {
                                                if (value.Status_ == 'Success') {
                                                    $.ajax({
                                                        beforeSend: function () {
                                                            $("#loading").css("visibility", "visible");
                                                        },
                                                        url: "https://localhost:44354/api/Login/UpdateLogin?userid=" + userid + "&password=" + new_password1,
                                                        type: "GET",
                                                        success: function (data) {
                                                            $.each(data, function (index, value) {
                                                                if (value.Status_ == 'Success') {
                                                                    alert("Successfully Updated New Password");
                                                                    document.getElementById('text_id').value = '';
                                                                    document.getElementById('text_password_current').value = '';
                                                                    vdocument.getElementById('text_password_new').value = '';
                                                                    vdocument.getElementById('text_password_new2').value = '';
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
                    <div>

                        <a href="login.aspx" style="color: white; font-weight: bolder; text-align: left">Back to Sign IN</a>

                    </div>
                </form>
            </div>
            <!-- //content bottom -->
        </div>
    </div>
    <!--//copyright-->
    <script src="js/jquery-2.2.3.min.js"></script>
    <!-- script for show password -->
    <script>
        $(".toggle-password").click(function () {

            $(this).toggleClass("fa-eye fa-eye-slash");
            var input = $($(this).attr("toggle"));
            if (input.attr("type") == "password") {
                input.attr("type", "text");
            } else {
                input.attr("type", "password");
            }
        });
    </script>
    <!-- /script for show password -->

</body>
<!-- //Body -->
</html>

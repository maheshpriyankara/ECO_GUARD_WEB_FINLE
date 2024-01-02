<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="bbq.login" %>

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
    <link rel="stylesheet" href="css/style.css" type="text/css" media="all">
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
                <h2 style="text-align: center">Login</h2>
                <h3 style="text-align: center; color: #808080" id="txt_name" runat="server">WILDLIFE | FOREST </h3>
                <h4 style="text-align: center; color: #808080" id="H1" runat="server">RESOLUTION CENTER</h4>
            </div>
            <div class="content-bottom">
                <form id="Form1" action="#" method="post" runat="server">
                    <div id="Div1" class="field_w3ls" runat="server">
                        <div id="Div2" class="field-group" runat="server">
                            <input runat="server" name="userID" id="text_id" type="text" value="" placeholder="email | nic" />
                        </div>
                        <div class="field-group">
                            <input runat="server" id="text_password" type="password" class="form-control" name="password" value="" placeholder="type your password here..." />

                            <span id="Span1" runat="server" toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                        </div>
                    </div>

                    <div class="wthree-field">
                        <asp:Button ID="btn_signin" runat="server" Text="SIGN IN" />
                        <script>
                            const button2 = document.querySelector("#btn_signin");

                            button2.addEventListener("click", function () {
                                myMethod();
                                event.preventDefault();
                            });

                            function myMethod() {

                                var userid = document.getElementById('text_id').value;
                                var password = document.getElementById('text_password').value;
                               
                                if (userid == "" || password == "") {

                                    alert("Please type valied Username and Password")
                                }
                                else {

                                    $.ajax({
                                        beforeSend: function () {
                                            $("#loading").css("visibility", "visible");
                                        },
                                        url: "http://geryjdakdai-001-site30.atempurl.com/api/Login/GetLoginCredentials?userid=" + userid + "&password=" + password ,
                                        type: "GET",
                                        success: function (data) {
                                            $.each(data, function (index, value) {
                                                if (value.Status_ == 'Success Login') {
                                                    window.location.href = 'home.aspx?userID=' + userid;

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

                        <a href="froget_password.aspx" style="color: white; font-weight: bolder; text-align: left">Froget Password ?</a>
                        <a href="signup.aspx" style="color: white; font-weight: bolder; margin-left: 190px">Sign Up</a>

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

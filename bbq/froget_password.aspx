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
                            <input runat="server" name="userID" id="text_nic" type="text" value="" placeholder="type your email | nic" />
                        </div>

                    </div>

                    <div class="wthree-field">
                        <asp:Button ID="Button23" runat="server" Text="PASSWORD RESET" OnClick="Button1_Click3" />
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

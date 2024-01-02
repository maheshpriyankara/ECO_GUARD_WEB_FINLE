<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="bbq.signup" %>

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
    <link rel="stylesheet" href="css/style_signup.css" type="text/css" media="all">
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
                <h2 style="text-align: center">CREATE NEW ACCOUNT</h2>
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
                        <div class="field-group">
                            <input runat="server" id="text_retypepassword" type="password" class="form-control" name="password" value="" placeholder="re-type your password here..." />

                            <span id="Span2" runat="server" toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                        </div>
                    </div>

                    <div class="wthree-field">
                        <asp:Button ID="btn_signup" runat="server" Text="SIGN UP"  />
                          <script>
                              const button2 = document.querySelector("#btn_signup");

                              button2.addEventListener("click", function () {
                                  myMethod();
                                  event.preventDefault();
                              });

                              function myMethod() {

                                  var userid = document.getElementById('text_id').value;
                                  var password = document.getElementById('text_password').value;
                                  var retype_password = document.getElementById('text_retypepassword').value;

                                  if (userid == "" || password == "") {

                                      alert("Please type valied Username and Password")
                                  } else if (password != retype_password) {

                                      alert("Sorry, Both Password's are not Matching..");
                                  }
                                  else {

                                      $.ajax({
                                          beforeSend: function () {
                                              $("#loading").css("visibility", "visible");
                                          },
                                          url: "http://geryjdakdai-001-site30.atempurl.com/api/Login/CreateLoginCredentials?userid=" + userid + "&password=" + password,
                                          type: "GET",
                                          success: function (data) {
                                              $.each(data, function (index, value) {
                                                  if (value.Status_ == 'Success') {
                                                      alert("Successfully Created New User");
                                                      document.getElementById('text_id').value='';
                                                      document.getElementById('text_password').value='';
                                                      vdocument.getElementById('text_retypepassword').value='';
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

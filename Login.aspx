<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="login.aspx.vb" Inherits="SistemaGestion.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>Inicio de Sesion</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet"/>

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet"/>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="text-center">
                        <!-- Nested Row within Card Body -->
                        <div class="text-center">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div></div>
                       <img class="img-profile" src="../img/logo.jpg.jpg" />
                            <div class="text-center">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Bienvenido de nuevo!</h1>
                                    </div>
                                    <form class="user" id="formLogin" runat="server">
                                        <div class="form-group">
                                            <asp:TextBox ID="txtEmail" runat="server" class="form-control form-control-user" 
                                                placeholder="Enter Email Address..."></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox type="password" class="form-control form-control-user"
                                                ID="txtPassword" placeholder="Password" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <asp:CheckBox ID="rememberCheck" runat="server" class="custom-control-input" />
                                                <asp:Label ID="rememberLb" runat="server" class="custom-control-label" for="customCheck">Recordarme</asp:Label>
                                            </div>
                                        </div>
                                        <asp:Button ID="loginBtn" runat="server" Text="Login" class="btn btn-primary btn-user btn-block"/>
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <asp:HyperLink ID="HyperLink1" runat="server" class="small" href="forgot-password.aspx">
                                            Olvido su Contraseña?
                                        </asp:HyperLink>
                                    </div>
                                    <div class="text-center">
                                        <asp:HyperLink ID="HyperLink2" runat="server" class="small" href="register.aspx">
                                            Crear una cuenta
                                        </asp:HyperLink>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>


    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TrabajoRealizar.aspx.vb" Inherits="SistemaGestion.TrabajoRealizar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>TRABAJOS A REALIZAR</title>

    <!-- Custom fonts for this template -->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet"/>

    <!-- Custom styles for this template -->
    <link href="../css/sb-admin-2.min.css" rel="stylesheet"/>

    <!-- Custom styles for this page -->
    <link href="../vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet"/>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="../index.aspx">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">SELPRO<sup>2022</sup></div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="../index.aspx">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Menu Principal</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Interface
            </div>

             <!-- Items del menu de opciones lateral-->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>MENU</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Pantallas</h6>
                        <a class="collapse-item" href="../login.aspx">Login</a>
                        <a class="collapse-item" href="../Tablas/Usuario.aspx">Usuario</a>
                        <a class="collapse-item" href="../Tablas/Empresa.aspx">Empresa</a>
                        <a class="collapse-item" href="../Tablas/Sucursal.aspx">Sucursal</a>
                        <a class="collapse-item" href="../Tablas/Empleado.aspx">Empleado</a>
                        <a class="collapse-item" href="../Tablas/Cliente.aspx">Cliente</a>
                        <a class="collapse-item" href="../Tablas/TrabajoRealizar.aspx">Trabajos a Realizar</a>
                        <a class="collapse-item" href="../Tablas/TrabajoRealizado.aspx">Trabajos Realizados</a>
                        <a class="collapse-item" href="../Tablas/Facturacion.aspx">Facturacion</a>
                        <a class="collapse-item" href="../Tablas/Pagos.aspx">Pagos</a>
                        <a class="collapse-item" href="../Tablas/PagosHistorial.aspx">Historial de Pagos</a>
                        <div class="collapse-divider"></div>
                        <!--<h6 class="collapse-header">Other Pages:</h6>
                        <a class="collapse-item" href="../register.aspx">Register</a>
                        <a class="collapse-item" href="../forgot-password.aspx">Forgot Password</a>
                        <a class="collapse-item" href="../404.aspx">404 Page</a>
                        <a class="collapse-item" href="../blank.aspx">Blank Page</a>!-->
                    </div>
                </div>
            </li>



            
            <!-- Nav Item - Charts -->
            <!--<li class="nav-item">
                <a class="nav-link" href="charts.aspx">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>Charts</span></a>
            </li>

            <!-- Nav Item - Tables -->
            <!--<li class="nav-item active">
                <a class="nav-link" href="tables.aspx">
                    <i class="fas fa-fw fa-table"></i>
                    <span>Tables</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block"/>

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <form class="form-inline">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                    </form>

                    <!-- Topbar Search -->
                    <%--<form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2"/>
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>--%>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <!--<div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2"/>
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- Nav Item - Alerts -->
                        <!--<li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span class="badge badge-danger badge-counter">0+</span>
                            </a>
                            <!-- Dropdown - Alerts -->
                           <!-- <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    Alerts Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 12, 2019</div>
                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 7, 2019</div>
                                        $290.29 has been deposited into your account!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 2, 2019</div>
                                        Spending Alert: We've noticed unusually high spending for your account.
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                            </div>
                        </li>

                        <!-- Nav Item - Messages -->
                       <!-- <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-envelope fa-fw"></i>
                                <!-- Counter - Messages -->
                                <!--<span class="badge badge-danger badge-counter">1</span>
                            </a>
                            <!-- Dropdown - Messages -->
                           <!-- <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="messagesDropdown">
                                <h6 class="dropdown-header">
                                    Message Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_1.svg"
                                            alt="..."/>
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">Hi there! I am wondering if you can help me with a
                                            problem I've been having.</div>
                                        <div class="small text-gray-500">Emily Fowler · 58m</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_2.svg"
                                            alt="..."/>
                                        <div class="status-indicator"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">I have the photos that you ordered last month, how
                                            would you like them sent to you?</div>
                                        <div class="small text-gray-500">Jae Chun · 1d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_3.svg"
                                            alt="..."/>
                                        <div class="status-indicator bg-warning"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Last month's report looks great, I am very happy with
                                            the progress so far, keep up the good work!</div>
                                        <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60"
                                            alt="..."/>
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Am I a good boy? The reason I ask is because someone
                                            told me that people say this to all dogs, even if they aren't good...</div>
                                        <div class="small text-gray-500">Chicken the Dog · 2w</div>
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                            </div>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><asp:Label ID="txtUser" runat="server" Text="User"></asp:Label></span>                                
                                <img class="img-profile rounded-circle"
                                    src="../img/logo.jpg.jpg"/>
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <%--<a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>--%>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                    </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <form runat="server" id="formEmpresa" class="auto-style7">
                    <div class="container-fluid">

                        <!-- Page Heading -->
                        <h1 class="h3 mb-2 text-gray-800">Trabajos a Realizar</h1>
                        <%--<p class="mb-4">
                            DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.
                        </p>--%>

                        <!-- DataTales Example -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Tabla de Trabajos a Realizar</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <%--<table class="auto-style6">
                                        <tr>
                                            <td class="auto-style1">
                                                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="XX-Large" Text="Empresas"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>--%>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td class="auto-style8">
                                                <asp:Button ID="btnID" runat="server" Text="ID" Width="70px" />
                                                <%--<asp:Button ID="btnImprimir" runat="server" Text="Imprimir" Width="119px" />--%>
                                            </td>
                                            <td class="auto-style2">
                                                <asp:TextBox ID="txtID" runat="server" Width="215px"></asp:TextBox>
                                            </td>
                                            <td class="auto-style5">
                                                <asp:Button ID="btnNuevo" runat="server" Text="Nuevo" Width="119px" />
                                            </td>
                                            <td class="auto-style4">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style8">DESCRIPCIÓN DEL CASO</td>
                                            <td class="auto-style2">
                                                <asp:TextBox ID="txtDescripcion" runat="server" Width="215px"></asp:TextBox>
                                            </td>
                                            <td class="auto-style5">
                                                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" Width="119px" />
                                            </td>
                                            <td class="auto-style4">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style8">FECHA</td>
                                            <td class="auto-style2">
                                                <asp:Calendar ID="Calendar1" runat="server" Width="215px"></asp:Calendar>
                                                <asp:TextBox ID="txtFecha" runat="server" Width="215px"></asp:TextBox>
                                            </td>
                                            <td class="auto-style5">
                                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" Width="119px" />
                                            </td>
                                            <td class="auto-style4">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style8">EMPRESA</td>
                                            <td class="auto-style2">
                                                <asp:DropDownList ID="ddlEmpresa" runat="server" Width="215px" AutoPostBack="True">

                                                </asp:DropDownList>
                                            </td>
                                            <td class="auto-style5">
                                                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" Width="119px" />
                                            </td>
                                            <td class="auto-style4">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                         <tr>
                                            <td class="auto-style8">SUCURSAL</td>
                                            <td class="auto-style2">
                                                <asp:DropDownList ID="ddlSucursal" runat="server" Width="215px" AutoPostBack="True" ValidationGroup="">

                                                </asp:DropDownList>
                                            </td>
                                            <td class="auto-style5">
                                                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" Width="119px" />
                                            </td>
                                            <td class="auto-style4">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style8">EMPLEADO</td>
                                            <td class="auto-style2">
                                                <asp:DropDownList ID="ddlEmpleado" runat="server" Width="215px" AutoPostBack="True">

                                                </asp:DropDownList>
                                            </td>
                                            <td class="auto-style5">
                                                &nbsp;</td>
                                            <td class="auto-style4">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style8">CLIENTE</td>
                                            <td class="auto-style2">
                                                <asp:DropDownList ID="ddlCliente" runat="server" Width="215px" AutoPostBack="True">

                                                </asp:DropDownList>
                                            </td>
                                            <td class="auto-style5">
                                                &nbsp;</td>
                                            <td class="auto-style4">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                         <tr>
                                            <td class="auto-style8">TIPO DE TRABAJO</td>
                                            <td class="auto-style2">
                                                <asp:RadioButton ID="RBPreventivo" runat="server" GroupName="tipoTrabajo" Text="Mantenimiento Preventivo" AutoPostBack="True" /><br />
                                                <asp:RadioButton ID="RBCorrectivo" runat="server" GroupName="tipoTrabajo" Text="Mantenimiento Correctivo" AutoPostBack="True" />
                                            </td>
                                            <td class="auto-style5">
                                                &nbsp;</td>
                                            <td class="auto-style4">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style8">FINALIZADO</td>
                                            <td class="auto-style2">
                                                <asp:CheckBox ID="CBFinal" runat="server" Width="215px" Text=" " AutoPostBack="True"/>
                                                <%--<asp:RadioButton ID="CBFinal" runat="server" Width="215px" Text=" " AutoPostBack="True"/>--%>
                                                <%--<asp:Label ID="lblFinal" runat="server" Text="Label"></asp:Label>--%>
                                            </td>
                                            <td class="auto-style5">
                                                &nbsp;</td>
                                            <td class="auto-style4">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtBuscar" runat="server" Width="525px"></asp:TextBox>
                                            </td>
                                            <td class="auto-style5">
                                                
                                            </td>
                                            <td class="auto-style4">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                    <asp:GridView ID="realizarGrid" runat="server" AutoGenerateColumns="False" Width="900px" class="table table-bordered" >
                                        <Columns>
                                            <asp:BoundField DataField="ID_TRABAJOREALIZADO" HeaderText="ID" />
                                            <asp:BoundField DataField="DESCRIPCION" HeaderText="DESCRIPCIÓN" />
                                            <asp:BoundField DataField="FECHA" HeaderText="FECHA" />
                                            <asp:BoundField DataField="EMPRESA" HeaderText="EMPRESA" />
                                            <asp:BoundField DataField="SUCURSAL" HeaderText="SUCURSAL" />
                                            <asp:BoundField DataField="T_TRABAJO" HeaderText="TIPO DE TRABAJO" />
                                            <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE" />
                                            <asp:BoundField DataField="EMPLEADO" HeaderText="EMPLEADO" />
                                            <asp:BoundField DataField="USUARIO" HeaderText="AGREGADO POR" />
                                        </Columns>
                                    </asp:GridView>                               

                                    <table style="width: 100%;">
                                        <tr>
                                            <td class="auto-style1"></td>
                                            <td class="auto-style9"></td>
                                            <td class="auto-style1">&nbsp;</td>
                                            <td class="auto-style1">
                                            </td>
                                        </tr>
                                    </table>
                                    <%--<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        --%>
                                </div>
                            </div>
                        </div>

                    </div>
                </form>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; UEES-SELPRO 2022</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="../login.aspx">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="../vendor/jquery/jquery.min.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="../js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="../vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="../vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="../js/demo/datatables-demo.js"></script>

</body>

</html>

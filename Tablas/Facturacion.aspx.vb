Imports MySql.Data.MySqlClient

Public Class Facturacion
    Inherits System.Web.UI.Page
    Public dst As DataSet
    Private tpago As Integer
    Private estadopago As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        VerificaCookie()

        Poblar()

        If Not (IsPostBack) Then
            listEmpresa()
            listSucursal()
            listCliente()
            listEmpleado()
            listTrabajo()
        End If
    End Sub

    Private Sub VerificaCookie()
        If Request.Cookies("EmpleadoASP") Is Nothing Then
            Response.Redirect("~/Login.aspx")
        Else
            Dim cookie As HttpCookie = HttpContext.Current.Request.Cookies("EmpleadoASP")
            cookie.Value = "Activa"
            cookie.Expires = Now.AddMinutes(3)
            Response.Cookies.Add(cookie)

        End If
    End Sub

    Private Sub Limpiar()
        txtID.Text = "0"
        Calendar1.SelectedDate = Today
        txtFecha.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss")
        ddlEmpresa.ClearSelection()
        ddlSucursal.ClearSelection()
        ddlEmpleado.ClearSelection()
        ddlCliente.ClearSelection()
        RBContado.Checked = False
        RBCredito.Checked = False
        txtNeto.Text = ""
        txtEstadoPago.Text = ""
        txtAbonado.Text = ""
        txtIVA.Text = ""
        txtPago.Text = ""
        txtTotal.Text = ""
        txtBuscar.Text = ""
        txtNeto.Focus()

        'txtDescripcion.Enabled = False
        'txtFecha.Enabled = False
        'ddlEmpresa.Enabled = False
        'ddlSucursal.Enabled = False
        'ddlCliente.Enabled = False
        'ddlEmpleado.Enabled = False
    End Sub

    Private Sub Poblar()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim da As New MySqlDataAdapter("CALL CallFacturas('" & txtBuscar.Text & "',1)", Conexiones.Cnn)
        ' Dim ds As New DataSet
        dst = New DataSet
        da.Fill(dst)
        If dst.Tables(0).Rows.Count > 0 Then
            facturaGrid.DataSource = dst.Tables(0)
            facturaGrid.DataBind()

        Else
            facturaGrid.DataSource = Nothing
            facturaGrid.DataBind()
        End If


        Conexiones.Cnn.Close()
    End Sub


    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Poblar()

    End Sub

    Protected Sub btnLimpiar_Click(sender As Object, e As EventArgs) Handles btnLimpiar.Click
        Limpiar()
        Poblar()
    End Sub

    Public Sub listEmpresa()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim cmd As New MySqlCommand("select * from empresa where ACTIVO = '1'", Conexiones.Cnn)
        Dim da As New MySqlDataAdapter(cmd)
        dst = New DataSet
        Dim dt As New DataTable
        da.Fill(dst)

        ddlEmpresa.DataSource = dst
        ddlEmpresa.DataTextField = "NOMBRE"
        ddlEmpresa.DataValueField = "ID_EMPRESA"

        ddlEmpresa.DataBind()
        ddlEmpresa.Items.Insert(0, New ListItem("----Empresa----", "disabled"))

        Conexiones.Cnn.Close()

    End Sub

    Public Sub listSucursal()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim cmd As New MySqlCommand("select * from sucursal where ACTIVO = '1'", Conexiones.Cnn)
        Dim da As New MySqlDataAdapter(cmd)
        dst = New DataSet
        Dim dt As New DataTable
        da.Fill(dst)

        ddlSucursal.DataSource = dst
        ddlSucursal.DataTextField = "NOMBRE"
        ddlSucursal.DataValueField = "ID_SUCURSAL"

        ddlSucursal.DataBind()
        ddlSucursal.Items.Insert(0, New ListItem("----Sucursal----", "disabled"))

        Conexiones.Cnn.Close()

    End Sub

    Public Sub listEmpleado()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim cmd As New MySqlCommand("SELECT ID_EMPLEADO, CONCAT(NOMBRE,' ',APELLIDO) as 'EMPLEADO' FROM empleado WHERE ACTIVO = '1'", Conexiones.Cnn)
        Dim da As New MySqlDataAdapter(cmd)
        dst = New DataSet
        Dim dt As New DataTable
        da.Fill(dst)

        ddlEmpleado.DataSource = dst
        ddlEmpleado.DataTextField = "EMPLEADO"
        ddlEmpleado.DataValueField = "ID_EMPLEADO"

        ddlEmpleado.DataBind()
        ddlEmpleado.Items.Insert(0, New ListItem("----Empleado----", "disabled"))

        Conexiones.Cnn.Close()

    End Sub

    Public Sub listCliente()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim cmd As New MySqlCommand("SELECT ID_CLIENTE, CONCAT(NOMBRE,' ',APELLIDO) as 'CLIENTE' FROM cliente WHERE ACTIVO = '1'", Conexiones.Cnn)
        Dim da As New MySqlDataAdapter(cmd)
        dst = New DataSet
        Dim dt As New DataTable
        da.Fill(dst)

        ddlCliente.DataSource = dst
        ddlCliente.DataTextField = "CLIENTE"
        ddlCliente.DataValueField = "ID_CLIENTE"

        ddlCliente.DataBind()
        ddlCliente.Items.Insert(0, New ListItem("----Cliente----", "disabled"))

        Conexiones.Cnn.Close()

    End Sub

    Public Sub listTrabajo()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim cmd As New MySqlCommand("SELECT * FROM `trabajorealizado` WHERE `ACTIVO` = 1", Conexiones.Cnn)
        Dim da As New MySqlDataAdapter(cmd)
        dst = New DataSet
        Dim dt As New DataTable
        da.Fill(dst)

        ddlTrabajo.DataSource = dst
        ddlTrabajo.DataTextField = "DESCRIPCION"
        ddlTrabajo.DataValueField = "ID_TRABAJOREALIZADO"

        ddlTrabajo.DataBind()
        ddlTrabajo.Items.Insert(0, New ListItem("----Trabajo----", "disabled"))

        Conexiones.Cnn.Close()

    End Sub

    Protected Sub Calendar1_SelectionChanged(sender As Object, e As EventArgs) Handles Calendar1.SelectionChanged
        Dim oDate As DateTime = Calendar1.SelectedDate
        txtFecha.Text = oDate.ToString("yyyy-MM-dd HH:mm:ss")
    End Sub

    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnNuevo.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim da As New MySqlDataAdapter("CALL CallFacturabyID('" & txtID.Text & "',1)", Conexiones.Cnn)
        'SELECT sucursal.*, empresa.NOMBRE as 'EMPRESA' FROM sucursal INNER JOIN empresa on empresa.ID_EMPRESA = sucursal.ID_EMPRESA
        Dim ds As New DataSet
        da.Fill(ds)

        If ds.Tables(0).Rows.Count > 0 Then
            'txtID.Text = ds.Tables(0).Rows(0).Item("ID_TRABAJOREALIZADO")
            ddlEmpresa.SelectedValue = ds.Tables(0).Rows(0).Item("ID_EMPRESA")
            ddlSucursal.SelectedValue = ds.Tables(0).Rows(0).Item("ID_SUCURSAL")
            ddlEmpleado.SelectedValue = ds.Tables(0).Rows(0).Item("ID_EMPLEADO")
            ddlCliente.SelectedValue = ds.Tables(0).Rows(0).Item("ID_CLIENTE")
            txtPago.Text = ds.Tables(0).Rows(0).Item("ID_TRABAJOREALIZADO")
            ddlTrabajo.SelectedValue = ds.Tables(0).Rows(0).Item("ID_TRABAJOREALIZADO")

            'If ds.Tables(0).Rows(0).Item("TIPOTRABAJO") = 0 Then
            '    RBContado.Checked = True
            'ElseIf ds.Tables(0).Rows(0).Item("TIPOTRABAJO") = 1 Then
            '    RBCredito.Checked = True
            'End If

            Calendar1.SelectedDate = ds.Tables(0).Rows(0).Item("FECHA")
            txtFecha.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss")

        Else
            'txtID.Text = ""
            ddlEmpresa.SelectedValue = ds.Tables(0).Rows(0).Item("ID_EMPRESA")
            ddlSucursal.SelectedValue = ds.Tables(0).Rows(0).Item("ID_SUCURSAL")
            ddlEmpleado.SelectedValue = ds.Tables(0).Rows(0).Item("ID_EMPLEADO")
            ddlCliente.SelectedValue = ds.Tables(0).Rows(0).Item("ID_CLIENTE")
            txtPago.Text = ds.Tables(0).Rows(0).Item("ID_TRABAJOREALIZADO")
            ddlTrabajo.SelectedValue = ds.Tables(0).Rows(0).Item("ID_TRABAJOREALIZADO")
            RBContado.Checked = False
            RBCredito.Checked = False
            Calendar1.SelectedDate = Today
            txtFecha.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss")
        End If

        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        VerificaCookie()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()
        Dim dst1 As DataSet
        Dim da1 As New MySqlDataAdapter("SELECT * FROM `factura` WHERE `ID_FACTURA` = " & txtID.Text, Conexiones.Cnn)
        'Dim da2 As New MySqlDataAdapter("SELECT * FROM `trabajorealizado` WHERE `ID_TRABAJOREALIZADO` = " & txtID.Text, Conexiones.Cnn)
        ' Dim ds As New DataSet
        dst1 = New DataSet
        If txtAbonado.Text = "0" Then
            txtEstadoPago.Text = 1
        ElseIf txtAbonado.Text > "0" And txtAbonado.Text <> txtTotal.Text Then
            txtEstadoPago.Text = 2
        ElseIf txtAbonado.Text = txtTotal.Text Then
            txtEstadoPago.Text = 3
        End If

        If RBContado.Checked = True Then
            tpago = 1
        ElseIf RBCredito.Checked = True Then
            tpago = 2
        End If

        'Dim dst2 = New DataSet
        'da2.Fill(dst2)
        'estadopago = dst2.Tables(0).Rows(0).Item("DESCRIPCION")
        da1.Fill(dst1)
        If dst1.Tables(0).Rows.Count = 0 Then

            Dim cmd As New MySqlCommand("CALL AddFactura ('" & txtID.Text & "','" & ddlEmpresa.SelectedValue & "','" & ddlSucursal.SelectedValue & "', '" & ddlCliente.SelectedValue & "', '" & ddlEmpleado.SelectedValue & "', '" & ddlTrabajo.SelectedValue &
                                        "', '" & txtFecha.Text & "', '1', '" & tpago & "', '" & txtEstadoPago.Text & "', '" & txtAbonado.Text & "', '" & txtNeto.Text & "', '" & txtIVA.Text & "', '" & txtTotal.Text & "')", Conexiones.Cnn)
            cmd.ExecuteNonQuery()
            txtSentencia.Text = cmd.CommandText
            Poblar()
            Limpiar()
        Else
            Dim cmd As New MySqlCommand("CALL UpdateFactura ('" & txtID.Text & "','" & ddlEmpresa.SelectedValue & "','" & ddlSucursal.SelectedValue & "', '" & ddlCliente.SelectedValue & "', '" & ddlEmpleado.SelectedValue & "', '" & ddlTrabajo.SelectedValue &
                                        "', '" & txtFecha.Text & "', '1', '" & tpago & "', '" & txtEstadoPago.Text & "', '" & txtAbonado.Text & "', '" & txtNeto.Text & "', '" & txtIVA.Text & "', '" & txtTotal.Text & "')", Conexiones.Cnn)
            cmd.ExecuteNonQuery()
            txtSentencia.Text = cmd.CommandText
            Poblar()
            Limpiar()

        End If

        Conexiones.Cnn.Close()
    End Sub

    Protected Sub txtFecha_TextChanged(sender As Object, e As EventArgs) Handles txtFecha.TextChanged
        txtFecha.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss")
    End Sub

    Protected Sub btnCalcular_Click(sender As Object, e As EventArgs) Handles btnCalcular.Click
        Dim pago As Double
        Dim iva As Double
        Dim total As Double
        pago = txtNeto.Text
        iva = pago * (0.13)
        total = pago + iva
        txtIVA.Text = iva
        txtTotal.Text = total

        If txtAbonado.Text = "0" Then
            txtEstadoPago.Text = 1
        ElseIf txtAbonado.Text > "0" And txtAbonado.Text <> txtTotal.Text Then
            txtEstadoPago.Text = 2
        ElseIf txtAbonado.Text = txtTotal.Text Then
            txtEstadoPago.Text = 3
        End If
    End Sub

    Protected Sub btnID_Click(sender As Object, e As EventArgs) Handles btnID.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim da As New MySqlDataAdapter("CALL FacturaByID('" & txtID.Text & "',1)", Conexiones.Cnn)
        'SELECT sucursal.*, empresa.NOMBRE as 'EMPRESA' FROM sucursal INNER JOIN empresa on empresa.ID_EMPRESA = sucursal.ID_EMPRESA
        Dim ds As New DataSet
        da.Fill(ds)

        If ds.Tables(0).Rows.Count > 0 Then
            txtID.Text = ds.Tables(0).Rows(0).Item("ID_FACTURA")
            ddlEmpresa.SelectedValue = ds.Tables(0).Rows(0).Item("ID_EMPRESA")
            ddlSucursal.SelectedValue = ds.Tables(0).Rows(0).Item("ID_SUCURSAL")
            ddlEmpleado.SelectedValue = ds.Tables(0).Rows(0).Item("ID_EMPLEADO")
            ddlCliente.SelectedValue = ds.Tables(0).Rows(0).Item("ID_CLIENTE")
            txtPago.Text = ds.Tables(0).Rows(0).Item("ID_FACTURA")
            ddlTrabajo.SelectedValue = ds.Tables(0).Rows(0).Item("ID_TRABAJOREALIZADO")

            If ds.Tables(0).Rows(0).Item("PG_TIPOPAGO") = 1 Then
                RBContado.Checked = True
            ElseIf ds.Tables(0).Rows(0).Item("PG_TIPOPAGO") = 2 Then
                RBCredito.Checked = True
            End If

            Calendar1.SelectedDate = ds.Tables(0).Rows(0).Item("FECHA")
            txtFecha.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss")

            txtAbonado.Text = ds.Tables(0).Rows(0).Item("PG_TOTALPAGADO")
            txtEstadoPago.Text = ds.Tables(0).Rows(0).Item("PG_ESTADO")
            txtNeto.Text = ds.Tables(0).Rows(0).Item("PG_TOTALNETO")
            txtIVA.Text = ds.Tables(0).Rows(0).Item("PG_IVA")
            txtTotal.Text = ds.Tables(0).Rows(0).Item("PG_TOTALPAGAR")

        Else
            txtID.Text = ""
            ddlEmpresa.SelectedValue = 0
            ddlSucursal.SelectedValue = 0
            ddlEmpleado.SelectedValue = 0
            ddlCliente.SelectedValue = 0
            txtPago.Text = ""
            ddlTrabajo.SelectedValue = 0
            RBContado.Checked = False
            RBCredito.Checked = False
            Calendar1.SelectedDate = Today
            txtFecha.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss")
            txtAbonado.Text = ""
            txtEstadoPago.Text = ""
            txtNeto.Text = ""
            txtIVA.Text = ""
            txtTotal.Text = ""
        End If

        Conexiones.Cnn.Close()
    End Sub

End Class
Imports System.Globalization
Imports MySql.Data.MySqlClient

Public Class TrabajoRealizar
    Inherits System.Web.UI.Page
    Public dst As DataSet
    Private ttrabajo As Integer
    Private final As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        VerificaCookie()

        Poblar()

        If Not (IsPostBack) Then
            listEmpresa()
            listSucursal()
            listCliente()
            listEmpleado()
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
        txtDescripcion.Text = ""
        Calendar1.SelectedDate = Today
        txtFecha.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss")
        ddlEmpresa.ClearSelection()
        ddlSucursal.ClearSelection()
        ddlEmpleado.ClearSelection()
        ddlCliente.ClearSelection()
        txtBuscar.Text = ""
        txtDescripcion.Focus()

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

        Dim da As New MySqlDataAdapter("CALL CallTrabajos('" & txtBuscar.Text & "',0,1)", Conexiones.Cnn)
        ' Dim ds As New DataSet
        dst = New DataSet
        da.Fill(dst)
        If dst.Tables(0).Rows.Count > 0 Then
            realizarGrid.DataSource = dst.Tables(0)
            realizarGrid.DataBind()

        Else
            realizarGrid.DataSource = Nothing
            realizarGrid.DataBind()
        End If


        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnID_Click(sender As Object, e As EventArgs) Handles btnID.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim da As New MySqlDataAdapter("CALL TrabajoByID('" & txtID.Text & "',0,1)", Conexiones.Cnn)
        'SELECT sucursal.*, empresa.NOMBRE as 'EMPRESA' FROM sucursal INNER JOIN empresa on empresa.ID_EMPRESA = sucursal.ID_EMPRESA
        Dim ds As New DataSet
        da.Fill(ds)

        If ds.Tables(0).Rows.Count > 0 Then
            txtDescripcion.Text = ds.Tables(0).Rows(0).Item("DESCRIPCION")
            Calendar1.SelectedDate = ds.Tables(0).Rows(0).Item("FECHA")
            txtFecha.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss")
            ddlEmpresa.SelectedValue = ds.Tables(0).Rows(0).Item("ID_EMPRESA")
            listSucursal()
            ddlSucursal.SelectedValue = ds.Tables(0).Rows(0).Item("ID_SUCURSAL")
            listEmpleado()
            ddlEmpleado.SelectedValue = ds.Tables(0).Rows(0).Item("ID_EMPLEADO")
            listCliente()
            ddlCliente.SelectedValue = ds.Tables(0).Rows(0).Item("ID_CLIENTE")

            If ds.Tables(0).Rows(0).Item("TIPOTRABAJO") = 1 Then
                RBPreventivo.Checked = True
            ElseIf ds.Tables(0).Rows(0).Item("TIPOTRABAJO") = 2 Then
                RBCorrectivo.Checked = True
            End If

            If ds.Tables(0).Rows(0).Item("FINALIZADO").ToString = "1" Then
                CBFinal.Checked = True
            ElseIf ds.Tables(0).Rows(0).Item("FINALIZADO").ToString = "0" Then
                CBFinal.Checked = False
            End If

        Else
            txtDescripcion.Text = ""
            Calendar1.SelectedDate = Today
            ddlEmpresa.ClearSelection()
            ddlSucursal.ClearSelection()
            ddlEmpleado.ClearSelection()
            ddlCliente.ClearSelection()
            RBCorrectivo.Checked = False
            RBPreventivo.Checked = False
            CBFinal.Checked = False
            'txtCorreo.Text = ""
        End If

        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnNuevo.Click
        VerificaCookie()

        Limpiar()

    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()
        If RBPreventivo.Checked = True Then
            ttrabajo = 1
        ElseIf RBCorrectivo.Checked = True Then
            ttrabajo = 2
        End If

        If txtID.Text = "0" Or txtID.Text = "" Then
            Dim cmd As New MySqlCommand("INSERT INTO `trabajorealizado`(`ID_EMPRESA`, `ID_SUCURSAL`, `ID_CLIENTE`, `ID_EMPLEADO`, `ID_USUARIO`, `FECHA`, `DESCRIPCION`, `TIPOTRABAJO`, `FINALIZADO`, `ACTIVO`) 
                                         VALUES ('" & ddlEmpresa.SelectedValue & "','" & ddlSucursal.SelectedValue & "','" & ddlCliente.SelectedValue & "','" & ddlEmpleado.SelectedValue & "','" & 1 & 'ActiveUser.IdUser
                                         "','" & txtFecha.Text & "','" & txtDescripcion.Text & "','" & ttrabajo & "b','" & final & "',b'1')", Conexiones.Cnn)
            cmd.ExecuteNonQuery()

            Poblar()
            Limpiar()
        Else
            Dim cmd As New MySqlCommand("UPDATE `trabajorealizado` SET `ID_EMPRESA`='" & ddlEmpresa.SelectedValue & "',`ID_SUCURSAL`='" & ddlSucursal.SelectedValue & "',`ID_CLIENTE`='" & ddlCliente.SelectedValue & "',`ID_EMPLEADO`='" & ddlEmpleado.SelectedValue & "',`ID_USUARIO`='" & 1 & "',`FECHA`='" & txtFecha.Text & 'ActiveUser.IdUser
                                        "',`DESCRIPCION`='" & txtDescripcion.Text & "',`TIPOTRABAJO`='" & ttrabajo & "',`FINALIZADO`= b'" & final & "',`ACTIVO`= b'1' WHERE `ID_TRABAJOREALIZADO`='" & txtID.Text & "'", Conexiones.Cnn)
            cmd.ExecuteNonQuery()

            Poblar()
            Limpiar()

        End If

        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        If MsgBox("¿Seguro que desea eliminar este registro ?", vbYesNo + vbCritical + vbDefaultButton2, "Atención") = vbYes Then
            Dim cmd As New MySqlCommand("UPDATE trabajorealizado SET `ACTIVO`= 0 WHERE ID_TRABAJOREALIZADO= " & txtID.Text, Conexiones.Cnn)
            cmd.ExecuteNonQuery()

            Poblar()
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
        ddlEmpresa.Items.Insert(0, New ListItem("----Seleccione Empresa----", "disabled"))

        Conexiones.Cnn.Close()

    End Sub

    Public Sub listSucursal()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim cmd As New MySqlCommand("select * from sucursal where ID_EMPRESA = '" & ddlEmpresa.SelectedValue & "' AND ACTIVO = '1'", Conexiones.Cnn)
        Dim da As New MySqlDataAdapter(cmd)
        dst = New DataSet
        Dim dt As New DataTable
        da.Fill(dst)

        ddlSucursal.DataSource = dst
        ddlSucursal.DataTextField = "NOMBRE"
        ddlSucursal.DataValueField = "ID_SUCURSAL"

        ddlSucursal.DataBind()
        ddlSucursal.Items.Insert(0, New ListItem("----Seleccione Sucursal----", "disabled"))

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
        ddlEmpleado.Items.Insert(0, New ListItem("----Seleccione Empleado----", "disabled"))

        Conexiones.Cnn.Close()

    End Sub

    Public Sub listCliente()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim cmd As New MySqlCommand("SELECT ID_CLIENTE, CONCAT(NOMBRE,' ',APELLIDO) as 'CLIENTE' FROM cliente WHERE ID_EMPRESA = '" & ddlEmpresa.SelectedValue &
                                    "' AND ID_SUCURSAL = '" & ddlSucursal.SelectedValue & "' AND ACTIVO = '1'", Conexiones.Cnn)
        Dim da As New MySqlDataAdapter(cmd)
        dst = New DataSet
        Dim dt As New DataTable
        da.Fill(dst)

        ddlCliente.DataSource = dst
        ddlCliente.DataTextField = "CLIENTE"
        ddlCliente.DataValueField = "ID_CLIENTE"

        ddlCliente.DataBind()
        ddlCliente.Items.Insert(0, New ListItem("----Seleccione Cliente----", "disabled"))

        Conexiones.Cnn.Close()

    End Sub

    Protected Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        ddlEmpresa.SelectedItem.Selected = True
        listSucursal()
    End Sub

    Protected Sub ddlSucursal_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSucursal.SelectedIndexChanged
        ddlSucursal.SelectedItem.Selected = True
        listCliente()
    End Sub

    Protected Sub ddlEmpleado_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpleado.SelectedIndexChanged
        ddlEmpleado.SelectedItem.Selected = True
    End Sub

    Protected Sub ddlCliente_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCliente.SelectedIndexChanged
        ddlCliente.SelectedItem.Selected = True
    End Sub

    Protected Sub Calendar1_SelectionChanged(sender As Object, e As EventArgs) Handles Calendar1.SelectionChanged
        Dim oDate As DateTime = Calendar1.SelectedDate
        txtFecha.Text = oDate.ToString("yyyy-MM-dd HH:mm:ss")
    End Sub

    Protected Sub CBFinal_CheckedChanged(sender As Object, e As EventArgs) Handles CBFinal.CheckedChanged
        If CBFinal.Checked = True Then
            final = 1
        ElseIf CBFinal.Checked = False Then
            final = 0
        End If
    End Sub


    Protected Sub txtFecha_TextChanged(sender As Object, e As EventArgs) Handles txtFecha.TextChanged
        txtFecha.Text = Calendar1.SelectedDate.ToString
    End Sub
End Class
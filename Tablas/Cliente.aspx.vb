Imports MySql.Data.MySqlClient

Public Class Cliente
    Inherits System.Web.UI.Page
    Public dst As DataSet

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        VerificaCookie()

        Poblar()

        If Not (IsPostBack) Then
            listEmpresa()
            listSucursal()

        End If

    End Sub

    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnNuevo.Click
        VerificaCookie()

        Limpiar()
    End Sub

    Private Sub Limpiar()
        txtID.Text = "0"
        txtNombre.Text = ""
        txtApellido.Text = ""
        txtTelefono.Text = ""
        txtCorreo.Text = ""
        txtBuscar.Text = ""
        ddlEmpresa.ClearSelection()
        ddlSucursal.ClearSelection()
        txtNombre.Focus()
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
        ddlSucursal.Items.Insert(0, New ListItem("----Seleccione Empresa----", "disabled"))

        Conexiones.Cnn.Close()

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

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        If txtID.Text = "0" Or txtID.Text = "" Then
            Dim cmd As New MySqlCommand("INSERT INTO `cliente`(`NOMBRE`, `APELLIDO`, `TELEFONO`, `CORREO`,`ID_EMPRESA`, `ID_SUCURSAL`, `ACTIVO`)
                                        VALUES ('" & txtNombre.Text & "', '" & txtApellido.Text & "', '" & txtTelefono.Text & "', '" & txtCorreo.Text &
                                        "', '" & ddlEmpresa.SelectedValue & "', '" & ddlSucursal.SelectedValue & "', b'1')", Conexiones.Cnn)
            cmd.ExecuteNonQuery()

            Poblar()
            Limpiar()
        Else
            Dim cmd As New MySqlCommand("UPDATE `cliente` SET `NOMBRE`='" & txtNombre.Text & "',`APELLIDO`='" & txtApellido.Text & "',`TELEFONO`='" & txtTelefono.Text & "',`CORREO`='" & txtCorreo.Text &
                                        "',`ID_EMPRESA`='" & ddlEmpresa.SelectedValue & "',`ID_SUCURSAL`= '" & ddlSucursal.SelectedValue & "',`ACTIVO`= '1' WHERE `ID_CLIENTE`='" & txtID.Text & "'", Conexiones.Cnn)
            cmd.ExecuteNonQuery()

            Poblar()
            Limpiar()

        End If

        Conexiones.Cnn.Close()
    End Sub

    Private Sub Poblar()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim da As New MySqlDataAdapter("SELECT cliente.*, empresa.ID_EMPRESA AS 'EMPR_ID', empresa.NOMBRE AS 'EMPRESA', sucursal.ID_SUCURSAL AS 'SUCR_ID', sucursal.NOMBRE AS 'SUCURSAL' FROM cliente
                                        INNER JOIN empresa ON empresa.ID_EMPRESA = cliente.ID_EMPRESA 
                                        INNER JOIN sucursal ON sucursal.ID_SUCURSAL= cliente.ID_SUCURSAL
                                        WHERE cliente.NOMBRE LIKE '%" & txtBuscar.Text & "%' and cliente.ACTIVO = '1'", Conexiones.Cnn) 'SELECT sucursal.ID_SUCURSAL, empresa.NOMBRE as 'EMPRESA', sucursal.NOMBRE, sucursal.DIRECCION, sucursal.TELEFONO, sucursal.ACTIVO FROM sucursal INNER JOIN empresa on empresa.ID_EMPRESA = sucursal.ID_EMPRESA
        ' Dim ds As New DataSet
        dst = New DataSet
        da.Fill(dst)
        If dst.Tables(0).Rows.Count > 0 Then
            clienteGrid.DataSource = dst.Tables(0)
            clienteGrid.DataBind()

        Else
            clienteGrid.DataSource = Nothing
            clienteGrid.DataBind()
        End If


        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        If MsgBox("¿Seguro que desea eliminar este registro ?", vbYesNo + vbCritical + vbDefaultButton2, "Atención") = vbYes Then
            Dim cmd As New MySqlCommand("UPDATE `cliente` SET `ACTIVO`= 0 WHERE `ID_CLIENTE` = " & txtID.Text, Conexiones.Cnn)
            cmd.ExecuteNonQuery()

            Poblar()
        End If

        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Poblar()

    End Sub

    Protected Sub btnID_Click(sender As Object, e As EventArgs) Handles btnID.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim da As New MySqlDataAdapter("SELECT cliente.*, empresa.ID_EMPRESA AS 'EMPR_ID', empresa.NOMBRE AS 'EMPRESA', sucursal.ID_SUCURSAL AS 'SUCR_ID', sucursal.NOMBRE AS 'SUCURSAL' FROM cliente
                                        INNER JOIN empresa ON empresa.ID_EMPRESA = cliente.ID_EMPRESA 
                                        INNER JOIN sucursal ON sucursal.ID_SUCURSAL= cliente.ID_SUCURSAL
                                        WHERE cliente.ID_CLIENTE ='" & txtID.Text & "' and cliente.ACTIVO = '1'", Conexiones.Cnn)
        'SELECT sucursal.*, empresa.NOMBRE as 'EMPRESA' FROM sucursal INNER JOIN empresa on empresa.ID_EMPRESA = sucursal.ID_EMPRESA
        Dim ds As New DataSet
        da.Fill(ds)
        If ds.Tables(0).Rows.Count > 0 Then
            txtNombre.Text = ds.Tables(0).Rows(0).Item("NOMBRE")
            txtApellido.Text = ds.Tables(0).Rows(0).Item("APELLIDO")
            txtTelefono.Text = ds.Tables(0).Rows(0).Item("TELEFONO")
            txtCorreo.Text = ds.Tables(0).Rows(0).Item("CORREO")
            ddlEmpresa.SelectedValue = ds.Tables(0).Rows(0).Item("ID_EMPRESA")
            listSucursal()
            ddlSucursal.SelectedValue = ds.Tables(0).Rows(0).Item("ID_SUCURSAL")
        Else
            txtNombre.Text = ""
            txtApellido.Text = ""
            txtTelefono.Text = ""
            txtCorreo.Text = ""
            ddlEmpresa.ClearSelection()
            ddlSucursal.ClearSelection()
        End If

        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnLimpiar_Click(sender As Object, e As EventArgs) Handles btnLimpiar.Click
        Limpiar()

        Poblar()
    End Sub

    Protected Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        ddlEmpresa.SelectedItem.Selected = True
        listSucursal()
    End Sub

    Protected Sub ddlSucursal_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSucursal.SelectedIndexChanged
        ddlSucursal.SelectedItem.Selected = True
    End Sub

End Class
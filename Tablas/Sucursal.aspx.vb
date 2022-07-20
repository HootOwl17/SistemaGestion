Imports MySql.Data.MySqlClient

Public Class Sucursal
    Inherits System.Web.UI.Page
    Public dst As DataSet

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        VerificaCookie()
        listEmpresa()
        Poblar()
    End Sub

    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnNuevo.Click
        VerificaCookie()

        Limpiar()
    End Sub

    Private Sub Limpiar()
        txtID.Text = "0"
        txtNombre.Text = ""
        'ddlEmpresa.DataSourceID = 0
        txtTelefono.Text = ""
        txtDireccion.Text = ""
        txtBuscar.Text = ""
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
        ddlEmpresa.Items.Insert(0, New ListItem("----Seleccione Empresa----", "0"))

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
            Dim cmd As New MySqlCommand("insert into sucursal(ID_EMPRESA,NOMBRE,TELEFONO,DIRECCION,ACTIVO) values(" & ddlEmpresa.SelectedItem.Value & ",'" &
                                        txtNombre.Text & "','" & txtTelefono.Text & "','" & txtDireccion.Text & "', '1')", Conexiones.Cnn)
            cmd.ExecuteNonQuery()

            Poblar()
            Limpiar()
        Else
            Dim cmd As New MySqlCommand("update sucursal set NOMBRE='" & txtNombre.Text & "', ID_EMPRESA = '" & ddlEmpresa.SelectedItem.Value &
                                        "', TELEFONO='" & txtTelefono.Text & "', DIRECCION='" & txtDireccion.Text &
                                        "' where ID_SUCURSAL=" & txtID.Text, Conexiones.Cnn)
            cmd.ExecuteNonQuery()

            Poblar()
            Limpiar()

        End If

        Conexiones.Cnn.Close()
    End Sub

    Private Sub Poblar()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim da As New MySqlDataAdapter("SELECT sucursal.*, empresa.NOMBRE as 'EMPRESA', empresa.ID_EMPRESA as 'EMPRESA_ID' FROM sucursal 
                                        INNER JOIN empresa on empresa.ID_EMPRESA = sucursal.ID_EMPRESA 
                                        WHERE sucursal.NOMBRE LIKE '%" & txtBuscar.Text & "%' and sucursal.ACTIVO = '1'", Conexiones.Cnn) 'SELECT sucursal.ID_SUCURSAL, empresa.NOMBRE as 'EMPRESA', sucursal.NOMBRE, sucursal.DIRECCION, sucursal.TELEFONO, sucursal.ACTIVO FROM sucursal INNER JOIN empresa on empresa.ID_EMPRESA = sucursal.ID_EMPRESA
        ' Dim ds As New DataSet
        dst = New DataSet
        da.Fill(dst)
        If dst.Tables(0).Rows.Count > 0 Then
            empresaGrid.DataSource = dst.Tables(0)
            empresaGrid.DataBind()

        Else
            empresaGrid.DataSource = Nothing
            empresaGrid.DataBind()
        End If


        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        If MsgBox("¿Seguro que desea eliminar este registro ?", vbYesNo + vbCritical + vbDefaultButton2, "Atención") = vbYes Then
            Dim cmd As New MySqlCommand("update sucursal SET ACTIVO = 0 where ID_SUCURSAL = " & txtID.Text, Conexiones.Cnn)
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

        Dim da As New MySqlDataAdapter("SELECT sucursal.*, empresa.NOMBRE as 'EMPRESA', empresa.ID_EMPRESA as 'EMPRESA_ID' FROM sucursal 
                                        INNER JOIN empresa on empresa.ID_EMPRESA = sucursal.ID_EMPRESA 
                                        WHERE sucursal.ID_SUCURSAL ='" & txtID.Text & "' and sucursal.ACTIVO = '1'", Conexiones.Cnn)
        'SELECT sucursal.*, empresa.NOMBRE as 'EMPRESA' FROM sucursal INNER JOIN empresa on empresa.ID_EMPRESA = sucursal.ID_EMPRESA
        Dim ds As New DataSet
        da.Fill(ds)
        If ds.Tables(0).Rows.Count > 0 Then
            txtNombre.Text = ds.Tables(0).Rows(0).Item("NOMBRE")
            txtTelefono.Text = ds.Tables(0).Rows(0).Item("TELEFONO")
            txtDireccion.Text = ds.Tables(0).Rows(0).Item("DIRECCION")
            ddlEmpresa.SelectedValue = ds.Tables(0).Rows(0).Item("ID_EMPRESA")
        Else
            txtNombre.Text = ""
            txtTelefono.Text = ""
            txtDireccion.Text = ""
        End If

        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnLimpiar_Click(sender As Object, e As EventArgs) Handles btnLimpiar.Click
        Limpiar()

        Poblar()
    End Sub

    Protected Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged

    End Sub
End Class
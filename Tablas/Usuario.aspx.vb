Imports MySql.Data.MySqlClient

Public Class Usuario
    Inherits System.Web.UI.Page
    Public dst As DataSet

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        VerificaCookie()

        Poblar()
    End Sub

    Private Sub Limpiar()
        txtID.Text = "0"
        txtNombre.Text = ""
        txtApellido.Text = ""
        txtCorreo.Text = ""
        txtPassword.Text = ""
        txtTelefono.Text = ""
        txtBuscar.Text = ""
        txtNombre.Focus()
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

    Private Sub Poblar()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim da As New MySqlDataAdapter("select * from usuario where NOMBRE LIKE '%" & txtBuscar.Text & "%' and ACTIVO = '1'", Conexiones.Cnn)
        ' Dim ds As New DataSet
        dst = New DataSet
        da.Fill(dst)
        If dst.Tables(0).Rows.Count > 0 Then
            usuarioGrid.DataSource = dst.Tables(0)
            usuarioGrid.DataBind()

        Else
            usuarioGrid.DataSource = Nothing
            usuarioGrid.DataBind()
        End If


        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnNuevo.Click
        VerificaCookie()
        txtID.Enabled = False
        Limpiar()
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        If txtID.Text = "0" Or txtID.Text = "" Then
            Dim cmd As New MySqlCommand("INSERT INTO `usuario`(`NOMBRE`, `APELLIDO`, `TELEFONO`, `CORREO`, `PASSWORD`, `ACTIVO`) VALUES ('" &
                                        txtNombre.Text & "','" & txtApellido.Text & "','" & txtTelefono.Text & "','" & txtCorreo.Text &
                                        "', SHA1('" & txtPassword.Text & "'), b'1')", Conexiones.Cnn)
            cmd.ExecuteNonQuery()

            Poblar()
            Limpiar()
        Else
            Dim cmd As New MySqlCommand("UPDATE `usuario` SET `NOMBRE`= '" & txtNombre.Text & "',`APELLIDO`='" & txtApellido.Text &
                                        "',`TELEFONO`='" & txtTelefono.Text & "',`CORREO`='" & txtCorreo.Text & "',`PASSWORD`= SHA1('" & txtPassword.Text &
                                        "') WHERE `ID_USUARIO`='" & txtID.Text & "'", Conexiones.Cnn)
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
            Dim cmd As New MySqlCommand("UPDATE usuario SET ACTIVO = 0 WHERE ID_USUARIO = " & txtID.Text, Conexiones.Cnn)
            cmd.ExecuteNonQuery()

            Poblar()
            Limpiar()
        End If

        Conexiones.Cnn.Close()
    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Poblar()

    End Sub

    Protected Sub btnLimpiar_Click(sender As Object, e As EventArgs) Handles btnLimpiar.Click
        Limpiar()
        Poblar()
        txtID.Enabled = True
    End Sub

    Protected Sub btnID_Click(sender As Object, e As EventArgs) Handles btnID.Click
        VerificaCookie()

        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim da As New MySqlDataAdapter("SELECT * FROM `usuario` WHERE `ID_USUARIO` = '" & txtID.Text & "' and `ACTIVO` = '1'", Conexiones.Cnn)
        Dim ds As New DataSet
        da.Fill(ds)
        If ds.Tables(0).Rows.Count > 0 Then
            txtNombre.Text = ds.Tables(0).Rows(0).Item("NOMBRE")
            txtApellido.Text = ds.Tables(0).Rows(0).Item("APELLIDO")
            txtTelefono.Text = ds.Tables(0).Rows(0).Item("TELEFONO")
            txtCorreo.Text = ds.Tables(0).Rows(0).Item("CORREO")
            txtPassword.Text = ds.Tables(0).Rows(0).Item("PASSWORD")
        Else
            txtNombre.Text = ""
            txtApellido.Text = ""
            txtTelefono.Text = ""
            txtCorreo.Text = ""
            txtPassword.Text = ""
        End If

        Conexiones.Cnn.Close()
    End Sub
End Class
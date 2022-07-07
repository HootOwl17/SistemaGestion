Imports MySql.Data.MySqlClient
Public Class login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub loginBtn_Click(sender As Object, e As EventArgs) Handles loginBtn.Click

        Conectar.ConectarMySql()
        'Conectar.Cnn.Open()
        Dim comando As MySqlCommand = New MySqlCommand

        comando.CommandText = "select * from usuarios where usuario='" & txtEmail.Text & "' and clave='" & txtPassword.Text & "'"

        Dim r As MySqlDataReader

        r = comando.ExecuteReader

        If r.HasRows <> False Then
            CreateCookies()
            r.Read()
            MsgBox(r.GetString("nombre"))
            Response.Redirect("~/index.aspx")

        Else
            MsgBox("usuario incorrecto! ", vbCritical, "Login Error")

        End If

        Conectar.Conexion.Close()
    End Sub

    Private Sub CreateCookies()
        Dim FechaHora As String = Now.AddMinutes(30)

        If Request.Cookies("EmpleadoASP") Is Nothing Then

            Dim aCookie As New HttpCookie("EmpleadoASP")
            aCookie.Value = "Activa"
            aCookie.Expires = FechaHora
            Response.Cookies.Add(aCookie)

        Else

            Dim cookie As HttpCookie = HttpContext.Current.Request.Cookies("EmpleadoASP")
            cookie.Value = "Activa"
            cookie.Expires = FechaHora
            Response.Cookies.Add(cookie)

        End If
    End Sub
End Class
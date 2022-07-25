Imports MySql.Data.MySqlClient
Imports SistemaGestion
Public Class login
    Inherits System.Web.UI.Page
    Public IDUser As Integer
    Public UserName As String
    Public UserLastName As String



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub loginBtn_Click(sender As Object, e As EventArgs) Handles loginBtn.Click

        'Conectar.ConectarMySql()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()
        'Dim comando As MySqlCommand = New MySqlCommand

        Dim da As New MySqlDataAdapter("select * from usuario where CORREO='" & txtEmail.Text & "' and PASSWORD= SHA1('" & txtPassword.Text & "') and ACTIVO= '1' ", Conexiones.Cnn)
        Dim ds As New DataSet
        da.Fill(ds)
        If ds.Tables(0).Rows.Count > 0 Then
            CreateCookies()
            Response.Redirect("~/index.aspx")
            While da.Fill(ds)
                ActiveUser.NameUser = ds.Tables(0).Rows(1).Item("NOMBRE")
                ActiveUser.LastNUser = ds.Tables(0).Rows(1).Item("APELLIDO")
                ActiveUser.Password = ds.Tables(0).Rows(1).Item("PASSWORD")
                ActiveUser.Phone = ds.Tables(0).Rows(1).Item("TELEFONO")
                ActiveUser.Email = ds.Tables(0).Rows(1).Item("CORREO")
                ActiveUser.Active = ds.Tables(0).Rows(1).Item("ACTIVO")
                ActiveUser.IdUser = ds.Tables(0).Rows(1).Item("ID_USUARIO")
            End While

        Else
            MsgBox("usuario incorrecto! ", vbCritical, "Login Error")

        End If

        Conexiones.Cnn.Close()
        'Conectar.Conexion.Close()
    End Sub

    Private Sub CreateCookies()
        Dim FechaHora As String = Now.AddMinutes(20)

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
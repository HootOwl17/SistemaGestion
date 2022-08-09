Imports SistemaGestion

Public Class index
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        VerificaCookie()

        lblUser.Text = ActiveUser.NameUser + " " + ActiveUser.LastNUser
        txtWelcome.Text = "BIENVENIDO " + ActiveUser.NameUser + " " + ActiveUser.LastNUser + " " + ActiveUser.IdUser
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

End Class
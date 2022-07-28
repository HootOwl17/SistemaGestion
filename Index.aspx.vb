Imports SistemaGestion

Public Class index
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        VerificaCookie()

        lblUser.Text = Session("NameUser") + " " + Session("LastNUser")
        txtWelcome.Text = "BIENVENIDO " + Session("NameUser") + " " + Session("LastNUser") + " " + Session("UserId")
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
Imports MySql.Data.MySqlClient

Public Class PagosHistorial
    Inherits System.Web.UI.Page
    Dim dst As DataSet

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Poblar()
        limpiar()

    End Sub

    Private Sub Poblar()
        Conexiones.AbrirConexion()
        Conexiones.Cnn.Open()

        Dim da As New MySqlDataAdapter("CALL CallPagoBitacora('" & txtBuscar.Text & "')", Conexiones.Cnn)
        ' Dim ds As New DataSet
        dst = New DataSet
        da.Fill(dst)
        If dst.Tables(0).Rows.Count > 0 Then
            bitacoraGrid.DataSource = dst.Tables(0)
            bitacoraGrid.DataBind()

        Else
            bitacoraGrid.DataSource = Nothing
            bitacoraGrid.DataBind()
        End If


        Conexiones.Cnn.Close()
    End Sub

    Public Sub limpiar()

        txtBuscar.Text = ""

        Poblar()

    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Poblar()

    End Sub

    Protected Sub btnLimpiar_Click(sender As Object, e As EventArgs) Handles btnLimpiar.Click
        limpiar()

    End Sub
End Class
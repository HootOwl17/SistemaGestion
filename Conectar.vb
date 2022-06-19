Imports MySql.Data.MySqlClient

Public Module Conectar
    Public Conexion As New MySqlConnection

    Public Sub ConectarMySql()
        Try
            With Conexion
                .ConnectionString = "server=localhost;User Id=root;database=sistemagestion;Password= ;SslMode=none"
                .Open()
            End With
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
End Module

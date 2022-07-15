Imports System.Web
Imports MySql.Data.MySqlClient

Public Module Conectar
    Public Conexion As New MySqlConnection
    Dim comando As MySqlCommand = New MySqlCommand
    'Public Shared Cnn As SqlClient.SqlConnection
    'Public Shared Validar As String = "0"

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

Public Class Conexiones
    'Public 
    Public Shared Cnn As MySqlConnection
    'Public Cnn As MySqlConnection
    Public Shared Validar As String = "0"

    Public Shared Sub AbrirConexion()
        Cnn = New MySqlConnection("server=localhost;Port=3306;User Id=root;database=sistemagestion;Password= ;") 'SslMode=none
        'Cnn.ConnectionString = "server=localhost:3306;User Id=root;database=sistemagestion;Password= ;" 'SslMode=none
    End Sub
End Class

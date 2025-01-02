<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proses Hapus Data Pendaftaran</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background: url('images/backgroundkampus.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.9); /* Semi-transparan */
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h1 {
            color: #4CAF50;
            font-size: 26px;
            margin-bottom: 20px;
        }

        .message {
            font-size: 16px;
            padding: 10px;
            margin: 20px 0;
            border-radius: 8px;
            font-weight: bold;
        }

        .success {
            color: green;
            background-color: #e8f5e9;
        }

        .error {
            color: red;
            background-color: #f8d7da;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: 500;
        }

        a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
            }

            h1 {
                font-size: 22px;
            }

            .message, button {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Proses Hapus Data Pendaftaran</h1>

        <%
            // Retrieve the email parameter from the request
            String email = request.getParameter("email");

            // Database connection details
            String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";  // Database URL
            String user = "root";  // Database username
            String password = "";  // Database password, adjust if necessary

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                // Load JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection to the database
                conn = DriverManager.getConnection(url, user, password);

                // SQL query to delete data from the dashboard table
                String deleteSQL = "DELETE FROM dashboard WHERE email = ?";
                pstmt = conn.prepareStatement(deleteSQL);
                pstmt.setString(1, email);

                // Execute the delete query
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
        %>
                    <div class="message success">
                        Data dengan email <%= email %> berhasil dihapus!
                    </div>
        <%
                } else {
        %>
                    <div class="message error">
                        Data dengan email <%= email %> tidak ditemukan!
                    </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='message error'>Terjadi kesalahan: " + e.getMessage() + "</div>");
            } finally {
                // Close the database resources
                try {
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='message error'>Kesalahan saat menutup koneksi: " + e.getMessage() + "</div>");
                }
            }
        %>

        <form action="lihatdata.jsp" method="GET">
            <button type="submit">Kembali ke Halaman Data Pendaftaran</button>
        </form>
    </div>
</body>
</html>

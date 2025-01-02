<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lihat Data Pendaftaran</title>
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

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 20px;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #4CAF50;
            margin-bottom: 30px;
            font-size: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        .action-buttons form {
            display: inline;
        }

        .action-buttons button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .action-buttons button:hover {
            background-color: #45a049;
        }

        .logout-button {
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        .logout-button:hover {
            background-color: #e53935;
        }

        .logout-button:focus {
            outline: none;
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 24px;
            }

            th, td {
                font-size: 12px;
                padding: 10px;
            }

            .logout-button {
                font-size: 14px;
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Lihat Data Pendaftaran Calon Mahasiswa Baru</h1>

    <table>
        <thead>
            <tr>
                <th>Email</th>
                <th>Nama Lengkap</th>
                <th>Tempat Lahir</th>
                <th>Tanggal Lahir</th>
                <th>Jenis Kelamin</th>
                <th>Alamat</th>
                <th>Agama</th>
                <th>Informasi Orang Tua</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
        <%
            String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";  // Database URL
            String user = "root";  // Database username
            String password = "";  // Database password

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Load JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection to the database
                conn = DriverManager.getConnection(url, user, password);

                // SQL query to retrieve all data from the dashboard table
                String sql = "SELECT * FROM dashboard";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                // Loop through the result set and display each record
                while (rs.next()) {
                    String email = rs.getString("email");
                    String namaLengkap = rs.getString("nama_lengkap");
                    String tempatLahir = rs.getString("tempat_lahir");
                    Date tanggalLahir = rs.getDate("tanggal_lahir");
                    String jenisKelamin = rs.getString("jenis_kelamin");
                    String alamat = rs.getString("alamat");
                    String agama = rs.getString("agama");
                    String informasiOrangtua = rs.getString("informasiorangtua");
        %>
            <tr>
                <td><%= email %></td>
                <td><%= namaLengkap %></td>
                <td><%= tempatLahir %></td>
                <td><%= tanggalLahir %></td>
                <td><%= jenisKelamin %></td>
                <td><%= alamat %></td>
                <td><%= agama %></td>
                <td><%= informasiOrangtua %></td>
                <td class="action-buttons">
                    <div style="display: flex; justify-content: center; gap: 10px;">
                    <!-- Edit button -->
                    <form action="updatedata.jsp" method="GET">
                        <input type="hidden" name="email" value="<%= email %>">
                        <button type="submit">Ubah Data</button>
                    </form>
                    <!-- Delete button -->
                    <form action="process_hapus.jsp" method="GET">
                        <input type="hidden" name="email" value="<%= email %>">
                        <button type="submit">Hapus Data</button>
                    </form>
                </td>
            </tr>
        <%
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h2>Terjadi kesalahan: " + e.getMessage() + "</h2>");
            } finally {
                // Close the database resources
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<h2>Kesalahan saat menutup koneksi: " + e.getMessage() + "</h2>");
                }
            }
        %>
        </tbody>
    </table>

    <!-- Logout Button -->
    <center>
        <form action="dashboard.jsp" method="POST">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </center>
</div>

</body>
</html>

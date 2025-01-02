<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            flex-direction: column;
            min-height: 100vh;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #4CAF50;
            font-size: 30px;
            margin-bottom: 20px;
            text-shadow: 1px 1px 5px rgba(0,0,0,0.2);
        }

        table {
            width: 90%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
        }

        td {
            font-size: 14px;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 8px;
            cursor: pointer;
            width: 100px;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            max-width: 450px;
            margin-bottom: 30px;
            width: 100%;
        }

        .logout-button {
            background-color: #f44336;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            color: white;
            font-size: 14px;
            width: 150px;
            transition: background-color 0.3s ease;
        }

        .logout-button:hover {
            background-color: #e53935;
        }

        .button-container {
            text-align: center;
            margin-top: 30px;
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 24px;
            }

            table {
                width: 100%;
                margin-top: 15px;
            }

            button {
                width: 80px;
                font-size: 12px;
            }

            .logout-button {
                width: 130px;
            }
        }
    </style>
</head>
<body>

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
            String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";
            String user = "root";
            String password = "";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                String sql = "SELECT * FROM dashboard";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

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
                <td>
                <div style="display: flex; justify-content: center; gap: 10px;">
                    <form action="updatedata.jsp" method="GET" style="display: inline;">
                        <input type="hidden" name="email" value="<%= email %>">
                        <button type="submit">Ubah Data</button>
                    </form>
                    <form action="cetakdata.jsp" method="GET" style="display: inline;">
                        <input type="hidden" name="email" value="<%= email %>">
                        <button type="submit">Cetak</button>
                    </form>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h2>Terjadi kesalahan: " + e.getMessage() + "</h2>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<h2>Kesalahan saat menutup koneksi: " + e.getMessage() + "</h2>");
                }
            }
        %>
        </tbody>
    </table>

    <div class="button-container">
        <!-- Logout Button -->
        <form action="dashboard.jsp" method="POST" style="display: inline;">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </div>

</body>
</html>

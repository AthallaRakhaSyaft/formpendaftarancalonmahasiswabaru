<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ubah Data Pendaftaran</title>
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
        }

        .form-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px 40px;
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

        label {
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-size: 14px;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #4CAF50;
            outline: none;
            box-shadow: 0 0 4px rgba(76, 175, 80, 0.3);
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

        .message {
            margin-top: 20px;
            font-size: 18px;
            color: #333;
            font-weight: bold;
        }

        .success {
            color: #4CAF50;
        }

        .error {
            color: #f44336;
        }

        .back-link {
            margin-top: 20px;
            text-align: center;
        }

        .back-link a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: 500;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
            }

            h1 {
                font-size: 22px;
            }

            label, input, select, button, .message {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Update Data Pendaftaran</h1>

        <%
            // Retrieve form data
            String email = request.getParameter("email");
            String namaLengkap = request.getParameter("namaLengkap");
            String tempatLahir = request.getParameter("tempatLahir");
            String tanggalLahirStr = request.getParameter("tanggalLahir");
            String jenisKelamin = request.getParameter("jenisKelamin");
            String alamat = request.getParameter("alamat");
            String agama = request.getParameter("agama");
            String informasiOrangtua = request.getParameter("informasiOrangtua");

            // Parse the date
            Date tanggalLahir = null;
            if (tanggalLahirStr != null && !tanggalLahirStr.isEmpty()) {
                try {
                    tanggalLahir = java.sql.Date.valueOf(tanggalLahirStr);
                } catch (Exception e) {
                    out.println("<div class='message error'>Format Tanggal Lahir tidak valid</div>");
                }
            }

            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";
            String user = "root";
            String password = "";
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                // Load JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection to the database
                conn = DriverManager.getConnection(url, user, password);

                // SQL query to update data
                String updateSQL = "UPDATE dashboard SET nama_lengkap = ?, tempat_lahir = ?, tanggal_lahir = ?, jenis_kelamin = ?, alamat = ?, agama = ?, informasiorangtua = ? WHERE email = ?";
                pstmt = conn.prepareStatement(updateSQL);
                pstmt.setString(1, namaLengkap);
                pstmt.setString(2, tempatLahir);
                pstmt.setDate(3, tanggalLahir);
                pstmt.setString(4, jenisKelamin);
                pstmt.setString(5, alamat);
                pstmt.setString(6, agama);
                pstmt.setString(7, informasiOrangtua);
                pstmt.setString(8, email);

                int updated = pstmt.executeUpdate();
                if (updated > 0) {
                    out.println("<div class='message success'>Data berhasil diperbarui!</div>");
                } else {
                    out.println("<div class='message error'>Gagal memperbarui data.</div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='message error'>Terjadi kesalahan: " + e.getMessage() + "</div>");
            } finally {
                // Close the database resources
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='message error'>Kesalahan saat menutup koneksi: " + e.getMessage() + "</div>");
                }
            }
        %>

        <div class="back-link">
            <a href="lihatdata.jsp">Kembali ke Halaman Data Pendaftaran</a>
        </div>
    </div>
</body>
</html>

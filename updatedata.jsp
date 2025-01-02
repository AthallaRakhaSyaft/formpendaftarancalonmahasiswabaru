<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Data Pendaftaran</title>
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
            flex-direction: column;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.9); /* Semi-transparan */
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h1 {
            color: #4CAF50;
            font-size: 28px;
            margin-bottom: 20px;
        }

        label {
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-size: 14px;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input:focus, textarea:focus {
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

        .error-message, .success-message {
            padding: 15px;
            margin-top: 20px;
            text-align: center;
            border-radius: 8px;
            font-size: 14px;
            font-weight: bold;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        a {
            color: white;
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
                font-size: 24px;
            }

            label, input, textarea, button {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h1>Update Data Pendaftaran</h1>

        <%
            // Retrieve the email parameter from the request (passed from the previous page)
            String email = request.getParameter("email");

            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";
            String user = "root";
            String password = "";
            Connection conn = null;
            ResultSet rs = null;

            String namaLengkap = "";
            String tempatLahir = "";
            String tanggalLahir = "";
            String jenisKelamin = "";
            String alamat = "";
            String agama = "";
            String informasiOrangtua = "";

            // Fetch existing data based on email
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                String selectSQL = "SELECT * FROM dashboard WHERE email = ?";
                PreparedStatement pstmt = conn.prepareStatement(selectSQL);
                pstmt.setString(1, email);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    namaLengkap = rs.getString("nama_lengkap");
                    tempatLahir = rs.getString("tempat_lahir");
                    java.sql.Date tanggalLahirSQL = rs.getDate("tanggal_lahir");
                    if (tanggalLahirSQL != null) {
                        tanggalLahir = tanggalLahirSQL.toString();
                    } else {
                        tanggalLahir = ""; // Set a default value if null
                    }
                    jenisKelamin = rs.getString("jenis_kelamin");
                    alamat = rs.getString("alamat");
                    agama = rs.getString("agama");
                    informasiOrangtua = rs.getString("informasiorangtua");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='error-message'>Terjadi kesalahan: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='error-message'>Kesalahan saat menutup koneksi: " + e.getMessage() + "</div>");
                }
            }
        %>

        <!-- Form for updating data -->
        <form action="updatedata.jsp" method="POST">
            <label for="email">Email:</label>
            <input type="text" id="email" name="email" value="<%= email %>" readonly>

            <label for="namaLengkap">Nama Lengkap:</label>
            <input type="text" id="namaLengkap" name="namaLengkap" value="<%= namaLengkap %>" required>

            <label for="tempatLahir">Tempat Lahir:</label>
            <input type="text" id="tempatLahir" name="tempatLahir" value="<%= tempatLahir %>" required>

            <label for="tanggalLahir">Tanggal Lahir:</label>
            <input type="date" id="tanggalLahir" name="tanggalLahir" value="<%= tanggalLahir %>" required>

            <label for="jenisKelamin">Jenis Kelamin:</label>
            <input type="text" id="jenisKelamin" name="jenisKelamin" value="<%= jenisKelamin %>" required>

            <label for="alamat">Alamat:</label>
            <textarea id="alamat" name="alamat" required><%= alamat %></textarea>

            <label for="agama">Agama:</label>
            <input type="text" id="agama" name="agama" value="<%= agama %>" required>

            <label for="informasiOrangtua">Informasi Orang Tua:</label>
            <textarea id="informasiOrangtua" name="informasiOrangtua" required><%= informasiOrangtua %></textarea>

            <div style="display: flex; justify-content: center; gap: 10px;">
            <button type="submit">Update Data</button>
        </form>

        <%
            // Handle form submission and update the data in the database
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                namaLengkap = request.getParameter("namaLengkap");
                tempatLahir = request.getParameter("tempatLahir");
                tanggalLahir = request.getParameter("tanggalLahir");
                jenisKelamin = request.getParameter("jenisKelamin");
                alamat = request.getParameter("alamat");
                agama = request.getParameter("agama");
                informasiOrangtua = request.getParameter("informasiOrangtua");

                try {
                    conn = DriverManager.getConnection(url, user, password);
                    String updateSQL = "UPDATE dashboard SET nama_lengkap = ?, tempat_lahir = ?, tanggal_lahir = ?, jenis_kelamin = ?, alamat = ?, agama = ?, informasiorangtua = ? WHERE email = ?";
                    PreparedStatement updatePstmt = conn.prepareStatement(updateSQL);
                    updatePstmt.setString(1, namaLengkap);
                    updatePstmt.setString(2, tempatLahir);
                    updatePstmt.setDate(3, java.sql.Date.valueOf(tanggalLahir));
                    updatePstmt.setString(4, jenisKelamin);
                    updatePstmt.setString(5, alamat);
                    updatePstmt.setString(6, agama);
                    updatePstmt.setString(7, informasiOrangtua);
                    updatePstmt.setString(8, email);

                    int updated = updatePstmt.executeUpdate();
                    if (updated > 0) {
                        out.println("<div class='success-message'>Data berhasil diperbarui!</div>");
                    } else {
                        out.println("<div class='error-message'>Gagal memperbarui data. Pastikan data yang Anda masukkan sudah benar.</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='error-message'>Terjadi kesalahan saat memperbarui data: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>

        <div style="display: flex; justify-content: center; gap: 10px;">
        <button style="background-color: red; color: white; border: none; padding: 12px 20px; border-radius: 4px; cursor: pointer; width: 100%;">
            <a href="lihatdata.jsp" style="color: white; text-decoration: none;">Kembali ke Halaman Data Pendaftaran</a>
        </button>
            
    </div>
</body>
</html>

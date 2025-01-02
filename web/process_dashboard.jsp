<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proses Registrasi</title>
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

        label {
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input:focus {
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

        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
            }

            h1 {
                font-size: 22px;
            }

            label, input, button {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Proses Registrasi</h1>

        <% 
            String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";  // Database URL
            String user = "root";  // Database username
            String password = "";  // Database password, adjust if necessary

            // Get the form data from the request
            String email = request.getParameter("email");
            String namaLengkap = request.getParameter("nama");
            String tempatLahir = request.getParameter("tempat_lahir");
            String tanggalLahir = request.getParameter("tanggal_lahir");
            String jenisKelamin = request.getParameter("jenis_kelamin");
            String alamat = request.getParameter("alamat");
            String agama = request.getParameter("agama");
            String informasiOrangtua = request.getParameter("informasiorangtua");
            String action = request.getParameter("cmddashboard"); // Action parameter for submit

            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                // Load JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Establish a connection to the database
                conn = DriverManager.getConnection(url, user, password);

                if ("simpan".equals(action)) {
                    // SQL query to insert new data into the dashboard table
                    String sql = "INSERT INTO dashboard (email, nama_lengkap, tempat_lahir, tanggal_lahir, jenis_kelamin, alamat, agama, informasiorangtua) " +
                                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, email);
                    stmt.setString(2, namaLengkap);
                    stmt.setString(3, tempatLahir);
                    stmt.setString(4, tanggalLahir);
                    stmt.setString(5, jenisKelamin);
                    stmt.setString(6, alamat);
                    stmt.setString(7, agama);
                    stmt.setString(8, informasiOrangtua);

                    // Execute the query
                    int result = stmt.executeUpdate();
                    if (result > 0) {
        %>
                        <div class="message success">
                            Data berhasil disimpan!
                        </div>
        <% 
                    } else {
        %>
                        <div class="message error">
                            Gagal menyimpan data.
                        </div>
        <% 
                    }
                } else {
        %>
                    <div class="message error">
                        Action tidak dikenali.
                    </div>
        <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='message error'>Terjadi kesalahan: " + e.getMessage() + "</div>");
            } finally {
                // Close the database connection
                try {
                    if (conn != null) {
                        conn.close();
                    }
                    if (stmt != null) {
                        stmt.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='message error'>Kesalahan saat menutup koneksi database: " + e.getMessage() + "</div>");
                }
            }
        %>

        <form action="registrasi.jsp" method="POST">
            <button type="submit">Kembali ke Halaman Registrasi</button>
        </form>
    </div>
</body>
</html>

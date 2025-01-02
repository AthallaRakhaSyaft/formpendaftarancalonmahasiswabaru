<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cetak Data Calon Mahasiswa</title>
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

        .container {
            width: 100%;
            max-width: 1200px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9); /* Semi-transparent background */
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #4CAF50;
            font-size: 28px;
            margin-bottom: 20px;
        }

        .data-row {
            margin-bottom: 15px;
            font-size: 16px;
            color: #333;
        }

        .label {
            font-weight: bold;
            color: #4CAF50;
        }

        .data-row span {
            font-weight: normal;
            color: #555;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
            transition: all 0.3s ease;
            border: none;
        }

        button:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            font-size: 18px;
            margin-bottom: 20px;
        }

        .success-message {
            color: green;
            font-size: 18px;
            margin-bottom: 20px;
        }

        /* Red button for Logout */
        .logout-button {
            background-color: red; /* Red background */
            color: white; /* White text */
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
            transition: all 0.3s ease;
            border: none;
        }

        .logout-button:hover {
            background-color: darkred; /* Darker red on hover */
        }

        @media print {
            body {
                background: none;
            }

            .container {
                max-width: 100%;
                box-shadow: none;
                padding: 20px;
            }

            button {
                display: none; /* Hide the print button on print */
            }

            h1 {
                font-size: 24px;
            }

            .data-row {
                font-size: 14px;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
                width: 90%;
            }

            h1 {
                font-size: 24px;
            }

            .data-row {
                font-size: 14px;
            }

            button {
                padding: 10px 20px;
            }
        }
    </style>
</head>
<body onload="window.print();">
    <div class="container">
        <h1>Detail Data Calon Mahasiswa Baru</h1>

        <div>
        <% 
            String email = request.getParameter("email");
            if (email == null || email.trim().isEmpty()) {
                out.println("<div class='error-message'>Email tidak valid atau tidak diberikan.</div>");
            } else {
                String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";
                String user = "root";
                String password = "";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);

                    String sql = "SELECT * FROM dashboard WHERE email = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, email);

                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String namaLengkap = rs.getString("nama_lengkap");
                        String tempatLahir = rs.getString("tempat_lahir");
                        Date tanggalLahir = rs.getDate("tanggal_lahir");
                        String jenisKelamin = rs.getString("jenis_kelamin");
                        String alamat = rs.getString("alamat");
                        String agama = rs.getString("agama");
                        String informasiOrangtua = rs.getString("informasiorangtua");
        %>

        <div class="data-row">
            <span class="label">Email:</span> <%= email %>
        </div>
        <div class="data-row">
            <span class="label">Nama Lengkap:</span> <%= namaLengkap %>
        </div>
        <div class="data-row">
            <span class="label">Tempat Lahir:</span> <%= tempatLahir %>
        </div>
        <div class="data-row">
            <span class="label">Tanggal Lahir:</span> <%= tanggalLahir %>
        </div>
        <div class="data-row">
            <span class="label">Jenis Kelamin:</span> <%= jenisKelamin %>
        </div>
        <div class="data-row">
            <span class="label">Alamat:</span> <%= alamat %>
        </div>
        <div class="data-row">
            <span class="label">Agama:</span> <%= agama %>
        </div>
        <div class="data-row">
            <span class="label">Informasi Orang Tua:</span> <%= informasiOrangtua %>
        </div>

        <% 
                    } else {
                        out.println("<div class='error-message'>Data dengan email " + email + " tidak ditemukan.</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='error-message'>Terjadi kesalahan: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
        </div>
        
        <form action="lihatdata.jsp" method="get">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </div>
</body>
</html>

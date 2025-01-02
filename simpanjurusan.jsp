<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simpan Jurusan</title>
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
            max-width: 400px;
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

            label, input, button, .message {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Hasil Penyimpanan Data</h1>
        <% 
            String jurusan = request.getParameter("jurusan");
            String hargaStr = request.getParameter("harga");

            if (jurusan != null && hargaStr != null && !hargaStr.trim().isEmpty()) {
                String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru"; 
                String user = "root"; 
                String password = "";

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);

                    String insertSql = "INSERT INTO jurusandanharga (jurusan, harga_per_semester) VALUES (?, ?)";
                    pstmt = conn.prepareStatement(insertSql);
                    pstmt.setString(1, jurusan);
                    pstmt.setDouble(2, Double.parseDouble(hargaStr));
                    int rows = pstmt.executeUpdate();

                    if (rows > 0) {
                        out.println("<div class='message success'>Data berhasil disimpan!</div>");
                    } else {
                        out.println("<div class='message error'>Gagal menyimpan data.</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='message error'>Terjadi kesalahan: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<div class='message error'>Data tidak lengkap.</div>");
            } 
        %>
        <div class="back-link">
            <a href="jurusan.jsp">Kembali ke Form</a>
        </div>
    </div>
</body>
</html>

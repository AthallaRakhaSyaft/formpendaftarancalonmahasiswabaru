<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proses Ulasan</title>
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
            background: rgba(255, 255, 255, 0.9); /* Semi-transparan */
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        h1 {
            text-align: center;
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

        input, textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
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

        p.message {
            text-align: center;
            color: #666;
            margin-top: 15px;
            font-size: 14px;
        }

        p.success {
            color: #4CAF50;
        }

        p.error {
            color: #f44336;
        }

        a {
            display: block;
            text-align: center;
            color: #4CAF50;
            text-decoration: none;
            font-weight: 500;
            margin-top: 20px;
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

            label, input, textarea, button, a {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Proses Ulasan</h1>
        
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String message = "";
            String messageClass = "";

            try {
                String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";
                String user = "root";
                String password = "";

                conn = DriverManager.getConnection(url, user, password);

                String nama = request.getParameter("nama");
                String ulasan = request.getParameter("ulasan");
                int rating = Integer.parseInt(request.getParameter("rating"));

                // Check if review already exists
                String checkSQL = "SELECT COUNT(*) FROM ulasan WHERE nama = ? AND ulasan = ?";
                stmt = conn.prepareStatement(checkSQL);
                stmt.setString(1, nama);
                stmt.setString(2, ulasan);
                rs = stmt.executeQuery();
                rs.next();

                if (rs.getInt(1) > 0) {
                    message = "Ulasan sudah ada sebelumnya. Silakan masukkan ulasan yang berbeda.";
                    messageClass = "error";
                } else {
                    // Insert the review into the database
                    String insertSQL = "INSERT INTO ulasan (nama, ulasan, rating) VALUES (?, ?, ?)";
                    stmt = conn.prepareStatement(insertSQL);
                    stmt.setString(1, nama);
                    stmt.setString(2, ulasan);
                    stmt.setInt(3, rating);
                    stmt.executeUpdate();
                    message = "Ulasan berhasil ditambahkan!";
                    messageClass = "success";
                }

            } catch (SQLException e) {
                message = "Terjadi kesalahan: " + e.getMessage();
                messageClass = "error";
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
        
        <!-- Display the message -->
        <p class="message <%= messageClass %>"><%= message %></p>

        <!-- Link to go back to the main page -->
        <a href="ulasan.jsp">Kembali ke halaman utama</a>
    </div>
</body>
</html>

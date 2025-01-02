<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .success {
            color: #4CAF50;
        }

        .error {
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

            label, input, button, p, a {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Proses Registrasi</h1>
        
        <%
            // Database connection settings
            String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";
            String user = "root";
            String password = "";

            // Get form values
            String email = request.getParameter("email");
            String rawPassword = request.getParameter("password");
            String nama = request.getParameter("nama");
            String tempatLahir = request.getParameter("tempat_lahir");
            String jurusan = request.getParameter("jurusan");
            String action = request.getParameter("cmdregister"); // Action (simpan, ubah, hapus)

            // Initialize message variables
            String message = "";
            String messageClass = "";

            // Validate input
            if (email == null || email.isEmpty() || rawPassword == null || rawPassword.isEmpty() || nama == null || nama.isEmpty()) {
                message = "Semua field wajib diisi!";
                messageClass = "error";
            } else {
                // Hash the password using SHA-256
                String hashedPassword = null;
                try {
                    MessageDigest md = MessageDigest.getInstance("SHA-256");
                    md.update(rawPassword.getBytes());
                    byte[] byteData = md.digest();
                    StringBuilder sb = new StringBuilder();
                    for (byte b : byteData) {
                        sb.append(String.format("%02x", b));
                    }
                    hashedPassword = sb.toString();
                } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
                    message = "Terjadi kesalahan pada pengolahan password: " + e.getMessage();
                    messageClass = "error";
                }

                // Create database connection
                Connection conn = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);

                    if (action != null) {
                        if ("simpan".equals(action)) {
                            // Check if the email already exists
                            String checkEmailSQL = "SELECT COUNT(*) FROM register WHERE email = ?";
                            PreparedStatement checkStmt = conn.prepareStatement(checkEmailSQL);
                            checkStmt.setString(1, email);
                            ResultSet rs = checkStmt.executeQuery();
                            if (rs.next() && rs.getInt(1) > 0) {
                                message = "Email sudah terdaftar!";
                                messageClass = "error";
                            } else {
                                // Insert new user into database
                                String insertSQL = "INSERT INTO register (email, password, nama, tempat_lahir, jurusan) VALUES (?, ?, ?, ?, ?)";
                                PreparedStatement insertStmt = conn.prepareStatement(insertSQL);

                                insertStmt.setString(1, email);
                                insertStmt.setString(2, hashedPassword);
                                insertStmt.setString(3, nama);
                                insertStmt.setString(4, tempatLahir);
                                insertStmt.setString(5, jurusan);
                                int result = insertStmt.executeUpdate();

                                if (result > 0) {
                                    message = "Data berhasil disimpan.";
                                    messageClass = "success";
                                } else {
                                    message = "Terjadi kesalahan saat menyimpan data.";
                                    messageClass = "error";
                                }
                            }
                        } else if ("ubah".equals(action)) {
                            // Update existing data
                            String updateSQL = "UPDATE register SET password = ?, nama = ?, tempat_lahir = ?, jurusan = ? WHERE email = ?";
                            PreparedStatement updateStmt = conn.prepareStatement(updateSQL);

                            updateStmt.setString(1, hashedPassword);
                            updateStmt.setString(2, nama);
                            updateStmt.setString(3, tempatLahir);
                            updateStmt.setString(4, jurusan);
                            updateStmt.setString(5, email);
                            int result = updateStmt.executeUpdate();

                            if (result > 0) {
                                message = "Data berhasil diubah.";
                                messageClass = "success";
                            } else {
                                message = "Terjadi kesalahan saat mengubah data.";
                                messageClass = "error";
                            }
                        } else if ("hapus".equals(action)) {
                            // Delete data
                            String deleteSQL = "DELETE FROM register WHERE email = ?";
                            PreparedStatement deleteStmt = conn.prepareStatement(deleteSQL);

                            deleteStmt.setString(1, email);
                            int result = deleteStmt.executeUpdate();

                            if (result > 0) {
                                message = "Data berhasil dihapus.";
                                messageClass = "success";
                            } else {
                                message = "Terjadi kesalahan saat menghapus data.";
                                messageClass = "error";
                            }
                        } else {
                            message = "Operasi tidak dikenali.";
                            messageClass = "error";
                        }
                    } else {
                        message = "Action tidak diberikan.";
                        messageClass = "error";
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    message = "Terjadi kesalahan: " + e.getMessage();
                    messageClass = "error";
                } finally {
                    // Ensure the connection is closed
                    try {
                        if (conn != null && !conn.isClosed()) {
                            conn.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        message = "Kesalahan saat menutup koneksi database: " + e.getMessage();
                        messageClass = "error";
                    }
                }
            }
        %>

        <!-- Display the message -->
        <p class="message <%= messageClass %>"><%= message %></p>

        <!-- Link to go back to the registration page -->
        <a href="registrasi.jsp">Kembali ke halaman registrasi</a>
    </div>
</body>
</html>

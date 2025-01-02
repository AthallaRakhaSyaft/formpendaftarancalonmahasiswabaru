<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proses dan Lihat Data Pendaftaran dan Pembayaran</title>
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

        .container {
            background: rgba(255, 255, 255, 0.9); /* Semi-transparan */
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }

        h1, h2 {
            text-align: center;
            color: #4CAF50;
            font-size: 26px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            text-align: left;
        }

        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #4CAF50;
            color: white;
            text-align: center;
        }

        table td {
            background-color: #f9f9f9;
        }

        .message {
            padding: 10px;
            text-align: center;
            margin-top: 20px;
        }

        .message.success {
            background-color: #4CAF50;
            color: white;
        }

        .message.error {
            background-color: #f44336;
            color: white;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
            width: 48%;
        }

        button:hover {
            background-color: #45a049;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px 30px;
            }

            h1, h2 {
                font-size: 22px;
            }

            button {
                font-size: 14px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Proses dan Lihat Data Pendaftaran dan Pembayaran</h1>

        <%
            // Get form data
            String kodependaftaran = request.getParameter("kodependaftaran");
            String email = request.getParameter("email");
            String namaLengkap = request.getParameter("namaLengkap");
            String jurusan = request.getParameter("jurusan");
            String harga = request.getParameter("harga");

            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";
            String user = "root";
            String password = "";

            Connection conn = null;
            PreparedStatement stmt = null;
            int result = 0;

            // Process the form submission and insert into database
            if (kodependaftaran != null && email != null && namaLengkap != null && jurusan != null && harga != null) {
                try {
                    // Step 1: Load the JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Step 2: Establish the connection
                    conn = DriverManager.getConnection(url, user, password);

                    // Step 3: Prepare SQL query to insert data into the pembayaran table
                    String sql = "INSERT INTO pembayaran (kodependaftaran, email, namaLengkap, jurusan, harga) "
                               + "VALUES (?, ?, ?, ?, ?)";

                    // Step 4: Prepare the statement and set the values
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, kodependaftaran);
                    stmt.setString(2, email);
                    stmt.setString(3, namaLengkap);
                    stmt.setString(4, jurusan);
                    stmt.setString(5, harga);

                    // Step 5: Execute the insert query
                    result = stmt.executeUpdate();

                    // Step 6: Check if the insertion was successful
                    if (result > 0) {
        %>
                        <div class="message success">
                            <h2>Data berhasil disimpan!</h2>
                        </div>
        <%
                    } else {
        %>
                        <div class="message error">
                            <h2>Gagal menyimpan data!</h2>
                        </div>
        <%
                    }

                } catch (Exception e) {
                    // Handle exception
                    e.printStackTrace();
                    out.println("<div class='message error'>Error: " + e.getMessage() + "</div>");
                } finally {
                    // Step 7: Close the resources
                    try {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>

        <!-- Display the submitted data -->
        <h2>Data Pendaftaran</h2>
        <table>
            <thead>
                <tr>
                    <th>Kode Pendaftaran</th>
                    <th>Email</th>
                    <th>Nama Lengkap</th>
                    <th>Jurusan</th>
                    <th>Harga per Semester</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= kodependaftaran %></td>
                    <td><%= email %></td>
                    <td><%= namaLengkap %></td>
                    <td><%= jurusan %></td>
                    <td>Rp <%= harga %></td>
                </tr>
            </tbody>
        </table>

        <div class="button-container">
            <button onclick="window.history.back();">Kembali ke Form Pendaftaran</button>
            <!-- Add Print Button -->
            <button onclick="window.print();">Cetak Data</button>
        </div>
        
    </div>

</body>
</html>

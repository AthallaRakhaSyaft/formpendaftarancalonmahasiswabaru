<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pilih Jurusan dan Masukkan Harga per Semester</title>
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
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            margin-bottom: 30px;
        }

        h1 {
            text-align: center;
            color: #4CAF50;
            font-size: 26px;
            margin-bottom: 20px;
            text-shadow: 1px 1px 5px rgba(0,0,0,0.2);
        }

        label {
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-size: 14px;
        }

        select, input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        select:focus, input:focus {
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

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
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

        tr:hover {
            background-color: #f1f1f1;
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

        @media (max-width: 768px) {
            h1 {
                font-size: 22px;
            }

            select, input, button {
                font-size: 13px;
                padding: 10px;
            }

            table {
                width: 100%;
            }
        }
    </style>
</head>
<body>

    <!-- Form Container -->
    <div class="form-container">
        <h1>Pilih Jurusan dan Masukkan Harga per Semester</h1>

        <!-- Form to select Jurusan and input Harga per Semester -->
        <form action="simpanjurusan.jsp" method="POST">
            <label for="jurusan">Pilih Jurusan:</label>
            <select id="jurusan" name="jurusan" required>
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
                        String sql = "SELECT jurusan FROM jurusan";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            String jurusanData = rs.getString("jurusan");
                %>
                    <option value="<%= jurusanData %>"><%= jurusanData %></option>
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
            </select>

            <label for="harga">Harga per Semester:</label>
            <input type="text" id="harga" name="harga" required />

            <button type="submit">Simpan Data</button>
        </form>
    </div>

    <!-- Display Data Table -->
    <h1>Data Jurusan dan Harga per Semester</h1>

    <table>
        <thead>
            <tr>
                <th>Jurusan</th>
                <th>Harga per Semester</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    conn = DriverManager.getConnection(url, user, password);
                    String sql = "SELECT jurusan, harga_per_semester FROM jurusan";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String jurusanData = rs.getString("jurusan");
                        double hargaPerSemester = rs.getDouble("harga_per_semester");
            %>
                <tr>
                    <td><%= jurusanData %></td>
                    <td>Rp <%= String.format("%,.2f", hargaPerSemester).replace(',', '.') %></td>
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

    <!-- Logout Button -->
    <div style="text-align: center;">
        <form action="dashboard.jsp" method="POST">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </div>

</body>
</html>

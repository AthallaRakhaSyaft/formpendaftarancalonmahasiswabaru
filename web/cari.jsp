<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PMB Online System - Cari</title>
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

        h1 {
            color: #4CAF50;
            font-size: 30px;
            margin-bottom: 20px;
            text-align: center;
        }

        .search-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            margin-bottom: 30px;
        }

        .search-container label {
            font-weight: 500;
            margin-bottom: 10px;
            color: #555;
            display: block;
        }

        .search-container select,
        .search-container input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .search-container select:focus,
        .search-container input:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 4px rgba(76, 175, 80, 0.3);
            outline: none;
        }

        .search-container button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: all 0.3s ease;
            border: none;
        }

        .search-container button:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            max-width: 800px;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
            font-size: 16px;
            color: #333;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .logout-button {
            background-color: #f44336;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            width: 100%;
        }

        .logout-button:hover {
            background-color: #e53935;
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 26px;
            }

            .search-container {
                padding: 20px;
                width: 90%;
            }

            .search-container label,
            .search-container select,
            .search-container input,
            .search-container button {
                font-size: 14px;
            }

            table th, table td {
                font-size: 14px;
            }
        }
        
            .logout-button {
            background-color: #f44336;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            width: 100%;
            margin-top: 30px; /* Added margin-top to push the logout button down */
        }

            .logout-button:hover {
            background-color: #e53935;
        }    
    </style>
</head>
<body>
    <h1>Cari Data Pendaftaran Calon Mahasiswa Baru</h1>

    <div class="search-container">
        <form action="cari.jsp" method="GET">
            <label for="search">Cari Berdasarkan:</label>
            <select id="search" name="search_type" required>
                <option value="email">Email</option>
                <option value="nama">Nama Lengkap</option>
            </select>

            <label for="keyword">Masukkan Kata Kunci:</label>
            <input type="text" id="keyword" name="keyword" placeholder="Masukkan kata kunci pencarian" required>

            <button type="submit">Cari</button>
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th>Email</th>
                <th>Nama Lengkap</th>
            </tr>
        </thead>
        <tbody>
        <% 
            String searchType = request.getParameter("search_type");
            String keyword = request.getParameter("keyword");

            if (searchType != null && keyword != null && !keyword.trim().isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru", "root", "");

                    String query = "";
                    if ("email".equals(searchType)) {
                        query = "SELECT email, nama_lengkap FROM dashboard WHERE email LIKE ?";
                    } else if ("nama".equals(searchType)) {
                        query = "SELECT email, nama_lengkap FROM dashboard WHERE nama_lengkap LIKE ?";
                    }

                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, "%" + keyword + "%");
                    rs = pstmt.executeQuery();

                    boolean hasResults = false;
                    while (rs.next()) {
                        hasResults = true;
                        String email = rs.getString("email");
                        String nama = rs.getString("nama_lengkap");
        %>
            <tr>
                <td><%= email %></td>
                <td><%= nama %></td>
            </tr>
        <% 
                    }

                    if (!hasResults) {
        %>
            <tr>
                <td colspan="2">Tidak ada data yang ditemukan untuk kata kunci: <%= keyword %></td>
            </tr>
        <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<h2>Terjadi kesalahan: " + e.getMessage() + "</h2>");
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            }
        %>
        </tbody>
    </table>

    <form action="dashboard.jsp" method="POST">
        <button type="submit" class="logout-button">Logout</button>
    </form>

</body>
</html>

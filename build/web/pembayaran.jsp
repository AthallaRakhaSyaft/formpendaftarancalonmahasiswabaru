<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lihat Data Pendaftaran dan Jurusan</title>
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
            align-items: flex-start;
            min-height: 100vh;
            padding-top: 50px;
        }

        .container {
            background: rgba(255, 255, 255, 0.9); /* Semi-transparan */
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1200px;
        }

        h1 {
            text-align: center;
            color: #4CAF50;
            font-size: 28px;
            margin-bottom: 20px;
        }

        h2 {
            color: #4CAF50;
            font-size: 22px;
            margin-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
        }

        .form-container {
            margin-top: 30px;
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

        .logout-button {
            background-color: #f44336;
            margin-top: 30px;
        }

        .logout-button:hover {
            background-color: #e53935;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            h1, h2 {
                font-size: 22px;
            }

            th, td, input, button {
                font-size: 13px;
            }

            table {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <div class="container">

        <h1>Lihat Data Pendaftaran Calon Mahasiswa Baru</h1>

        <!-- Data Pendaftaran Table -->
        <h2>Data Pendaftaran</h2>
        <table>
            <thead>
                <tr>
                    <th>Email</th>
                    <th>Nama Lengkap</th>
                    <th>Tempat Lahir</th>
                    <th>Tanggal Lahir</th>
                    <th>Jenis Kelamin</th>
                    <th>Alamat</th>
                    <th>Agama</th>
                    <th>Informasi Orang Tua</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
            <%-- Koneksi ke database untuk mendapatkan data pendaftaran --%>
            <%
                String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";
                String user = "root";
                String password = "";

                try (Connection conn = DriverManager.getConnection(url, user, password);
                     Statement stmt = conn.createStatement()) {

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String sql = "SELECT * FROM dashboard";
                    try (ResultSet rs = stmt.executeQuery(sql)) {
                        while (rs.next()) {
                            String email = rs.getString("email");
                            String namaLengkap = rs.getString("nama_lengkap");
                            String tempatLahir = rs.getString("tempat_lahir");
                            Date tanggalLahir = rs.getDate("tanggal_lahir");
                            String jenisKelamin = rs.getString("jenis_kelamin");
                            String alamat = rs.getString("alamat");
                            String agama = rs.getString("agama");
                            String informasiOrangtua = rs.getString("informasiorangtua");
            %>
                <tr>
                    <td><%= email %></td>
                    <td><%= namaLengkap %></td>
                    <td><%= tempatLahir %></td>
                    <td><%= tanggalLahir %></td>
                    <td><%= jenisKelamin %></td>
                    <td><%= alamat %></td>
                    <td><%= agama %></td>
                    <td><%= informasiOrangtua %></td>
                    <td>
                        <form action="updatedata.jsp" method="GET">
                            <input type="hidden" name="email" value="<%= email %>">
                            <button type="submit">Ubah Data</button>
                        </form>
                    </td>
                </tr>
            <%
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            </tbody>
        </table>

        <!-- Data Jurusan Table -->
        <h2>Data Jurusan</h2>
        <table>
            <thead>
                <tr>
                    <th>ID Jurusan</th>
                    <th>Nama Jurusan</th>
                    <th>Harga per Semester</th>
                </tr>
            </thead>
            <tbody>
            <%-- Koneksi ke database untuk mendapatkan data jurusan --%>
            <%
                try (Connection conn = DriverManager.getConnection(url, user, password);
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT * FROM jurusan")) {

                    while (rs.next()) {
                        int idJurusan = rs.getInt("id");
                        String namaJurusan = rs.getString("jurusan");
                        double hargaPerSemester = rs.getDouble("harga_per_semester");
            %>
                <tr>
                    <td><%= idJurusan %></td>
                    <td><%= namaJurusan %></td>
                    <td>Rp <%= String.format("%,.2f", hargaPerSemester).replace(',', '.') %></td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            </tbody>
        </table>

        <!-- Form Pendaftaran dan Pembayaran -->
        <div class="form-container">
            <h2>Form Pendaftaran dan Pembayaran</h2>
            <form action="process_pembayaran.jsp" method="POST">
                <label for="kodependaftaran">Kode Pendaftaran:</label>
                <input type="text" id="kodependaftaran" name="kodependaftaran" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="namaLengkap">Nama Lengkap:</label>
                <input type="text" id="namaLengkap" name="namaLengkap" required>

                <label for="jurusan">Jurusan:</label>
                <input type="text" id="jurusan" name="jurusan" required>

                <label for="harga">Harga per Semester:</label>
                <input type="text" id="harga" name="harga" required>

                <button type="submit">Submit</button>
            </form>
        </div>

        <!-- Logout Button -->
        <center>
            <form action="dashboard.jsp" method="POST">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </center>

    </div>

</body>
</html>

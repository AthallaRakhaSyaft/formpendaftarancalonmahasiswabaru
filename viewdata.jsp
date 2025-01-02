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
    <title>View Data Pendaftaran dan Pembayaran</title>
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
            background: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        h1 {
            text-align: center;
            color: #4CAF50;
            font-size: 26px;
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
            margin-top: 20px;
            text-align: left;
        }

        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        table th {
            background-color: #4CAF50;
            color: white;
        }

        table td {
            background-color: #f9f9f9;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            cursor: pointer;
            width: 150px;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
                margin: 10px;
            }

            h1 {
                font-size: 22px;
            }

            h2 {
                font-size: 18px;
            }

            table th, table td {
                font-size: 13px;
            }

            button {
                width: 100%;
                font-size: 14px;
                padding: 12px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>View Data Pendaftaran dan Pembayaran</h1>

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
                <%
                    String kodePendaftaran = request.getParameter("kodependaftaran");
                    String email = request.getParameter("email");
                    String namaLengkap = request.getParameter("namaLengkap");
                    String jurusan = request.getParameter("jurusan");
                    String harga = request.getParameter("harga");
                %>

                <tr>
                    <td><%= kodePendaftaran %></td>
                    <td><%= email %></td>
                    <td><%= namaLengkap %></td>
                    <td><%= jurusan %></td>
                    <td>Rp <%= harga %></td>
                </tr>

            </tbody>
        </table>

        <div class="button-container">
            <button onclick="window.history.back();">Kembali</button>
        </div>
        
    </div>

</body>
</html>

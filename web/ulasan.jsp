<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ulasan Mahasiswa</title>
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
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .nav {
            width: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 15px 0;
            text-align: center;
        }

        .nav h1 {
            color: white;
            font-size: 24px;
            margin-bottom: 10px;
        }

        .nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .nav ul li {
            display: inline;
        }

        .nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 15px;
            border-radius: 4px;
        }

        .nav ul li a:hover {
            background-color: #4CAF50;
            transition: background-color 0.3s ease;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            margin-top: 20px;
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

        .logout {
            text-align: center;
            margin-top: 20px;
        }

        .logout button {
            background-color: #f44336;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .logout button:hover {
            background-color: #d32f2f;
        }

        @media (max-width: 768px) {
            .nav h1 {
                font-size: 20px;
            }

            .nav ul {
                flex-direction: column;
                gap: 10px;
            }

            .form-container {
                padding: 20px;
            }

            h1 {
                font-size: 22px;
            }

            label, input, textarea, button {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="nav">
        <h1>PMB Online System</h1>
        <ul>
            <li><a href="dashboard.jsp">Home</a></li>
            <li><a href="ulasan.jsp">Ulasan</a></li>
            <li><a href="lihatdata.jsp">Lihat Data</a></li>
            <li><a href="ubah.jsp">Ubah</a></li>
            <li><a href="hapus.jsp">Hapus</a></li>
            <li><a href="cari.jsp">Cari</a></li>
            <li><a href="jurusan.jsp">Jurusan</a></li>
            <li><a href="pembayaran.jsp">Pembayaran</a></li>
        </ul>    
    </div>

    <div class="form-container">
        <h1>Ulasan Mahasiswa</h1>

        <!-- Form for submitting the review -->
        <form action="process_ulasan.jsp" method="POST">
            <div class="form-group">
                <label for="nama">Nama:</label>
                <input type="text" id="nama" name="nama" placeholder="Masukkan nama Anda" required>
            </div>

            <div class="form-group">
                <label for="ulasan">Ulasan:</label>
                <textarea id="ulasan" name="ulasan" rows="4" placeholder="Tulis ulasan Anda" required></textarea>
            </div>

            <div class="form-group">
                <label for="rating">Rating (1-5):</label>
                <input type="number" id="rating" name="rating" min="1" max="5" required>
            </div>

            <button type="submit">Kirim Ulasan</button>
        </form>

        <div class="logout">
            <form action="dashboard.jsp" method="get">
                <button type="submit">Logout</button>
            </form>
        </div>
    </div>
</body>
</html>

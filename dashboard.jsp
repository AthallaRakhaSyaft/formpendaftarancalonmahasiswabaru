<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PMB Online System</title>
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
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-direction: row;
            margin: 0 20px;
        }

        nav {
            width: 250px;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 20px;
            border-radius: 8px;
            margin-right: 20px;
            flex-shrink: 0;
        }

        nav h1 {
            text-align: center;
            color: white;
            margin-bottom: 20px;
        }

        nav ul {
            list-style: none;
            padding-left: 0;
        }

        nav ul li {
            margin: 10px 0;
        }

        nav ul li a {
            text-decoration: none;
            color: #fff;
            font-weight: 500;
            font-size: 16px;
            transition: color 0.3s;
        }

        nav ul li a:hover {
            color: #4CAF50;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            margin-left: 20px;
        }

        h1 {
            text-align: center;
            color: #4CAF50;
            font-size: 26px;
            margin-bottom: 20px;
        }

        h2 {
            margin-bottom: 15px;
            font-size: 20px;
            color: #4CAF50;
        }

        label {
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-size: 14px;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input:focus, select:focus, textarea:focus {
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

        p {
            text-align: center;
            color: #666;
            margin-top: 15px;
            font-size: 14px;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: 500;
        }

        a:hover {
            text-decoration: underline;
        }

        .logout {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .logout button {
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }

        .logout button:hover {
            background-color: #d32f2f;
        }

        @media (max-width: 768px) {
            nav {
                width: 100%;
                margin-right: 0;
                margin-bottom: 20px;
            }

            .container {
                flex-direction: column;
                align-items: center;
            }

            .form-container {
                width: 100%;
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
    <div class="container">
        <nav>
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
        </nav>

        <div class="form-container">
            <form action="process_dashboard.jsp" method="POST">
                <h1>Formulir Pendaftaran Calon Mahasiswa Baru</h1>

                <h2>Informasi Akun Login</h2>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Masukkan email" required>

                <h2>Informasi Utama</h2>
                <label for="nama">Nama Lengkap:</label>
                <input type="text" id="nama" name="nama" placeholder="Masukkan nama lengkap" required>

                <label for="tempat_lahir">Tempat Lahir:</label>
                <input type="text" id="tempat_lahir" name="tempat_lahir" placeholder="Masukkan tempat lahir" required>

                <label for="tanggal_lahir">Tanggal Lahir:</label>
                <input type="date" id="tanggal_lahir" name="tanggal_lahir" required>

                <div class="form-group">
                    <label for="jenis_kelamin">Jenis Kelamin:</label>
                    <div class="radio-group">
                        <label>
                            <input type="radio" id="laki-laki" name="jenis_kelamin" value="laki-laki" required>
                            Laki-laki
                        </label>
                        <label>
                            <input type="radio" id="perempuan" name="jenis_kelamin" value="perempuan" required>
                            Perempuan
                        </label>
                    </div>
                </div>

                <label for="alamat">Alamat Lengkap:</label>
                <textarea id="alamat" name="alamat" rows="4" placeholder="Masukkan alamat lengkap" required></textarea>

                <label for="agama">Agama:</label>
                <select id="agama" name="agama" required>
                    <option value="islam">Islam</option>
                    <option value="kristen">Kristen</option>
                    <option value="katolik">Katolik</option>
                    <option value="hindu">Hindu</option>
                    <option value="buddha">Buddha</option>
                    <option value="lainnya">Lainnya</option>
                </select>

                <label for="informasiorangtua">Informasi Orang Tua</label>
                <input type="text" id="informasiorangtua" name="informasiorangtua" placeholder="Masukkan No. Telephone Orang Tua" required>

                <input type="hidden" name="cmddashboard" value="simpan">
                <button type="submit">Simpan</button>
            </form>
            
            <div class="logout">
                <form action="index.jsp" method="get">
                    <button type="submit">Logout</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

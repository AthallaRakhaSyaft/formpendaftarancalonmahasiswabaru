<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
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
        <h1>Login</h1>
        <form id="loginForm" action="process_login.jsp" method="POST">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Masukkan email Anda" required>
            
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Masukkan password Anda" required>
            
            <button type="submit">Login</button>
        </form>
        <p>Belum punya akun? <a href="register.jsp">Daftar di sini</a></p>
    </div>
</body>
</html>

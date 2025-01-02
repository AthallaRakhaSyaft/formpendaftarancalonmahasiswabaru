<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.security.MessageDigest" %>
<%@page import="java.security.NoSuchAlgorithmException" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Proses Login</title>
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
            padding: 40px 50px;
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

        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
            margin-top: 15px;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 20px 30px;
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

<%
    // Database connection settings
    String url = "jdbc:mysql://localhost:3306/formpendaftaranmahasiswabaru";
    String user = "root";
    String password = "";

    // Get form data
    String email = request.getParameter("email");
    String rawPassword = request.getParameter("password");

    // Validate input
    if (email == null || rawPassword == null || email.isEmpty() || rawPassword.isEmpty()) {
        response.sendRedirect("dashboard.jsp?error=missing_fields");
        return;
    }

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
        response.sendRedirect("dashboard.jsp?error=hashing_error");
        return;
    }

    // Connect to the database
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Prepare SQL statement to check credentials
        String sql = "SELECT * FROM login WHERE email = ? AND password = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, hashedPassword);

        // Execute the query
        ResultSet rs = pstmt.executeQuery();

        // Check if a matching user was found
        if (rs.next()) {
            // Successful login, redirect to the home page or user dashboard
            response.sendRedirect("dashboard.jsp?login=true");
        } else {
            // Invalid credentials, redirect back to login with an error
            response.sendRedirect("dashboard.jsp?error=invalid_credentials");
        }

        // Close resources
        rs.close();
        pstmt.close();
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("dashboard.jsp?error=database_error");
    } finally {
        // Ensure the connection is closed in case of an exception
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!-- comment
    <div class="form-container">
        <h1>Login</h1>

        <form method="POST">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>

            <button type="submit">Login</button>
        </form>

        <p>Don't have an account? <a href="register.jsp">Sign Up</a></p>
    </div>

</body>
</html>
-->

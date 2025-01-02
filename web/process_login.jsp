<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.security.MessageDigest" %>
<%@page import="java.security.NoSuchAlgorithmException" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Proses Login</title>
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
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="checkConnection.jsp" %>
<%
   String name = (String) session.getAttribute("name");
   String userid = (String) session.getAttribute("userid");
   String adminid = (String) session.getAttribute("adminid");
   String loginBtnLink = (name != null && !name.isEmpty()) ? "./logout.jsp" : "./login.jsp";
   String loginBtnStatus = (name != null && !name.isEmpty()) ? "Logout" : "Login";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" href="css/container.css">
    <script src="./js/nav.js"></script>
    <style>
        /* CSS styles go here */
    </style>
</head>
<body>
    <nav class="navbar">
		<div class="logo">UserED</div>
		<div class="menu-toggle" onclick="toggleMenu()">&#9776;</div>
		<div class="menu">
			<a href="./" class="link">Home</a>
			<a href="./courses.jsp" class="link">Courses</a>
			<a href="#" class="link">Students</a>
			<a href="quickstart.jsp" class="link">Quick Start Guide</a>
        </div>
	</nav>
	<div class="page-overlay"></div>
    <div class="container">
        <header>
            <h1>Login Page</h1>
        </header>
    <%
        String email = request.getParameter("email");
        String passwd = request.getParameter("passwd");

        try {
            // database connection already Establish in checkConnection.jsp
            Connection conn = (Connection) request.getAttribute("conn"); // Retrieve the database connection
            // Prepare the SQL query to check user existence
            String query = "SELECT * FROM admins WHERE email = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);

            // Execute the query
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // User exists, check password
                String storedPassword = rs.getString("password");
                String uname = rs.getString("name");
                String admin_id = rs.getString("admin_id");

                if (passwd.equals(storedPassword)) {
                    if (session == null) {
                        session = request.getSession(true);
                    }
                    // Authentication successful
                    session.setAttribute("name", uname);
                    session.setAttribute("adminid", admin_id);
                    // code for page Redirect
                    // response.sendRedirect("user/"); // Redirect to the dashboard page
                    String continueUrl = request.getParameter("continue");
                    if (continueUrl != null && !continueUrl.isEmpty()) {
                        out.print("<h2>Login successful, Go to <a href='admin/" + continueUrl + "' color='white;'><button class='link login button'>" + continueUrl + "</button></a><h2>");
                    }else{
                        out.print("<h2>Login successful, Go to <a href='admin/' color='white;'><button class='link login button'>Dashboard</button></a><h2>");
                    }
                } else {
                    // Authentication failed - incorrect password
                    out.print("<h2 color='red;'>Login failed - incorrect password , <a href='admin.jsp' color='white;'><button class='link login button'>Try Again</button></a></h2>");
                }
            } else {
                // Authentication failed - user does not exist
                out.print("<h2 color='red;'>Login failed - incorrect Admin Email Address, <a href='admin.jsp' color='white;'><button class='link login button'>Try Again</button></a></h2>");
            }

            // Close database resources
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            out.print("An error occurred: " + e.getMessage());
        }
    %>
    </div>
</body>
</html>

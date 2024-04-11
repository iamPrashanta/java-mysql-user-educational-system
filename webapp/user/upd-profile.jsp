<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../checkConnection.jsp" %>
<%
    String name = (String) session.getAttribute("name");
    String userid = (String) session.getAttribute("userid");
    String loginBtnLink = (name != null && !name.isEmpty()) ? "./logout.jsp" : "./login.jsp";
    String loginBtnStatus = (name != null && !name.isEmpty()) ? "Logout" : "Login";

    if (name == null && userid == null) {
        // User is not logged in, redirect to the login page
        response.sendRedirect("../login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Update Profile</title>
	<link rel="stylesheet" href="../css/navbar.css">
	<link rel="stylesheet" href="../css/sidenav.css">
    <link rel="stylesheet" href="../css/page-content.css">
	<script src="../js/nav.js"></script>
</head>
<body>
    <nav class="navbar">
        <div class="logo">UserED</div>
        <a href="<%= loginBtnLink %>" class="link login button" style="margin-top: 5px;margin-left: 10px;margin-right: 30px;"><%= loginBtnStatus %></a>
    </nav>
	<div class="page-overlay"></div>
	<div id="sidebar" class="visible">
        <ul>
            <li><a href="./">Dashboard</a></li>
            <li><a href="./profile.jsp">My Profile</a></li>
            <li><a href="./my-courses.jsp">My Courses</a></li>
            <li><a href="./search-courses.jsp">Search Courses</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
        <h2>Update Profile</h2>
        <%
        try {
            // Database connection already established in checkConnection.jsp
            Connection conn = (Connection) request.getAttribute("conn");

            // Prepare the SQL query to retrieve user profile by user ID
            String query = "SELECT * FROM users WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userid);

            // Execute the query
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Retrieve user profile data
                String uname = rs.getString("name");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String address = rs.getString("address");
                String passwd = rs.getString("password");

                // Output user data in the form fields
                %>
                <form action="upd-profile02.jsp" method="post">
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" id="uname" value="<%= uname %>" name="uname" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone:</label>
                        <input type="tel" id="phone" name="phone" value="<%= phone %>" required pattern="[0-9]{10,12}">
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" placeholder="<%= email %> (readonly)" value="<%= email %>" readonly required style="cursor:no-drop;">
                    </div>
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <input type="text" id="address" name="address" value="<%= address %>" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="text" id="passwd" name="passwd" value="<%= passwd %>" required>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Submit">
                    </div>
                </form>
                <%
            } else {
                // User not found
                out.println("<p>User not found <a href='./'>Go Back</a></p>");
            }

            // Close database resources
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            out.println("An error occurred: " + e.getMessage());
        }
        %>
    </div>
</body>
</html>
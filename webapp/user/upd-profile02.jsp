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
        // Retrieve user inputs from the registration form
        String uname = request.getParameter("uname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String passwd = request.getParameter("passwd");


        if (uname == null || phone == null || email == null || address == null || passwd == null) {
            response.sendRedirect("./");
        }
        
        try {
            // database connection already Establish in checkConnection.jsp
            Connection conn = (Connection) request.getAttribute("conn"); // Retrieve the database connection

            // Create a SQL query to insert the user into the database
            String updateQuery = "UPDATE users SET name = ?, phone = ?, address = ?, password = ? WHERE id = ? AND email = ?";
            PreparedStatement pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, uname);
            pstmt.setString(2, phone);
            pstmt.setString(3, address);
            pstmt.setString(4, passwd);
            pstmt.setString(5, userid);
            pstmt.setString(6, email);
            int profileUpdated = pstmt.executeUpdate();
            if (profileUpdated > 0) {
                // Update successful
                out.println("<p>Profile Update successful! <a href='./profile.jsp'> View Profile </a></p>");
            } else {
                // Update failed
                out.println("<p>Profile Update failed. <a href='./profile.jsp'> Try Again </a></p>");

            }

            // Close database resources
            pstmt.close();
        } catch (Exception e) {
            out.println("<p>An error occurred: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        %>
    </div>
</body>
</html>
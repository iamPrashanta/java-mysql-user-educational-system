<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../../checkConnection.jsp" %>
<%
    String name = (String) session.getAttribute("name");
    String adminid = (String) session.getAttribute("adminid");
    String loginBtnLink = (name != null && !name.isEmpty()) ? "../logout.jsp" : "../login.jsp";
    String loginBtnStatus = (name != null && !name.isEmpty()) ? "Logout" : "Login";

    if (name == null && adminid == null) {
        // User is not logged in, redirect to the login page
        response.sendRedirect("../../admin.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Student Management System</title>
	<link rel="stylesheet" href="../../css/navbar.css">
	<link rel="stylesheet" href="../../css/sidenav.css">
	<link rel="stylesheet" href="../../css/page-content.css">
	<script src="../../js/nav.js"></script>
</head>
<body>
    <nav class="navbar">
        <div class="logo">UserED</div>
        <a href="<%= loginBtnLink %>" class="link login button" style="margin-top: 5px;margin-left: 10px;margin-right: 30px;"><%= loginBtnStatus %></a>
    </nav>
	<div class="page-overlay"></div>
	<div id="sidebar" class="visible">
        <ul>
            <li><a href="../">Dashboard</a></li>
            <li><a href="./">Users List</a></li>
            <li><a href="../course/view_courses.jsp">Courses</a></li>
            <li><a href="#">Add New Job</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
            <h2>Add New User</h2>
        <%
            if (request.getMethod().equals("POST")) {
                // Retrieve user inputs from the registration form
                String user_id = request.getParameter("user_id");
                String uname = request.getParameter("uname");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String password = request.getParameter("password");
                String address = request.getParameter("address");
                if (user_id == null || uname == null || email == null || phone == null || password == null || address == null) {
                    response.sendRedirect("./add.jsp");
                }
                try {
                    // database connection already Establish in checkConnection.jsp
                    Connection conn = (Connection) request.getAttribute("conn"); // Retrieve the database connection

                    // Create a SQL query to insert the user into the database
                    String insertQuery = "INSERT INTO users (id, name, email, phone, address, password) VALUES (?, ?, ?, ?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                    pstmt.setString(1, user_id);
                    pstmt.setString(2, uname);
                    pstmt.setString(3, email);
                    pstmt.setString(4, phone);
                    pstmt.setString(5, address);
                    pstmt.setString(6, password);
                    int rowsInserted = pstmt.executeUpdate();
                    if (rowsInserted > 0) {
                        // Registration successful
                        out.println("<p>Registration successful! <a href='./'> go to Users List</a></p>");
                    } else {
                        // Registration failed
                        out.println("<p>Registration failed. <a href='./add.jsp'> Please try again.</a></p>");
                    }

                    // Close database resources
                    pstmt.close();
                } catch (Exception e) {
                    out.println("<p>An error occurred: " + e.getMessage() + " <a href='./add.jsp'> go Back</a> & ReSubmit the Form</p>");
                    e.printStackTrace();
                }
            }else{
                out.println("<p>An error occurred: <a href='./add.jsp'> go Back</a> & ReSubmit the Form</p>");
            }
        %>
    </div>
</body>
</html>

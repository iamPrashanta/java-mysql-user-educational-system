<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<title>Student Management System</title>
	<link rel="stylesheet" href="css/navbar.css">
	<link rel="stylesheet" href="css/container.css">
	<script src="./js/nav.js"></script>
</head>
<body>
    <nav class="navbar">
		<div class="logo">UserED</div>
		<div class="menu-toggle" onclick="toggleMenu()">&#9776;</div>
		<div class="menu">
			<a href="#" class="link">Home</a>
			<a href="./courses.jsp" class="link">Courses</a>
			<a href="#" class="link">Students</a>
			<a href="quickstart.jsp" class="link">Quick Start Guide</a>
            <a href="<%= loginBtnLink %>" class="link login button" style="margin-top: 5px"><%= loginBtnStatus %></a>
        </div>
	</nav>
	<div class="page-overlay"></div>
    <div class="container">
        <%
        int student_id = Integer.parseInt(request.getParameter("student_id"));
        String uname = request.getParameter("uname");
        String email = request.getParameter("email");
        int phone = Integer.parseInt(request.getParameter("phone"));
        String passwd = request.getParameter("passwd");

        try {
            // database connection already Establish in checkConnection.jsp
            Connection conn = (Connection) request.getAttribute("conn"); // Retrieve the database connection
            // Insert the form data into the users table
            String sql = "INSERT INTO users (id, name, email, phone, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, student_id);
            pstmt.setString(2, uname);
            pstmt.setString(3, email);
            pstmt.setInt(4, phone);
            pstmt.setString(5, passwd);
            pstmt.executeUpdate();

            // Redirect to a confirmation page
            response.sendRedirect("confirmation.jsp?student_id=" + student_id + "&name=" + name);
        } catch (Exception e) {
            out.println("An error occurred: " + e.getMessage());
            e.printStackTrace();
            %>
            <p><a href="signup.jsp">Try again</a></p>
            <%
        }
        %>
    </div>
</body>
</html>
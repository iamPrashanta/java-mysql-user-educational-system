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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
	<link rel="stylesheet" href="../css/navbar.css">
	<link rel="stylesheet" href="../css/sidenav.css">
  <link rel="stylesheet" href="../../css/page-content.css">
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
            <li><a href="./profile.jsp">My Profile</a></li>
            <li><a href="./upd-profile.jsp">Update Profile</a></li>
            <li><a href="./my-courses.jsp">My Courses</a></li>
            <li><a href="./search-courses.jsp">Search Courses</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
        <h2>Hello, <u><%= name %></u></h2>
        <img src="https://www.shutterstock.com/image-vector/user-icon-trendy-flat-style-600nw-418179865.jpg"  class="img-fluid" style="width: 200px; height: 200px; border-radius:50%;" alt="Image">
        <p>Welcome to your UserED Dashboard! Your personalized hub for educational and career excellence. Here, youre in control. Easily manage your courses, explore exciting job opportunities, and showcase your achievements. Connect with mentors for guidance and engage in lively discussions with peers. Your profile is your digital identity – update it with your latest accomplishments. Share your personal projects and receive valuable feedback from our supportive community. UserED is where your educational and professional journey unfolds. Your dashboard is your command center, designed to empower you on your path to success.</p>
    </div>
</body>
</html>

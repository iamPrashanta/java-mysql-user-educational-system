<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../checkConnection.jsp" %>
<%
    String name = (String) session.getAttribute("name");
    String adminid = (String) session.getAttribute("adminid");
    String loginBtnLink = (name != null && !name.isEmpty()) ? "./logout.jsp" : "./login.jsp";
    String loginBtnStatus = (name != null && !name.isEmpty()) ? "Logout" : "Login";

    if (name == null && adminid == null) {
        // User is not logged in, redirect to the login page
        response.sendRedirect("../admin.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Student Management System</title>
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
            <li><a href="./">Dashboard</a></li>
            <li><a href="./users/">Users List</a></li>
            <li><a href="./course/view_courses.jsp">Courses</a></li>
            <li><a href="#">Add New Job</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
    <h2>Profile (<%= name %>)</h2>
    <div id="profile">
        <img src="https://www.shutterstock.com/image-vector/user-icon-trendy-flat-style-600nw-418179865.jpg"  class="img-fluid" style="width: 200px; height: 200px; border-radius:50%;" alt="Image">
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis aliquet mauris quis dui ultricies, vitae consectetur elit pellentesque. Quisque sollicitudin tortor id libero tristique, sed tempor metus dapibus. Integer tincidunt, odio ac congue ultricies, mauris leo tincidunt metus, in consequat justo ligula id justo. Nunc quis bibendum sem.</p>
    </div>
</div>

</body>
</html>
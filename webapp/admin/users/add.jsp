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
        <div id="form-field">
            <div id="form">
                <h2>Add New User</h2>
                <form action="add_new.jsp" method="post">
                    <div class="form-group">
                        <label for="userID">User ID:</label>
                        <input type="text" id="user_id" name="user_id" required pattern="[0-9]{6}" title="6 digit user id">
                    </div>
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" id="uname" name="uname" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone:</label>
                        <input type="tel" id="phone" name="phone" required pattern="[0-9]{10,12}">
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <input type="text" id="address" name="address" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="text" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Submit">
                    </div>
                </form>
            </div>

            <div id="form-image">
                <img src="../../img/typing.gif">
            </div>
        </div>
    </div>
</body>
</html>
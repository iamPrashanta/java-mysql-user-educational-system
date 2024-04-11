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
            <li><a href="../users/">Users List</a></li>
            <li><a href="./view_courses.jsp">View All Courses</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
            <h2> Add New Course</h2>
            <div class="course-container">
                <form action="add_course2.jsp" method="post">
                    <div class="form-group">
                        <label for="name">Course Name:</label>
                        <input type="text" id="course_name" name="course_name" required pattern="[A-Za-z]{3,15}">
                    </div>
                    <div class="form-group">
                        <label for="Uniq id">Course Uniq ID:</label>
                        <input type="text" id="course_id" name="course_id" required pattern="[A-Z0-9]{3,15}" placeholder="eg : JAVA101">
                    </div>
                    <div class="form-group">
                        <label for="Uniq id">Course Length (Hours):</label>
                        <input type="text" id="course_length" name="course_length" required pattern="[0-9]{1,3}" placeholder="eg : 10">
                    </div>
                    <div class="form-group">
                        <label for="Description">Course Description:</label>
                        <textarea class="input-textarea" id="course_description" name="course_description" required placeholder="Write a Description about this Course"></textarea>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Submit">
                    </div>
                </form>
            </div>
    </div>
</body>
</html>
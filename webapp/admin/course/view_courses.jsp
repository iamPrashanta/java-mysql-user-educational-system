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
	<link rel="stylesheet" href="../../css/courses.css">
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
            <li><a href="./add_course.jsp">Add New Course</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
        <h2> All Course(s)</h2>
        <div class="course-container">
            <%
            try {
                // Retrieve the database connection from the request attribute
                Connection conn = (Connection) request.getAttribute("conn");

                String get_course_list = "SELECT * FROM courses";
                PreparedStatement pstmt = conn.prepareStatement(get_course_list);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    // Get the course ID for this course_join_history table
                    String course_id = rs.getString("course_id");
                    String course_name = rs.getString("course_name");
                    String course_length = rs.getString("course_length");
                    String course_description = rs.getString("course_description");
                    String course_banner = rs.getString("course_banner");
                    %>
                    <div class="course">
                        <div class="image-container">
                            <img src="./img/<%= course_banner %>" alt="Course Image">
                        </div>
                        <div class="text-container">
                            <h3><%= course_name %></h3>
                            <p>Course Description: <%= course_description %></p>
                            <p>Total Duration: <%= course_length %> weeks</p>
                        </div>
                    </div>
                    <%
                }
            } catch (Exception e) {
                out.println("<p>Something Wrong! <a href='../users/'> go to Users List</a></p>");
            }
            %>
        </div>
    </div>
</body>
</html>
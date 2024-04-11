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
                <%
                if (request.getMethod().equals("POST")) {
                    // Retrieve user inputs from the registration form
                    String course_id = request.getParameter("course_id");
                    String course_name = request.getParameter("course_name");
                    String course_length = request.getParameter("course_length");
                    String course_description = request.getParameter("course_description");
                    if (course_id == null || course_name == null || course_description == null) {
                        response.sendRedirect("./add_course.jsp");
                    }else{
                        try {
                            // database connection already Establish in checkConnection.jsp
                            Connection conn = (Connection) request.getAttribute("conn"); // Retrieve the database connection
        
                            // Create a SQL query to insert the user into the database
                            String insertQuery = "INSERT INTO `courses`(`course_id`, `course_name`, `course_length`, `course_description`, `course_banner`) VALUES (?, ?, ?, ?, ?)";
                            PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                            pstmt.setString(1, course_id);
                            pstmt.setString(2, course_name);
                            pstmt.setString(3, course_length);
                            pstmt.setString(4, course_description);
                            pstmt.setString(5, course_name + ".jpg");

                            int rowsInserted = pstmt.executeUpdate();
                            if (rowsInserted > 0) {
                                // Registration successful
                                out.println("<p>Course Added Successfully <a href='./view_courses.jsp'> View List</a></p>");
                            } else {
                                // Registration failed
                                out.println("<p>Course failed to add. <a href='./add_course.jsp'> Please try again.</a></p>");
                            }
        
                            // Close database resources
                            pstmt.close();
                        } catch (Exception e) {
                            out.println("<p>An error occurred: " + e.getMessage() + " <a href='./add_course.jsp'> go Back</a> & ReSubmit the Form</p>");
                            e.printStackTrace();
                        }
                    }
                }else{
                    out.println("<p>An error occurred: <a href='./add_course.jsp'> go Back</a> & ReSubmit the Form</p>");
                }
                %>
            </div>
    </div>
</body>
</html>
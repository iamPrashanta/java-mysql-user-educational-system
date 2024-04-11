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
    <link rel="stylesheet" href="../css/page-content.css">
    <link rel="stylesheet" href="../css/courses.css">
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
        <h2> My Course(s) Details</h2>

        <%
        Boolean coursesFound = false;
        try {
            // Retrieve the database connection from the request attribute
            Connection conn = (Connection) request.getAttribute("conn");

            String get_applied_course_list = "SELECT * FROM course_join_history WHERE user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(get_applied_course_list);
            pstmt.setString(1, userid);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                // Get the course ID for this course_join_history table
                String course_id = rs.getString("course_id");
            
                // get Course Data using course_id
                String get_course_data = "SELECT * FROM courses WHERE course_id = ?";
                PreparedStatement pstmt2 = conn.prepareStatement(get_course_data);
                pstmt2.setString(1, course_id);
                ResultSet rs2 = pstmt2.executeQuery();

                if (rs2.next()) {
                    String course_name = rs2.getString("course_name");
                    String course_length = rs2.getString("course_length");
                    String course_description = rs2.getString("course_description");
                    String course_banner = rs2.getString("course_banner");
                    %>
                    <div class="course">
                        <div class="image-container">
                            <img src="../admin/course/img/<%= course_banner %>" alt="Course Image">
                        </div>
                        <div class="text-container">
                            <h3><%= course_name %></h3>
                            <p>Course Description: <%= course_description %></p>
                            <p>Total Duration: <%= course_length %> weeks</p>
                        </div>
                    </div>
                    <%
                    coursesFound = true; // Set the flag to true
                }
            }

            // Check if no courses were found and print the message
            if (!coursesFound) {
                out.println("<p>You have not enrolled in any courses yet. Please <a href='./search-courses.jsp'>Enroll now</a> to kickstart your academic journey today.</p>");
                out.print("<img src='../img/empty-space-02.gif' style='height:300px;width:300px;' title='empty gif'>");
            }
        } catch (Exception e) {
            out.println("<p>Error <a href='./'> go back</a></p>");
        }
        %>
    </div>
</body>
</html>

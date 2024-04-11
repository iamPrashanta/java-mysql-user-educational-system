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
            <li><a href="./view_courses.jsp">View All Courses</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
        <div class="course-container">
            <h2> User Course(s) Details</h2>
            <%
            // Get the userid from the URL parameter
            String userIdParam = request.getParameter("userid");
            int user_id = -1;
            // Initialize a flag variable to check if a member is not enrolled in any course and print the appropriate message
            boolean coursesFound = false;

            if (userIdParam != null && !userIdParam.isEmpty()) {
                // Parse the user ID as an integer
                user_id = Integer.parseInt(userIdParam);
                // out.print("Course List(s) of User " + user_id);
                try {
                    // Retrieve the database connection from the request attribute
                    Connection conn = (Connection) request.getAttribute("conn");

                    String get_applied_course_list = "SELECT * FROM course_join_history WHERE user_id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(get_applied_course_list);
                    pstmt.setInt(1, user_id);
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
                                    <img src="./img/<%= course_banner %>" alt="Course Image">
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
                    // out.print("Course List(s) of User " + user_id);

                    // Check if no courses were found and print the message
                    if (!coursesFound) {
                        out.println("<p>Student has not enrolled in any courses yet. Please <a href='../users/'>go back</a> or <a href='#direct_enroll'>add a course to their profile</a> to kickstart their academic journey.</p>");
                        out.print("<img src='../../img/empty-space-02.gif' style='height:300px;width:300px;' title='empty gif'>");
                    }
                } catch (Exception e) {
                    out.println("<p>Invalid User ID provided in the URL. <a href='../users/'> go to Users List</a></p>");
                }


                if (!coursesFound) {
                    %>
                    <div style="padding-top: 120px;" id="direct_enroll">
                        <h2>Direct Enroll to a Course</h2>
                    </div>
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
                                    <a href="./add_enroll.jsp?course_id=<%= course_id %>&userid=<%= user_id %>"><button class="apply-button">Add Enroll</button></a>
                                </div>
                            </div>
                            <%
                        }
                    } catch (Exception e) {
                        out.println("<p>Something Wrong! <a href='../users/'> go to Users List</a></p>");
                    }
                }
            }else{
                // Handle the case when 'userid' parameter is not present in the URL
                out.println("<p>User ID not provided in the URL. <a href='../users/'> go to Users List</a></p>");
            }

            
            %>
        </div>
    </div>
</body>
</html>
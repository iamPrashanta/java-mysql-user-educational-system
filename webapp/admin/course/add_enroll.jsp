<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

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
            String course_idParam = request.getParameter("course_id");
            int user_id = -1;
            String course_id = null;

            if (userIdParam != null && !userIdParam.isEmpty() && course_idParam != null && !course_idParam.isEmpty()) {
                // Parse the user ID as an integer
                user_id = Integer.parseInt(userIdParam);
                course_id = course_idParam;

                try {
                    // Retrieve the database connection from the request attribute
                    Connection conn = (Connection) request.getAttribute("conn");


                    // checking if user is already enrolled in this course
                    String verify_enrollment = "SELECT * FROM course_join_history WHERE user_id = ? AND course_id = ?";

                    try (PreparedStatement pstmt = conn.prepareStatement(verify_enrollment)) {
                        pstmt.setInt(1, user_id);
                        pstmt.setString(2, course_id);
                        try (ResultSet verify_res = pstmt.executeQuery()) {
                            if (verify_res.next()) {
                                // Already enrolled
                                out.println("<p>Enrollment failed. This Student Already Enrolled in this Course <a href='./?userid=" + user_id + "'> Show now</a></p>");
                            } else {
                                // Not enrolled, proceed with enrollment
                                // Implement your enrollment logic here
                            
                                String update_applied_course_list = "INSERT INTO `course_join_history`(`user_id`, `course_id`, `join_date`) VALUES (?, ?, ?)";

                                try(PreparedStatement spstmt = conn.prepareStatement(update_applied_course_list)){
                                    spstmt.setInt(1, user_id);
                                    spstmt.setString(2, course_id);

                                    // static date
                                    // String joinDate = "2024-03-04";

                                    // dymanic date
                                    // Get the current date
                                    LocalDate currentDate = LocalDate.now();

                                    // Format the date as yyyy-MM-dd
                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                    String formattedDate = currentDate.format(formatter);

                                    // Set the formatted date in your PreparedStatement
                                    spstmt.setString(3, formattedDate);

                                    int courseRowsInserted = spstmt.executeUpdate();
                                    if (courseRowsInserted > 0) {
                                        // Registration successful
                                        out.print("<img src='../../img/4dgtswjdz07d6s9txle6.gif' style='height:400px;width:400px;' title='gif'>");
                                        out.println("<p>Course Enrollment successful! <a href='./?userid=" + user_id + "'> Show now</a></p>");
                                    } else {
                                        // Registration failed
                                        out.println("<p>Enrollment failed. <a href='./?userid=" + user_id + "'> Please try again.</a></p>");
                                    }
                                }
                            }
                        }
                    }
                } catch (Exception e) {
                    out.println("<p>Invalid User ID provided in the URL. <a href='../users/'> go to Users List</a></p>");
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
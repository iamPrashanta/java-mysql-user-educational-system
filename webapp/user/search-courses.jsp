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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
    <h2> Search Course</h2>
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
                    <img src="../admin/course/img/<%= course_banner %>" alt="Course Image">
                </div>
                <div class="text-container">
                    <h3><%= course_name %></h3>
                    <p>Course Description: <%= course_description %></p>
                    <p>Total Duration: <%= course_length %> weeks</p>
                    <button class="apply-button enroll-btn" data-course-id="<%= course_id %>">Enroll Now</button>
                </div>
            </div>
            <%
        }
    } catch (Exception e) {
        out.println("<p>Something Wrong! <a href='../users/'> go to Users List</a></p>");
    }
    %>
    </div>

    <script>
        $(document).ready(function () {
            $('.enroll-btn').click(function () {
                let courseId = $(this).data('course-id');
                let userId = '<%= userid %>';
                let element = this;

                $(element).prop('disabled', true); // Disable the button

                $.ajax({
                    url: './enroll_ajax.jsp',
                    type: 'POST',
                    data: {
                        course_id: courseId,
                        userid: userId
                    },
                    success: function (response) {
                        // Handle success
                        if (response.trim() === "success" || response.trim() === "Success") {
                            console.log(response.trim());
                            $(element).css("background-color", "green").html("Enroll Success");
                        } else if (response.trim() === "already" || response.trim() === "Already") {
                            console.log(response.trim());
                            $(element).css("background-color", "red").html("Student Already Enrolled");
                        } else {
                            console.log('Enrollment failed');    
                        }
                        
                    },
                    error: function () {
                        // Handle error
                        console.log('Error Modifying Database');
                    }
                });
            });
        });
    </script>

</body>
</html>

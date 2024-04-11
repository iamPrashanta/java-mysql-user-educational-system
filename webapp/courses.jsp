<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="checkConnection.jsp" %>
<%
    String name = (String) session.getAttribute("name");
    String userid = (String) session.getAttribute("userid");
    String adminid = (String) session.getAttribute("adminid");
    String loginBtnLink = (name != null && !name.isEmpty()) ? "./logout.jsp" : "./login.jsp";
    String loginBtnStatus = (name != null && !name.isEmpty()) ? "Logout" : "Login";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Student Management System</title>
	<link rel="stylesheet" href="./css/navbar.css">
	<link rel="stylesheet" href="./css/courses.css">
    <style>
        #indexinfo {
            margin: auto;
            margin-top : 80px;
            padding : 20px;
            max-width: 1000px;
            font-size: 18px;
            line-height: 28px;
        }
        #indexinfo h2 {
            color : white;
        }
    </style>
</head>
<body>
	<nav class="navbar">
		<div class="logo">UserED</div>
		<div class="menu-toggle" onclick="toggleMenu()">&#9776;</div>
		<div class="menu">
			<a href="./" class="link">Home</a>
			<a href="./admin.jsp?continue=users" class="link">Students</a>
			<a href="quickstart.jsp" class="link">Quick Start Guide</a>
            <a href="<%= loginBtnLink %>" class="link login button" style="margin-top: 5px"><%= loginBtnStatus %></a>
        </div>
	</nav>
	<div class="page-overlay"></div>
	<div id="indexinfo">
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
                            <img src="./admin/course/img/<%= course_banner %>" alt="Course Image">
                        </div>
                        <div class="text-container">
                            <h3><%= course_name %></h3>
                            <p>Course Description: <%= course_description %></p>
                            <p>Total Duration: <%= course_length %> weeks</p>
                            <button class="apply-button"><a href="./login.jsp">Apply</a></button>
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
    <script src="./js/nav.js"></script>
</body>
</html>
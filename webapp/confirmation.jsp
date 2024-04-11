<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirmation Page</title>
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" href="css/container.css">
    <script src="./js/nav.js"></script>
</head>
<body>
    <nav class="navbar">
		<div class="logo">UserED</div>
		<div class="menu-toggle" onclick="toggleMenu()">&#9776;</div>
		<div class="menu">
			<a href="./" class="link">Home</a>
			<a href="#" class="link">Courses</a>
			<a href="#" class="link">Students</a>
			<a href="quickstart.jsp" class="link">Quick Start Guide</a>
            <a href="./login.jsp" class="link login button" style="margin-top: 5px">Login</a>
        </div>
	</nav>
	<div class="page-overlay"></div>
    <div class="container">
        <%-- Retrieve parameter values from the URL --%>
        <% String studentId = request.getParameter("student_id");
            String uname = request.getParameter("uname");
        %>
        <h1>Congratulations !</h1>
        <p>Student <%= uname %> (<%= studentId %>) Your information has been successfully submitted.</p>
    </div>

</body>
</html>

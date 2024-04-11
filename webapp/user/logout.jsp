<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout Page</title>
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/container.css">
    <script src="../js/nav.js"></script>
</head>
<body>
    <nav class="navbar">
		<div class="logo">UserED</div>
		<div class="menu-toggle" onclick="toggleMenu()">&#9776;</div>
		<div class="menu">
			<a href="../" class="link">Home</a>
			<a href="../courses.jsp" class="link">Courses</a>
			<a href="../quickstart.jsp" class="link">Quick Start Guide</a>
            <a href="../login.jsp" class="link login button" style="margin-top: 5px">Log in</a>
        </div>
	</nav>
	<div class="page-overlay"></div>
    <div class="container">
        <header>
            <h1>Logout Page</h1>
        </header>
        <%-- Invalidate the session and redirect to the login page --%>
        <%
            if (request.getSession(false) != null) {
                session.invalidate();
            }
        %>
        <p>You have been successfully logged out.</p>
    </div>
</body>
</html>

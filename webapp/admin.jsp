<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
    String name = (String) session.getAttribute("name");
    String userid = (String) session.getAttribute("userid");
    String adminid = (String) session.getAttribute("adminid");
    String loginBtnLink = (name != null && !name.isEmpty()) ? "./logout.jsp" : "./login.jsp";
    String loginBtnStatus = (name != null && !name.isEmpty()) ? "Logout" : "Login";
    if (userid != null) {
        // User is logged in, redirect to user dashboard
        response.sendRedirect("user/");
    }else if (adminid != null) {
        // Admin is logged in, redirect to Admin dashboard
        response.sendRedirect("admin/");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login Page</title>
    <link rel="stylesheet" href="css/navbar.css">
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
       <link rel="stylesheet" href="css/form.css">
    <script src="./js/nav.js"></script>
    <style>
        /* CSS styles go here */
    </style>
</head>
<body>
    <nav class="navbar">
		<div class="logo">UserED</div>
		<div class="menu-toggle" onclick="toggleMenu()">&#9776;</div>
		<div class="menu">
			<a href="./" class="link">Home</a>
			<a href="./courses.jsp" class="link">Courses</a>
			<a href="quickstart.jsp" class="link">Quick Start Guide</a>
            <a href="./login.jsp" class="link login button" style="margin-top: 5px">User Login</a>
        </div>
	</nav>
	<div class="page-overlay"></div>
    <section id="cover" class="min-vh-100">
            <div id="cover-caption">
                <div class="container">
                    <div class="row text-white">
                        <div class="col-xl-5 col-lg-6 col-md-8 col-sm-10 mx-auto text-center form p-4">
                            <h1 class="display-4 py-2 text-truncate">Admin Login</h1>
                            <div class="px-2">
                                <form method="post" action="admin02.jsp" class="justify-content-center">
                                    <div class="form-group">
                                                <label class="sr-only">Email:</label>
                                                <input type="email" class="form-control" id="email" name="email" required
                                                placeholder="Email Address">
                                    </div>

                                    <div class="form-group">
                                                <label class="sr-only">Password:</label>
                                                <input type="text" class="form-control" id="passwd" name="passwd" required
                                                placeholder="Password">
                                    </div>

                                    <input type="hidden" name="continue" value="<%= request.getParameter("continue") != null ? request.getParameter("continue") : "" %>">
                                    
                                    <button type="submit" class="btn-login">Login</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
</body>
</html>

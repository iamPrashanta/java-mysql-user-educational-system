<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <title>Form Submission Example</title>
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link rel="stylesheet" href="css/form.css">
    <script src="./js/nav.js"></script>
</head>
<body>
    <nav class="navbar">
		<div class="logo">UserED</div>
		<div class="menu-toggle" onclick="toggleMenu()">&#9776;</div>
		<div class="menu">
			<a href="./" class="link">Home</a>
			<a href="./courses.jsp" class="link">Courses</a>
			<a href="#" class="link">Students</a>
			<a href="quickstart.jsp" class="link">Quick Start Guide</a>
            <a href="<%= loginBtnLink %>" class="link login button" style="margin-top: 5px"><%= loginBtnStatus %></a>
        </div>
	</nav>
	<div class="page-overlay"></div>

	<section id="cover" class="min-vh-100">
        <div id="cover-caption">
            <div class="container">
                <div class="row text-white">
                    <div class="col-xl-5 col-lg-6 col-md-8 col-sm-10 mx-auto text-center form p-4">
                        <h1 class="display-4 py-2 text-truncate">Your Information</h1>
                        <div class="px-2">
                            <form method="post" action="signup02.jsp" class="justify-content-center">
                                <div class="form-group">
                                            <label class="sr-only">Student ID:</label>
                                            <input type="text" class="form-control" id="student_id" name="student_id"
                                            required pattern="[0-9]{5}" placeholder="Student ID">
                                            </div>
                                <div class="form-group">
                                            <label class="sr-only">Name:</label>
                                            <input type="text" class="form-control" id="uname" name="uname" required
                                            pattern="[a-zA-z/n]{20}" placeholder="Full Name">
                                              </div>
                                <div class="form-group">
                                            <label class="sr-only">Email:</label>
                                            <input type="email" class="form-control" id="email" name="email" required
                                            placeholder="Email Address">
                                                </div>
                                <div class="form-group">
                                            <label class="sr-only">Phone:</label>
                                            <input type="tel" class="form-control" id="phone" name="phone" required
                                            placeholder="Phone Number">
                                             </div>
                                <div class="form-group">
                                            <label class="sr-only">Password:</label>
                                            <input type="text" class="form-control" id="passwd" name="passwd" required
                                            placeholder="Password">
                                                </div>
                                <button type="submit" class="btn-login">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Student Management System</title>
	<style>
	body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    .navbar {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        background-color: rgba(0, 0, 0, 0.7);
        padding: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        z-index: 2; /* Ensure the navbar is above other elements */
    }

    .navbar .logo {
        font-size: 24px;
        font-weight: bold;
        color: white;
        margin: 0 20px;
    }

    .navbar .menu-toggle {
        display: none;
        font-size: 24px;
        color: white;
        cursor: pointer;
        padding: 10px;
        border-radius: 4px;
        margin-right: 10px;
    }

    .navbar .menu-toggle:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }

    .navbar .menu {
        display: flex;
        align-items: center;
        margin-right: 20px;
    }

    .navbar .menu a {
        color: white;
        text-decoration: none;
        margin-right: 20px;
    }

    .navbar .menu a:hover {
        color: rgba(255, 255, 255, 0.8);
    }

    .button {
        display: inline-block;
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        border: none;
        cursor: pointer;
        font-size: 18px;
        margin-top: 20px;
    }

    .button:hover {
        background-color: #EC5E30;
    }


    @media only screen and (max-width: 768px) {
        .navbar .menu-toggle {
            display: block;
        }

        .navbar .menu {
            display: none;
            flex-direction: column;
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 10px;
        }

        .navbar .menu.show {
            display: flex;
        }

        .navbar .menu a {
            margin-right: 0;
            margin-bottom: 10px;
        }
    }
	</style>
</head>
<body>
	<nav class="navbar">
		<div class="logo">UserED</div>
		<div class="menu-toggle" onclick="toggleMenu()">&#9776;</div>
		<div class="menu">
			<a href="./courses.jsp" class="link">Courses</a>
			<a href="./admin.jsp?continue=users" class="link">Students</a>
			<a href="quickstart.jsp" class="link">Quick Start Guide</a>
        </div>
	</nav>
    <script>
    function toggleMenu() {
        const menu = document.querySelector('.menu');
        menu.classList.toggle('show');
    }

    const sidebarBtn = document.getElementById("sidebar-btn");
        const sidebar = document.getElementById("sidebar");

        sidebarBtn.addEventListener("click", function () {
        sidebar.classList.toggle("visible");
    });
    </script>
</body>
</html>

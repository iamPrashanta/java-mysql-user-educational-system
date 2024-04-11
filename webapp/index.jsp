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
	<link rel="stylesheet" href="./css/container.css">
    <style>
        @keyframes hideStatus {
            0% { opacity: 1; }
            100% { opacity: 0; display: none; }
        }

        #statusMessage {
            animation: hideStatus 5s linear forwards;
        }

        #indexinfo {
            margin: auto;
            margin-top : 140px;
            padding : 10px;
            max-width: 900px;
            font-size: 18px;
            line-height: 28px;
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
            <a href="<%= loginBtnLink %>" class="link login button" style="margin-top: 5px"><%= loginBtnStatus %></a>
        </div>
	</nav>
	<div class="page-overlay"></div>
	<div class="container">
	    <div class="info">
            <h1>Connecting Students and Professionals for Success</h1>
            <p style="color: <%= statusColor %>;" id="statusMessage"><%= statusMessage %></p>
            <p>
                UserED is an innovative online platform that fosters collaboration between students and professionals, unlocking their full potential. Through UserED, students gain access to valuable guidance, mentorship, and industry insights, empowering them to make informed career choices and develop the necessary skills for success. Professionals, on the other hand, have the opportunity to contribute their expertise, provide mentorship, and shape the future of aspiring talent. Join UserED today to create meaningful connections, expand your horizons, and embark on a journey of growth and achievement.
            </p>
            <a href="signup.jsp" class="button">Sign Up</a>
        </div>
	</div>
	<div id="indexinfo">
	    <h2>Key Features That Empower You:</h2>

        <p>
            UserED is a cutting-edge online platform designed to bridge the gap between students and professionals, offering a multitude of features that empower both groups in their respective journeys. With a commitment to fostering collaboration and growth, UserED serves as a hub for educational and career development.
        </p>

        <p>
            Our platform is tailored to meet the unique needs of students, professionals, and those in between. Whether you're a student looking for guidance, a professional eager to share your expertise, or someone exploring their career options, UserED has something exceptional to offer.
        </p>

        <p>
            <strong>1. Comprehensive Course Management:</strong> UserED allows students to curate their educational journey by adding and managing courses in their accounts. You have the flexibility to tailor your learning path according to your interests and career goals.
        </p>

        <p>
            <strong>2. Job Search Made Easy:</strong> Our platform features a robust job search engine, making it effortless to explore exciting career opportunities in your field. Whether you're seeking internships, entry-level positions, or advanced roles, UserED connects you with relevant job listings.
        </p>

        <p>
            <strong>3. Personalized Profile:</strong> Your UserED profile is your digital identity. It's where you can showcase your skills, qualifications, and interests. Update your profile anytime to reflect your latest achievements and aspirations.
        </p>

        <p>
            <strong>4. Project Showcase:</strong> Have a personal project you're proud of? UserED provides a platform to share your work with the community. Describe your project, upload images, and receive valuable feedback from professionals and peers.
        </p>

        <p>
            <strong>5. Mentorship and Guidance:</strong> Connect with experienced professionals who are eager to offer mentorship and guidance. Whether you're navigating your educational choices or looking to advance your career, our network of mentors is here to support you.
        </p>

        <p>
            <strong>6. Interactive Forums:</strong> Engage in discussions, ask questions, and share insights with fellow members through our interactive forums. Exchange ideas, collaborate on projects, and expand your horizons within the UserED community.
        </p>

        <p>
            <strong>7. Feedback and Ratings:</strong> Transparency is essential. UserED allows users to provide and receive feedback, helping everyone understand the quality of courses, mentorship, and projects. Make informed decisions based on community reviews.
        </p>

        <h2>Your Journey Starts Here</h2>

        <p>
            At UserED, we believe in the transformative power of education, mentorship, and professional growth. Whether you're a student taking your first steps towards your dream career or a seasoned professional eager to give back, UserED is your platform for empowerment.
        </p>

        <p>
            Join us today and embark on a journey of learning, collaboration, and achievement. Unlock your potential with UserED, where knowledge meets opportunity.
        </p>
    </div>
    <script src="./js/nav.js"></script>
</body>
</html>

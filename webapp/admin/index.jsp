<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../checkConnection.jsp" %>
<%
    String name = (String) session.getAttribute("name");
    String adminid = (String) session.getAttribute("adminid");
    String loginBtnLink = (name != null && !name.isEmpty()) ? "./logout.jsp" : "./login.jsp";
    String loginBtnStatus = (name != null && !name.isEmpty()) ? "Logout" : "Login";

    if (name == null && adminid == null) {
        // User is not logged in, redirect to the login page
        response.sendRedirect("../admin.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="https://pixinvent.com/stack-responsive-bootstrap-4-admin-template/app-assets/fonts/simple-line-icons/style.min.css">
    <link rel="stylesheet" type="text/css" href="https://pixinvent.com/stack-responsive-bootstrap-4-admin-template/app-assets/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/sidenav.css">
    <link rel="stylesheet" href="../../css/page-content.css">
    <script src="../js/nav.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        .row {
            margin-bottom : 10px;
        }

        .card {
            margin-bottom : 20px;
        }

        i {
            font-size : 30px;
        }

        .icon-user {
            color: #00B5B8 !important;
        }

        .icon-diamond {
            color: #FFA87D !important;
        }

        .icon-heart {
            color: #FF7588 !important;
        }

        .icon-wallet {
            color: #16D39A !important;
        }

        .wireframe {
            margin: 0 auto;
            transition: 0.3s;
            border-radius: 8px;
            max-width:100%;
            height: auto;
            margin-top:50px;
        }

        @keyframes animate-loader {
        0% {
            background-position: -100px;
        }

        40%,
        100% {
            background-position: 270px;
        }
        }

        .skeleton {
            padding: 2px 16px;
        }

        .skeleton-first,
        .skeleton-second,
        .skeleton-third,
        .skeleton-forth,
        .skeleton-fifth,
        .skeleton-six {
            max-width:100%;
            height: 30px;
            background-image: linear-gradient(90deg, #ddd 0px, #e8e8e8 40px, #ddd 80px);
            animation: animate-loader 1.6s infinite linear;
            background-size: 300px;
        }
    </style>
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
            <li><a href="./users/">Users List</a></li>
            <li><a href="./course/view_courses.jsp">Courses</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
        <div class="wireframe" id="wireframe-img">
            <div class="skeleton">
                <div class="t-white mast">
                <p class="skeleton-first"></p>
                <p class="skeleton-second"></p>
                <p class="skeleton-third"></p>
                <h1>&nbsp;</h1>
                <p class="skeleton-forth"></p>
                <p class="skeleton-fifth"></p>
                <p class="skeleton-six"></p>
                </div>
            </div>
        </div>
        
        <div class="grey-bg container-fluid">
            <section id="stats-subtitle">
                <div class="row">
                    <div class="col-12 mt-3 mb-1">
                    <h2>Hello <u><%= name %></u></h2>
                    <p>Welcome to Admin Panel.</p>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xl-6 col-md-12">
                    <div class="card overflow-hidden">
                        <div class="card-content">
                        <div class="card-body cleartfix">
                            <div class="media align-items-stretch">
                            <div class="align-self-center">
                                <i class="icon-user primary font-large-2 mr-2"></i>
                            </div>
                            <div class="media-body">
                                <h4>Total Users</h4>
                                <span>Monthly Total User</span>
                            </div>
                            <div class="align-self-center">
                                <h1 id="total_monthly_num"><div class="spinner-border" role="status">
                                <span class="sr-only">Loading...</span>
                              </div></h1>
                            </div>
                            </div>
                        </div>
                        </div>
                    </div>
                    </div>

                    <div class="col-xl-6 col-md-12">
                    <div class="card">
                        <div class="card-content">
                        <div class="card-body cleartfix">
                            <div class="media align-items-stretch">
                            <div class="align-self-center">
                                <i class="icon-diamond warning font-large-2 mr-2"></i>
                            </div>
                            <div class="media-body">
                                <h4>Total Course Selse</h4>
                                <span>Monthly Selse</span>
                            </div>
                            <div class="align-self-center"> 
                                <h1 id="course_sell_num"><div class="spinner-border" role="status">
                                <span class="sr-only">Loading...</span>
                              </div></h1>
                            </div>
                            </div>
                        </div>
                        </div>
                    </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xl-6 col-md-12">
                    <div class="card overflow-hidden">
                        <div class="card-content">
                        <div class="card-body cleartfix">
                            <div class="media align-items-stretch">
                            <div class="align-self-center">
                                <i class="icon-heart danger font-large-2 mr-2"></i>
                            </div>
                            <div class="media-body">
                                <h4>User retention rate</h4>
                                <span>Monthly retention rate</span>
                            </div>
                            <div class="align-self-center">
                                <h1 id="retention_num"><div class="spinner-border" role="status">
                                <span class="sr-only">Loading...</span>
                              </div></h1>
                            </div>
                            </div>
                        </div>
                        </div>
                    </div>
                    </div>

                    <div class="col-xl-6 col-md-12">
                    <div class="card">
                        <div class="card-content">
                        <div class="card-body cleartfix">
                            <div class="media align-items-stretch">
                            <div class="align-self-center">
                            <i class="icon-wallet success font-large-2 mr-2"></i>
                            </div>
                            <div class="media-body">
                                <h4>Total Imcome</h4>
                                <span>Monthly Imcome</span>
                            </div>
                            <div class="align-self-center"> 
                                <h1 id="income_num"><div class="spinner-border" role="status">
                                <span class="sr-only">Loading...</span>
                              </div></h1>
                            </div>
                            </div>
                        </div>
                        </div>
                    </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <script>
        $(document).ready(function() {
            function randomWidth() {
                return Math.floor(Math.random() * (100 - 70 + 1)) + 70;
            }
            
            
            $(".skeleton-first").css("max-width", randomWidth() + "%");
            $(".skeleton-second").css("max-width", randomWidth() + "%");
            $(".skeleton-third").css("max-width", randomWidth() + "%");
            $(".skeleton-forth").css("max-width", randomWidth() + "%");
            $(".skeleton-fifth").css("max-width", randomWidth() + "%");
            $(".skeleton-six").css("max-width", randomWidth() + "%");
            


            var img = $("#wireframe-img");
            var div = $(".grey-bg");
            div.hide();

            setTimeout(function() {
                img.hide();
                div.show();
            }, 2000);
            
            
            setTimeout(function() {
                $("#retention_num").html("67%");
                $("#income_num").html("$2378");
                $("#course_sell_num").html("24");
            }, 5000);

            setTimeout(function() {
                $("#total_monthly_num").html("145");
            }, 6000);
        });    
    </script>
</body>
</html>

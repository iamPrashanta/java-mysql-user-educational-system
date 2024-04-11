<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
	<title>Delete Student Profile</title>
	<link rel="stylesheet" href="../../css/navbar.css">
	<link rel="stylesheet" href="../../css/sidenav.css">
	<link rel="stylesheet" href="../../css/page-content.css">
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
            <li><a href="./">Users List</a></li>
            <li><a href="../course/view_courses.jsp">Courses</a></li>
            <li><a href="#">Add New Job</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
        <h2>Delete User Profile</h2>
        <%
            // Get the userid from the URL parameter
            String userIdParam = request.getParameter("userid");

            if (userIdParam != null && !userIdParam.isEmpty()) {
                try {
                    // Parse the user ID as an integer
                    int user_id = Integer.parseInt(userIdParam);

                    // Database connection already established in checkConnection.jsp
                    Connection conn = (Connection) request.getAttribute("conn");

                    // Prepare the SQL query to delete the user by user ID
                    String query = "DELETE FROM users WHERE id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, user_id);

                    // Execute the query (use executeUpdate() for DELETE)
                    int rowsDeleted = pstmt.executeUpdate();

                    if (rowsDeleted > 0) {
                        // User deleted successfully
                        out.println("<p>User with ID " + user_id + " has been deleted. <a href='./'> go to Users List</a></p>");
                    } else {
                        // User not found
                        out.println("<p>User with ID " + user_id + " not found. <a href='./'> go to Users List</a></p>");
                    }

                    // Close database resources
                    pstmt.close();
                } catch (NumberFormatException e) {
                    out.println("<p>Invalid User ID provided in the URL. <a href='./'> go to Users List</a></p>");
                } catch (SQLException e) {
                    out.println("An error occurred: " + e.getMessage());
                }
            } else {
                // Handle the case when 'userid' parameter is not present in the URL
                out.println("<p>User ID not provided in the URL. <a href='./'> go to Users List</a></p>");
            }
        %>
    </div>
</body>
</html>
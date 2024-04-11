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
	<title>Student Management System</title>
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
            <li><a href="./add.jsp">Add New User</a></li>
            <li><a href="../course/view_courses.jsp">Courses</a></li>
            <li><a href="#">Add New Job</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
            <div id="search-user">
                <h2>Search User</h2>
                <form action="search.jsp" method="post">
                    <div class="form-group">
                        <label for="userID">User ID:</label>
                        <input type="text" id="user_id" name="user_id" required pattern="[0-9]{6}" title="6 digit user id">
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Search">
                    </div>
                </form>
            </div>

            <div class="table-container">
                <%
                // Retrieve inputs value from the Search form
                String user_id = request.getParameter("user_id");
                if(user_id == null){
                    // nothing to print
                }else{
                    %>
                    <h2> Search Result</h2>
                    <%

                    try {
                        // database connection already Establish in checkConnection.jsp
                        Connection conn = (Connection) request.getAttribute("conn"); // Retrieve the database connection

                        String query = "SELECT * FROM users WHERE id = ?";

                        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                            pstmt.setString(1, user_id);
                            try (ResultSet rs = pstmt.executeQuery()) {
                                if (rs.next()) {
                                    // Retrieve user data from the result set
                                    String urname = rs.getString("name");
                                    String email = rs.getString("email");
                                    String phone = rs.getString("phone");
                                    String address = rs.getString("address");
        
                                    // Output user data in a table row
                                    %>
                                    <table>
                                    <tr>
                                        <th>User ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Edit</th>
                                        <th>Applied Courses</th>
                                        <th>Delete User</th>
                                    </tr>
                                    <tr>
                                        <td><%= user_id %></td>
                                        <td><%= urname %></td>
                                        <td><%= email %></td>
                                        <td><%= phone %></td>
                                        <td><%= address %></td>
                                        <td><button class="add-button"><a href="./edit.jsp?userid=<%= user_id %>">Edit</a></button></td>
                                        <td><button class="add-button"><a href="../course/?userid=<%= user_id %>">Show</a></button></td>
                                        <td>
                                            <a href="./delete.jsp?userid=<%= user_id %>" onclick="return confirm('Are you sure?')">
                                                <button class="button-muted-coral">Delete</button>
                                            </a>
                                        </td>
                                    </tr>
                                    </table>
                                    <%
                                }else{
                                    out.println("<p>No user found with User ID: " + user_id + "</p>");
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<p>Error executing SQL query</p>");
                        }

                    } catch (Exception e) {
                        // Handle any SQL exceptions here
                        out.println("An error occurred: " + e.getMessage());
                    }
                }
                %>
            </div>
    </div>
</body>
</html>
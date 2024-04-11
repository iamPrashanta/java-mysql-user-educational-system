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
            <li><a href="./add.jsp">Add New User</a></li>
            <li><a href="./search.jsp">Search User</a></li>
            <li><a href="../course/view_courses.jsp">Courses</a></li>
        </ul>
        <div id="sidebar-btn">
            &#9776;
        </div>
    </div>
    <div id="page-content">
        <h2> User(s) List</h2>
        <div class="table-container">
            <table>
                <tr>
                    <th>NO</th>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Edit</th>
                    <th>Applied Courses</th>
                    <th>Delete</th>
                </tr>

                <%
                    int num = 1;
                    try {
                        // Retrieve the database connection from the request attribute
                        Connection conn = (Connection) request.getAttribute("conn");

                        String query = "SELECT * FROM users";
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        ResultSet rs = pstmt.executeQuery();

                        while (rs.next()) {
                            // Retrieve user data from the result set
                            int user_id = rs.getInt("id");
                            String urname = rs.getString("name");
                            String email = rs.getString("email");
                            String phone = rs.getString("phone");
                            String address = rs.getString("address");

                            // Output user data in a table row
                            %>
                            <tr>
                                <td><%= num %></td>
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
                            <%
                            num ++;
                        }
                        rs.close();
                        pstmt.close();
                    } catch (SQLException e) {
                        // Handle any SQL exceptions here
                        out.println("An error occurred: " + e.getMessage());
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>
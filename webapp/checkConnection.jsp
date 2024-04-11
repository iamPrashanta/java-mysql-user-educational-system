<%@ page import="java.sql.*" %>

<%
   // Database connection settings
   String url = "jdbc:mysql://localhost:3306/edu-connect-db";
   String username = "root";
   String password = "";

   String statusMessage = ""; // Initialize the status message
   String statusColor = "red"; // Initialize the color as red

   // Attempt to establish a connection to the database
   try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection(url, username, password);
      statusMessage = "Connection successful!";
      statusColor = "yellow"; // Change color to blue since the connection is successful

      request.setAttribute("conn", conn);
      // connection.close();

      // out.print(statusMessage);
   } catch (Exception  e) {
      statusMessage = "Connection failed!";
      e.printStackTrace();
      // out.print(statusMessage);
   }
%>

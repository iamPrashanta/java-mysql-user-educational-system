<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../checkConnection.jsp" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
String courseId = request.getParameter("course_id");
String userId = request.getParameter("userid");
%>
<%
try {
    // Retrieve the database connection from the request attribute
    Connection conn = (Connection) request.getAttribute("conn");
    // checking if user is already enrolled in this course
    String verify_enrollment = "SELECT * FROM course_join_history WHERE user_id = ? AND course_id = ?";

    try (PreparedStatement pstmt = conn.prepareStatement(verify_enrollment)) {
        pstmt.setString(1, userId);
        pstmt.setString(2, courseId);
        try (ResultSet verify_res = pstmt.executeQuery()) {
            if (verify_res.next()) {
                // Already enrolled
                out.println("Already");
            } else {
                String update_applied_course_list = "INSERT INTO `course_join_history`(`user_id`, `course_id`, `join_date`) VALUES (?, ?, ?)";

                try(PreparedStatement spstmt = conn.prepareStatement(update_applied_course_list)){
                    spstmt.setString(1, userId);
                    spstmt.setString(2, courseId);
                    LocalDate currentDate = LocalDate.now();

                    // Format the date as yyyy-MM-dd
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    String formattedDate = currentDate.format(formatter);

                    // Set the formatted date in your PreparedStatement
                    spstmt.setString(3, formattedDate);

                    int courseRowsInserted = spstmt.executeUpdate();
                    if (courseRowsInserted > 0) {
                        // Registration successful
                        out.println("Success");
                    } else {
                        // Registration failed
                        out.println("Enrollment failed");
                    }
                }
            }
        }
    }
} catch (Exception e) {
    out.println("Something Wrong");
}
%>

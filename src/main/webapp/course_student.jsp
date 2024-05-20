<%@ page
	import="java.util.ArrayList,java.util.*, java.util.Date, java.util.List, java.sql.Connection, java.sql.DriverManager, java.sql.SQLException, java.util.Collections, java.util.Comparator"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.studentmanagement.Student"%>
<%@ page import="com.studentmanagement.Course_student"%>
<%@ page import="com.studentmanagement.courseDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student List</title>
</head>

<!--  add bootstrap  -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<!-- link to css file -->
<link href="css/course_student.css" rel= "stylesheet">
<body>
	<%

 
    String searchYear = request.getParameter("searchYear");

	if (searchYear == null ) {searchYear = "";} 
    String url = "jdbc:postgresql://localhost:5432/QLHS"; // 
	String username = "y"; 
	String password = "123"; 
	List<Course_student> course_student_list = new ArrayList<>();
	try {
    Class.forName("org.postgresql.Driver");
    Connection connection = DriverManager.getConnection(url, username, password);
    if (connection != null) {
        courseDAO stu_dao = new courseDAO(connection) ; 
        course_student_list = stu_dao.getAllSets(searchYear);
        connection.close();
    }} catch (ClassNotFoundException e) {
    System.out.println("PostgreSQL JDBC driver not found.");
    e.printStackTrace();} catch (SQLException e) {
    System.out.println("Failed to connect to PostgreSQL database.");
    System.out.println("Error: " + e.getMessage());}
   
 
%>
	<div class="container">
	
		<h2 class= "text-center">Lớp học và học sinh</h2>
	
	
		<table class="table">
			<tr class="stick">
				<th>ID</th>
				<th>Name Student</th>
				<th>Name Course</th>
				<th>Grade</th>
				<th>Year</th>
	
			</tr>
			<!-- Iterate through the list of students -->
			<% for (Course_student cs : course_student_list) { %>
			<tr>
				<td><%= cs.getId() %></td>
				<td><%= cs.getStudent_id() %></td>
				<td><%= cs.getcourse_id() %></td>
				<td><%= cs.getGrade() %></td>
				<td><%= cs.getYear() %></td>
	
	
	
				<td>
				
				</td>
			</tr>
			<% } %>
		</table>
		
		
		<div class="function">
			<form class="back-button" action="index.jsp">
				<input type="submit" value="Back to main">
			</form>
	
	
			<!-- Search by year -->
			<form action="course_student.jsp" method="post">
				<input type="text" name="searchYear" placeholder="Search by Year"
					value="<%= searchYear %>"> 
					<input class="button-search" type="submit" value="Search">
			</form>
	
		</div>
		
		
	</div>
	


</body>
</html>

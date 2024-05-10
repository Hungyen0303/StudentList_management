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
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	width: 100vw;
	height: 100vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	font-family: Arial, sans-serif;
	background-color: #f3f4f6;
}

h2 {
	margin: 20px 0;
	color: #333;
}

form {
	margin-top: 10px;
}

input[type="text"], input[type="submit"] {
	padding: 8px 15px;
	margin-right: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="submit"] {
	background-color: #4CAF50;
	color: white;
	cursor: pointer;
	transition: background-color 0.3s ease; /* Smooth transition */
}

input[type="submit"]:hover {
	background-color: #45a049;
}

table {
	border-collapse: collapse;
	width: 90%;
	margin-top: 20px;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

tr:hover {
	background-color: #ddd;
}

.function {
	display: flex;
	flex-direction: row;
	margin-top: 20px;
}

.function form {
	margin-right: 10px;
}
</style>
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

	<h2>Lớp học và học sinh</h2>


	<table border="1">
		<tr>
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
				<form method="post" action="seeCourseAndGrade.jsp">
					<input type="hidden" name="id_student"
						value="<%= cs.getStudent_id() %>"> <input type="submit"
						value="See course and grade">
				</form>
			</td>


		</tr>
		<% } %>
	</table>
	<div class="function">
		<form action="index.jsp">
			<input type="submit" value="Back to main">
		</form>


		<!-- Search by year -->
		<form action="course_student.jsp" method="post">
			<input type="text" name="searchYear" placeholder="Search by Year"
				value="<%= searchYear %>"> <input type="submit"
				value="Search">
		</form>

	</div>


</body>
</html>

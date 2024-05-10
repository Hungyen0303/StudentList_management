<%@ page
	import="java.util.ArrayList, java.util.Date, java.util.List, java.sql.Connection, java.sql.DriverManager, java.sql.SQLException, java.util.Collections, java.util.Comparator"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.studentmanagement.Student"%>
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
	position: relative;
	font-family: Arial, sans-serif;
}

h2 {
	margin: 20px 0;
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
}

input[type="submit"]:hover {
	background-color: #45a049;
}

table {
	border-collapse: collapse;
	width: 90%;
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

.btn-container {
	display: flex;
	margin-top: 20px;
}

.btn-container form {
	margin-right: 10px;
}

h4 {
	color: #45a049;
	margin-top: 20px;
	text-size: 20px;
}
</style>
<body>
	<%
  	String meg  = request.getParameter("message"); 
	String id_course = request.getParameter("id_course"); 
    String url = "jdbc:postgresql://localhost:5432/QLHS"; // 
	String username = "y"; 
	String password = "123"; 
	List<Student> students = new ArrayList<>();
	try {
	
    Class.forName("org.postgresql.Driver");
    Connection connection = DriverManager.getConnection(url, username, password);

    if (connection != null) {
        courseDAO stu_dao = new courseDAO(connection) ; 
        students = stu_dao.getUnregisteredStudent(id_course); 
        connection.close();
    }} catch (ClassNotFoundException e) {
    System.out.println("PostgreSQL JDBC driver not found.");
    e.printStackTrace();} catch (SQLException e) {
    System.out.println("Failed to connect to PostgreSQL database.");
    System.out.println("Error: " + e.getMessage());}
   
   
%>

	<h2>Student List did not join</h2>

	<table border="1">
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Date of Birth</th>
			<th>Address</th>
			<th>Notes</th>
			<th>Actions</th>
		</tr>
		<!-- Iterate through the list of students -->
		<% for (Student student : students) { %>
		<tr>
			<td><%= student.getId() %></td>
			<td><%= student.getName() %></td>
			<td><%= student.getBirthday() %></td>
			<td><%= student.getAddress() %></td>
			<td><%= student.getNotes() %></td>
			<!-- Button to update a student -->
			<td>
				<form method="post" action="AddStudentToCourseServlet">
					<input type="hidden" name="id_student"
						value="<%= student.getId() %>"> <input type="hidden"
						name="id_course" value="<%= id_course %>"> <input
						type="submit" value=Add>
				</form>
			</td>

		</tr>
		<% } %>


	</table>
	<% if (meg != null) { %>
	<h4>Add successfully</h4>
	<% } %>
	<form action="StudentlistFiltered.jsp?id = <%= id_course %> ">
		<input type="submit" value="Back"> <input type="hidden"
			name="id" value="<%= id_course %>">
	</form>
</body>
</html>

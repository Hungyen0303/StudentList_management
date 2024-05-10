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
<title>Course and Grade</title>
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
</style>
<body>
	<%

 
    String id_student = request.getParameter("id_student");
    String url = "jdbc:postgresql://localhost:5432/QLHS"; // 
	String username = "y"; 
	String password = "123"; 
	List<Map.Entry<String, String>> course_student_list = new ArrayList<>();
	try {
	
    Class.forName("org.postgresql.Driver");
    Connection connection = DriverManager.getConnection(url, username, password);

    if (connection != null) {
        courseDAO stu_dao = new courseDAO(connection) ; 
        course_student_list = stu_dao.getAllSetById(id_student);
        connection.close();
    }} catch (ClassNotFoundException e) {
    System.out.println("PostgreSQL JDBC driver not found.");
    e.printStackTrace();} catch (SQLException e) {
    System.out.println("Failed to connect to PostgreSQL database.");
    System.out.println("Error: " + e.getMessage());}
   
 
%>

	<h2>
		Sinh viên
		<%= id_student %></h2>








	<table border="1">
		<tr>

			<th>Name Course</th>
			<th>Grade</th>


		</tr>
		<!-- Iterate through the list of students -->
		<% for (Map.Entry<String,String> cs : course_student_list) { %>
		<tr>
			<td><%= cs.getKey() %></td>
			<td><%= cs.getValue() %></td>

		</tr>
		<% } %>
	</table>
	<form action="course_student.jsp">
		<input type="submit" value="Back">
	</form>
</body>

</html>



</body>
</html>
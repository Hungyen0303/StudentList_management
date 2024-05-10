<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.util.ArrayList, java.util.Date, java.util.List, java.sql.Connection
, java.sql.DriverManager, java.sql.SQLException, java.util.Collections, java.util.Comparator,java.util.*"%>
<%@ page import="com.studentmanagement.Student"%>
<%@ page import="com.studentmanagement.StudentDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Student student</title>
</head>
<style>
<
style>* {
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

input[type="text"], input[type="submit"], input[type="date"] {
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
	width: 100%;
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

button {
	padding: 10px;
	border-radius: 10px;
	border: none;
	background-color: #45a049;
	color: white;
}
</style>
<body>
	<%
	String url = "jdbc:postgresql://localhost:5432/QLHS"; // 
	String username = "y"; 
	String password = "123"; 
	Student a = new Student() ; 
	String id = request.getParameter("id"); 
	System.out.println(id);
	try {
	
   Class.forName("org.postgresql.Driver");
   Connection connection = DriverManager.getConnection(url, username, password);

   if (connection != null) {
       StudentDAO stu_dao = new StudentDAO(connection) ; 
       a  = stu_dao.searchStudentbyID(id); 
       System.out.println(a.getAddress());
       connection.close();
   }} catch (ClassNotFoundException e) {
   System.out.println("PostgreSQL JDBC driver not found.");
   e.printStackTrace();} catch (SQLException e) {
   System.out.println("Failed to connect to PostgreSQL database.");
   System.out.println("Error: " + e.getMessage());}


%>

	<form method="post" action="updateStudentServlet">
		<input name='id' type="text" value="<%= a.getId() %>"> <input
			name='name' type="text" value="<%= a.getName() %>"> <input
			name='dob' type="date" value="<%= a.getBirthday() %>"> <input
			name='address' type="text" value="<%= a.getAddress() %>"> <input
			name='notes' type="text" value="<%= a.getNotes() %>">
		<button type="submit">Submit</button>
	</form>


	<form action="index.jsp">
		<input type="submit" value="Back to main">
	</form>


</body>
</html>
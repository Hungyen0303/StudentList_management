<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.util.ArrayList, java.util.Date, java.util.List, java.sql.Connection
, java.sql.DriverManager, java.sql.SQLException, java.util.Collections, java.util.Comparator,java.util.*"%>
<%@ page import="com.studentmanagement.course"%>
<%@ page import="com.studentmanagement.courseDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Student student</title>
</head>
<link href = "css/updateStudent.css" rel= "stylesheet" >
<body>
	<%
	String url = "jdbc:postgresql://localhost:5432/QLHS"; // 
	String username = "y"; 
	String password = "123"; 
	course a = new course() ; 
	String id = request.getParameter("id"); 
	try {
	
   Class.forName("org.postgresql.Driver");
   Connection connection = DriverManager.getConnection(url, username, password);

   if (connection != null) {
       courseDAO stu_dao = new courseDAO(connection) ; 
       a  = stu_dao.searchCoursebyID(id);
       connection.close();
   }} catch (ClassNotFoundException e) {
   System.out.println("PostgreSQL JDBC driver not found.");
   e.printStackTrace();} catch (SQLException e) {
   System.out.println("Failed to connect to PostgreSQL database.");
   System.out.println("Error: " + e.getMessage());}


%>

	<form method="post" action="updatecourseServlet">
		<input name='id' type="text" value="<%= a.getId() %>" readonly> <input
			name='name' type="text" value="<%= a.getName() %>"> <input
			name='year' type="text" value="<%= a.getyear() %>"> <input
			name='lecture' type="text" value="<%= a.getLecture() %>"> <input
			name='notes' type="text" value="<%= a.getNotes() %>">
		<button type="submit">Submit</button>
	</form>


	<form action="course.jsp">
		<input type="submit" value="Back">
	</form>


</body>
</html>
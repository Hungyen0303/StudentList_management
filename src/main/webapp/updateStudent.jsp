<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.Date, java.util.List, java.sql.Connection
, java.sql.DriverManager, java.sql.SQLException, java.util.Collections, java.util.Comparator,java.util.*"%>
<%@ page import="com.studentmanagement.Student"%>
<%@ page import="com.studentmanagement.StudentDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Student student</title>
<link href = "css/updateStudent.css" rel= "stylesheet">
</head>

<body>
	<%
	String url = "jdbc:postgresql://localhost:5432/QLHS"; // 
	String username = "y"; 
	String password = "123"; 
	Student a = new Student() ; 
	String id = request.getParameter("id"); 
	try {
   Class.forName("org.postgresql.Driver");
   Connection connection = DriverManager.getConnection(url, username, password);
   if (connection != null) {
       StudentDAO stu_dao = new StudentDAO(connection) ; 
       a  = stu_dao.searchStudentbyID(id); 
       connection.close();
   }} catch (ClassNotFoundException e) {
   System.out.println("PostgreSQL JDBC driver not found.");
   e.printStackTrace();} catch (SQLException e) {
   System.out.println("Failed to connect to PostgreSQL database.");
   System.out.println("Error: " + e.getMessage());}


%>
	
	<div class = "container">
		<div class= "title"><h2>Update student: <%= a.getId() %></h2></div>
		<form class="btn-group" method="post" action="updateStudentServlet" accept-charset="UTF-8">
			<input name='id'  type="text" value="<%= a.getId() %>" readonly> 
			<input name='name' type="text" value="<%= a.getName() %>"> 
			<input name='dob' type="date" value="<%= a.getBirthday() %>"> 
			<input name='address' type="text" value="<%= a.getAddress() %>"> 
			<input name='notes' type="text" value="<%= a.getNotes() %>">
			<button type="submit">Submit</button>
		</form>
		<form action="studentList.jsp">
			<input type="submit" value="Back">
		</form>
	</div>
	


</body>
</html>
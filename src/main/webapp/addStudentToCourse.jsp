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

<script src= "js/handlePopUp.js"></script>
<link href = "css/PopUp.css" rel="stylesheet" >
<!--  add bootstrap  -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
	color : 
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

p{margin : 0;}
.btn_close
{
	background-color : #6c757d;
	color : white ; 
	padding :0 0.5rem; 
	height : 41.6px	 ;
	border : none; 
	border-radius : 5px ;
}

.popup {
    height: 10%;
    justify-content : start;
    align-items : center ;
    gap : 5px;
}
.overlay{
 	background-color: rgba(0, 0, 0, 0.11);
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
	
	<div class='popup' id='enterGrade' >
	<div class= "d-flex align-items-center"><p> Nhập điểm </p></div>
	<div class= "d-flex">  
	<form method="post" action="AddStudentToCourseServlet">	
					<input id="id_student" type="hidden" name="id_student" value=""> 
					<input type="hidden" name="id_course" value="<%= id_course %>">
					<input type="text" name="grade" value="" placeholder="Bằng 0 nếu không nhập ">
					<input type="submit" value=Add>
					
	</form>
	<div class= "d-flex align-items-center"><button class = "btn_close" onclick="hideUpGrade()">Close</button></div>
	</div>
  
	</div>
    <div class='overlay' id='overlay'></div>
	
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
				<button class="btn btn-success" onclick="showPopUpGrade(<%= student.getId()%>)">Add</button>

			</td>

		</tr>
		<% } %>


	</table>
	<% if (meg != null) { %>
	<h4>Add successfully</h4>
	<% } %>
	<form action="StudentlistFiltered.jsp?id = <%= id_course %> ">
		<input type="submit" value=	"Back"> <input type="hidden"
			name="id" value="<%= id_course %>">
	</form>
</body>
</html>

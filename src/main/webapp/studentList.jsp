<%@ page
	import="java.util.ArrayList, java.util.Date, java.util.List, java.sql.Connection, java.sql.DriverManager, java.sql.SQLException, java.util.Collections, java.util.Comparator"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.studentmanagement.Student"%>
<%@ page import="com.studentmanagement.StudentDAO"%>
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
	border-radius: 10px;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
	border-radius: 10px;
}

tr {
	border-radius: 10px;
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

.function {
	display: flex;
	flex-direction: row;
}

h2 {
	color: #4CAF50;
}
</style>
<body>
	<%
    String sortType = request.getParameter("sortType");
    String searchName = request.getParameter("searchName");
    String url = "jdbc:postgresql://localhost:5432/QLHS"; // 
	String username = "y"; 
	String password = "123"; 
	List<Student> students = new ArrayList<>();
	try {
	
    Class.forName("org.postgresql.Driver");
    Connection connection = DriverManager.getConnection(url, username, password);

    if (connection != null) {
        System.out.println("Connected to PostgreSQL database successfully.");
        StudentDAO stu_dao = new StudentDAO(connection) ; 
        students = stu_dao.getAllStudents();
        connection.close();
    }} catch (ClassNotFoundException e) {
    System.out.println("PostgreSQL JDBC driver not found.");
    e.printStackTrace();} catch (SQLException e) {
    System.out.println("Failed to connect to PostgreSQL database.");
    System.out.println("Error: " + e.getMessage());}
   
	if (searchName != null && !searchName.isEmpty()) {
        List<Student> filteredStudents = new ArrayList<>();
        for (Student student : students) {
            if (student.getName().toLowerCase().contains(searchName.toLowerCase())) {
                filteredStudents.add(student);
            }
        }
        students = filteredStudents;
    }
    // Sắp xếp danh sách sinh viên theo tên nếu có yêu cầu sắp xếp
    if (sortType != null && (sortType.equals("asc") || sortType.equals("desc"))) {
        Collections.sort(students, sortType.equals("desc") ? Comparator.comparing(Student::getName).reversed() : Comparator.comparing(Student::getName));
    }

    // Nếu có yêu cầu tìm kiếm theo tên, lọc danh sách sinh viên phù hợp
    %>

	<h2>Student List</h2>


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
				<form method="post" action="updateStudent.jsp">
					<input type="hidden" name="id" value="<%= student.getId() %>">
					<input type="submit" value="Update">
				</form>
			</td>
			<!-- Button to delete a student -->
			<td>
				<form action="deleteStudentServlet" method="post">
					<input type="hidden" name="id" value="<%= student.getId() %>">
					<input type="submit" value="Delete">
				</form>
			</td>
		</tr>
		<% } %>
	</table>
	<div class="function">
		<form action="index.jsp">
			<input type="submit" value="Back to main">
		</form>
		<!-- Button to add a new student -->
		<form action="addStudent.jsp">
			<input type="submit" value="Add Student">
		</form>

		<!-- Search by name -->
		<form action="studentList.jsp" method="get">
			<input type="text" name="searchName" placeholder="Search by Name"
				value="<%= searchName != null ? searchName : "" %>"> <input
				type="submit" value="Search">
		</form>

		<!-- Buttons to sort by name -->
		<form action="studentList.jsp" method="get">
			<input type="hidden" name="sortType" value="asc"> <input
				type="submit" value="Sort by Name ASC">
		</form>
		<form action="studentList.jsp" method="get">
			<input type="hidden" name="sortType" value="desc"> <input
				type="submit" value="Sort by Name DESC">
		</form>
	</div>

</body>
</html>

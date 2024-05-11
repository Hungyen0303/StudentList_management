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
<link href = "css/studentList.css" rel= "stylesheet">
<script>
function showPopup() {
    document.getElementById("errorPopup").style.display = "block";
    document.getElementById("overlay").style.display = "block";
}

function hidePopup() {
    document.getElementById("errorPopup").style.display = "none";
    document.getElementById("overlay").style.display = "none";
}
</script>
 </head>

<body>
	<%
	
	String delete_noti = request.getParameter("delete_noti");
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
	<div class="popup" id="errorPopup"  >
    <h2>An error occurred while deleting the student. Please try again later.</h2>
    <button onclick="hidePopup()">Close</button>
    <button> Continue </button>
	</div>
	<div class="overlay" id="overlay"></div>

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
					<%
					if (delete_noti != null && delete_noti.equals("error")) 
					{
						out.println("<script>showPopup();</script>");
					}
					%>
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

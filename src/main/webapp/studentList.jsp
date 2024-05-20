<%@ page import="java.util.ArrayList, java.util.Date, java.util.List, java.sql.Connection, 
java.sql.DriverManager, java.sql.SQLException, java.util.Collections, java.util.Comparator, java.text.Normalizer, java.util.regex.Pattern"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.studentmanagement.Student"%>
<%@ page import="com.studentmanagement.StudentDAO"%>
<%@ page import="com.studentmanagement.courseDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student List</title>
<!--  add bootstrap  -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Link to css file  -->

<link href = "css/studentList.css" rel= "stylesheet">
<link href = "css/PopUp.css" rel= "stylesheet">
<!-- Link to js file  -->

<script src = "js/handlePopUp.js"></script>
 </head>

<body>
	<%
    String sortType = request.getParameter("sortType");
    String searchName = request.getParameter("searchName");
    String url = "jdbc:postgresql://localhost:5432/QLHS";
    String username = "y";
    String password = "123";
    List<Student> students = new ArrayList<>();

    try {
        Class.forName("org.postgresql.Driver");
        Connection connection = DriverManager.getConnection(url, username, password);

        if (connection != null) {
            StudentDAO stu_dao = new StudentDAO(connection);
            students = stu_dao.getAllStudents();
            connection.close();
        }
    } catch (ClassNotFoundException e) {
        System.out.println("PostgreSQL JDBC driver not found.");
        e.printStackTrace();
    } catch (SQLException e) {
        System.out.println("Failed to connect to PostgreSQL database.");
        System.out.println("Error: " + e.getMessage());
    } finally
    {
    	
    }

    // Sắp xếp danh sách sinh viên theo tên nếu có yêu cầu sắp xếp
    if (sortType != null && (sortType.equals("asc") || sortType.equals("desc"))) {
        Collections.sort(students, sortType.equals("desc") ? Comparator.comparing(Student::getName).reversed() : Comparator.comparing(Student::getName));
    }

    // Nếu có yêu cầu tìm kiếm theo tên, lọc danh sách sinh viên phù hợp
    if (searchName != null && !searchName.isEmpty()) {
        List<Student> filteredStudents = new ArrayList<>();
        for (Student student : students) {
            if (student.getName().toLowerCase().contains(searchName.toLowerCase())) {
                filteredStudents.add(student);
            }
        }
        students = filteredStudents;
    }
%>

	<h2><strong>Student List</strong></h2>
	
	<!-- Pop up to confirm delete or not  -->
	<div class='popup' id='errorPopup' >

	<p> Bạn có muốn tiếp tục xoá </p>
	<div class= "d-flex gr-button">  
	<button onclick='hidePopup()'>Close</button>
    <form action="deleteStudentServlet" method="post">
    	<input type="hidden" id="id" name="id" value = "">
		<input class="button-continue" type="submit" value="Continue">
	</form>
	</div>
  
	</div>
    <div class='overlay' id='overlay'></div>

	
	
	<div class = "container-xxl">
	
	
	
	<table class="table table-striped"  border="1">
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Date of Birth</th>
			<th>Address</th>
			<th>Notes</th>
			<th></th>
		</tr>
		<!-- Iterate through the list of students -->
		<% 
		for (Student student : students) {
		%>
		<tr>
			<td><%= student.getId() %></td>
			<td><%= student.getName() %></td> 
<%-- 			<% System.out.println(student.getName()); %> --%>
			<td><%= student.getBirthday() %></td>
			<td><%= student.getAddress() %></td>
			<td><%= student.getNotes() %></td>
			<!-- Button to update a student -->
			<td>
			
				<div class= "button-group">
					<!-- Button to update a student -->
					<form   method="post" action="updateStudent.jsp">
						<input type="hidden" name="id" value="<%= student.getId() %>">
						<input class="button button-update" type="submit" value="Update">
					</form>
					<!-- Button to delete a student -->
					<button class="button button-delete" onclick='showPopup(<%= student.getId() %>)'> Delete </button>
					<form style="margin-left: 5px;" method="post" action="seeCourseAndGrade.jsp" >
							<input type="hidden" name="id_student" value="<%= student.getId() %>">
							<input class="btn__seecourse" type="submit" value="See course and grade">
					</form>
				</div>
				
			</td>
			
			
		</tr>
		<%} %>
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
			<input type="hidden" name="sortType" value="asc"> 
			<input type="hidden" name="searchName"  value="<%= searchName != null ? searchName : "" %>"> 
			<input type="submit" value="Sort by Name ASC">
		</form>
		<form action="studentList.jsp" method="get">
			<input type="hidden" name="sortType" value="desc"> 
			<input type="hidden" name="searchName"  value="<%= searchName != null ? searchName : "" %>"> 
			<input type="submit" value="Sort by Name DESC">
		</form>
	</div>
	</div>

</body>
</html>

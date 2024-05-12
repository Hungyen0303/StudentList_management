<%@ page
	import="java.util.ArrayList, java.util.Date, java.util.List, java.sql.Connection, java.sql.DriverManager, java.sql.SQLException, java.util.Collections, java.util.Comparator"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.studentmanagement.course"%>
<%@ page import="com.studentmanagement.courseDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course List</title>
</head>
<!--  add bootstrap  -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- link to css  -->
<link href = "css/course.css"  rel= "stylesheet"> 
<body>
	<%
	String url = "jdbc:postgresql://localhost:5432/QLHS"; // 
	String username = "y"; 
	String password = "123"; 
	List<course> course_list = new ArrayList<>();
	try {
	
    Class.forName("org.postgresql.Driver");

   
    Connection connection = DriverManager.getConnection(url, username, password);

    if (connection != null) {
        System.out.println("Connected to PostgreSQL database successfully.");
        courseDAO course_dao = new courseDAO(connection) ; 
        course_list = course_dao.getAllCourse(); 
        connection.close();
    }} catch (ClassNotFoundException e) {
    System.out.println("PostgreSQL JDBC driver not found.");
    e.printStackTrace();} catch (SQLException e) {
    System.out.println("Failed to connect to PostgreSQL database.");
    System.out.println("Error: " + e.getMessage());}
    String sortType = request.getParameter("sortType");
    String searchName = request.getParameter("searchName");
    String searchYear = request.getParameter("searchYear");

    // Sắp xếp danh sách lớp học theo tên nếu có yêu cầu sắp xếp
    if (sortType != null && (sortType.equals("asc") || sortType.equals("desc"))) {
        Collections.sort(course_list, sortType.equals("desc") ? Comparator.comparing(course::getName).reversed() : Comparator.comparing(course::getName));
    }

    // Nếu có yêu cầu tìm kiếm theo tên, lọc danh sách lớp học phù hợp
    if (searchName != null && !searchName.isEmpty()) {
        List<course> filteredcourse = new ArrayList<>();
        for (course course : course_list) {
            if (course.getName().toLowerCase().contains(searchName.toLowerCase())) {
                filteredcourse.add(course);
            }
        }
        course_list = filteredcourse;
    }
    if (searchYear != null && !searchName.isEmpty()) {
        List<course> filteredcourse = new ArrayList<>();
        for (course course : course_list) {
            if (course.getyear().toLowerCase().contains(searchName.toLowerCase())) {
                filteredcourse.add(course);
            }
        }
        course_list = filteredcourse;
    }
%>

	<h2>course List</h2>

	<!-- Button to add a new course -->



	<table border="1">
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Date</th>
			<th>Lecture</th>
			<th>Notes</th>
			<th></th>
		</tr>
		<!-- Iterate through the list of courses -->
		<% for (course c : course_list) { %>
		<tr>
			<td><%= c.getId() %></td>
			<td><%= c.getName() %></td>
			<td><%= c.getyear()%></td>
			<td><%= c.getLecture() %></td>
			<td><%= c.getNotes() %></td>
			<!-- Button to update a course -->
			<td>
				<form action="updatecourse.jsp">
					<input type="hidden" name="id" value="<%= c.getId() %>"> <input
						type="submit" value="Update">
				</form>
			</td>
			<!-- Button to delete a course -->
			<td>
				<form action="deletecourseServlet" method="post">
					<input type="hidden" name="id" value="<%= c.getId() %>"> <input
						type="submit" value="Delete">
				</form>
			</td>
			<td>
				<form action="StudentlistFiltered.jsp" method="post">
					<input type="hidden" name="id" value="<%= c.getId() %>"> <input
						type="submit" value="See all students">
				</form>
			</td>
		</tr>
		<% } %>
	</table>
	<div class="function">
		<form action="index.jsp">
			<input type="submit" value="Back to main">
		</form>
		<form action="addcourse.jsp">
			<input type="submit" value="Add course">
		</form>

		<!-- Search by name -->
		<form action="course.jsp" method="get">
			<input type="text" name="searchName" placeholder="Search by Name"
				value="<%= searchName != null ? searchName : "" %>"> <input
				type="submit" value="Search">
		</form>
		<!-- Search by year -->
		<form action="course.jsp" method="get">
			<input type="text" name="searchYear" placeholder="Search by Year"
				value="<%= searchYear != null ? searchYear : "" %>"> <input
				type="submit" value="Search">
		</form>
		<!-- Buttons to sort by name -->
		<form action="course.jsp" method="get">
			<input type="hidden" name="sortType" value="asc"> <input
				type="submit" value="Sort by Name ASC">
		</form>
		<form action="course.jsp" method="get">
			<input type="hidden" name="sortType" value="desc"> <input
				type="submit" value="Sort by Name DESC">
		</form>
	</div>
</body>
</html>

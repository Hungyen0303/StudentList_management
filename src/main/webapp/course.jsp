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
<link href = "css/PopUp.css"  rel= "stylesheet"> 

<script src = "js/handlePopUp.js"></script>
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
   
    if (searchYear != null && !searchYear.isEmpty()) {
        List<course> filteredcourse = new ArrayList<>();
        for (course course : course_list) {
            if (course.getyear().toLowerCase().contains(searchYear.toLowerCase())) {
                filteredcourse.add(course);
            }
        }
        course_list = filteredcourse;
    }
%>






	<h2>Course List</h2>
	<div class='popup' id='errorPopup' >
	<p> Bạn có muốn tiếp tục xoá </p>
	<div class= "d-flex gr-button">  
	<button onclick='hidePopup()'>Close</button>
    <form action="deletecourseServlet" method="post">
    	<input type="hidden" id="id" name="id" value = "">
		<input class="button-continue" type="submit" value="Continue">
	</form>
	</div>
	</div>
    <div class='overlay' id='overlay'></div>



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
				<div class= "button-group">
				
				<form action="updatecourse.jsp">
					<input type="hidden" name="id" value="<%= c.getId() %>"> 
					<input class = "button button-update"
						type="submit" value="Update">
				</form>
				
				<button class= "button button-delete" type = "button" onclick = "showPopup('<%=c.getId()%>')" class = "btn btn-danger"> Delete </button>
				
				<form action="StudentlistFiltered.jsp" method="post">
					<input type="hidden" name="id" value="<%= c.getId() %>"> <input
						type="submit" value="See all students">
				</form>
				</div>
			</td>
		</tr>
		<% } %>
	</table>
	<div class = "btn-group">
	<div class="function">
		<form action="index.jsp">
			<input type="submit" value="Back to main">
		</form>
		<form action="addcourse.jsp">
			<input type="submit" value="Add course">
		</form>
		
		<form action="course.jsp" method="get">
				<!-- search by name   -->
			<input type="text" name="searchName" placeholder="Search by Name"
				value="<%= searchName != null ? searchName : "" %>"> 
				<input type="submit" value="Search">
			<!-- search by year  -->
			<input type="text" name="searchYear" placeholder="Search by Year"
				value="<%= searchYear != null ? searchYear : "" %>"> 
			<input type="submit" value="Search">	
			
		</form>
		<form action="course.jsp" method="get">
				<!-- search by name   -->
			<input type="hidden" name="searchName" value="<%= searchName != null ? searchName : "" %>"> 
			<!-- search by year  -->
			<input type="hidden" name="searchYear"  value="<%= searchYear != null ? searchYear : "" %>"> 
			<!-- sort type  -->
			<input type="hidden" name="sortType" value="asc"> 
			<input type="submit" value="Sort by Name ASC">
			
		</form>
		<form action="course.jsp" method="get">
				<!-- search by name   -->
			<input type="hidden" name="searchName" value="<%= searchName != null ? searchName : "" %>"> 
			<!-- search by year  -->
			<input type="hidden" name="searchYear"  value="<%= searchYear != null ? searchYear : "" %>"> 
			<!-- sort type  -->
			<input type="hidden" name="sortType" value="desc"> 
			<input type="submit" value="Sort by Name DESC">
			
		</form>
	</div>
	
	</div>	 	
</body>
</html>

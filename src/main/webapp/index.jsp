<%@ page import="java.util.ArrayList, java.util.Date, java.util.List, java.sql.Connection, java.sql.DriverManager, java.sql.SQLException"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.studentmanagement.Student"%>
<%@ page import="com.studentmanagement.StudentDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student List</title>
<!--  add bootstrap  -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!--    -->
<link href="css/index.css" rel="stylesheet">
</head>
<body>
	<div class="container-xl text-white " >
		
		<div class="title">
			<h2>Trang chủ</h2>
		</div>
		<div class = "container row"> 
		
			<div class = "col-xl-6 img" ></div>
		
			<div class = "col-xl-6" >
				<form action="studentList.jsp">
					<input type="submit" value="Danh sách học sinh">
				</form>
				<form action="course.jsp">
					<input type="submit" value="Danh sách khoá học">
				</form>
				<form action="course_student.jsp">		
					<input type="submit" value="Danh sách học sinh tham gia khoá học">
				</form>
			</div >
		</div>
	</div>
</body>
</html>

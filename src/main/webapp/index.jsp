<%@ page import="java.util.ArrayList, java.util.Date, java.util.List, java.sql.Connection, java.sql.DriverManager, java.sql.SQLException"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.studentmanagement.Student"%>
<%@ page import="com.studentmanagement.StudentDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student List</title>
<link href="css/index.css" rel="stylesheet">
</head>
<body>
	<div class="main">
		<div class="title">
			<h1>Website Quản lí học sinh</h1>
			<h2>Trang chủ</h2>
		</div>
		<!-- Button to add a new student -->
		<form action="studentList.jsp">
			<input type="submit" value="Danh sách học sinh">
		</form>
		<form action="course.jsp">
			<input type="submit" value="Danh sách khoá học">
		</form>
		<form action="course_student.jsp">
			<input type="submit" value="Danh sách học sinh tham gia khoá học">
		</form>
	</div>
</body>
</html>

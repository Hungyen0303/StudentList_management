<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add student</title>
<link href = "css/updateStudent.css" rel = "stylesheet">
<style>
input[name = "id"]
{
background-color: #ffffff  ;
}
</style>
</head>

<body>

	<form method="post" action="AddStudentServlet">
		<input name='id' type="text" name="id" placeholder="ID ( have to contain 8 letter"> <input
			name='name' type="text" name="name" placeholder="Name"> <input
			name='dob' type="date" name="dob" placeholder="Date of Birth">
		<input name='address' type="text" name="address" placeholder="Address">
		<input name='notes' type="text" name="notes" placeholder="Notes">
		<button type="submit">Submit</button>
	</form>


	<form action="studentList.jsp">
		<input type="submit" value="Back">
	</form>

</body>
</html>
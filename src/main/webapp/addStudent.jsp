<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add student</title>
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

input[type="text"], input[type="submit"], input[type="date"] {
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
	width: 100%;
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

.btn-container {
	display: flex;
	margin-top: 20px;
}

.btn-container form {
	margin-right: 10px;
}

button {
	padding: 10px;
	border-radius: 10px;
	border: none;
	background-color: #45a049;
	color: white;
}
</style>
<body>

	<form method="post" action="AddStudentServlet">
		<input name='id' type="text" name="id" placeholder="ID"> <input
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Course</title>
</head>
<script src = "js/validation.js" ></script>

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


</style>
<body>
	
	<%
	String valid= request.getParameter("valid"); 
	String current_id = request.getParameter("id"); 
	String current_name = request.getParameter("name"); 
	String current_year = request.getParameter("year"); 
	String current_lecture = request.getParameter("lecture"); 
	String current_note = request.getParameter("notes"); 
	if (current_id == null) 
	{
		current_id = "";
	}
	if (current_year == null) 
	{
		current_year = "";
	}
	if (current_lecture == null) 
	{
		current_lecture = "";
	}
	if (current_name == null) 
	{
		current_name = "";
	}
	if (current_note == null) 
	{
		current_note = "";
	}
	if (valid == null) 
	{
		
	}
	else if (valid.equals("blank")){
		out.println("<p style='color: red; ' >Please fill out the form </p>");
	}
	else {
		out.println("<p style='color: red; text-transform: uppercase;' >Please type suitable id (must contain 8 letter) </p>");
		out.println("<p style='color: red; text-transform: uppercase;' >ex: CSC00001 </p>");
	}
	%>
	<div >
	
	</div>
	

	<form method="post" action="AddCourseServlet">
		<input name='id' type="text" name="id" placeholder="ID" value="<%= current_id%>"> 
		<input name='name' type="text" name="name" placeholder="Name" value="<%= current_name%>"> 
		<input name='year' type="number" min="1900" max="2099" step="1" value="2024" value="<%= current_year%>"/>
		<input name='lecture' type="text" name="lecture" placeholder="lecture" value="<%= current_lecture%>">
		<input name='notes' type="text" name="notes" placeholder="Notes" value="<%= current_note%>">
		<button type="submit" >Submit</button>
	</form>
	
	
	
	
	<form action="index.jsp">
		<input type="submit" value="Back to main">
	</form>




</body>
</html>
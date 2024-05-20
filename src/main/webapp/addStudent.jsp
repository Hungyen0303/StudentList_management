
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

	<%
	String valid= request.getParameter("valid"); 
	String current_id = request.getParameter("id"); 
	String current_name = request.getParameter("name"); 
	String current_dob = request.getParameter("dob"); 
	String current_address = request.getParameter("address"); 
	String current_note = request.getParameter("notes"); 
	if (current_id == null) 
	{
		current_id = "";
	}
	if (current_name == null) 
	{
		current_name = "";
	}
	if (current_dob == null) 
	{
		current_dob = "";
	}
	if (current_address == null) 
	{
		current_address = "";
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
		out.println("<p style='color: red; text-transform: uppercase;' >ex: 21120372 </p>");
	}
	%>
	<form method="post" action="AddStudentServlet" >
	<input name='id' type="text" name="id" placeholder="ID" value="<%= current_id%>"> 
		<input name='name' type="text" name="name" placeholder="Name" value="<%= current_name%>"> 
		<input name='dob' type="date"  value="<%= current_dob%>"/>
		<input name='address' type="text" placeholder="Address" value="<%=current_address%>">
		<input name='notes' type="text" placeholder="Notes" value="<%= current_note%>">
		<button type="submit" >Submit</button>
	</form>


	<form action="studentList.jsp">
		<input type="submit" value="Back">
	</form>

</body>
</html>
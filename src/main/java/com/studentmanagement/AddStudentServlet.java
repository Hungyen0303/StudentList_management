package com.studentmanagement;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet (urlPatterns = "/AddStudentServlet")
public class AddStudentServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {	
	}
	
	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8");


        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String notes = request.getParameter("notes");
        String url = "jdbc:postgresql://localhost:5432/QLHS"; 
    	String username = "y"; 
    	String password = "123"; 
    	/*check valid info */
    
    	String current_info = "&id=" + id + "&name="  + name + "&dob="+dob + 
    			"&address="+ address + "&notes=" + notes; 
    	System.out.println(current_info);
    	if ( name.length()==0 || dob.length() == 0 || address.length() == 0 ) 
    	{
    		String link_to_studentLIst= "http://localhost:8080/demo/addStudent.jsp?valid=blank"+ current_info;
            response.sendRedirect(link_to_studentLIst);
            return ; 
    	}
    	if (id.trim().length()!=8 ) 
    	{
    		String link_to_studentLIst= "http://localhost:8080/demo/addStudent	.jsp?valid=id" + current_info;
            response.sendRedirect(link_to_studentLIst);
            return ; 
    	}
    	try {
    	
        Class.forName("org.postgresql.Driver");
        Connection connection = DriverManager.getConnection(url, username, password);

        if (connection != null) {
        	
            StudentDAO stu_dao = new StudentDAO(connection) ; 
            stu_dao.addStudent(id, name, dob, address, notes);
            
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<h3>Student added successfully!</h3>");
            out.println("</body></html>");
            String link_to_studentLIst= "http://localhost:8080/demo/studentList.jsp";
            
            response.sendRedirect(link_to_studentLIst);
            connection.close();
        }} catch (ClassNotFoundException e) {
        System.out.println("PostgreSQL JDBC driver not found.");
        e.printStackTrace();} 
    	catch (SQLException e) {
        System.out.println("Failed to connect to PostgreSQL database.");
        System.out.println("Error: " + e.getMessage());} 
      
        
    }

   
}

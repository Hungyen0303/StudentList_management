package com.studentmanagement;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet (urlPatterns = "/AddCourseServlet")
public class AddCourseServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8");


        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String year = request.getParameter("year");
        String lecture = request.getParameter("lecture");
        String notes = request.getParameter("notes");
        String url = "jdbc:postgresql://localhost:5432/QLHS"; 
    	String username = "y"; 
    	String password = "123"; 
    	
    	
    	
    	/*check valid info */
    	String current_info = "&id=" + id + "&name= "  + name + "&year="+year + 
    			"&lecture="+ lecture + "&note = " + notes  ; 
    	if ( name.length()==0 || year.length() == 0 || lecture.length() == 0 ) 
    	{
    		String link_to_studentLIst= "http://localhost:8080/demo/addcourse.jsp?valid=blank"+ current_info;
    		
            response.sendRedirect(link_to_studentLIst);
            return ; 
    	}
    	if (id.trim().length()!=8 ) 
    	{
    		String link_to_studentLIst= "http://localhost:8080/demo/addcourse.jsp?valid=id" + current_info;
            response.sendRedirect(link_to_studentLIst);
            return ; 
    	}
     	
    	year = year.substring(0,4);
    	
    	try {
    	
        Class.forName("org.postgresql.Driver");
        Connection connection = DriverManager.getConnection(url, username, password);

        if (connection != null) {          
            courseDAO co_dao = new courseDAO(connection) ; 
            co_dao.addCourse(id, name, year, lecture, notes);
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<h3>Student added successfully!</h3>");
            out.println("</body></html>");
            String link_to_studentLIst= "http://localhost:8080/demo/course.jsp";
            
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

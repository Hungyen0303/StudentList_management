package com.studentmanagement;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet (urlPatterns = "/AddStudentToCourseServlet")
public class AddStudentToCourseServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id_student = request.getParameter("id_student");
        String id_course = request.getParameter("id_course");
        
        String url = "jdbc:postgresql://localhost:5432/QLHS"; 
    	String username = "y"; 
    	String password = "123"; 
 
    	try {
    	
        Class.forName("org.postgresql.Driver");
        Connection connection = DriverManager.getConnection(url, username, password);

        if (connection != null) {
            courseDAO stu_dao = new courseDAO(connection) ; 
            stu_dao.addStudentToCourse(id_student , id_course);
            String link_to_studentLIst= "http://localhost:8080/demo/addStudentToCourse.jsp?id_course="+id_course+"&message="+"success"  ;
            
            System.out.println("link to redirect " + link_to_studentLIst);
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

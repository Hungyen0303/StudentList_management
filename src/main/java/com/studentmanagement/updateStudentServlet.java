package com.studentmanagement;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet (urlPatterns = "/updateStudentServlet")
public class updateStudentServlet extends HttpServlet {
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
 
    	try {
    	
        Class.forName("org.postgresql.Driver");
        Connection connection = DriverManager.getConnection(url, username, password);

        if (connection != null) {
            System.out.println("Connected to PostgreSQL database successfully.");
            
            StudentDAO stu_dao = new StudentDAO(connection) ; 
            stu_dao.updateStudent(id , name , dob, address, notes);
            
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

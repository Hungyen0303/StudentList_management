package com.studentmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteStudentInClassServlet")
public class deleteStudentInClassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            response.setContentType("text/html;charset=UTF-8");
            String id_student = request.getParameter("id_student");
            String id_course = request.getParameter("id_course");
            System.out.print(id_student + id_course);
     
            String url = "jdbc:postgresql://localhost:5432/QLHS"; 
        	String username = "y"; 
        	String password = "123"; 
     
        	try {
        	
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);

            if (connection != null) {

                courseDAO stu_dao = new courseDAO(connection) ; 
                stu_dao.deleteStudentbyID(id_course, id_student);
                String link_to_studentLIst= "http://localhost:8080/demo/StudentlistFiltered.jsp?id=" + id_course ;
                
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

// StudentDAO.java
package com.studentmanagement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager; 
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class StudentDAO {
    private Connection connection;

    public StudentDAO(Connection connection) {
        this.connection = connection;
    }
    public StudentDAO() {
    	this.connection = this.createConnect(); 
    }
    public Connection getConnection() {return this.connection;}
    public Connection createConnect() 
    {
    	 String url = "jdbc:postgresql://localhost:5432/QLHS"; // 
    	 String username = "y"; 
    	 String password = "123"; 

    		try {
    		
    	    Class.forName("org.postgresql.Driver");
    	    Connection connection = DriverManager.getConnection(url, username, password);

    	    if (connection != null) {
    	        System.out.println("Connected to PostgreSQL database successfully.");
    	    	return connection; 
    	    }} catch (ClassNotFoundException e) {
    	    System.out.println("PostgreSQL JDBC driver not found.");
    	    e.printStackTrace();} catch (SQLException e) {
    	    System.out.println("Failed to connect to PostgreSQL database.");
    	    System.out.println("Error: " + e.getMessage());}
    	return connection; 
    }
    // Method to get all students from database
    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        String query = "SELECT * FROM student_QLHS";

        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                // Assuming a Date object for the birthday
                Student student = new Student(
                        rs.getString("id"),
                        rs.getString("name_student"),
                        rs.getString("birthday"),
                        rs.getString("address_student"),
                        rs.getString("notes")
                );
                students.add(student);
            }
        }

        return students;
    }

    // Method to add a new student to the database
    public void addStudent(String id, String name, String dob, String address, String notes) throws SQLException {
        String query = "INSERT INTO Student_QLHS (ID, Name_student, Birthday, address_student, notes) VALUES (?, ?, ?, ?, ?)";

     System.out.println(dob);
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id);
            stmt.setString(2, name);
            stmt.setString(3, dob);
            stmt.setString(4, address);
            stmt.setString(5, notes);

            stmt.executeUpdate();
        }
    }

    // Method to update an existing student in the database
    public void updateStudent(String id , String name , String birthday , String address , String notes) throws SQLException {
        String query = "UPDATE Student_QLHS SET name_student = ?, birthday = ?, address_student = ?, notes = ? WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, name);
            stmt.setString(2, birthday);
            stmt.setString(3, address);
            stmt.setString(4,notes);
            stmt.setString(5, id);
            stmt.executeUpdate();
        }
    }

    // Method to search for a student by ID
    public Student searchStudent(String name) throws SQLException {
        String query = "SELECT * FROM Student_QLHS WHERE name = ?";
        Student student = null;

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, name);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    student = new Student(
                            rs.getString("id"),
                            rs.getString("name_student"),
                            rs.getString("birthday"),
                            rs.getString("address_student"),
                            rs.getString("notes")
                    );
                }
            }
        }

        return student;
    }
    public Student searchStudentbyID(String id) throws SQLException {
        String query = "SELECT * FROM Student_QLHS WHERE id = ?";
        Student student = null;

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    student = new Student(
                            rs.getString("id"),
                            rs.getString("name_student"),
                            rs.getString("birthday"),
                            rs.getString("address_student"),
                            rs.getString("notes")
                    );
                }
            }
        }

        return student;
    }


    // Method to delete a student from the database by ID
    public void deleteStudent(String id) throws SQLException {
    	String query1 = "DELETE FROM course_student_QLHS WHERE student_id = ?"; 
        String query = "DELETE FROM Student_QLHS WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query1)) {
            stmt.setString(1, id);
            stmt.executeUpdate();
        }
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id);
            stmt.executeUpdate();
        }
    }
}

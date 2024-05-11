package com.studentmanagement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class courseDAO {
    private Connection connection;

    
    public courseDAO(Connection connection) {
        this.connection = connection;
    }

    // Method to get all course from database
    public List<course> getAllCourse() throws SQLException {
        List<course> courses = new ArrayList<>();
        String query = "SELECT * FROM course_QLHS";

        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                // Assuming a Date object for the birthday
                course co = new course(
                        rs.getString("id"),
                        rs.getString("name_course"),
                        rs.getString("year_of_course"),
                        rs.getString("lecture"),
                        rs.getString("notes")
                );
                courses.add(co);
            }
        }

        return courses;
    }
  
    
    public List<Student> getAllStudentByCourse(String id) throws SQLException {
        List<Student> stud = new ArrayList<>();
       
        String query = "\r\n"
        		+ "SELECT *\r\n"
        		+ "FROM student_qlhs\r\n"
        		+ "WHERE id IN (\r\n"
        		+ "    SELECT student_id\r\n"
        		+ "    FROM course_student_QLHS\r\n"
        		+ "    WHERE course_id = ?\r\n"
        		+ ")\r\n"
        		+ "";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                // Assuming a Date object for the birthday
                Student co = new Student(
                        rs.getString("id"),
                        rs.getString("name_student"),
                        rs.getString("birthday"),
                        rs.getString("address_student"),
                        rs.getString("notes")
                );
                stud.add(co);
            }
        }}

        return stud;
    }
    public List<Course_student> getAllSets(String year) throws SQLException {
        List<Course_student> stud = new ArrayList<>();
        String query = null; 
        if (year.equals("")) 
        {
        query = "select cs.id , cs.course_id , cs.student_id , cs.grade , c.year_of_course \r\n"
        		+ "from course_student_qlhs as cs ,course_qlhs as c\r\n"
        		+ "where cs.course_id = c.id";}
        else 
        {
        query = "select cs.id , cs.course_id , cs.student_id , cs.grade , c.year_of_course \r\n"
        		+ "from course_student_qlhs as cs ,course_qlhs as c\r\n"
        		+ "where course_id in (select id from course_qlhs \r\n"
        		+ "					where SUBSTRING(year_of_course, 1, 4) = ?  ) and cs.course_id = c.id";
        }
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
        	 if (year.equals("")) 
        	 {}else 
        	 {
        		 stmt.setString(1, year);
        	 }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Assuming a Date object for the birthday
                    Course_student co = new Course_student(
                            rs.getString("id"),
                            rs.getString("student_id"),
                            rs.getString("course_id"),
                            String.valueOf(rs.getDouble("grade")),
                            rs.getString("year_of_course"));
                            
      
                    stud.add(co);
                }
            }
        }
        return stud;
    }

    
    public List<Map.Entry<String, String>> getAllSetById(String id_student) throws SQLException {
        List<Map.Entry<String, String>> stud = new ArrayList<>();
        String query = "SELECT c.name_course, cs.grade FROM course_student_qlhs AS cs , course_qlhs AS c " +
                       "WHERE cs.course_id = c.id AND cs.student_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id_student);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String courseName = rs.getString("name_course");
                    String grade = String.valueOf(rs.getDouble("grade"));
                    Map.Entry<String, String> co = new AbstractMap.SimpleEntry<>(courseName, grade);
                    stud.add(co);
                }
            }
        }
        return stud;
    }
    public List<Student> getUnregisteredStudent(String id) throws SQLException {
        List<Student> stud = new ArrayList<>();
       
        String query = "select * from student_QLHS \r\n"
        		+ "where id not in (select student_id \r\n"
        		+ "				 from course_student_QLHS \r\n"
        		+ "				where course_id = ?)" ;

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                // Assuming a Date object for the birthday
                Student co = new Student(
                        rs.getString("id"),
                        rs.getString("name_student"),
                        rs.getString("birthday"),
                        rs.getString("address_student"),
                        rs.getString("notes")
                );
                stud.add(co);
            }
        }}

        return stud;
    }
    
    
    // Method to add a new student to the database
    public void addCourse(String id ,String name , String year , String lecture, String notes ) throws SQLException {
        String query = "INSERT INTO course_QLHS (id, name_course, lecture, year_of_course, notes) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id);
            stmt.setString(2, name);
            stmt.setString(4, year);
            stmt.setString(3, lecture);
            stmt.setString(5, notes);

            stmt.executeUpdate();
        }
    }

    public void addStudentToCourse(String id_student ,String id_course) throws SQLException {
    	// for check key exist or not 
    	boolean isKeyExist = false ; 
    	while (!isKeyExist) {
    		String sql = "SELECT COUNT(*) FROM course_student_QLHS WHERE id = ?";
            
            // Prepare the statement
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                // Set the parameter (id = '1')
                statement.setString(1, Integer.toString(course.number));
                
                // Execute the query and get the result set
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        // Get the count from the result set
                        int count = resultSet.getInt(1);
                        if (count !=  1 ) {  isKeyExist  = true;  }                     
                        else { course.number ++; } 
                        System.out.println("Count " + count + "number " + course.number );
                    }
                }
            }}
        String query = "INSERT INTO course_student_QLHS (id, student_id, course_id, grade) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, Integer.toString(course.number));
            stmt.setString(2, id_student);
            stmt.setString(3, id_course);
            stmt.setNull(4,Types.DOUBLE);
            course.number++;
            stmt.executeUpdate();
        }
    }

    // Method to update an existing course in the database
    public void updateCourse(String id , String name , String year , String lecture, String notes ) throws SQLException {
        String query = "UPDATE course_QLHS \r\n"
        		+ "SET name_course = ? , year_of_course = ?, lecture = ?, notes = ? \r\n"
        		+ "WHERE id = ? ";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, name);
            stmt.setString(2, year);
            stmt.setString(3, lecture);
            stmt.setString(4, notes);
            stmt.setString(5, id);
            stmt.executeUpdate();
        }
    }

    // Method to search for a course by ID
    public course searchCourseByName(String name) throws SQLException {
        String query = "SELECT * FROM course_QLHS WHERE name = ?";
        course co = null;

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, name);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    co = new course(
                            rs.getString("id"),
                            rs.getString("name"),
                            rs.getString("year"),
                            rs.getString("lecture"),
                            rs.getString("notes")
                    );
                }
            }
        }

        return co;
    }
    public course searchCourseByYear(String name) throws SQLException {
        String query = "SELECT * FROM Student WHERE Year(year) = ?";
        course co = null;

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, name);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    co = new course(
                            rs.getString("id"),
                            rs.getString("name"),
                            rs.getString("year"),
                            rs.getString("lecture"),
                            rs.getString("notes")
                    );
                }
            }
        }

        return co;
    }

    public course searchCoursebyID(String id) throws SQLException {
        String query = "SELECT * FROM course_QLHS WHERE id = ?";
        course c = null;

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    c = new course(
                            rs.getString("id"),
                            rs.getString("name_course"),
                            rs.getString("year_of_course"),
                            rs.getString("lecture"),
                            rs.getString("notes")
                    );
                }
            }
        }

        return c;
    }
    // Method to delete a course from the database by ID
    public void deleteCourse(String id) throws SQLException {
        String query = "DELETE FROM course_QLHS WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id);
            stmt.executeUpdate();
        }
    }
    public void deleteStudentbyID(String id_course, String id_student) throws SQLException {
        String query = "DELETE FROM course_student_QLHS WHERE course_id = ? and student_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, id_course);
            stmt.setString(2, id_student);
            
            stmt.executeUpdate();
        }
    }
    

}

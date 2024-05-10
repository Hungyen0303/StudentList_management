
package com.studentmanagement;


public class Course_student {
    private String id;
    private String student_id;
    private String course_id;
    private String grade;
    private String year; 
    
    // Constructor
    public Course_student(String id, String student_id,  String course_id, String grade, String year ) {
        this.id = id;
        this.student_id = student_id;
        this.course_id = course_id;
        this.grade = grade;
        this.year = year ; 
    }
    
    // Default constructor
    public Course_student() {}

    // Getters and setters
    public void setId(String id) {
        this.id = id;
    }
    public void setYear(String year) {
        this.year= year;
    }
    public void setgrade(String grade) {
        this.grade = grade;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public void setcourse_id(String course_id) {
        this.course_id = course_id;
    }
    public String getId() {
        return this.id; 
    }

    public String getcourse_id() {
        return this.course_id; 
    }


    public String getStudent_id() {
        return this.student_id;
    }

    public String getGrade() {
        return this.grade;
    }
    public String getYear() {
        return this.year;
    }
    
}

package com.studentmanagement;


public class course {
	static int number = 1 ; 
    private String id;
    private String name;
    private String lecture;
    private String Year;
    private String notes;
    
    // Constructor
    public course(String id, String name, String year, String lecture, String notes) {
        this.id = id;
        this.name = name;
        this.Year = year;
        this.lecture = lecture;
        this.notes = notes;
    }
    
    // Default constructor
    public course() {}

    // Getters and setters
    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setYear(String year) {
        this.Year = year;
    }

    public void setLecture(String lecture) {
        this.lecture = lecture;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
    public String getId() {
        return this.id; 
    }

    public String getName() {
        return this.name; 
    }

    public String getyear() {
        return this.Year;
    }

    public String getLecture() {
        return this.lecture;
    }

    public String getNotes() {
        return this.notes;
    }
}

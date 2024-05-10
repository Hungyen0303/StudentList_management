// Student.java
package com.studentmanagement;

public class Student {
    private String id;
    private String name;
    private String birthday;
    private String address;
    private String notes;
    
    // Constructor
    public Student(String id, String name, String birthday, String address, String notes) {
        this.id = id;
        this.name = name;
        this.birthday = birthday;
        this.address = address;
        this.notes = notes;
    }
    
    // Default constructor
    public Student() {}

    // Getters and setters
    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public String getBirthday() {

        return this.birthday;
    }

    public String getAddress() {
        return this.address;
    }

    public String getNotes() {
        return this.notes;
    }
}

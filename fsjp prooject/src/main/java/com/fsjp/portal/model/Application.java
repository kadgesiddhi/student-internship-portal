package com.fsjp.portal.model;

public class Application {
    private int id;
    private int internshipId;
    private int studentId;
    private String appliedDate;
    private String status;
    private String internshipTitle;
    private String companyName;
    private String location;
    private String studentName;
    private String email;
    private String college;
    private String course;
    private String skills;

    public Application() {
    }

    public Application(int id, int internshipId, int studentId, String appliedDate, String status,
                      String internshipTitle, String companyName, String location,
                      String studentName, String email, String college, String course, String skills) {
        this.id = id;
        this.internshipId = internshipId;
        this.studentId = studentId;
        this.appliedDate = appliedDate;
        this.status = status;
        this.internshipTitle = internshipTitle;
        this.companyName = companyName;
        this.location = location;
        this.studentName = studentName;
        this.email = email;
        this.college = college;
        this.course = course;
        this.skills = skills;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getInternshipId() { return internshipId; }
    public void setInternshipId(int internshipId) { this.internshipId = internshipId; }
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public String getAppliedDate() { return appliedDate; }
    public void setAppliedDate(String appliedDate) { this.appliedDate = appliedDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getInternshipTitle() { return internshipTitle; }
    public void setInternshipTitle(String internshipTitle) { this.internshipTitle = internshipTitle; }
    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getCollege() { return college; }
    public void setCollege(String college) { this.college = college; }
    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }
    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }
}

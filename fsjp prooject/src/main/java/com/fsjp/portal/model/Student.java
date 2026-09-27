package com.fsjp.portal.model;

public class Student {
    private int id;
    private int userId;
    private String fullName;
    private String mobile;
    private String college;
    private String course;
    private String graduationYear;
    private String skills;
    private String resumeLink;
    private String experience;
    private String address;
    private String createdAt;

    public Student() {
    }

    public Student(int id, int userId, String fullName, String mobile, String college, String course,
                   String graduationYear, String skills, String resumeLink, String createdAt) {
        this.id = id;
        this.userId = userId;
        this.fullName = fullName;
        this.mobile = mobile;
        this.college = college;
        this.course = course;
        this.graduationYear = graduationYear;
        this.skills = skills;
        this.resumeLink = resumeLink;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public String getCollege() { return college; }
    public void setCollege(String college) { this.college = college; }
    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }
    public String getGraduationYear() { return graduationYear; }
    public void setGraduationYear(String graduationYear) { this.graduationYear = graduationYear; }
    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }
    public String getResumeLink() { return resumeLink; }
    public void setResumeLink(String resumeLink) { this.resumeLink = resumeLink; }
    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}

package com.fsjp.portal.model;

public class Internship {
    private int id;
    private int companyId;
    private String title;
    private String description;
    private String skills;
    private String location;
    private String internshipType;
    private String duration;
    private String stipend;
    private String requirements;
    private String benefits;
    private String deadline;
    private String status;
    private String createdAt;
    private String companyName;

    public Internship() {
    }

    public Internship(int id, int companyId, String title, String description, String skills,
                     String location, String internshipType, String duration, String stipend,
                     String requirements, String benefits, String deadline, String status,
                     String createdAt, String companyName) {
        this.id = id;
        this.companyId = companyId;
        this.title = title;
        this.description = description;
        this.skills = skills;
        this.location = location;
        this.internshipType = internshipType;
        this.duration = duration;
        this.stipend = stipend;
        this.requirements = requirements;
        this.benefits = benefits;
        this.deadline = deadline;
        this.status = status;
        this.createdAt = createdAt;
        this.companyName = companyName;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getCompanyId() { return companyId; }
    public void setCompanyId(int companyId) { this.companyId = companyId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getInternshipType() { return internshipType; }
    public void setInternshipType(String internshipType) { this.internshipType = internshipType; }
    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }
    public String getStipend() { return stipend; }
    public void setStipend(String stipend) { this.stipend = stipend; }
    public String getRequirements() { return requirements; }
    public void setRequirements(String requirements) { this.requirements = requirements; }
    public String getBenefits() { return benefits; }
    public void setBenefits(String benefits) { this.benefits = benefits; }
    public String getDeadline() { return deadline; }
    public void setDeadline(String deadline) { this.deadline = deadline; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
}

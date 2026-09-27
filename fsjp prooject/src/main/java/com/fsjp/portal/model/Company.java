package com.fsjp.portal.model;

public class Company {
    private int id;
    private int userId;
    private String companyName;
    private String mobile;
    private String location;
    private String website;
    private String description;
    private String approvalStatus;
    private String createdAt;

    public Company() {
    }

    public Company(int id, int userId, String companyName, String mobile, String location,
                   String website, String description, String approvalStatus, String createdAt) {
        this.id = id;
        this.userId = userId;
        this.companyName = companyName;
        this.mobile = mobile;
        this.location = location;
        this.website = website;
        this.description = description;
        this.approvalStatus = approvalStatus;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(String approvalStatus) { this.approvalStatus = approvalStatus; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}

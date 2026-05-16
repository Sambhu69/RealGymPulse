package com.gympulse.model;

public class InstructorProfileModel {
    private int profileId;
    private int userId;
    private String bio;
    private String specializations;
    private double rating;
    
    // Join fields
    private String fullName;
    private String profileImage;
    private String status;
    private String email;
    private String phone;

    public int getProfileId() { return profileId; }
    public void setProfileId(int profileId) { this.profileId = profileId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }
    public String getSpecializations() { return specializations; }
    public void setSpecializations(String specializations) { this.specializations = specializations; }
    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getProfileImage() { return profileImage; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}

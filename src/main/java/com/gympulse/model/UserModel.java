package com.gympulse.model;

import java.io.Serializable;

/**
 * UserModel represents a user in the GymPulse application.
 * It follows the JavaBean pattern with private fields and public accessors.
 */
public class UserModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int userId;
    private String fullName;
    private String userEmail;
    private String phone;
    private String userPassword;
    private String role;
    private String status;
    private int failedAttempts;
    private String lockedUntil;
    private String profileImage;
    private String createdAt;

    /** No-arg constructor */
    public UserModel() {}

    /** All-args constructor */
    public UserModel(int userId, String fullName, String userEmail, String phone, String userPassword, String role, 
                     String status, int failedAttempts, String lockedUntil, String profileImage, String createdAt) {
        this.userId = userId;
        this.fullName = fullName;
        this.userEmail = userEmail;
        this.phone = phone;
        this.userPassword = userPassword;
        this.role = role;
        this.status = status;
        this.failedAttempts = failedAttempts;
        this.lockedUntil = lockedUntil;
        this.profileImage = profileImage;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getUserPassword() { return userPassword; }
    public void setUserPassword(String userPassword) { this.userPassword = userPassword; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getFailedAttempts() { return failedAttempts; }
    public void setFailedAttempts(int failedAttempts) { this.failedAttempts = failedAttempts; }

    public String getLockedUntil() { return lockedUntil; }
    public void setLockedUntil(String lockedUntil) { this.lockedUntil = lockedUntil; }

    public String getProfileImage() { return profileImage; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "UserModel [userId=" + userId + ", fullName=" + fullName + ", userEmail=" + userEmail + ", phone=" + phone
                + ", role=" + role + ", status=" + status + ", createdAt=" + createdAt + "]";
    }
}

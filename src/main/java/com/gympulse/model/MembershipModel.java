package com.gympulse.model;

import java.io.Serializable;

/**
 * MembershipModel represents a user's subscription record.
 */
public class MembershipModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int membershipId;
    private int userId;
    private int planId;
    private String startDate;
    private String endDate;
    private String status;
    private String planName; // joined field

    /** No-arg constructor */
    public MembershipModel() {}

    /** All-args constructor */
    public MembershipModel(int membershipId, int userId, int planId, String startDate, String endDate, String status, String planName) {
        this.membershipId = membershipId;
        this.userId = userId;
        this.planId = planId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.planName = planName;
    }

    // Getters and Setters
    public int getMembershipId() { return membershipId; }
    public void setMembershipId(int membershipId) { this.membershipId = membershipId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getPlanId() { return planId; }
    public void setPlanId(int planId) { this.planId = planId; }

    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }

    public String getEndDate() { return endDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPlanName() { return planName; }
    public void setPlanName(String planName) { this.planName = planName; }

    @Override
    public String toString() {
        return "MembershipModel [membershipId=" + membershipId + ", userId=" + userId + ", planName=" + planName + ", status=" + status + "]";
    }
}

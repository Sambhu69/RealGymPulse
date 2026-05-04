package com.gympulse.model;

import java.io.Serializable;

/**
 * MembershipPlanModel represents a subscription plan in the GymPulse application.
 */
public class MembershipPlanModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int planId;
    private String planName;
    private int durationMonths;
    private double price;
    private String description;
    private String status;

    /** No-arg constructor */
    public MembershipPlanModel() {}

    /** All-args constructor */
    public MembershipPlanModel(int planId, String planName, int durationMonths, double price, String description, String status) {
        this.planId = planId;
        this.planName = planName;
        this.durationMonths = durationMonths;
        this.price = price;
        this.description = description;
        this.status = status;
    }

    // Getters and Setters
    public int getPlanId() { return planId; }
    public void setPlanId(int planId) { this.planId = planId; }

    public String getPlanName() { return planName; }
    public void setPlanName(String planName) { this.planName = planName; }

    public int getDurationMonths() { return durationMonths; }
    public void setDurationMonths(int durationMonths) { this.durationMonths = durationMonths; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "MembershipPlanModel [planId=" + planId + ", planName=" + planName + ", price=" + price + ", status=" + status + "]";
    }
}

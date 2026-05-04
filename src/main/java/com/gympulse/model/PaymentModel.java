package com.gympulse.model;

import java.io.Serializable;

/**
 * PaymentModel represents a financial transaction for a membership.
 */
public class PaymentModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int paymentId;
    private int userId;
    private int membershipId;
    private double amount;
    private String paymentDate;
    private String paymentMethod;

    /** No-arg constructor */
    public PaymentModel() {}

    /** All-args constructor */
    public PaymentModel(int paymentId, int userId, int membershipId, double amount, String paymentDate, String paymentMethod) {
        this.paymentId = paymentId;
        this.userId = userId;
        this.membershipId = membershipId;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
    }

    // Getters and Setters
    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getMembershipId() { return membershipId; }
    public void setMembershipId(int membershipId) { this.membershipId = membershipId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentDate() { return paymentDate; }
    public void setPaymentDate(String paymentDate) { this.paymentDate = paymentDate; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    @Override
    public String toString() {
        return "PaymentModel [paymentId=" + paymentId + ", userId=" + userId + ", amount=" + amount + ", date=" + paymentDate + "]";
    }
}

package com.gympulse.model;

public class ContactQueryModel {
    private int queryId;
    private String name;
    private String email;
    private String message;
    private String status;
    private String createdAt;

    // Getters and Setters
    public int getQueryId() { return queryId; }
    public void setQueryId(int queryId) { this.queryId = queryId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}

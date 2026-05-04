package com.gympulse.model;

import java.io.Serializable;

/**
 * BookingModel represents a user's registration for a fitness class.
 */
public class BookingModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int bookingId;
    private int userId;
    private int classId;
    private String bookingDate;
    private String status;
    private String className; // joined field
    private String scheduleDate; // joined field
    private String scheduleTime; // joined field

    /** No-arg constructor */
    public BookingModel() {}

    /** All-args constructor */
    public BookingModel(int bookingId, int userId, int classId, String bookingDate, String status, 
                        String className, String scheduleDate, String scheduleTime) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.classId = classId;
        this.bookingDate = bookingDate;
        this.status = status;
        this.className = className;
        this.scheduleDate = scheduleDate;
        this.scheduleTime = scheduleTime;
    }

    // Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getClassId() { return classId; }
    public void setClassId(int classId) { this.classId = classId; }

    public String getBookingDate() { return bookingDate; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }

    public String getScheduleDate() { return scheduleDate; }
    public void setScheduleDate(String scheduleDate) { this.scheduleDate = scheduleDate; }

    public String getScheduleTime() { return scheduleTime; }
    public void setScheduleTime(String scheduleTime) { this.scheduleTime = scheduleTime; }

    @Override
    public String toString() {
        return "BookingModel [bookingId=" + bookingId + ", className=" + className + ", status=" + status + "]";
    }
}

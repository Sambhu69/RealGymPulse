package com.gympulse.model;

import java.io.Serializable;

/**
 * FitnessClassModel represents a workout session offered by the gym.
 */
public class FitnessClassModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int classId;
    private String className;
    private String instructor;
    private String scheduleDate;
    private String scheduleTime;
    private int capacity;
    private int enrolled;
    private String description;
    private String status;

    /** No-arg constructor */
    public FitnessClassModel() {}

    /** All-args constructor */
    public FitnessClassModel(int classId, String className, String instructor, String scheduleDate, String scheduleTime, 
                             int capacity, int enrolled, String description, String status) {
        this.classId = classId;
        this.className = className;
        this.instructor = instructor;
        this.scheduleDate = scheduleDate;
        this.scheduleTime = scheduleTime;
        this.capacity = capacity;
        this.enrolled = enrolled;
        this.description = description;
        this.status = status;
    }

    // Getters and Setters
    public int getClassId() { return classId; }
    public void setClassId(int classId) { this.classId = classId; }

    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }

    public String getInstructor() { return instructor; }
    public void setInstructor(String instructor) { this.instructor = instructor; }

    public String getScheduleDate() { return scheduleDate; }
    public void setScheduleDate(String scheduleDate) { this.scheduleDate = scheduleDate; }

    public String getScheduleTime() { return scheduleTime; }
    public void setScheduleTime(String scheduleTime) { this.scheduleTime = scheduleTime; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    public int getEnrolled() { return enrolled; }
    public void setEnrolled(int enrolled) { this.enrolled = enrolled; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "FitnessClassModel [classId=" + classId + ", className=" + className + ", instructor=" + instructor
                + ", schedule=" + scheduleDate + " " + scheduleTime + "]";
    }
}

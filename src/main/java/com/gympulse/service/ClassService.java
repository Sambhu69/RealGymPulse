package com.gympulse.service;

import com.gympulse.config.DBConfig;
import com.gympulse.model.FitnessClassModel;
import com.gympulse.model.BookingModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ClassService handles business logic for fitness classes and bookings.
 */
public class ClassService {

    public List<FitnessClassModel> getAllClasses() {
        List<FitnessClassModel> classes = new ArrayList<>();
        String sql = "SELECT * FROM fitness_classes ORDER BY schedule_date";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                classes.add(mapResultSetToClass(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return classes;
    }

    public List<FitnessClassModel> getAvailableClasses() {
        List<FitnessClassModel> classes = new ArrayList<>();
        String sql = "SELECT * FROM fitness_classes WHERE status = 'available' AND enrolled < capacity";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                classes.add(mapResultSetToClass(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return classes;
    }

    public FitnessClassModel getClassById(int classId) {
        String sql = "SELECT * FROM fitness_classes WHERE class_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, classId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) return mapResultSetToClass(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean addClass(FitnessClassModel fc) {
        String sql = "INSERT INTO fitness_classes (class_name, instructor, schedule_date, schedule_time, capacity, enrolled, description, status) VALUES (?, ?, ?, ?, ?, 0, ?, 'available')";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, fc.getClassName());
            pst.setString(2, fc.getInstructor());
            pst.setString(3, fc.getScheduleDate());
            pst.setString(4, fc.getScheduleTime());
            pst.setInt(5, fc.getCapacity());
            pst.setString(6, fc.getDescription());
            return pst.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean updateClass(FitnessClassModel fc) {
        String sql = "UPDATE fitness_classes SET class_name=?, instructor=?, schedule_date=?, schedule_time=?, capacity=?, description=?, status=? WHERE class_id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, fc.getClassName());
            pst.setString(2, fc.getInstructor());
            pst.setString(3, fc.getScheduleDate());
            pst.setString(4, fc.getScheduleTime());
            pst.setInt(5, fc.getCapacity());
            pst.setString(6, fc.getDescription());
            pst.setString(7, fc.getStatus());
            pst.setInt(8, fc.getClassId());
            return pst.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteClass(int classId) {
        String sql = "DELETE FROM fitness_classes WHERE class_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, classId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    /**
     * Books a class for a user using a SQL transaction.
     */
    public boolean bookClass(int userId, int classId) {
        // 1. Check if already booked
        if (isAlreadyBooked(userId, classId)) return false;

        Connection conn = null;
        try {
            conn = DBConfig.getConnection();
            conn.setAutoCommit(false); // Start Transaction

            // 2. Insert into class_bookings
            String bookingSql = "INSERT INTO class_bookings (user_id, class_id, booking_date, status) VALUES (?, ?, NOW(), 'confirmed')";
            try (PreparedStatement pst = conn.prepareStatement(bookingSql)) {
                pst.setInt(1, userId);
                pst.setInt(2, classId);
                pst.executeUpdate();
            }

            // 3. Increment enrolled and update status if full
            String updateClassSql = "UPDATE fitness_classes SET enrolled = enrolled + 1, status = IF(enrolled + 1 >= capacity, 'full', 'available') WHERE class_id = ?";
            try (PreparedStatement pst = conn.prepareStatement(updateClassSql)) {
                pst.setInt(1, classId);
                pst.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    public boolean cancelBooking(int bookingId, int classId) {
        Connection conn = null;
        try {
            conn = DBConfig.getConnection();
            conn.setAutoCommit(false);

            // 1. Update booking status
            String cancelSql = "UPDATE class_bookings SET status = 'cancelled' WHERE booking_id = ?";
            try (PreparedStatement pst = conn.prepareStatement(cancelSql)) {
                pst.setInt(1, bookingId);
                pst.executeUpdate();
            }

            // 2. Decrement enrolled and reset status
            String decrementSql = "UPDATE fitness_classes SET enrolled = enrolled - 1, status = 'available' WHERE class_id = ?";
            try (PreparedStatement pst = conn.prepareStatement(decrementSql)) {
                pst.setInt(1, classId);
                pst.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    public List<BookingModel> getBookingsByUser(int userId) {
        List<BookingModel> bookings = new ArrayList<>();
        String sql = "SELECT b.*, f.class_name, f.schedule_date, f.schedule_time FROM class_bookings b " +
                     "JOIN fitness_classes f ON b.class_id = f.class_id WHERE b.user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                bookings.add(mapResultSetToBooking(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return bookings;
    }

    public List<BookingModel> getAllBookings() {
        List<BookingModel> bookings = new ArrayList<>();
        // Note: Joining with users to get member name if needed, but BookingModel only has specific fields.
        // We assume className is the identifier for the joined field.
        String sql = "SELECT b.*, f.class_name, f.schedule_date, f.schedule_time FROM class_bookings b " +
                     "JOIN fitness_classes f ON b.class_id = f.class_id";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                bookings.add(mapResultSetToBooking(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return bookings;
    }

    // Helper Methods
    private boolean isAlreadyBooked(int userId, int classId) {
        String sql = "SELECT booking_id FROM class_bookings WHERE user_id = ? AND class_id = ? AND status != 'cancelled'";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, userId);
            pst.setInt(2, classId);
            return pst.executeQuery().next();
        } catch (SQLException e) { return false; }
    }

    private FitnessClassModel mapResultSetToClass(ResultSet rs) throws SQLException {
        FitnessClassModel fc = new FitnessClassModel();
        fc.setClassId(rs.getInt("class_id"));
        fc.setClassName(rs.getString("class_name"));
        fc.setInstructor(rs.getString("instructor"));
        fc.setScheduleDate(rs.getString("schedule_date"));
        fc.setScheduleTime(rs.getString("schedule_time"));
        fc.setCapacity(rs.getInt("capacity"));
        fc.setEnrolled(rs.getInt("enrolled"));
        fc.setDescription(rs.getString("description"));
        fc.setStatus(rs.getString("status"));
        return fc;
    }

    private BookingModel mapResultSetToBooking(ResultSet rs) throws SQLException {
        BookingModel b = new BookingModel();
        b.setBookingId(rs.getInt("booking_id"));
        b.setUserId(rs.getInt("user_id"));
        b.setClassId(rs.getInt("class_id"));
        b.setBookingDate(rs.getString("booking_date"));
        b.setStatus(rs.getString("status"));
        b.setClassName(rs.getString("class_name"));
        b.setScheduleDate(rs.getString("schedule_date"));
        b.setScheduleTime(rs.getString("schedule_time"));
        return b;
    }
}

package com.gympulse.service;

import com.gympulse.config.DBConfig;
import com.gympulse.model.TrainerProfileModel;
import com.gympulse.model.TrainerSlotModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TrainerService {

    public List<TrainerProfileModel> getAllTrainers() {
        List<TrainerProfileModel> trainers = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name, u.profile_image, u.status FROM trainer_profiles p " +
                     "JOIN users u ON p.user_id = u.user_id WHERE u.role = 'trainer'";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                TrainerProfileModel tp = new TrainerProfileModel();
                tp.setProfileId(rs.getInt("profile_id"));
                tp.setUserId(rs.getInt("user_id"));
                tp.setBio(rs.getString("bio"));
                tp.setSpecializations(rs.getString("specializations"));
                tp.setRating(rs.getDouble("rating"));
                tp.setFullName(rs.getString("full_name"));
                tp.setProfileImage(rs.getString("profile_image"));
                tp.setStatus(rs.getString("status"));
                trainers.add(tp);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return trainers;
    }

    public List<TrainerSlotModel> getAvailableSlots(int trainerId) {
        List<TrainerSlotModel> slots = new ArrayList<>();
        String sql = "SELECT * FROM trainer_slots WHERE trainer_id = ? AND status = 'available' AND slot_date >= CURDATE()";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, trainerId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                TrainerSlotModel slot = new TrainerSlotModel();
                slot.setSlotId(rs.getInt("slot_id"));
                slot.setTrainerId(rs.getInt("trainer_id"));
                slot.setSlotDate(rs.getString("slot_date"));
                slot.setStartTime(rs.getString("start_time"));
                slot.setEndTime(rs.getString("end_time"));
                slot.setStatus(rs.getString("status"));
                slots.add(slot);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return slots;
    }

    public boolean bookTrainerSlot(int memberId, int trainerId, int slotId) {
        Connection conn = null;
        try {
            conn = DBConfig.getConnection();
            conn.setAutoCommit(false);
            
            // 1. Check if slot is still available and update it to booked
            String updateSlot = "UPDATE trainer_slots SET status = 'booked' WHERE slot_id = ? AND status = 'available'";
            try (PreparedStatement pst = conn.prepareStatement(updateSlot)) {
                pst.setInt(1, slotId);
                int updated = pst.executeUpdate();
                if (updated == 0) {
                    return false; // Slot was already booked or doesn't exist
                }
            }

            // 2. Insert booking record
            String insertBooking = "INSERT INTO trainer_bookings (member_id, trainer_id, slot_id, status) VALUES (?, ?, ?, 'scheduled')";
            try (PreparedStatement pst = conn.prepareStatement(insertBooking)) {
                pst.setInt(1, memberId);
                pst.setInt(2, trainerId);
                pst.setInt(3, slotId);
                pst.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) { try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); } }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) { try { conn.close(); } catch (SQLException e) { e.printStackTrace(); } }
        }
    }
    public boolean cancelTrainerBooking(int bookingId, int memberId) {
        Connection conn = null;
        try {
            conn = DBConfig.getConnection();
            conn.setAutoCommit(false);

            int slotId = -1;
            String getSlotSql = "SELECT slot_id FROM trainer_bookings WHERE booking_id = ? AND member_id = ?";
            try (PreparedStatement pst = conn.prepareStatement(getSlotSql)) {
                pst.setInt(1, bookingId);
                pst.setInt(2, memberId);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    slotId = rs.getInt("slot_id");
                } else {
                    conn.rollback();
                    return false;
                }
            }

            String cancelSql = "UPDATE trainer_bookings SET status = 'cancelled' WHERE booking_id = ?";
            try (PreparedStatement pst = conn.prepareStatement(cancelSql)) {
                pst.setInt(1, bookingId);
                pst.executeUpdate();
            }

            String freeSlotSql = "UPDATE trainer_slots SET status = 'available' WHERE slot_id = ?";
            try (PreparedStatement pst = conn.prepareStatement(freeSlotSql)) {
                pst.setInt(1, slotId);
                pst.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) { try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); } }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) { try { conn.close(); } catch (SQLException e) { e.printStackTrace(); } }
        }
    }

    public boolean cancelAllTrainerBookings(int memberId) {
        List<java.util.Map<String, String>> bookings = getMemberTrainerBookings(memberId);
        boolean allCancelled = true;
        for (java.util.Map<String, String> b : bookings) {
            if (!"cancelled".equals(b.get("status"))) {
                int bookingId = Integer.parseInt(b.get("bookingId"));
                boolean success = cancelTrainerBooking(bookingId, memberId);
                if (!success) allCancelled = false;
            }
        }
        return allCancelled;
    }

    public List<java.util.Map<String, String>> getMemberTrainerBookings(int memberId) {
        List<java.util.Map<String, String>> bookings = new ArrayList<>();
        String sql = "SELECT b.booking_id, b.status, s.slot_date, s.start_time, u.full_name as trainer_name " +
                     "FROM trainer_bookings b " +
                     "JOIN trainer_slots s ON b.slot_id = s.slot_id " +
                     "JOIN users u ON b.trainer_id = u.user_id " +
                     "WHERE b.member_id = ? AND b.status != 'cancelled' ORDER BY s.slot_date, s.start_time";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, memberId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                java.util.Map<String, String> b = new java.util.HashMap<>();
                b.put("bookingId", String.valueOf(rs.getInt("booking_id")));
                b.put("status", rs.getString("status"));
                b.put("date", rs.getString("slot_date"));
                b.put("time", rs.getString("start_time"));
                b.put("trainerName", rs.getString("trainer_name"));
                bookings.add(b);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return bookings;
    }

    public boolean addTrainer(com.gympulse.model.UserModel user, String bio, String specializations) {
        UserService userService = new UserService();
        user.setRole("trainer");
        user.setStatus("active");
        int userId = userService.registerUser(user);
        if (userId == -1) {
            return false;
        }
        
        String sql = "INSERT INTO trainer_profiles (user_id, bio, specializations, rating) VALUES (?, ?, ?, 5.0)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, userId);
            pst.setString(2, bio);
            pst.setString(3, specializations);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateTrainer(int profileId, int userId, String fullName, String phone, String bio, String specializations) {
        // Update user
        String userSql = "UPDATE users SET full_name = ?, phone = ? WHERE user_id = ?";
        String profileSql = "UPDATE trainer_profiles SET bio = ?, specializations = ? WHERE profile_id = ?";
        
        Connection conn = null;
        try {
            conn = DBConfig.getConnection();
            conn.setAutoCommit(false);
            
            try (PreparedStatement pst1 = conn.prepareStatement(userSql)) {
                pst1.setString(1, fullName);
                pst1.setString(2, phone);
                pst1.setInt(3, userId);
                pst1.executeUpdate();
            }
            
            try (PreparedStatement pst2 = conn.prepareStatement(profileSql)) {
                pst2.setString(1, bio);
                pst2.setString(2, specializations);
                pst2.setInt(3, profileId);
                pst2.executeUpdate();
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) { try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); } }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) { try { conn.close(); } catch (SQLException e) { e.printStackTrace(); } }
        }
    }

    public boolean deleteTrainer(int userId) {
        UserService userService = new UserService();
        return userService.deleteUser(userId); // ON DELETE CASCADE will handle trainer_profiles
    }
}

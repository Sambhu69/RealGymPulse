package com.gympulse.service;

import com.gympulse.config.DBConfig;
import com.gympulse.model.InstructorProfileModel;
import com.gympulse.model.UserModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InstructorService {

    public List<InstructorProfileModel> getAllInstructors() {
        List<InstructorProfileModel> instructors = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name, u.email, u.phone, u.profile_image, u.status FROM instructor_profiles p " +
                     "JOIN users u ON p.user_id = u.user_id WHERE u.role = 'instructor'";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                InstructorProfileModel ip = new InstructorProfileModel();
                ip.setProfileId(rs.getInt("profile_id"));
                ip.setUserId(rs.getInt("user_id"));
                ip.setBio(rs.getString("bio"));
                ip.setSpecializations(rs.getString("specializations"));
                ip.setRating(rs.getDouble("rating"));
                ip.setFullName(rs.getString("full_name"));
                ip.setEmail(rs.getString("email"));
                ip.setPhone(rs.getString("phone"));
                ip.setProfileImage(rs.getString("profile_image"));
                ip.setStatus(rs.getString("status"));
                instructors.add(ip);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return instructors;
    }

    public boolean addInstructor(UserModel user, String bio, String specializations) {
        UserService userService = new UserService();
        user.setRole("instructor");
        user.setStatus("active");
        int userId = userService.registerUser(user);
        if (userId == -1) {
            return false;
        }
        
        String sql = "INSERT INTO instructor_profiles (user_id, bio, specializations, rating) VALUES (?, ?, ?, 5.0)";
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

    public boolean updateInstructor(int profileId, int userId, String fullName, String phone, String bio, String specializations) {
        String userSql = "UPDATE users SET full_name = ?, phone = ? WHERE user_id = ?";
        String profileSql = "UPDATE instructor_profiles SET bio = ?, specializations = ? WHERE profile_id = ?";
        
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
            
            // Sync name with fitness_classes table
            String classSql = "UPDATE fitness_classes SET instructor = ? WHERE instructor = (SELECT full_name FROM (SELECT full_name FROM users WHERE user_id = ?) as t)";
            try (PreparedStatement pst3 = conn.prepareStatement(classSql)) {
                pst3.setString(1, fullName);
                pst3.setInt(2, userId);
                pst3.executeUpdate();
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

    public boolean deleteInstructor(int userId) {
        UserService userService = new UserService();
        return userService.deleteUser(userId);
    }
}

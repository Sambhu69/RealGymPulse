package com.gympulse.service;

import com.gympulse.config.DBConfig;
import com.gympulse.model.UserModel;
import com.gympulse.service.EncryptionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * UserService handles business logic and database operations for users.
 */
public class UserService {

    /**
     * Authenticates a user. Handles failed attempts and account locking.
     */
    public UserModel loginUser(String userEmail, String userPassword) throws SQLException {
        String query = "SELECT * FROM users WHERE email = ?";
        
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            
            pst.setString(1, userEmail);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                UserModel user = mapResultSetToUser(rs);
                
                // Check if account is locked
                if ("locked".equals(user.getStatus())) {
                    Timestamp lockedUntil = rs.getTimestamp("locked_until");
                    if (lockedUntil != null && lockedUntil.after(new Timestamp(System.currentTimeMillis()))) {
                        user.setStatus("locked");
                        return user; // Return user with locked status
                    } else {
                        // Lock expired, unlock
                        unlockUser(user.getUserId());
                        user.setStatus("active");
                    }
                }

                // Verify password
                if (EncryptionUtil.verifyPassword(userPassword, user.getUserPassword())) {
                    resetFailedAttempts(user.getUserId());
                    return user;
                } else {
                    handleFailedLogin(user.getUserId(), user.getFailedAttempts());
                }
            }
        }
        return null;
    }

    /**
     * Registers a new user with encrypted password.
     */
    public boolean registerUser(UserModel user) {
        if (isEmailExists(user.getUserEmail()) || isPhoneExists(user.getPhone())) {
            return false;
        }

        String sql = "INSERT INTO users (full_name, email, phone, password, role, status) VALUES (?, ?, ?, ?, ?, 'active')";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            pst.setString(1, user.getFullName());
            pst.setString(2, user.getUserEmail());
            pst.setString(3, user.getPhone());
            pst.setString(4, EncryptionUtil.encrypt(user.getUserPassword()));
            pst.setString(5, user.getRole());
            
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public UserModel getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) return mapResultSetToUser(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<UserModel> getAllMembers() {
        List<UserModel> members = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'member'";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                members.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

    public boolean updateUser(UserModel user) {
        String sql = "UPDATE users SET full_name = ?, phone = ?, status = ? WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, user.getFullName());
            pst.setString(2, user.getPhone());
            pst.setString(3, user.getStatus());
            pst.setInt(4, user.getUserId());
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, userId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, EncryptionUtil.encrypt(newPassword));
            pst.setInt(2, userId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProfileImage(int userId, String relativePath) {
        String sql = "UPDATE users SET profile_image = ? WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, relativePath);
            pst.setInt(2, userId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper Methods
    private boolean isEmailExists(String userEmail) {
        String query = "SELECT user_id FROM users WHERE email = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            pst.setString(1, userEmail);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) { return true; }
    }

    private boolean isPhoneExists(String phone) {
        String query = "SELECT user_id FROM users WHERE phone = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            pst.setString(1, phone);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) { return true; }
    }

    private void handleFailedLogin(int userId, int currentAttempts) {
        int newAttempts = currentAttempts + 1;
        String sql = newAttempts >= 3 
            ? "UPDATE users SET failed_attempts = ?, status = 'locked', locked_until = DATE_ADD(NOW(), INTERVAL 15 MINUTE) WHERE user_id = ?" 
            : "UPDATE users SET failed_attempts = ? WHERE user_id = ?";
        
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, newAttempts);
            pst.setInt(2, userId);
            pst.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    private void resetFailedAttempts(int userId) {
        String sql = "UPDATE users SET failed_attempts = 0, status = 'active', locked_until = NULL WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, userId);
            pst.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    private void unlockUser(int userId) {
        resetFailedAttempts(userId);
    }

    private UserModel mapResultSetToUser(ResultSet rs) throws SQLException {
        UserModel user = new UserModel();
        user.setUserId(rs.getInt("user_id"));
        user.setFullName(rs.getString("full_name"));
        user.setUserEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setUserPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        user.setStatus(rs.getString("status"));
        user.setFailedAttempts(rs.getInt("failed_attempts"));
        user.setLockedUntil(rs.getString("locked_until"));
        user.setProfileImage(rs.getString("profile_image"));
        user.setCreatedAt(rs.getString("created_at"));
        return user;
    }
}

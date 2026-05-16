package com.gympulse.service;

import com.gympulse.config.DBConfig;
import com.gympulse.model.PasswordResetRequestModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PasswordResetService {

    public boolean createRequest(String fullName, String phone, String email) {
        String sql = "INSERT INTO password_reset_requests (full_name, phone, email, status) VALUES (?, ?, ?, 'pending')";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, fullName);
            pst.setString(2, phone);
            pst.setString(3, email != null && !email.isEmpty() ? email : null);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<PasswordResetRequestModel> getAllRequests() {
        List<PasswordResetRequestModel> requests = new ArrayList<>();
        String sql = "SELECT * FROM password_reset_requests ORDER BY created_at DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                PasswordResetRequestModel model = new PasswordResetRequestModel();
                model.setRequestId(rs.getInt("request_id"));
                model.setFullName(rs.getString("full_name"));
                model.setPhone(rs.getString("phone"));
                model.setEmail(rs.getString("email"));
                model.setStatus(rs.getString("status"));
                model.setCreatedAt(rs.getString("created_at"));
                requests.add(model);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }

    public boolean updateRequestStatus(int requestId, String status) {
        String sql = "UPDATE password_reset_requests SET status = ? WHERE request_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, status);
            pst.setInt(2, requestId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getPendingRequestsCount() {
        String sql = "SELECT COUNT(*) FROM password_reset_requests WHERE status = 'pending'";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}

package com.gympulse.service;

import com.gympulse.config.DBConfig;
import com.gympulse.model.NoticeModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Service layer for notice board CRUD operations.
 */
public class NoticeService {

    /**
     * Returns all notices ordered by most recent, with author info joined.
     */
    public List<NoticeModel> getAllNotices() {
        List<NoticeModel> notices = new ArrayList<>();
        String sql = "SELECT n.*, u.full_name AS author_name, u.role AS author_role, r.full_name AS receiver_name " +
                     "FROM notices n " +
                     "JOIN users u ON n.author_id = u.user_id " +
                     "LEFT JOIN users r ON n.receiver_id = r.user_id " +
                     "ORDER BY n.created_at DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                notices.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return notices;
    }

    public List<NoticeModel> getAllNoticesForUser(int userId, String role) {
        List<NoticeModel> notices = new ArrayList<>();
        String sql = "SELECT n.*, u.full_name AS author_name, u.role AS author_role, r.full_name AS receiver_name " +
                     "FROM notices n " +
                     "JOIN users u ON n.author_id = u.user_id " +
                     "LEFT JOIN users r ON n.receiver_id = r.user_id ";
        
        if (!"admin".equalsIgnoreCase(role)) {
            sql += "WHERE n.receiver_id IS NULL AND (n.target_role = 'all' OR n.target_role = ?) OR n.receiver_id = ? OR n.author_id = ? ";
        }
        sql += "ORDER BY n.created_at DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            if (!"admin".equalsIgnoreCase(role)) {
                pst.setString(1, role.toLowerCase());
                pst.setInt(2, userId);
                pst.setInt(3, userId);
            }
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                notices.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return notices;
    }

    /**
     * Returns the N most recent notices (for the notification dropdown).
     */
    public List<NoticeModel> getRecentNotices(int limit) {
        List<NoticeModel> notices = new ArrayList<>();
        String sql = "SELECT n.*, u.full_name AS author_name, u.role AS author_role, r.full_name AS receiver_name " +
                     "FROM notices n " +
                     "JOIN users u ON n.author_id = u.user_id " +
                     "LEFT JOIN users r ON n.receiver_id = r.user_id " +
                     "ORDER BY n.created_at DESC LIMIT ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, limit);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                notices.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return notices;
    }

    public List<NoticeModel> getRecentNoticesForUser(int userId, String role, int limit) {
        List<NoticeModel> notices = new ArrayList<>();
        String sql = "SELECT n.*, u.full_name AS author_name, u.role AS author_role, r.full_name AS receiver_name " +
                     "FROM notices n " +
                     "JOIN users u ON n.author_id = u.user_id " +
                     "LEFT JOIN users r ON n.receiver_id = r.user_id ";

        if (!"admin".equalsIgnoreCase(role)) {
            sql += "WHERE n.receiver_id IS NULL AND (n.target_role = 'all' OR n.target_role = ?) OR n.receiver_id = ? OR n.author_id = ? ";
        }
        sql += "ORDER BY n.created_at DESC LIMIT ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            if (!"admin".equalsIgnoreCase(role)) {
                pst.setString(paramIndex++, role.toLowerCase());
                pst.setInt(paramIndex++, userId);
                pst.setInt(paramIndex++, userId);
            }
            pst.setInt(paramIndex, limit);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                notices.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return notices;
    }

    /**
     * Creates a new notice.
     */
    public boolean addNotice(int authorId, String title, String message, String category, Integer receiverId, String targetRole) {
        String sql = "INSERT INTO notices (author_id, title, message, category, receiver_id, target_role) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, authorId);
            pst.setString(2, title);
            pst.setString(3, message);
            pst.setString(4, category);
            if (receiverId != null) {
                pst.setInt(5, receiverId);
            } else {
                pst.setNull(5, Types.INTEGER);
            }
            pst.setString(6, targetRole != null ? targetRole : "all");
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes a notice. Only the author or an admin can delete.
     */
    public boolean deleteNotice(int noticeId) {
        String sql = "DELETE FROM notices WHERE notice_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, noticeId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Gets a single notice by ID.
     */
    public NoticeModel getNoticeById(int noticeId) {
        String sql = "SELECT n.*, u.full_name AS author_name, u.role AS author_role, r.full_name AS receiver_name " +
                     "FROM notices n " +
                     "JOIN users u ON n.author_id = u.user_id " +
                     "LEFT JOIN users r ON n.receiver_id = r.user_id " +
                     "WHERE n.notice_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, noticeId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /**
     * Updates an existing notice.
     */
    public boolean updateNotice(int noticeId, String title, String message, String category) {
        String sql = "UPDATE notices SET title = ?, message = ?, category = ? WHERE notice_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, title);
            pst.setString(2, message);
            pst.setString(3, category);
            pst.setInt(4, noticeId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private NoticeModel mapRow(ResultSet rs) throws SQLException {
        NoticeModel n = new NoticeModel();
        n.setNoticeId(rs.getInt("notice_id"));
        n.setAuthorId(rs.getInt("author_id"));
        n.setTitle(rs.getString("title"));
        n.setMessage(rs.getString("message"));
        n.setCategory(rs.getString("category"));
        n.setTargetRole(rs.getString("target_role"));
        n.setCreatedAt(rs.getString("created_at"));
        n.setAuthorName(rs.getString("author_name"));
        n.setAuthorRole(rs.getString("author_role"));
        int rId = rs.getInt("receiver_id");
        if (!rs.wasNull()) {
            n.setReceiverId(rId);
            n.setReceiverName(rs.getString("receiver_name"));
        }
        return n;
    }
}

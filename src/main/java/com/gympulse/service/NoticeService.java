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
        String sql = "SELECT n.*, u.full_name AS author_name, u.role AS author_role " +
                     "FROM notices n JOIN users u ON n.author_id = u.user_id " +
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

    /**
     * Returns the N most recent notices (for the notification dropdown).
     */
    public List<NoticeModel> getRecentNotices(int limit) {
        List<NoticeModel> notices = new ArrayList<>();
        String sql = "SELECT n.*, u.full_name AS author_name, u.role AS author_role " +
                     "FROM notices n JOIN users u ON n.author_id = u.user_id " +
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

    /**
     * Creates a new notice.
     */
    public boolean addNotice(int authorId, String title, String message, String category) {
        String sql = "INSERT INTO notices (author_id, title, message, category) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, authorId);
            pst.setString(2, title);
            pst.setString(3, message);
            pst.setString(4, category);
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
        String sql = "SELECT n.*, u.full_name AS author_name, u.role AS author_role " +
                     "FROM notices n JOIN users u ON n.author_id = u.user_id " +
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
        n.setCreatedAt(rs.getString("created_at"));
        n.setAuthorName(rs.getString("author_name"));
        n.setAuthorRole(rs.getString("author_role"));
        return n;
    }
}

package com.gympulse.service;

import com.gympulse.config.DBConfig;
import com.gympulse.model.ContactQueryModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactService {

    public boolean addQuery(String name, String email, String message) {
        String sql = "INSERT INTO contact_queries (name, email, message) VALUES (?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, message);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<ContactQueryModel> getAllQueries() {
        List<ContactQueryModel> queries = new ArrayList<>();
        String sql = "SELECT * FROM contact_queries ORDER BY created_at DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                ContactQueryModel q = new ContactQueryModel();
                q.setQueryId(rs.getInt("query_id"));
                q.setName(rs.getString("name"));
                q.setEmail(rs.getString("email"));
                q.setMessage(rs.getString("message"));
                q.setStatus(rs.getString("status"));
                q.setCreatedAt(rs.getString("created_at"));
                queries.add(q);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return queries;
    }

    public boolean updateQueryStatus(int queryId, String status) {
        String sql = "UPDATE contact_queries SET status = ? WHERE query_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, status);
            pst.setInt(2, queryId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteQuery(int queryId) {
        String sql = "DELETE FROM contact_queries WHERE query_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, queryId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

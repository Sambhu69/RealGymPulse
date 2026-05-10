package com.gympulse.service;

import com.gympulse.config.DBConfig;
import com.gympulse.model.MembershipPlanModel;
import com.gympulse.model.MembershipModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * MembershipService handles logic for subscription plans and user memberships.
 */
public class MembershipService {

    public List<MembershipPlanModel> getAllPlans() {
        List<MembershipPlanModel> plans = new ArrayList<>();
        String sql = "SELECT * FROM membership_plans WHERE status = 'active'";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                plans.add(mapResultSetToPlan(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return plans;
    }

    public MembershipPlanModel getPlanById(int planId) {
        String sql = "SELECT * FROM membership_plans WHERE plan_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, planId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) return mapResultSetToPlan(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean addPlan(MembershipPlanModel plan) {
        String sql = "INSERT INTO membership_plans (plan_name, duration_months, price, description, status) VALUES (?, ?, ?, ?, 'active')";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, plan.getPlanName());
            pst.setInt(2, plan.getDurationMonths());
            pst.setDouble(3, plan.getPrice());
            pst.setString(4, plan.getDescription());
            return pst.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean updatePlan(MembershipPlanModel plan) {
        String sql = "UPDATE membership_plans SET plan_name=?, duration_months=?, price=?, description=?, status=? WHERE plan_id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, plan.getPlanName());
            pst.setInt(2, plan.getDurationMonths());
            pst.setDouble(3, plan.getPrice());
            pst.setString(4, plan.getDescription());
            pst.setString(5, plan.getStatus());
            pst.setInt(6, plan.getPlanId());
            return pst.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deletePlan(int planId) {
        String sql = "UPDATE membership_plans SET status = 'inactive' WHERE plan_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, planId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    /**
     * Assigns a plan to a user. Calculates end date and record payment in one transaction.
     */
    public boolean assignMembership(int userId, int planId) {
        MembershipPlanModel plan = getPlanById(planId);
        if (plan == null) return false;

        Connection conn = null;
        try {
            conn = DBConfig.getConnection();
            conn.setAutoCommit(false);

            // 1. Insert Membership
            String memSql = "INSERT INTO memberships (user_id, plan_id, start_date, end_date, status) " +
                            "VALUES (?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL ? MONTH), 'active')";
            int membershipId = -1;
            try (PreparedStatement pst = conn.prepareStatement(memSql, Statement.RETURN_GENERATED_KEYS)) {
                pst.setInt(1, userId);
                pst.setInt(2, planId);
                pst.setInt(3, plan.getDurationMonths());
                pst.executeUpdate();
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) membershipId = rs.getInt(1);
            }

            // 2. Insert Payment
            String paySql = "INSERT INTO payments (user_id, membership_id, amount, payment_date, payment_method) VALUES (?, ?, ?, NOW(), 'Credit Card')";
            try (PreparedStatement pst = conn.prepareStatement(paySql)) {
                pst.setInt(1, userId);
                pst.setInt(2, membershipId);
                pst.setDouble(3, plan.getPrice());
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

    public MembershipModel getActiveMembership(int userId) {
        String sql = "SELECT m.*, p.plan_name FROM memberships m " +
                     "JOIN membership_plans p ON m.plan_id = p.plan_id " +
                     "WHERE m.user_id = ? AND m.status = 'active' AND m.end_date >= CURDATE()";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                MembershipModel m = new MembershipModel();
                m.setMembershipId(rs.getInt("membership_id"));
                m.setUserId(rs.getInt("user_id"));
                m.setPlanId(rs.getInt("plan_id"));
                m.setStartDate(rs.getString("start_date"));
                m.setEndDate(rs.getString("end_date"));
                m.setStatus(rs.getString("status"));
                m.setPlanName(rs.getString("plan_name"));
                return m;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public void expireOldMemberships() {
        String sql = "UPDATE memberships SET status='expired' WHERE end_date < CURDATE() AND status='active'";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public double getTotalRevenue() {
        String sql = "SELECT SUM(amount) as total FROM payments";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            if (rs.next()) return rs.getDouble("total");
        } catch (SQLException e) { e.printStackTrace(); }
        return 0.0;
    }

    private MembershipPlanModel mapResultSetToPlan(ResultSet rs) throws SQLException {
        MembershipPlanModel p = new MembershipPlanModel();
        p.setPlanId(rs.getInt("plan_id"));
        p.setPlanName(rs.getString("plan_name"));
        p.setDurationMonths(rs.getInt("duration_months"));
        p.setPrice(rs.getDouble("price"));
        p.setDescription(rs.getString("description"));
        p.setStatus(rs.getString("status"));
        return p;
    }
}

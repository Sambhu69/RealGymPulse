package com.gympulse.controllers;

import com.gympulse.config.DBConfig;
import com.gympulse.model.UserModel;
import com.gympulse.service.TrainerService;
import com.gympulse.model.TrainerSlotModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/trainer/dashboard")
public class TrainerDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");
        int trainerId = loggedUser.getUserId();

        // --- Stats ---
        int upcomingSessions = 0, completedSessions = 0;
        double avgRating = 0.0;

        String statsSql = "SELECT " +
            "SUM(CASE WHEN b.status = 'scheduled' THEN 1 ELSE 0 END) AS upcoming, " +
            "SUM(CASE WHEN b.status = 'completed' THEN 1 ELSE 0 END) AS completed " +
            "FROM trainer_bookings b WHERE b.trainer_id = ?";

        String ratingSql = "SELECT COALESCE(AVG(rating), 0.0) as avg_rating FROM trainer_reviews WHERE trainer_id = ?";

        try (Connection conn = DBConfig.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement(statsSql)) {
                pst.setInt(1, trainerId);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    upcomingSessions = rs.getInt("upcoming");
                    completedSessions = rs.getInt("completed");
                }
            }
            try (PreparedStatement pst = conn.prepareStatement(ratingSql)) {
                pst.setInt(1, trainerId);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) avgRating = rs.getDouble("avg_rating");
            }
        } catch (Exception e) { e.printStackTrace(); }

        // --- Upcoming Sessions ---
        List<Map<String, String>> sessions = new ArrayList<>();
        String sessionSql = "SELECT b.booking_id, b.status, s.slot_date, s.start_time, s.end_time, u.full_name AS member_name " +
            "FROM trainer_bookings b " +
            "JOIN trainer_slots s ON b.slot_id = s.slot_id " +
            "JOIN users u ON b.member_id = u.user_id " +
            "WHERE b.trainer_id = ? AND b.status IN ('scheduled', 'completed') AND s.slot_date >= CURDATE() " +
            "ORDER BY s.slot_date, s.start_time LIMIT 10";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sessionSql)) {
            pst.setInt(1, trainerId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Map<String, String> s = new HashMap<>();
                s.put("bookingId", String.valueOf(rs.getInt("booking_id")));
                s.put("date", rs.getString("slot_date"));
                s.put("time", rs.getString("start_time"));
                s.put("memberName", rs.getString("member_name"));
                s.put("status", rs.getString("status"));
                sessions.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }

        // --- My Available Slots ---
        TrainerService trainerService = new TrainerService();
        List<TrainerSlotModel> mySlots = trainerService.getAvailableSlots(trainerId);

        request.setAttribute("upcomingSessions", upcomingSessions);
        request.setAttribute("completedSessions", completedSessions);
        request.setAttribute("avgRating", String.format("%.1f", avgRating));
        request.setAttribute("sessions", sessions);
        request.setAttribute("mySlots", mySlots);
        request.setAttribute("pageTitle", "Trainer Dashboard");

        request.getRequestDispatcher("/WEB-INF/pages/trainer/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        if (loggedUser == null || !"trainer".equals(loggedUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        if ("complete".equals(action)) {
            try {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                String sql = "UPDATE trainer_bookings SET status = 'completed' WHERE booking_id = ? AND trainer_id = ?";
                try (Connection conn = DBConfig.getConnection();
                     PreparedStatement pst = conn.prepareStatement(sql)) {
                    pst.setInt(1, bookingId);
                    pst.setInt(2, loggedUser.getUserId());
                    pst.executeUpdate();
                }
                response.sendRedirect(request.getContextPath() + "/trainer/dashboard?success=completed");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/trainer/dashboard?error=failed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/trainer/dashboard");
        }
    }
}


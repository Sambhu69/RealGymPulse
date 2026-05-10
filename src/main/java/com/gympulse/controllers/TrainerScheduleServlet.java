package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.config.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/trainer/schedule")
public class TrainerScheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String slotDate = request.getParameter("slotDate");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");

            String sql = "INSERT INTO trainer_slots (trainer_id, slot_date, start_time, end_time) VALUES (?, ?, ?, ?)";
            try (Connection conn = DBConfig.getConnection();
                 PreparedStatement pst = conn.prepareStatement(sql)) {
                pst.setInt(1, loggedUser.getUserId());
                pst.setString(2, slotDate);
                pst.setString(3, startTime);
                pst.setString(4, endTime);
                pst.executeUpdate();
                response.sendRedirect(request.getContextPath() + "/trainer/dashboard?success=slot_added");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/trainer/dashboard?error=add_failed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/trainer/dashboard");
        }
    }
}

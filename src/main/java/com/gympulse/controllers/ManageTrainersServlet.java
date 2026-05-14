package com.gympulse.controllers;

import com.gympulse.model.TrainerProfileModel;
import com.gympulse.service.TrainerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/trainers")
public class ManageTrainersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrainerService trainerService;

    @Override
    public void init() throws ServletException {
        trainerService = new TrainerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<TrainerProfileModel> trainers = trainerService.getAllTrainers();
        request.setAttribute("trainers", trainers);

        String action = request.getParameter("action");
        if ("view".equals(action)) {
            String profileIdStr = request.getParameter("profileId");
            if (profileIdStr != null && !profileIdStr.isEmpty()) {
                int profileId = Integer.parseInt(profileIdStr);
                for (TrainerProfileModel t : trainers) {
                    if (t.getProfileId() == profileId) {
                        request.setAttribute("selectedTrainer", t);
                        break;
                    }
                }
            }
        }
        
        request.getRequestDispatcher("/WEB-INF/pages/admin/trainers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/trainers");
            return;
        }

        try {
            switch (action) {
                case "add":
                    handleAdd(request, response);
                    break;
                case "edit":
                    handleEdit(request, response);
                    break;
                case "password":
                    handlePassword(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                case "unlock":
                    handleUnlock(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/trainers");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/trainers?error=system_error");
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String bio = request.getParameter("bio");
        String specializations = request.getParameter("specializations");

        com.gympulse.model.UserModel user = new com.gympulse.model.UserModel();
        user.setFullName(fullName);
        user.setUserEmail(email);
        user.setPhone(phone);
        user.setUserPassword(password);

        if (trainerService.addTrainer(user, bio, specializations)) {
            response.sendRedirect(request.getContextPath() + "/admin/trainers?success=trainer_added");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/trainers?error=add_failed");
        }
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int profileId = Integer.parseInt(request.getParameter("profileId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String bio = request.getParameter("bio");
        String specializations = request.getParameter("specializations");

        if (trainerService.updateTrainer(profileId, userId, fullName, phone, bio, specializations)) {
            response.sendRedirect(request.getContextPath() + "/admin/trainers?success=trainer_updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/trainers?error=update_failed");
        }
    }

    private void handlePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String newPassword = request.getParameter("newPassword");
        
        com.gympulse.service.UserService userService = new com.gympulse.service.UserService();
        if (userService.updatePassword(userId, newPassword)) {
            response.sendRedirect(request.getContextPath() + "/admin/trainers?success=password_changed");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/trainers?error=password_failed");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        if (trainerService.deleteTrainer(userId)) {
            response.sendRedirect(request.getContextPath() + "/admin/trainers?success=trainer_deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/trainers?error=delete_failed");
        }
    }

    private void handleUnlock(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        com.gympulse.service.UserService userService = new com.gympulse.service.UserService();
        userService.unlockUser(userId);
        response.sendRedirect(request.getContextPath() + "/admin/trainers?success=trainer_unlocked");
    }
}

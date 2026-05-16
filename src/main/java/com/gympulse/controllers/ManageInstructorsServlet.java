package com.gympulse.controllers;

import com.gympulse.model.InstructorProfileModel;
import com.gympulse.model.UserModel;
import com.gympulse.service.InstructorService;
import com.gympulse.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/instructors")
public class ManageInstructorsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InstructorService instructorService;

    @Override
    public void init() throws ServletException {
        instructorService = new InstructorService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<InstructorProfileModel> instructors = instructorService.getAllInstructors();
        request.setAttribute("instructors", instructors);

        String action = request.getParameter("action");
        if ("view".equals(action)) {
            String profileIdStr = request.getParameter("profileId");
            if (profileIdStr != null && !profileIdStr.isEmpty()) {
                int profileId = Integer.parseInt(profileIdStr);
                for (InstructorProfileModel i : instructors) {
                    if (i.getProfileId() == profileId) {
                        request.setAttribute("selectedInstructor", i);
                        break;
                    }
                }
            }
        }
        
        request.getRequestDispatcher("/WEB-INF/pages/admin/instructors.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/instructors");
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
                    response.sendRedirect(request.getContextPath() + "/admin/instructors");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/instructors?error=system_error");
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String bio = request.getParameter("bio");
        String specializations = request.getParameter("specializations");

        UserModel user = new UserModel();
        user.setFullName(fullName);
        user.setUserEmail(email);
        user.setPhone(phone);
        user.setUserPassword(password);

        if (instructorService.addInstructor(user, bio, specializations)) {
            response.sendRedirect(request.getContextPath() + "/admin/instructors?success=instructor_added");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/instructors?error=add_failed");
        }
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int profileId = Integer.parseInt(request.getParameter("profileId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String bio = request.getParameter("bio");
        String specializations = request.getParameter("specializations");

        if (instructorService.updateInstructor(profileId, userId, fullName, phone, bio, specializations)) {
            response.sendRedirect(request.getContextPath() + "/admin/instructors?success=instructor_updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/instructors?error=update_failed");
        }
    }

    private void handlePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String newPassword = request.getParameter("newPassword");
        
        UserService userService = new UserService();
        if (userService.updatePassword(userId, newPassword)) {
            response.sendRedirect(request.getContextPath() + "/admin/instructors?success=password_changed");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/instructors?error=password_failed");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        if (instructorService.deleteInstructor(userId)) {
            response.sendRedirect(request.getContextPath() + "/admin/instructors?success=instructor_deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/instructors?error=delete_failed");
        }
    }

    private void handleUnlock(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        UserService userService = new UserService();
        userService.unlockUser(userId);
        response.sendRedirect(request.getContextPath() + "/admin/instructors?success=instructor_unlocked");
    }
}

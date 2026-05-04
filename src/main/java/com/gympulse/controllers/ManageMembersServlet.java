package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.service.UserService;
import com.gympulse.service.MembershipService;
import com.gympulse.service.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * ManageMembersServlet handles administration of gym members.
 */
@WebServlet("/admin/members")
public class ManageMembersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;
    private MembershipService membershipService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
        membershipService = new MembershipService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "delete":
                handleDelete(request, response);
                break;
            case "view":
                handleView(request, response);
                break;
            case "list":
            default:
                handleList(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if ("update".equals(action)) {
            handleUpdate(request, response);
        } else if ("changePassword".equals(action)) {
            handleChangePassword(request, response);
        } else if ("assignPlan".equals(action)) {
            handleAssignPlan(request, response);
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<UserModel> members = userService.getAllMembers();
        request.setAttribute("members", members);
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-members.jsp").forward(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        if (userService.deleteUser(userId)) {
            response.sendRedirect(request.getContextPath() + "/admin/members?success=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/members?error=delete_failed");
        }
    }

    private void handleView(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        UserModel member = userService.getUserById(userId);
        request.setAttribute("member", member);
        request.setAttribute("allPlans", membershipService.getAllPlans());
        request.setAttribute("activeMembership", membershipService.getActiveMembership(userId));
        request.setAttribute("members", userService.getAllMembers()); // Fix: Populate table even when viewing a specific user
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-members.jsp").forward(request, response);
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String status = request.getParameter("status");

        if (!ValidationUtil.isNotEmpty(fullName) || !ValidationUtil.isValidPhone(phone)) {
            response.sendRedirect(request.getContextPath() + "/admin/members?error=invalid_data");
            return;
        }

        UserModel user = userService.getUserById(userId);
        if (user != null) {
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setStatus(status);
            if (userService.updateUser(user)) {
                response.sendRedirect(request.getContextPath() + "/admin/members?success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/members?error=update_failed");
            }
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String newPassword = request.getParameter("newPassword");

        if (!ValidationUtil.isValidPassword(newPassword)) {
            response.sendRedirect(request.getContextPath() + "/admin/members?error=weak_password");
            return;
        }

        if (userService.updatePassword(userId, newPassword)) {
            response.sendRedirect(request.getContextPath() + "/admin/members?success=password_changed");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/members?error=password_update_failed");
        }
    }

    private void handleAssignPlan(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int planId = Integer.parseInt(request.getParameter("planId"));

        if (membershipService.assignMembership(userId, planId)) {
            response.sendRedirect(request.getContextPath() + "/admin/members?action=view&userId=" + userId + "&success=plan_assigned");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/members?action=view&userId=" + userId + "&error=plan_assign_failed");
        }
    }
}

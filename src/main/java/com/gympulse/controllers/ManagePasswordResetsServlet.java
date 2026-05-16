package com.gympulse.controllers;

import com.gympulse.model.PasswordResetRequestModel;
import com.gympulse.service.PasswordResetService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/password-resets")
public class ManagePasswordResetsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PasswordResetService resetService;

    @Override
    public void init() throws ServletException {
        resetService = new PasswordResetService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<PasswordResetRequestModel> requests = resetService.getAllRequests();
        request.setAttribute("resetRequests", requests);
        request.getRequestDispatcher("/WEB-INF/pages/admin/password-resets.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String status = request.getParameter("status");
            resetService.updateRequestStatus(requestId, status);
        }
        response.sendRedirect(request.getContextPath() + "/admin/password-resets");
    }
}

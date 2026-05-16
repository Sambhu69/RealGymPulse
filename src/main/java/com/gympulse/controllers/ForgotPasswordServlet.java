package com.gympulse.controllers;

import com.gympulse.service.PasswordResetService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PasswordResetService resetService;

    @Override
    public void init() throws ServletException {
        resetService = new PasswordResetService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        if (fullName == null || fullName.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
            request.setAttribute("error", "Full Name and Phone Number are required.");
            request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp").forward(request, response);
            return;
        }

        boolean success = resetService.createRequest(fullName, phone, email);
        if (success) {
            request.setAttribute("success", "Your password reset request has been sent to the administration. We will contact you shortly.");
        } else {
            request.setAttribute("error", "An error occurred while processing your request. Please try again.");
        }
        request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp").forward(request, response);
    }
}

package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.service.UserService;
import com.gympulse.service.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * RegisterServlet handles new user registration.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String userEmail = request.getParameter("email");
        String phone = request.getParameter("phone");
        String userPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // 1. Validate mandatory fields
        if (!ValidationUtil.isNotEmpty(fullName) || !ValidationUtil.isNotEmpty(userEmail) || 
            !ValidationUtil.isNotEmpty(phone) || !ValidationUtil.isNotEmpty(userPassword)) {
            forwardWithError(request, response, "All fields are required.");
            return;
        }

        // 2. Validate formats
        if (!ValidationUtil.isValidName(fullName)) {
            forwardWithError(request, response, "Name should only contain letters.");
            return;
        }
        if (!ValidationUtil.isValidEmail(userEmail)) {
            forwardWithError(request, response, "Invalid email format.");
            return;
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            forwardWithError(request, response, "Phone must be exactly 10 digits.");
            return;
        }
        if (!ValidationUtil.isValidPassword(userPassword)) {
            forwardWithError(request, response, "Password must be min 8 chars with 1 uppercase, 1 number, and 1 special char.");
            return;
        }
        if (!userPassword.equals(confirmPassword)) {
            forwardWithError(request, response, "Passwords do not match.");
            return;
        }

        // 3. Register
        UserModel user = new UserModel();
        user.setFullName(fullName);
        user.setUserEmail(userEmail);
        user.setPhone(phone);
        user.setUserPassword(userPassword);
        user.setRole("member");
        user.setStatus("active");

        if (userService.registerUser(user)) {
            request.getSession().setAttribute("successMsg", "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            forwardWithError(request, response, "Email or phone already registered.");
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String message) 
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }
}

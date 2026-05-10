package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.service.UserService;
import com.gympulse.service.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * LoginServlet handles user authentication and session creation.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (session != null) ? (UserModel) session.getAttribute("loggedUser") : null;

        if (loggedUser != null) {
            redirectByRole(loggedUser, request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userEmail = request.getParameter("email");
        String userPassword = request.getParameter("password");

        if (!ValidationUtil.isNotEmpty(userEmail) || !ValidationUtil.isNotEmpty(userPassword)) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }

        try {
            UserModel user = userService.loginUser(userEmail, userPassword);

            if (user == null) {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            } else if ("locked".equalsIgnoreCase(user.getStatus())) {
                request.setAttribute("error", "Account locked. Try again in 15 minutes.");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser", user);
                session.setAttribute("userId", user.getUserId());
                redirectByRole(user, request, response);
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database connection error. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }

    private void redirectByRole(UserModel user, HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        if ("admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else if ("trainer".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/trainer/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/member/dashboard");
        }
    }
}

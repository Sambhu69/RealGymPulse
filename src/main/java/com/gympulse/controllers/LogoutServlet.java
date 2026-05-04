package com.gympulse.controllers;

import com.gympulse.service.CookieUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * LogoutServlet invalidates the session and clears all cookies (including
 * any remember-me cookie) via CookieUtil, then redirects to /login.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Invalidate the session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // 2. Clear the JSESSIONID cookie
        CookieUtil.clearCookie(response, "JSESSIONID");

        // 3. Clear the remember-me cookie if present
        CookieUtil.clearCookie(response, "rememberMe");

        // 4. Redirect to login
        response.sendRedirect(request.getContextPath() + "/login");
    }

    /** Support POST logout (e.g., from a form-based logout button) */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

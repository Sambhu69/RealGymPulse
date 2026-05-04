package com.gympulse.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * ErrorServlet handles application error pages.
 * Intercepts both explicit ?code=xxx navigations and
 * container-dispatched java.lang.Exception / Throwable errors.
 * Never exposes stack traces — always forwards to a friendly JSP.
 */
@WebServlet("/error")
public class ErrorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleError(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleError(request, response);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Try reading the container-set status code first (exception dispatch)
        Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");

        // Fall back to explicit ?code= query parameter
        if (statusCode == null) {
            String code = request.getParameter("code");
            if (code != null) {
                try { statusCode = Integer.parseInt(code); } catch (NumberFormatException ignored) {}
            }
        }

        // Log the exception (never expose to end user)
        Throwable throwable = (Throwable) request.getAttribute("jakarta.servlet.error.exception");
        if (throwable != null) {
            getServletContext().log("ErrorServlet caught exception", throwable);
        }

        if (statusCode != null && statusCode == 404) {
            response.setStatus(404);
            request.getRequestDispatcher("/WEB-INF/pages/error-404.jsp").forward(request, response);
        } else {
            response.setStatus(statusCode != null ? statusCode : 500);
            request.getRequestDispatcher("/WEB-INF/pages/error-500.jsp").forward(request, response);
        }
    }
}

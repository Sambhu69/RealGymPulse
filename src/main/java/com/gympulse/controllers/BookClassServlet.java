package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.service.ClassService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * BookClassServlet handles class booking and cancellation for members.
 */
@WebServlet("/member/book")
public class BookClassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClassService classService;

    @Override
    public void init() throws ServletException {
        classService = new ClassService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");
        int classId = Integer.parseInt(request.getParameter("classId"));

        if (classService.bookClass(loggedUser.getUserId(), classId)) {
            response.sendRedirect(request.getContextPath() + "/member/dashboard?success=booked");
        } else {
            response.sendRedirect(request.getContextPath() + "/member/dashboard?error=alreadybooked");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("cancel".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int classId = Integer.parseInt(request.getParameter("classId"));

            if (classService.cancelBooking(bookingId, classId)) {
                response.sendRedirect(request.getContextPath() + "/member/dashboard?success=cancelled");
            } else {
                response.sendRedirect(request.getContextPath() + "/member/dashboard?error=cancel_failed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/member/dashboard");
        }
    }
}

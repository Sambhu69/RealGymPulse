package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.service.ClassService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.gympulse.service.MembershipService;
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

        MembershipService memService = new MembershipService();
        com.gympulse.model.MembershipModel activeMem = memService.getActiveMembership(loggedUser.getUserId());
        
        if (activeMem == null || (activeMem.getPlanId() != 2 && activeMem.getPlanId() != 3)) {
            response.sendRedirect(request.getContextPath() + "/member/dashboard?error=membership_required");
            return;
        }

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
            HttpSession session = request.getSession(false);
            UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");
            try {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                int classId = Integer.parseInt(request.getParameter("classId"));

                if (classService.cancelBooking(bookingId, classId, loggedUser.getUserId())) {
                    response.sendRedirect(request.getContextPath() + "/member/dashboard?success=cancelled");
                } else {
                    response.sendRedirect(request.getContextPath() + "/member/dashboard?error=cancel_failed");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/member/dashboard?error=invalid_input");
            }
        } else if ("cancelAll".equals(action)) {
            HttpSession session = request.getSession(false);
            UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");
            if (classService.cancelAllBookings(loggedUser.getUserId())) {
                response.sendRedirect(request.getContextPath() + "/member/dashboard?success=cancelled");
            } else {
                response.sendRedirect(request.getContextPath() + "/member/dashboard?error=cancel_failed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/member/dashboard");
        }
    }
}

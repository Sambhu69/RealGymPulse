package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.model.MembershipModel;
import com.gympulse.service.TrainerService;
import com.gympulse.service.MembershipService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/member/book-trainer")
public class BookTrainerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrainerService trainerService;
    private MembershipService membershipService;

    @Override
    public void init() throws ServletException {
        trainerService = new TrainerService();
        membershipService = new MembershipService();
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
                if (trainerService.cancelTrainerBooking(bookingId, loggedUser.getUserId())) {
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
            if (trainerService.cancelAllTrainerBookings(loggedUser.getUserId())) {
                response.sendRedirect(request.getContextPath() + "/member/dashboard?success=cancelled");
            } else {
                response.sendRedirect(request.getContextPath() + "/member/dashboard?error=cancel_failed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/member/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        MembershipModel activeMem = membershipService.getActiveMembership(loggedUser.getUserId());
        
        if (activeMem == null || activeMem.getPlanId() != 3) {
            response.sendRedirect(request.getContextPath() + "/member/trainers?error=premium_required");
            return;
        }

        try {
            int trainerId = Integer.parseInt(request.getParameter("trainerId"));
            int slotId = Integer.parseInt(request.getParameter("slotId"));

            if (trainerService.bookTrainerSlot(loggedUser.getUserId(), trainerId, slotId)) {
                response.sendRedirect(request.getContextPath() + "/member/dashboard?success=trainer_booked");
            } else {
                response.sendRedirect(request.getContextPath() + "/member/trainers?error=slot_unavailable");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/member/trainers?error=invalid_input");
        }
    }
}

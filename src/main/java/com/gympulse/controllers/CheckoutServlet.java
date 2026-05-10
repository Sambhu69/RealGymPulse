package com.gympulse.controllers;

import com.gympulse.model.MembershipPlanModel;
import com.gympulse.model.UserModel;
import com.gympulse.service.MembershipService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/member/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MembershipService membershipService;

    @Override
    public void init() throws ServletException {
        membershipService = new MembershipService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int planId = Integer.parseInt(request.getParameter("planId"));
            MembershipPlanModel plan = membershipService.getPlanById(planId);
            
            if (plan == null) {
                response.sendRedirect(request.getContextPath() + "/member/plans?error=invalid_plan");
                return;
            }
            
            request.setAttribute("plan", plan);
            request.setAttribute("pageTitle", "Checkout");
            request.getRequestDispatcher("/WEB-INF/pages/member/checkout.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/member/plans");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");
        
        try {
            int planId = Integer.parseInt(request.getParameter("planId"));
            
            // Mock payment processing success
            boolean success = membershipService.assignMembership(loggedUser.getUserId(), planId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/member/dashboard?success=membership_activated");
            } else {
                response.sendRedirect(request.getContextPath() + "/member/checkout?planId=" + planId + "&error=payment_failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/member/plans");
        }
    }
}

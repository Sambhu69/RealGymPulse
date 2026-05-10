package com.gympulse.controllers;

import com.gympulse.model.MembershipPlanModel;
import com.gympulse.service.MembershipService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/member/plans")
public class MembershipServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MembershipService membershipService;

    @Override
    public void init() throws ServletException {
        membershipService = new MembershipService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<MembershipPlanModel> plans = membershipService.getAllPlans();
        request.setAttribute("plans", plans);
        request.setAttribute("pageTitle", "Membership Plans");
        
        request.getRequestDispatcher("/WEB-INF/pages/member/plans.jsp").forward(request, response);
    }
}

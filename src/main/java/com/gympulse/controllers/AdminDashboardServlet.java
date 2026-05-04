package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.service.UserService;
import com.gympulse.service.ClassService;
import com.gympulse.service.MembershipService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AdminDashboardServlet aggregates key metrics for the admin landing page.
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;
    private ClassService classService;
    private MembershipService membershipService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
        classService = new ClassService();
        membershipService = new MembershipService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (session != null) ? (UserModel) session.getAttribute("loggedUser") : null;

        // Populate Dashboard Stats
        int totalMembers = userService.getAllMembers().size();
        int totalClasses = classService.getAllClasses().size();
        int totalBookings = classService.getAllBookings().size();
        int totalPlans = membershipService.getAllPlans().size();

        request.setAttribute("totalMembers", totalMembers);
        request.setAttribute("totalClasses", totalClasses);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("totalPlans", totalPlans);
        request.setAttribute("loggedUser", loggedUser);

        request.getRequestDispatcher("/WEB-INF/pages/admin/dashboard.jsp").forward(request, response);
    }
}

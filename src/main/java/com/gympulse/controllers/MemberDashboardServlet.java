package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.model.MembershipModel;
import com.gympulse.model.FitnessClassModel;
import com.gympulse.model.BookingModel;
import com.gympulse.service.ClassService;
import com.gympulse.service.MembershipService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * MemberDashboardServlet populates the member home page with
 * membership status, available classes, and booking history.
 */
@WebServlet("/member/dashboard")
public class MemberDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClassService classService;
    private MembershipService membershipService;

    @Override
    public void init() throws ServletException {
        classService = new ClassService();
        membershipService = new MembershipService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        // Active membership
        MembershipModel activeMembership = membershipService.getActiveMembership(loggedUser.getUserId());
        request.setAttribute("activeMembership", activeMembership);

        // Available classes
        List<FitnessClassModel> availableClasses = classService.getAvailableClasses();
        request.setAttribute("availableClasses", availableClasses);

        // User's bookings
        List<BookingModel> myBookings = classService.getBookingsByUser(loggedUser.getUserId());
        request.setAttribute("myBookings", myBookings);

        request.setAttribute("loggedUser", loggedUser);
        request.getRequestDispatcher("/WEB-INF/pages/member/dashboard.jsp").forward(request, response);
    }
}

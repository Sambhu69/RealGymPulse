package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.model.MembershipModel;
import com.gympulse.model.FitnessClassModel;
import com.gympulse.model.BookingModel;
import com.gympulse.service.ClassService;
import com.gympulse.service.MembershipService;
import com.gympulse.service.NoticeService;
import com.gympulse.model.NoticeModel;
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
    private NoticeService noticeService;

    @Override
    public void init() throws ServletException {
        classService = new ClassService();
        membershipService = new MembershipService();
        noticeService = new NoticeService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        // Active membership
        MembershipModel activeMembership = membershipService.getActiveMembership(loggedUser.getUserId());
        request.setAttribute("activeMembership", activeMembership);

        // 4. Fetch notices
        List<NoticeModel> notices = noticeService.getAllNoticesForUser(loggedUser.getUserId(), loggedUser.getRole());
        request.setAttribute("notices", notices);

        // User's bookings
        List<BookingModel> myBookings = classService.getBookingsByUser(loggedUser.getUserId());
        request.setAttribute("myBookings", myBookings);

        // Trainer bookings
        com.gympulse.service.TrainerService ts = new com.gympulse.service.TrainerService();
        request.setAttribute("trainerBookings", ts.getMemberTrainerBookings(loggedUser.getUserId()));

        request.setAttribute("loggedUser", loggedUser);
        request.getRequestDispatcher("/WEB-INF/pages/member/dashboard.jsp").forward(request, response);
    }
}

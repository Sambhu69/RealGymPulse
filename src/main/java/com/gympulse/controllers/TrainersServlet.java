package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.model.TrainerProfileModel;
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
import java.util.List;

@WebServlet("/member/trainers")
public class TrainersServlet extends HttpServlet {
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
        
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        MembershipModel activeMem = membershipService.getActiveMembership(loggedUser.getUserId());
        
        if (activeMem == null || activeMem.getPlanId() != 3) {
            // Not a Premium Annual member
            request.setAttribute("error", "Personal Trainer booking is exclusive to Premium Annual members.");
            request.getRequestDispatcher("/WEB-INF/pages/member/upgrade-prompt.jsp").forward(request, response);
            return;
        }

        List<TrainerProfileModel> trainers = trainerService.getAllTrainers();
        request.setAttribute("trainers", trainers);
        request.setAttribute("pageTitle", "Book a Personal Trainer");
        
        // Also fetch available slots for each trainer (could be optimized, but ok for now)
        for (TrainerProfileModel t : trainers) {
            request.setAttribute("slots_" + t.getUserId(), trainerService.getAvailableSlots(t.getUserId()));
        }

        request.getRequestDispatcher("/WEB-INF/pages/member/trainers.jsp").forward(request, response);
    }
}

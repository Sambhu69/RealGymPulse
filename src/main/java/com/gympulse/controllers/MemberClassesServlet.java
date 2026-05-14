package com.gympulse.controllers;

import com.gympulse.model.FitnessClassModel;
import com.gympulse.model.UserModel;
import com.gympulse.service.ClassService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Handles the display of available classes for members.
 */
@WebServlet("/member/classes")
public class MemberClassesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClassService classService;

    @Override
    public void init() throws ServletException {
        classService = new ClassService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        // Fetch available classes
        List<FitnessClassModel> availableClasses = classService.getAvailableClasses();
        request.setAttribute("availableClasses", availableClasses);
        request.setAttribute("loggedUser", loggedUser);

        request.getRequestDispatcher("/WEB-INF/pages/member/classes.jsp").forward(request, response);
    }
}

package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.model.FitnessClassModel;
import com.gympulse.service.ClassService;
import com.gympulse.utils.NepaliCalendarUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/instructor/dashboard")
public class InstructorDashboardServlet extends HttpServlet {
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
        
        if (loggedUser == null || !"instructor".equals(loggedUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String instructorName = loggedUser.getFullName();
        List<FitnessClassModel> allClasses = classService.getClassesByInstructor(instructorName);
        
        // Monday Holiday Logic
        LocalDate today = LocalDate.now();
        boolean isMonday = today.getDayOfWeek() == DayOfWeek.MONDAY;
        request.setAttribute("isMonday", isMonday);

        // Stats
        long upcomingCount = allClasses.stream().filter(c -> "available".equals(c.getStatus())).count();
        long activeCount = allClasses.stream().filter(c -> "in_progress".equals(c.getStatus())).count();
        long completedCount = allClasses.stream().filter(c -> "completed".equals(c.getStatus())).count();

        request.setAttribute("classes", allClasses);
        request.setAttribute("upcomingCount", upcomingCount);
        request.setAttribute("activeCount", activeCount);
        request.setAttribute("completedCount", completedCount);
        request.setAttribute("pageTitle", "Instructor Dashboard");

        // Nepali Calendar Logic
        NepaliCalendarUtils.NepaliDate nDate = NepaliCalendarUtils.convertToNepali(today);
        int daysInMonth = NepaliCalendarUtils.getDaysInMonth(nDate.month);
        LocalDate adStartOfMonth = NepaliCalendarUtils.getAdStartOfMonth(nDate.month);
        int startDayOfWeek = adStartOfMonth.getDayOfWeek().getValue(); // 1 = Monday, 7 = Sunday
        
        request.setAttribute("nepaliDate", nDate);
        request.setAttribute("daysInMonth", daysInMonth);
        request.setAttribute("startDayOfWeek", startDayOfWeek);
        request.setAttribute("todayDay", nDate.day);

        request.getRequestDispatcher("/WEB-INF/pages/instructor/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");
        
        if (loggedUser == null || !"instructor".equals(loggedUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        try {
            int classId = Integer.parseInt(request.getParameter("classId"));
            
            if ("open".equals(action)) {
                classService.updateClassStatus(classId, "in_progress");
                response.sendRedirect(request.getContextPath() + "/instructor/dashboard?success=opened");
            } else if ("close".equals(action)) {
                classService.updateClassStatus(classId, "completed");
                response.sendRedirect(request.getContextPath() + "/instructor/dashboard?success=closed");
            } else {
                response.sendRedirect(request.getContextPath() + "/instructor/dashboard");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/instructor/dashboard?error=invalid_id");
        }
    }
}

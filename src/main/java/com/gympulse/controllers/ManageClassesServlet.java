package com.gympulse.controllers;

import com.gympulse.model.FitnessClassModel;
import com.gympulse.service.ClassService;
import com.gympulse.service.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * ManageClassesServlet handles administration of fitness classes.
 */
@WebServlet("/admin/classes")
public class ManageClassesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClassService classService;

    @Override
    public void init() throws ServletException {
        classService = new ClassService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";

        if ("delete".equals(action)) {
            handleDelete(request, response);
        } else {
            handleList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            handleAdd(request, response);
        } else if ("update".equals(action)) {
            handleUpdate(request, response);
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<FitnessClassModel> classes = classService.getAllClasses();
        request.setAttribute("classes", classes);
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-classes.jsp").forward(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int classId = Integer.parseInt(request.getParameter("classId"));
        if (classService.deleteClass(classId)) {
            response.sendRedirect(request.getContextPath() + "/admin/classes?success=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/classes?error=delete_failed");
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String className = request.getParameter("className");
        String instructor = request.getParameter("instructor");
        String scheduleDate = request.getParameter("scheduleDate");
        String scheduleTime = request.getParameter("scheduleTime");
        String capacityStr = request.getParameter("capacity");
        String description = request.getParameter("description");

        if (!ValidationUtil.isNotEmpty(className) || !ValidationUtil.isNotEmpty(instructor) || 
            !ValidationUtil.isNotEmpty(scheduleDate) || !ValidationUtil.isNotEmpty(scheduleTime) ||
            !ValidationUtil.isPositiveNumber(capacityStr)) {
            response.sendRedirect(request.getContextPath() + "/admin/classes?error=invalid_data");
            return;
        }

        FitnessClassModel fc = new FitnessClassModel();
        fc.setClassName(className);
        fc.setInstructor(instructor);
        fc.setScheduleDate(scheduleDate);
        fc.setScheduleTime(scheduleTime);
        fc.setCapacity(Integer.parseInt(capacityStr));
        fc.setDescription(description);

        if (classService.addClass(fc)) {
            response.sendRedirect(request.getContextPath() + "/admin/classes?success=added");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/classes?error=add_failed");
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int classId = Integer.parseInt(request.getParameter("classId"));
        String className = request.getParameter("className");
        String instructor = request.getParameter("instructor");
        String scheduleDate = request.getParameter("scheduleDate");
        String scheduleTime = request.getParameter("scheduleTime");
        String capacityStr = request.getParameter("capacity");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        if (!ValidationUtil.isNotEmpty(className) || !ValidationUtil.isPositiveNumber(capacityStr)) {
            response.sendRedirect(request.getContextPath() + "/admin/classes?error=invalid_data");
            return;
        }

        FitnessClassModel fc = classService.getClassById(classId);
        if (fc != null) {
            fc.setClassName(className);
            fc.setInstructor(instructor);
            fc.setScheduleDate(scheduleDate);
            fc.setScheduleTime(scheduleTime);
            fc.setCapacity(Integer.parseInt(capacityStr));
            fc.setDescription(description);
            fc.setStatus(status);

            if (classService.updateClass(fc)) {
                response.sendRedirect(request.getContextPath() + "/admin/classes?success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/classes?error=update_failed");
            }
        }
    }
}

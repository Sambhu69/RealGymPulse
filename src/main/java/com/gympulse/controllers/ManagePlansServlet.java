package com.gympulse.controllers;

import com.gympulse.model.MembershipPlanModel;
import com.gympulse.service.MembershipService;
import com.gympulse.service.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * ManagePlansServlet handles CRUD for membership plans.
 */
@WebServlet("/admin/plans")
public class ManagePlansServlet extends HttpServlet {
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
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-plans.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            handleAdd(request, response);
        } else if ("update".equals(action)) {
            handleUpdate(request, response);
        } else if ("delete".equals(action)) {
            handleDelete(request, response);
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String planName = request.getParameter("planName");
        String durationStr = request.getParameter("durationMonths");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");

        if (!ValidationUtil.isNotEmpty(planName) || !ValidationUtil.isPositiveNumber(priceStr) ||
            !ValidationUtil.isPositiveNumber(durationStr)) {
            response.sendRedirect(request.getContextPath() + "/admin/plans?error=invalid_data");
            return;
        }

        MembershipPlanModel plan = new MembershipPlanModel();
        plan.setPlanName(planName);
        plan.setDurationMonths(Integer.parseInt(durationStr));
        plan.setPrice(Double.parseDouble(priceStr));
        plan.setDescription(description);

        if (membershipService.addPlan(plan)) {
            response.sendRedirect(request.getContextPath() + "/admin/plans?success=added");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/plans?error=add_failed");
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int planId = Integer.parseInt(request.getParameter("planId"));
        String planName = request.getParameter("planName");
        String durationStr = request.getParameter("durationMonths");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        MembershipPlanModel plan = new MembershipPlanModel();
        plan.setPlanId(planId);
        plan.setPlanName(planName);
        plan.setDurationMonths(Integer.parseInt(durationStr));
        plan.setPrice(Double.parseDouble(priceStr));
        plan.setDescription(description);
        plan.setStatus(status);

        if (membershipService.updatePlan(plan)) {
            response.sendRedirect(request.getContextPath() + "/admin/plans?success=updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/plans?error=update_failed");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int planId = Integer.parseInt(request.getParameter("planId"));
        if (membershipService.deletePlan(planId)) {
            response.sendRedirect(request.getContextPath() + "/admin/plans?success=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/plans?error=delete_failed");
        }
    }
}

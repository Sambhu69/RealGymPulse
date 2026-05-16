package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.service.ContactService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/queries")
public class ManageQueriesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ContactService contactService;

    @Override
    public void init() throws ServletException {
        contactService = new ContactService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        if (!"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return;
        }

        request.setAttribute("queries", contactService.getAllQueries());
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-queries.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        if (!"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return;
        }

        String action = request.getParameter("action");
        try {
            int queryId = Integer.parseInt(request.getParameter("queryId"));
            if ("resolve".equals(action)) {
                if (contactService.updateQueryStatus(queryId, "resolved")) {
                    response.sendRedirect(request.getContextPath() + "/admin/queries?success=query_resolved");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/queries?error=update_failed");
                }
            } else if ("delete".equals(action)) {
                if (contactService.deleteQuery(queryId)) {
                    response.sendRedirect(request.getContextPath() + "/admin/queries?success=query_deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/queries?error=delete_failed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/queries");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/queries?error=invalid_id");
        }
    }
}

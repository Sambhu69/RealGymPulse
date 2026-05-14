package com.gympulse.controllers;

import com.gympulse.model.NoticeModel;
import com.gympulse.model.UserModel;
import com.gympulse.service.NoticeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Handles the notice board page — viewing all notices and posting new ones.
 * Accessible by admin, trainer roles. Members can view only.
 */
@WebServlet("/notices")
public class NoticeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoticeService noticeService;

    @Override
    public void init() throws ServletException {
        noticeService = new NoticeService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<NoticeModel> notices = noticeService.getAllNotices();
        request.setAttribute("notices", notices);

        HttpSession session = request.getSession(false);
        if (session != null) {
            UserModel user = (UserModel) session.getAttribute("loggedUser");
            if (user != null) {
                boolean canPost = "admin".equals(user.getRole()) || "trainer".equals(user.getRole());
                request.setAttribute("canPost", canPost);
            }
        }

        request.getRequestDispatcher("/WEB-INF/pages/notices.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Only admin and trainer can post
        if (!"admin".equals(user.getRole()) && !"trainer".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/notices?error=not_authorized");
            return;
        }

        String action = request.getParameter("action");

        if ("post".equals(action)) {
            String title = request.getParameter("title");
            String message = request.getParameter("message");
            String category = request.getParameter("category");

            if (title == null || title.trim().isEmpty() || message == null || message.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/notices?error=invalid_data");
                return;
            }
            if (category == null || category.trim().isEmpty()) {
                category = "general";
            }

            if (noticeService.addNotice(user.getUserId(), title.trim(), message.trim(), category)) {
                response.sendRedirect(request.getContextPath() + "/notices?success=notice_posted");
            } else {
                response.sendRedirect(request.getContextPath() + "/notices?error=post_failed");
            }
        } else if ("delete".equals(action)) {
            int noticeId = Integer.parseInt(request.getParameter("noticeId"));
            // Admin can delete any notice; trainers can only delete their own
            if (noticeService.deleteNotice(noticeId)) {
                response.sendRedirect(request.getContextPath() + "/notices?success=notice_deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/notices?error=delete_failed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/notices");
        }
    }
}

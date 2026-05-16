package com.gympulse.controllers;

import com.gympulse.model.NoticeModel;
import com.gympulse.model.UserModel;
import com.gympulse.service.NoticeService;
import com.gympulse.service.UserService;
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
    private UserService userService;

    @Override
    public void init() throws ServletException {
        noticeService = new NoticeService();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserModel user = null;
        if (session != null) {
            user = (UserModel) session.getAttribute("loggedUser");
        }

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<NoticeModel> notices = noticeService.getAllNoticesForUser(user.getUserId(), user.getRole());
        request.setAttribute("notices", notices);

        boolean isAdmin = "admin".equalsIgnoreCase(user.getRole());
        boolean isTrainer = "trainer".equalsIgnoreCase(user.getRole());
        boolean isInstructor = "instructor".equalsIgnoreCase(user.getRole());
        boolean canPost = isAdmin || isTrainer || isInstructor;
        request.setAttribute("canPost", canPost);

        if (isAdmin) {
            request.setAttribute("usersList", userService.getAllUsers());
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

        // Only admin, trainer, and instructor can post
        String role = user.getRole();
        boolean authorized = "admin".equalsIgnoreCase(role) || 
                             "trainer".equalsIgnoreCase(role) || 
                             "instructor".equalsIgnoreCase(role);

        if (!authorized) {
            response.sendRedirect(request.getContextPath() + "/notices?error=not_authorized");
            return;
        }

        String action = request.getParameter("action");

        if ("post".equals(action)) {
            String title = request.getParameter("title");
            String message = request.getParameter("message");
            String category = request.getParameter("category");
            String targetRole = request.getParameter("targetRole");

            if (title == null || title.trim().isEmpty() || message == null || message.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/notices?error=invalid_data");
                return;
            }
            if (category == null || category.trim().isEmpty()) {
                category = "general";
            }

            if (noticeService.addNotice(user.getUserId(), title.trim(), message.trim(), category, null, targetRole)) {
                response.sendRedirect(request.getContextPath() + "/notices?success=notice_posted");
            } else {
                response.sendRedirect(request.getContextPath() + "/notices?error=post_failed");
            }
        } else if ("delete".equals(action)) {
            int noticeId = Integer.parseInt(request.getParameter("noticeId"));
            // Authorization check
            NoticeModel existing = noticeService.getNoticeById(noticeId);
            if (existing == null) {
                response.sendRedirect(request.getContextPath() + "/notices?error=not_found");
                return;
            }
            if (!"admin".equalsIgnoreCase(user.getRole()) && user.getUserId() != existing.getAuthorId()) {
                response.sendRedirect(request.getContextPath() + "/notices?error=not_authorized");
                return;
            }

            if (noticeService.deleteNotice(noticeId)) {
                response.sendRedirect(request.getContextPath() + "/notices?success=notice_deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/notices?error=delete_failed");
            }
        } else if ("edit".equals(action)) {
            int noticeId = Integer.parseInt(request.getParameter("noticeId"));
            String title = request.getParameter("title");
            String message = request.getParameter("message");
            String category = request.getParameter("category");

            if (title == null || title.trim().isEmpty() || message == null || message.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/notices?error=invalid_data");
                return;
            }

            // Authorization check
            NoticeModel existing = noticeService.getNoticeById(noticeId);
            if (existing == null) {
                response.sendRedirect(request.getContextPath() + "/notices?error=not_found");
                return;
            }
            if (!"admin".equalsIgnoreCase(user.getRole()) && user.getUserId() != existing.getAuthorId()) {
                response.sendRedirect(request.getContextPath() + "/notices?error=not_authorized");
                return;
            }

            if (noticeService.updateNotice(noticeId, title.trim(), message.trim(), category)) {
                response.sendRedirect(request.getContextPath() + "/notices?success=notice_updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/notices?error=update_failed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/notices");
        }
    }
}

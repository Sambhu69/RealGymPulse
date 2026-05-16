package com.gympulse.controllers;

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

@WebServlet("/admin/messages")
public class AdminMessagesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;
    private NoticeService noticeService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
        noticeService = new NoticeService();
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

        request.setAttribute("usersList", userService.getAllUsers());
        request.getRequestDispatcher("/WEB-INF/pages/admin/messages.jsp").forward(request, response);
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
        if ("send".equals(action)) {
            String title = request.getParameter("title");
            String message = request.getParameter("message");
            String receiverParams = request.getParameter("receiverIds");

            if (title == null || title.trim().isEmpty() || message == null || message.trim().isEmpty() || receiverParams == null || receiverParams.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/messages?error=invalid_data");
                return;
            }

            try {
                String[] receiverIdsArray = receiverParams.split(",");
                boolean allSuccess = true;
                for (String idStr : receiverIdsArray) {
                    int receiverId = Integer.parseInt(idStr.trim());
                    if (!noticeService.addNotice(user.getUserId(), title.trim(), message.trim(), "general", receiverId, null)) {
                        allSuccess = false;
                    }
                }
                
                if (allSuccess) {
                    response.sendRedirect(request.getContextPath() + "/admin/messages?success=message_sent");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/messages?error=send_partial_failed");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/messages?error=invalid_data");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/messages");
        }
    }
}

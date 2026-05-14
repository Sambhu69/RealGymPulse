package com.gympulse.controllers;

import com.gympulse.model.NoticeModel;
import com.gympulse.service.NoticeService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Returns the 5 most recent notices as JSON for the notification dropdown.
 */
@WebServlet("/api/notices")
public class NoticeApiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoticeService noticeService;

    @Override
    public void init() {
        noticeService = new NoticeService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<NoticeModel> notices = noticeService.getRecentNotices(5);

        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < notices.size(); i++) {
            NoticeModel n = notices.get(i);
            if (i > 0) sb.append(",");
            sb.append("{");
            sb.append("\"noticeId\":").append(n.getNoticeId()).append(",");
            sb.append("\"title\":\"").append(escapeJson(n.getTitle())).append("\",");
            sb.append("\"category\":\"").append(escapeJson(n.getCategory())).append("\",");
            sb.append("\"authorName\":\"").append(escapeJson(n.getAuthorName())).append("\",");
            sb.append("\"authorRole\":\"").append(escapeJson(n.getAuthorRole())).append("\",");
            sb.append("\"createdAt\":\"").append(escapeJson(n.getCreatedAt())).append("\"");
            sb.append("}");
        }
        sb.append("]");

        PrintWriter out = response.getWriter();
        out.print(sb.toString());
        out.flush();
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}

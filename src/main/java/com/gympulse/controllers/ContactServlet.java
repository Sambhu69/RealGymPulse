package com.gympulse.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.gympulse.service.ContactService;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ContactService contactService;

    @Override
    public void init() throws ServletException {
        contactService = new ContactService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String userEmail = request.getParameter("email");
        String message = request.getParameter("message");

        // Here we would typically send an email or save to DB.
        if (contactService.addQuery(name, userEmail, message)) {
            response.sendRedirect(request.getContextPath() + "/contact?success=message_sent");
        } else {
            response.sendRedirect(request.getContextPath() + "/contact?error=message_failed");
        }
    }
}

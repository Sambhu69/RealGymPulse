package com.gympulse.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
        // For now, we just redirect back with a success message.
        System.out.println("Contact Form Submission: " + name + " (" + userEmail + ") - " + message);
        
        response.sendRedirect(request.getContextPath() + "/contact?success=message_sent");
    }
}

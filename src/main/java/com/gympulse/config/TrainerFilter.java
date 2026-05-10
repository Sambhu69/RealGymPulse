package com.gympulse.config;

import com.gympulse.model.UserModel;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * TrainerFilter ensures that only authenticated users with the 'trainer' role
 * can access trainer routes.
 */
@WebFilter(urlPatterns = {"/trainer/*"})
public class TrainerFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("loggedUser") != null);
        
        if (!isLoggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        if (!"trainer".equalsIgnoreCase(user.getRole())) {
            // Unauthenticated or wrong role, redirect to appropriate place or generic error
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/error?code=403");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}

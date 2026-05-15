package com.gympulse.config;

import com.gympulse.model.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * InstructorFilter ensures that only authenticated users with the 'instructor' role
 * can access instructor routes.
 */
@WebFilter(urlPatterns = {"/instructor/*"})
public class InstructorFilter implements Filter {

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
        if (!"instructor".equalsIgnoreCase(user.getRole())) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/error?code=403");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}

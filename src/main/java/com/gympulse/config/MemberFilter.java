package com.gympulse.config;

import com.gympulse.model.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * MemberFilter ensures that only authenticated users with the 'member' role
 * can access /member/* URLs. Redirects to /login if userId is missing from
 * the session or if the role is not 'member'.
 */
@WebFilter(urlPatterns = {"/member/*"})
public class MemberFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Guard: session must exist AND contain both loggedUser and userId
        UserModel loggedUser = (session != null) ? (UserModel) session.getAttribute("loggedUser") : null;
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        boolean authenticated = (loggedUser != null)
                && (userId != null || loggedUser.getUserId() > 0)
                && "member".equalsIgnoreCase(loggedUser.getRole());

        if (authenticated) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {}
}

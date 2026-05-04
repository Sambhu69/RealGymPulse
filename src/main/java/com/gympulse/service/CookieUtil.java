package com.gympulse.service;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CookieUtil provides helper methods for setting and clearing HTTP cookies.
 */
public class CookieUtil {

    /**
     * Sets a cookie with the given name, value, and max-age.
     *
     * @param response the HTTP response
     * @param name     cookie name
     * @param value    cookie value
     * @param maxAge   cookie lifetime in seconds (use 0 to delete)
     */
    public static void setCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    /**
     * Clears (expires) a cookie by setting its max-age to 0.
     *
     * @param response the HTTP response
     * @param name     the name of the cookie to clear
     */
    public static void clearCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    /**
     * Retrieves a cookie value by name from the request, or null if not found.
     *
     * @param request the HTTP request
     * @param name    the cookie name to look up
     * @return the cookie value, or null
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        if (request.getCookies() == null) return null;
        for (Cookie cookie : request.getCookies()) {
            if (name.equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return null;
    }
}

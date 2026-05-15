package com.gympulse.controllers;

import com.gympulse.model.UserModel;
import com.gympulse.service.UserService;
import com.gympulse.service.EncryptionUtil;
import com.gympulse.service.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 * ProfileServlet handles member profile viewing, editing, file upload,
 * and password change. Supports multipart form data for profile image uploads.
 */
@WebServlet(urlPatterns = {"/member/profile", "/instructor/profile", "/trainer/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,        // 1 MB
    maxFileSize       = 5 * 1024 * 1024,    // 5 MB
    maxRequestSize    = 10 * 1024 * 1024    // 10 MB
)
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String PROFILE_IMG_DIR = "images/profiles/";
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        UserModel freshUser = userService.getUserById(loggedUser.getUserId());
        request.setAttribute("userProfile", freshUser);
        
        String role = freshUser.getRole().toLowerCase();
        request.getRequestDispatcher("/WEB-INF/pages/" + role + "/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");
        String role = loggedUser.getRole().toLowerCase();
        String profilePath = "/" + role + "/profile";

        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            handleUpdateProfile(request, response, loggedUser, profilePath);
        } else if ("changePassword".equals(action)) {
            handleChangePassword(request, response, loggedUser, profilePath);
        } else {
            response.sendRedirect(request.getContextPath() + profilePath);
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response, UserModel loggedUser, String profilePath)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String phone    = request.getParameter("phone");

        if (!ValidationUtil.isNotEmpty(fullName) || !ValidationUtil.isValidName(fullName)) {
            forwardWithError(request, response, "Invalid name. Only letters and spaces are allowed.", loggedUser.getRole().toLowerCase());
            return;
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            forwardWithError(request, response, "Phone must be exactly 10 digits.", loggedUser.getRole().toLowerCase());
            return;
        }

        UserModel user = userService.getUserById(loggedUser.getUserId());
        user.setFullName(fullName);
        user.setPhone(phone);

        Part filePart = request.getPart("profileImage");
        if (filePart != null && filePart.getSize() > 0) {
            String savedPath = saveProfileImage(request, filePart, loggedUser.getUserId());
            if (savedPath != null) {
                user.setProfileImage(savedPath);
                userService.updateProfileImage(loggedUser.getUserId(), savedPath);
            }
        }

        if (userService.updateUser(user)) {
            loggedUser.setFullName(fullName);
            loggedUser.setPhone(phone);
            request.getSession().setAttribute("loggedUser", loggedUser);
            response.sendRedirect(request.getContextPath() + profilePath + "?success=profile_updated");
        } else {
            forwardWithError(request, response, "Failed to update profile. Please try again.", loggedUser.getRole().toLowerCase());
        }
    }

    private String saveProfileImage(HttpServletRequest request, Part filePart, int userId)
            throws IOException {
        String submittedName = filePart.getSubmittedFileName();
        if (submittedName == null || submittedName.isEmpty()) return null;

        String extension = "";
        int dot = submittedName.lastIndexOf('.');
        if (dot >= 0) extension = submittedName.substring(dot).toLowerCase();

        if (!extension.matches("\\.(jpg|jpeg|png|gif|webp)")) return null;

        String uploadDir = getServletContext().getRealPath("/") + PROFILE_IMG_DIR;
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) uploadFolder.mkdirs();

        String fileName = "user_" + userId + "_" + System.currentTimeMillis() + extension;
        String absolutePath = uploadDir + fileName;

        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(absolutePath), StandardCopyOption.REPLACE_EXISTING);
        }

        return PROFILE_IMG_DIR + fileName;
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, UserModel loggedUser, String profilePath)
            throws ServletException, IOException {
        String currentPassword  = request.getParameter("currentPassword");
        String newPassword      = request.getParameter("newPassword");
        String confirmPassword  = request.getParameter("confirmPassword");

        UserModel freshUser = userService.getUserById(loggedUser.getUserId());
        if (!EncryptionUtil.verifyPassword(currentPassword, freshUser.getUserPassword())) {
            forwardWithError(request, response, "Current password is incorrect.", loggedUser.getRole().toLowerCase());
            return;
        }
        if (!ValidationUtil.isValidPassword(newPassword)) {
            forwardWithError(request, response, "New password must be min 8 chars with 1 uppercase, 1 number, 1 special char.", loggedUser.getRole().toLowerCase());
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            forwardWithError(request, response, "New passwords do not match.", loggedUser.getRole().toLowerCase());
            return;
        }

        if (userService.updatePassword(loggedUser.getUserId(), newPassword)) {
            response.sendRedirect(request.getContextPath() + profilePath + "?success=password_changed");
        } else {
            forwardWithError(request, response, "Failed to change password. Please try again.", loggedUser.getRole().toLowerCase());
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String message, String role)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");
        request.setAttribute("error", message);
        request.setAttribute("userProfile", userService.getUserById(loggedUser.getUserId()));
        request.getRequestDispatcher("/WEB-INF/pages/" + role + "/profile.jsp").forward(request, response);
    }
}

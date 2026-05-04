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
@WebServlet("/member/profile")
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
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        UserModel freshUser = userService.getUserById(loggedUser.getUserId());
        request.setAttribute("userProfile", freshUser);
        request.getRequestDispatcher("/WEB-INF/pages/member/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            handleUpdateProfile(request, response);
        } else if ("changePassword".equals(action)) {
            handleChangePassword(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/member/profile");
        }
    }

    // -------------------------------------------------------------------------
    // Profile update (supports multipart for image upload)
    // -------------------------------------------------------------------------
    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        String fullName = request.getParameter("fullName");
        String phone    = request.getParameter("phone");

        if (!ValidationUtil.isNotEmpty(fullName) || !ValidationUtil.isValidName(fullName)) {
            forwardWithError(request, response, "Invalid name. Only letters and spaces are allowed.");
            return;
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            forwardWithError(request, response, "Phone must be exactly 10 digits.");
            return;
        }

        UserModel user = userService.getUserById(loggedUser.getUserId());
        user.setFullName(fullName);
        user.setPhone(phone);

        // Handle profile image upload
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
            session.setAttribute("loggedUser", loggedUser);
            response.sendRedirect(request.getContextPath() + "/member/profile?success=profile_updated");
        } else {
            forwardWithError(request, response, "Failed to update profile. Please try again.");
        }
    }

    // -------------------------------------------------------------------------
    // Save uploaded profile image to webapp/images/profiles/
    // -------------------------------------------------------------------------
    private String saveProfileImage(HttpServletRequest request, Part filePart, int userId)
            throws IOException {
        String submittedName = filePart.getSubmittedFileName();
        if (submittedName == null || submittedName.isEmpty()) return null;

        String extension = "";
        int dot = submittedName.lastIndexOf('.');
        if (dot >= 0) extension = submittedName.substring(dot).toLowerCase();

        // Only allow image extensions
        if (!extension.matches("\\.(jpg|jpeg|png|gif|webp)")) return null;

        // Build absolute save path
        String uploadDir = getServletContext().getRealPath("/") + PROFILE_IMG_DIR;
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) uploadFolder.mkdirs();

        String fileName = "user_" + userId + "_" + System.currentTimeMillis() + extension;
        String absolutePath = uploadDir + fileName;

        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(absolutePath), StandardCopyOption.REPLACE_EXISTING);
        }

        // Return the relative path to store in DB
        return PROFILE_IMG_DIR + fileName;
    }

    // -------------------------------------------------------------------------
    // Password change
    // -------------------------------------------------------------------------
    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");

        String currentPassword  = request.getParameter("currentPassword");
        String newPassword      = request.getParameter("newPassword");
        String confirmPassword  = request.getParameter("confirmPassword");

        UserModel freshUser = userService.getUserById(loggedUser.getUserId());
        if (!EncryptionUtil.verifyPassword(currentPassword, freshUser.getUserPassword())) {
            forwardWithError(request, response, "Current password is incorrect.");
            return;
        }
        if (!ValidationUtil.isValidPassword(newPassword)) {
            forwardWithError(request, response, "New password must be min 8 chars with 1 uppercase, 1 number, 1 special char.");
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            forwardWithError(request, response, "New passwords do not match.");
            return;
        }

        if (userService.updatePassword(loggedUser.getUserId(), newPassword)) {
            response.sendRedirect(request.getContextPath() + "/member/profile?success=password_changed");
        } else {
            forwardWithError(request, response, "Failed to change password. Please try again.");
        }
    }

    // -------------------------------------------------------------------------
    // Helper: forward back to profile JSP with an error message
    // -------------------------------------------------------------------------
    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("loggedUser");
        request.setAttribute("error", message);
        request.setAttribute("userProfile", userService.getUserById(loggedUser.getUserId()));
        request.getRequestDispatcher("/WEB-INF/pages/member/profile.jsp").forward(request, response);
    }
}

package com.gympulse.service;

import java.util.regex.Pattern;

/**
 * ValidationUtil provides common data validation methods for the GymPulse application.
 */
public class ValidationUtil {

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final String NAME_REGEX = "^[a-zA-Z\\s]+$";
    /** Min 8 chars, 1 uppercase, 1 number, 1 special char */
    private static final String PASSWORD_REGEX = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";

    /**
     * Checks if email matches standard pattern.
     */
    public static boolean isValidEmail(String email) {
        if (email == null) return false;
        return Pattern.matches(EMAIL_REGEX, email);
    }

    /**
     * Checks if phone number is exactly 10 digits.
     */
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches("\\d{10}");
    }

    /**
     * Validates password: min 8 chars, 1 uppercase, 1 number, 1 special char.
     */
    public static boolean isValidPassword(String password) {
        if (password == null) return false;
        return Pattern.matches(PASSWORD_REGEX, password);
    }

    /**
     * Checks if a string is not null and not blank.
     */
    public static boolean isNotEmpty(String value) {
        return value != null && !value.trim().isEmpty();
    }

    /**
     * Validates name: only letters and spaces allowed.
     */
    public static boolean isValidName(String name) {
        if (name == null) return false;
        return Pattern.matches(NAME_REGEX, name);
    }

    /**
     * Checks if a string value can be parsed as a positive double.
     */
    public static boolean isPositiveNumber(String value) {
        if (value == null) return false;
        try {
            double d = Double.parseDouble(value);
            return d > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}

package com.gympulse.config;

import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * One-time fix: updates trainer seed passwords to use correct AES encryption.
 */
public class FixTrainerPasswords {
    public static void main(String[] args) {
        // This is the AES-encrypted value of "Admin@1234" using the app's key
        String encryptedPassword = "f4f324da3b23cc6dbe18cce8b5841536";
        
        // Also reset locked status and failed attempts from failed login attempts
        String sql = "UPDATE users SET password = ?, status = 'active', failed_attempts = 0, locked_until = NULL " +
                     "WHERE email IN ('alex.trainer@gympulse.com', 'sarah.trainer@gympulse.com')";
        
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, encryptedPassword);
            int updated = pst.executeUpdate();
            System.out.println("Updated " + updated + " trainer account(s) successfully.");
            System.out.println("Trainers can now login with password: Admin@1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

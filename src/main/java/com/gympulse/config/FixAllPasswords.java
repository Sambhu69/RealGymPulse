package com.gympulse.config;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class FixAllPasswords {
    public static void main(String[] args) {
        String encryptedPassword = "f4f324da3b23cc6dbe18cce8b5841536";
        String sql = "UPDATE users SET password = ?, status = 'active', failed_attempts = 0, locked_until = NULL";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, encryptedPassword);
            int updated = pst.executeUpdate();
            System.out.println("Updated " + updated + " accounts successfully to password Admin@1234.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

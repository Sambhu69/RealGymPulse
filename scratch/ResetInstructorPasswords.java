import java.sql.*;
import com.gympulse.config.DBConfig;
import com.gympulse.service.EncryptionUtil;

public class ResetInstructorPasswords {
    public static void main(String[] args) {
        try (Connection conn = DBConfig.getConnection();
             Statement stmt = conn.createStatement()) {
            
            String newPassword = EncryptionUtil.encrypt("Instructor123!");
            int rows = stmt.executeUpdate("UPDATE users SET password = '" + newPassword + "' WHERE role = 'instructor'");
            System.out.println("Reset passwords for " + rows + " instructors. New password is 'Instructor123!'");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

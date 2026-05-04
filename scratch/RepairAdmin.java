import java.sql.*;
import com.gympulse.config.DBConfig;
import com.gympulse.util.EncryptionUtil;

public class RepairAdmin {
    public static void main(String[] args) {
        String adminEmail = "admin@gympulse.com";
        String adminPass = "Admin@123";
        String encryptedPass = EncryptionUtil.encrypt(adminPass);
        
        System.out.println("Repairing Admin account...");
        System.out.println("Email: " + adminEmail);
        System.out.println("Correct Encrypted Password: " + encryptedPass);
        
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, encryptedPass);
            pst.setString(2, adminEmail);
            int rows = pst.executeUpdate();
            if (rows > 0) {
                System.out.println("Successfully updated admin password.");
            } else {
                System.out.println("Admin account not found in database.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

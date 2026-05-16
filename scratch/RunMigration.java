import java.sql.*;
import com.gympulse.config.DBConfig;

public class RunMigration {
    public static void main(String[] args) {
        try (Connection conn = DBConfig.getConnection();
             Statement stmt = conn.createStatement()) {
            
            String sql = "CREATE TABLE IF NOT EXISTS password_reset_requests (" +
                         "request_id INT AUTO_INCREMENT PRIMARY KEY, " +
                         "full_name VARCHAR(100) NOT NULL, " +
                         "phone VARCHAR(20) NOT NULL, " +
                         "email VARCHAR(100), " +
                         "status ENUM('pending', 'resolved', 'rejected') DEFAULT 'pending', " +
                         "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                         ")";
            stmt.executeUpdate(sql);
            System.out.println("Migration applied successfully.");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

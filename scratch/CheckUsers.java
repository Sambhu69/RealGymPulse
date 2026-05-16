import java.sql.*;
import com.gympulse.config.DBConfig;

public class CheckUsers {
    public static void main(String[] args) {
        try (Connection conn = DBConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT user_id, full_name, role FROM users WHERE role = 'instructor'")) {
            
            System.out.println("Instructors in DB:");
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("user_id") + 
                                   ", Name: " + rs.getString("full_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

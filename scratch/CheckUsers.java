import java.sql.*;
import com.gympulse.config.DBConfig;

public class CheckUsers {
    public static void main(String[] args) {
        try (Connection conn = DBConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM users")) {
            
            System.out.println("User List:");
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("user_id") + 
                                   ", Email: " + rs.getString("email") + 
                                   ", Password: " + rs.getString("password") + 
                                   ", Role: " + rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

import java.sql.*;
import com.gympulse.config.DBConfig;

public class CheckProfiles {
    public static void main(String[] args) {
        try (Connection conn = DBConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT user_id, full_name FROM users WHERE role = 'instructor'")) {
            
            System.out.println("Checking profiles for instructors:");
            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String name = rs.getString("full_name");
                
                String profileCheck = "SELECT profile_id FROM instructor_profiles WHERE user_id = " + userId;
                try (Statement stmt2 = conn.createStatement();
                     ResultSet rs2 = stmt2.executeQuery(profileCheck)) {
                    if (rs2.next()) {
                        System.out.println(name + " HAS a profile.");
                    } else {
                        System.out.println(name + " DOES NOT have a profile! Creating one...");
                        String createProfile = "INSERT INTO instructor_profiles (user_id, bio, specializations, rating) VALUES (" + userId + ", 'Expert fitness instructor specializing in general fitness.', 'General Fitness', 5.0)";
                        stmt2.executeUpdate(createProfile);
                        System.out.println("Created profile for " + name);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

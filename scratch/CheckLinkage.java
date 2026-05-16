import java.sql.*;
import com.gympulse.config.DBConfig;

public class CheckLinkage {
    public static void main(String[] args) {
        try (Connection conn = DBConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT fc.class_name, fc.instructor, u.full_name FROM fitness_classes fc LEFT JOIN users u ON fc.instructor = u.full_name AND u.role = 'instructor'")) {
            
            System.out.println("Class to User Mapping Check:");
            while (rs.next()) {
                String className = rs.getString("class_name");
                String classInst = rs.getString("instructor");
                String userInst = rs.getString("full_name");
                if (userInst != null) {
                    System.out.println("OK: " + className + " -> " + classInst + " matched to user " + userInst);
                } else {
                    System.out.println("FAIL: " + className + " -> " + classInst + " NO MATCH IN USERS!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

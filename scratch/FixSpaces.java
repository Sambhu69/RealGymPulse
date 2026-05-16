import java.sql.*;
import com.gympulse.config.DBConfig;

public class FixSpaces {
    public static void main(String[] args) {
        try (Connection conn = DBConfig.getConnection();
             Statement stmt = conn.createStatement()) {
            
            int rows1 = stmt.executeUpdate("UPDATE users SET full_name = TRIM(full_name)");
            System.out.println("Trimmed users full_name: " + rows1 + " rows affected.");
            
            int rows2 = stmt.executeUpdate("UPDATE fitness_classes SET instructor = TRIM(instructor)");
            System.out.println("Trimmed fitness_classes instructor: " + rows2 + " rows affected.");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

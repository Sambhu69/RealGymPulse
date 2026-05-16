import com.gympulse.config.DBConfig;
import java.sql.Connection;
import java.sql.Statement;

public class UpdateTable {
    public static void main(String[] args) {
        try (Connection conn = DBConfig.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate("ALTER TABLE fitness_classes ADD COLUMN IF NOT EXISTS completed_sessions INT DEFAULT 0;");
            System.out.println("Column added successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

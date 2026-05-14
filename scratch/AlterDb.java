package scratch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class AlterDb {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gympulse_db?useSSL=false&allowPublicKeyRetrieval=true", "root", "");
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("ALTER TABLE users MODIFY COLUMN role ENUM('admin', 'member', 'trainer', 'instructor') DEFAULT 'member'");
            System.out.println("Role enum updated successfully!");
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

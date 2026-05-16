import java.sql.*;

public class CheckDb {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/gympulse_db";
        String user = "root";
        String password = "";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            System.out.println("Connection successful!");
            DatabaseMetaData md = conn.getMetaData();
            ResultSet rs = md.getColumns(null, null, "users", null);
            System.out.println("Columns in users table:");
            while (rs.next()) {
                System.out.println("- " + rs.getString("COLUMN_NAME"));
            }
        } catch (SQLException e) {
            System.out.println("Connection failed: " + e.getMessage());
        }
    }
}

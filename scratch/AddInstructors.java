

import com.gympulse.config.DBConfig;
import com.gympulse.model.UserModel;
import com.gympulse.service.InstructorService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddInstructors {
    public static void main(String[] args) {
        InstructorService instructorService = new InstructorService();
        List<String> missingInstructors = new ArrayList<>();

        try (Connection conn = DBConfig.getConnection()) {
            // Find distinct instructors from fitness_classes
            String sqlClasses = "SELECT DISTINCT instructor FROM fitness_classes";
            try (PreparedStatement pst = conn.prepareStatement(sqlClasses);
                 ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    String instName = rs.getString("instructor");
                    if (instName != null && !instName.isEmpty()) {
                        // Check if they exist in users table
                        String checkUser = "SELECT * FROM users WHERE full_name = ? AND role = 'instructor'";
                        try (PreparedStatement checkPst = conn.prepareStatement(checkUser)) {
                            checkPst.setString(1, instName);
                            try (ResultSet checkRs = checkPst.executeQuery()) {
                                if (!checkRs.next()) {
                                    missingInstructors.add(instName);
                                }
                            }
                        }
                    }
                }
            }

            System.out.println("Missing Instructors to add: " + missingInstructors);

            for (String name : missingInstructors) {
                UserModel user = new UserModel();
                user.setFullName(name);
                // Create an email from name e.g. Jake Miller -> jake.miller@gympulse.com
                String email = name.toLowerCase().replace(" ", ".") + "@gympulse.com";
                user.setUserEmail(email);
                user.setPhone("555-000-" + (int)(Math.random() * 9000 + 1000));
                user.setUserPassword("Instructor123!");
                user.setRole("instructor");

                boolean success = instructorService.addInstructor(user, "Expert fitness instructor specializing in " + name + "'s favorite routines.", "General Fitness");
                if (success) {
                    System.out.println("Successfully added instructor: " + name);
                } else {
                    System.out.println("Failed to add instructor: " + name);
                }
            }

            // Verify mapping in fitness_classes (is it by name or by user_id?)
            // If it's by name, and we created users with the same name, we might be good.
            // Let's check fitness_classes schema and data.
            System.out.println("Fitness Classes Mapping:");
            String sqlMapping = "SELECT class_name, instructor FROM fitness_classes";
            try (PreparedStatement pst = conn.prepareStatement(sqlMapping);
                 ResultSet rs = pst.executeQuery()) {
                while(rs.next()) {
                    System.out.println("- " + rs.getString("class_name") + " -> " + rs.getString("instructor"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

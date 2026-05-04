import com.gympulse.service.UserService;
import com.gympulse.model.UserModel;

public class TestReg {
    public static void main(String[] args) {
        System.out.println("Starting test...");
        UserService us = new UserService();
        UserModel u = new UserModel();
        u.setFullName("Test User");
        u.setUserEmail("test@example.com");
        u.setPhone("1234567890");
        u.setUserPassword("Valid@123");
        u.setRole("member");
        u.setStatus("active");
        boolean res = us.registerUser(u);
        System.out.println("Result: " + res);
    }
}

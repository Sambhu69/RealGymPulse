import com.gympulse.util.EncryptionUtil;
import com.gympulse.config.DBConfig;

public class TestEncryption {
    public static void main(String[] args) {
        String pass = "Admin@123";
        String encrypted = EncryptionUtil.encrypt(pass);
        System.out.println("Password: " + pass);
        System.out.println("Encrypted (Java): " + encrypted);
    }
}

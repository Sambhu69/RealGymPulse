package com.gympulse.config;
import com.gympulse.service.EncryptionUtil;

public class TestEncryption {
    public static void main(String[] args) {
        String pass = "Admin@123";
        String encrypted = EncryptionUtil.encrypt(pass);
        System.out.println("Admin@123 -> " + encrypted);
        
        String pass2 = "Admin@1234";
        String encrypted2 = EncryptionUtil.encrypt(pass2);
        System.out.println("Admin@1234 -> " + encrypted2);
    }
}

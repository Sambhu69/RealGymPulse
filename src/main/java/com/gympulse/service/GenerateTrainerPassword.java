package com.gympulse.service;

/**
 * One-time utility to generate the correct AES-encrypted password
 * for seeding trainer accounts into the database.
 */
public class GenerateTrainerPassword {
    public static void main(String[] args) {
        String password = "Admin@1234";
        String encrypted = EncryptionUtil.encrypt(password);
        System.out.println("Encrypted password for '" + password + "': " + encrypted);
        System.out.println();
        System.out.println("-- Run this SQL to fix trainer passwords:");
        System.out.println("UPDATE users SET password = '" + encrypted + "' WHERE email IN ('alex.trainer@gympulse.com', 'sarah.trainer@gympulse.com');");
    }
}

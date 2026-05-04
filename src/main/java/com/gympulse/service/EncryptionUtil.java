package com.gympulse.service;

import com.gympulse.config.DBConfig;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

/**
 * EncryptionUtil provides AES-based encryption and decryption utilities.
 * Uses the secret key defined in DBConfig.
 */
public class EncryptionUtil {

    private static final String ALGORITHM = "AES/ECB/PKCS5Padding";

    /**
     * Internal helper to create a SecretKeySpec from the DBConfig.AES_KEY.
     * Ensures the key is exactly 16 bytes (128 bits) as required by AES.
     * 
     * @return SecretKeySpec for AES
     */
    private static SecretKeySpec getSecretKey() {
        byte[] keyBytes = DBConfig.AES_KEY.getBytes(StandardCharsets.UTF_8);
        keyBytes = Arrays.copyOf(keyBytes, 16); // Pad or truncate to 16 bytes
        return new SecretKeySpec(keyBytes, "AES");
    }

    /**
     * Encrypts a plain text string using AES.
     * 
     * @param plainText The string to encrypt
     * @return Hex-encoded encrypted string, or null on failure
     */
    public static String encrypt(String plainText) {
        if (plainText == null) return null;
        try {
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, getSecretKey());
            byte[] encryptedBytes = cipher.doFinal(plainText.getBytes(StandardCharsets.UTF_8));
            return bytesToHex(encryptedBytes);
        } catch (Exception e) {
            System.err.println("Encryption error: " + e.getMessage());
            return null;
        }
    }

    /**
     * Decrypts a hex-encoded encrypted string using AES.
     * 
     * @param hexEncryptedText The hex string to decrypt
     * @return Decrypted plain text string, or null on failure
     */
    public static String decrypt(String hexEncryptedText) {
        if (hexEncryptedText == null) return null;
        try {
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, getSecretKey());
            byte[] decryptedBytes = cipher.doFinal(hexToBytes(hexEncryptedText));
            return new String(decryptedBytes, StandardCharsets.UTF_8);
        } catch (Exception e) {
            System.err.println("Decryption error: " + e.getMessage());
            return null;
        }
    }

    /**
     * Verifies a plain text password against a stored encrypted value.
     * 
     * @param plainText The candidate password
     * @param storedEncrypted The password currently stored in the DB
     * @return true if they match, false otherwise
     */
    public static boolean verifyPassword(String plainText, String storedEncrypted) {
        if (plainText == null || storedEncrypted == null) return false;
        String encryptedInput = encrypt(plainText);
        return storedEncrypted.equalsIgnoreCase(encryptedInput);
    }

    /** Helper to convert bytes to hex string */
    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    /** Helper to convert hex string to bytes */
    private static byte[] hexToBytes(String s) {
        int len = s.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                                 + Character.digit(s.charAt(i + 1), 16));
        }
        return data;
    }
}

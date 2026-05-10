package com.gympulse.config;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.Statement;

public class RunMigration {
    public static void main(String[] args) {
        String scriptPath = "C:\\GymPulse\\database\\migration_v2.sql";
        try (Connection conn = DBConfig.getConnection();
             Statement stmt = conn.createStatement();
             BufferedReader br = new BufferedReader(new FileReader(scriptPath))) {
             
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().startsWith("--") || line.trim().isEmpty()) {
                    continue;
                }
                sb.append(line);
                if (line.trim().endsWith(";")) {
                    System.out.println("Executing: " + sb.toString());
                    try {
                        stmt.execute(sb.toString());
                    } catch (Exception e) {
                        System.err.println("Error executing statement: " + e.getMessage());
                    }
                    sb.setLength(0); // clear string builder
                }
            }
            System.out.println("Migration completed successfully.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

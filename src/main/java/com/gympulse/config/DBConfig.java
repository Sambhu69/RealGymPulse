package com.gympulse.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Configuration class for database connectivity and security constants.
 * This class handles the JDBC connection setup for the GymPulse application.
 */
public class DBConfig {

    /** Database connection URL: MySQL on localhost, port 3306, database gympulse_db */
    private static final String URL = "jdbc:mysql://localhost:3306/gympulse_db";
    
    /** Database username */
    private static final String USER = "root";
    
    /** Database password (empty string) */
    private static final String PASSWORD = "";

    /** Secret key used for AES encryption within the application */
    public static final String AES_KEY = "gympulse_secret";
    


    /**
     * Establishes and returns a connection to the MySQL database.
     * 
     * @return A Connection object to the gympulse_db database.
     * @throws SQLException If a database access error occurs or the driver is not found.
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found: " + e.getMessage());
            throw new SQLException("MySQL JDBC Driver not found", e);
        } catch (SQLException e) {
            System.err.println("Connection failed! Check your database URL, username, or password.");
            System.err.println("Error: " + e.getMessage());
            throw e;
        }
    }
}

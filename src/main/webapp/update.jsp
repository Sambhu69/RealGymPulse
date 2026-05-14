<%@ page import="java.sql.*" %>
<%@ page import="com.gympulse.config.DBConfig" %>
<%
    try {
        Connection conn = DBConfig.getConnection();
        Statement stmt = conn.createStatement();
        stmt.executeUpdate("ALTER TABLE users MODIFY COLUMN role ENUM('admin', 'member', 'trainer', 'instructor') DEFAULT 'member'");
        out.println("SUCCESS");
        conn.close();
    } catch (Exception e) {
        out.println("ERROR: " + e.getMessage());
    }
%>

-- ============================================================
-- GymPulse Database Schema
-- Run this entire script in phpMyAdmin SQL tab
-- ============================================================

CREATE DATABASE IF NOT EXISTS gympulse_db;
USE gympulse_db;

-- USERS TABLE (admin + members)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'member') DEFAULT 'member',
    status ENUM('active', 'inactive', 'locked') DEFAULT 'active',
    failed_attempts INT DEFAULT 0,
    locked_until DATETIME DEFAULT NULL,
    profile_image VARCHAR(255) DEFAULT 'default.png',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- MEMBERSHIP PLANS TABLE
CREATE TABLE membership_plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_name VARCHAR(100) NOT NULL,
    duration_months INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    status ENUM('active', 'inactive') DEFAULT 'active'
);

-- MEMBER MEMBERSHIPS TABLE
CREATE TABLE memberships (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('active', 'expired', 'cancelled') DEFAULT 'active',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES membership_plans(plan_id)
);

-- FITNESS CLASSES TABLE
CREATE TABLE fitness_classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    instructor VARCHAR(100) NOT NULL,
    schedule_date DATE NOT NULL,
    schedule_time TIME NOT NULL,
    capacity INT NOT NULL,
    enrolled INT DEFAULT 0,
    description TEXT,
    status ENUM('available', 'full', 'cancelled') DEFAULT 'available'
);

-- CLASS BOOKINGS TABLE
CREATE TABLE class_bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    class_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('confirmed', 'cancelled') DEFAULT 'confirmed',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES fitness_classes(class_id) ON DELETE CASCADE
);

-- PAYMENTS TABLE
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    membership_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) DEFAULT 'online',
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (membership_id) REFERENCES memberships(membership_id)
);

-- ============================================================
-- SEED DATA (Admin + Sample plans + classes)
-- Password for admin is: Admin@123 (AES encrypted stored)
-- ============================================================

-- Insert Admin (password = Admin@123, AES encrypted matching Java implementation)
INSERT INTO users (full_name, email, phone, password, role) VALUES 
('System Admin', 'admin@gympulse.com', '9800000000', 
 '8fed551b621f69ffeb4731ba3818b8b2', 'admin');

-- Membership Plans
INSERT INTO membership_plans (plan_name, duration_months, price, description) VALUES
('Basic Monthly', 1, 29.99, 'Access to gym floor and basic equipment'),
('Standard Quarterly', 3, 79.99, 'Gym floor + 2 fitness classes per week'),
('Premium Annual', 12, 299.99, 'Full access including all classes and personal training');

-- Sample Fitness Classes
INSERT INTO fitness_classes (class_name, instructor, schedule_date, schedule_time, capacity, description) VALUES
('Morning Yoga', 'Priya Sharma', '2025-05-10', '07:00:00', 20, 'Relaxing morning yoga for all levels'),
('HIIT Blast', 'Jake Miller', '2025-05-11', '09:00:00', 15, 'High intensity interval training'),
('Zumba Dance', 'Maria Lopez', '2025-05-12', '11:00:00', 25, 'Fun dance fitness class'),
('Strength Training', 'Tom Brady', '2025-05-13', '14:00:00', 10, 'Weight and resistance training fundamentals'),
('Pilates Core', 'Emma Stone', '2025-05-14', '08:00:00', 18, 'Core strengthening pilates session');

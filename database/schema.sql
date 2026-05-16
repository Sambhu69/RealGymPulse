-- ============================================================
-- GymPulse Final Database Schema
-- Consolidates all tables, migrations, and seed data.
-- ============================================================

CREATE DATABASE IF NOT EXISTS gympulse_db;
USE gympulse_db;

-- 1. USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'member', 'trainer', 'instructor') DEFAULT 'member',
    status ENUM('active', 'inactive', 'locked') DEFAULT 'active',
    failed_attempts INT DEFAULT 0,
    locked_until DATETIME DEFAULT NULL,
    profile_image VARCHAR(255) DEFAULT 'default.png',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. TRAINER PROFILES
CREATE TABLE IF NOT EXISTS trainer_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    bio TEXT,
    specializations VARCHAR(255),
    rating DECIMAL(3,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 3. INSTRUCTOR PROFILES
CREATE TABLE IF NOT EXISTS instructor_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    bio TEXT,
    specializations VARCHAR(255),
    rating DECIMAL(3,2) DEFAULT 5.00,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 4. MEMBERSHIP PLANS
CREATE TABLE IF NOT EXISTS membership_plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_name VARCHAR(100) NOT NULL,
    duration_months INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    status ENUM('active', 'inactive') DEFAULT 'active'
);

-- 5. MEMBER MEMBERSHIPS
CREATE TABLE IF NOT EXISTS memberships (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('active', 'expired', 'cancelled') DEFAULT 'active',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES membership_plans(plan_id)
);

-- 6. FITNESS CLASSES
CREATE TABLE IF NOT EXISTS fitness_classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    instructor VARCHAR(100) NOT NULL,
    schedule_date DATE NOT NULL,
    schedule_time TIME NOT NULL,
    capacity INT NOT NULL,
    enrolled INT DEFAULT 0,
    description TEXT,
    status ENUM('available', 'full', 'cancelled', 'in_progress', 'completed') DEFAULT 'available'
);

-- 7. CLASS BOOKINGS
CREATE TABLE IF NOT EXISTS class_bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    class_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('confirmed', 'cancelled') DEFAULT 'confirmed',
    attendance ENUM('present', 'absent') DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES fitness_classes(class_id) ON DELETE CASCADE
);

-- 8. CLASS WAITLIST
CREATE TABLE IF NOT EXISTS class_waitlist (
    waitlist_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    user_id INT NOT NULL,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES fitness_classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_waitlist (class_id, user_id)
);

-- 9. TRAINER SLOTS
CREATE TABLE IF NOT EXISTS trainer_slots (
    slot_id INT AUTO_INCREMENT PRIMARY KEY,
    trainer_id INT NOT NULL,
    slot_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status ENUM('available', 'booked') DEFAULT 'available',
    FOREIGN KEY (trainer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 10. TRAINER BOOKINGS
CREATE TABLE IF NOT EXISTS trainer_bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    trainer_id INT NOT NULL,
    slot_id INT NOT NULL UNIQUE,
    status ENUM('scheduled', 'completed', 'cancelled', 'no-show') DEFAULT 'scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (trainer_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (slot_id) REFERENCES trainer_slots(slot_id) ON DELETE CASCADE
);

-- 11. TRAINER REVIEWS
CREATE TABLE IF NOT EXISTS trainer_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    trainer_id INT NOT NULL,
    rating INT NOT NULL CHECK(rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (trainer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 12. NOTICES (Notice Board & Direct Messages)
CREATE TABLE IF NOT EXISTS notices (
    notice_id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT NOT NULL,
    receiver_id INT NULL,
    title VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    category ENUM('general', 'class_cancellation', 'holiday', 'maintenance', 'event') DEFAULT 'general',
    target_role ENUM('all', 'member', 'trainer', 'instructor') DEFAULT 'all',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 13. NOTIFICATIONS
CREATE TABLE IF NOT EXISTS notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 14. MEMBER PROGRESS
CREATE TABLE IF NOT EXISTS member_progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    weight DECIMAL(5,2),
    reps INT,
    notes TEXT,
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 15. CONTACT QUERIES
CREATE TABLE IF NOT EXISTS contact_queries (
    query_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    status ENUM('unread', 'read', 'resolved') DEFAULT 'unread',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 16. PASSWORD RESET REQUESTS
CREATE TABLE IF NOT EXISTS password_reset_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    status ENUM('pending', 'resolved', 'rejected') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- SEED DATA
-- ============================================================

-- Admin User (password = Admin@1234)
INSERT INTO users (full_name, email, phone, password, role) VALUES 
('System Admin', 'admin@gympulse.com', '9800000000', '8fed551b621f69ffeb4731ba3818b8b2', 'admin');

-- Trainers
INSERT INTO users (full_name, email, phone, password, role) VALUES 
('Alex Johnson', 'alex.trainer@gympulse.com', '9811111111', '8fed551b621f69ffeb4731ba3818b8b2', 'trainer'),
('Sarah Connor', 'sarah.trainer@gympulse.com', '9822222222', '8fed551b621f69ffeb4731ba3818b8b2', 'trainer');

INSERT INTO trainer_profiles (user_id, bio, specializations, rating) VALUES
((SELECT user_id FROM users WHERE email='alex.trainer@gympulse.com'), 'Expert in strength and conditioning.', 'Strength, Bodybuilding', 4.8),
((SELECT user_id FROM users WHERE email='sarah.trainer@gympulse.com'), 'Focus on core and flexibility.', 'Pilates, Yoga', 4.9);

-- Instructors
INSERT INTO users (full_name, email, phone, password, role) VALUES 
('David Miller', 'david.instructor@gympulse.com', '9833333333', '8fed551b621f69ffeb4731ba3818b8b2', 'instructor'),
('Emma Watson', 'emma.instructor@gympulse.com', '9844444444', '8fed551b621f69ffeb4731ba3818b8b2', 'instructor');

INSERT INTO instructor_profiles (user_id, bio, specializations, rating) VALUES
((SELECT user_id FROM users WHERE email='david.instructor@gympulse.com'), 'Expert in HIIT and Strength Training.', 'HIIT, Strength', 4.9),
((SELECT user_id FROM users WHERE email='emma.instructor@gympulse.com'), 'Yoga and Pilates specialist with 10 years experience.', 'Yoga, Pilates', 5.0);

-- Membership Plans
INSERT INTO membership_plans (plan_name, duration_months, price, description) VALUES
('Basic Monthly', 1, 29.99, 'Access to gym floor and basic equipment'),
('Standard Quarterly', 3, 79.99, 'Gym floor + 2 fitness classes per week'),
('Premium Annual', 12, 299.99, 'Full access including all classes and personal training');

-- Sample Fitness Classes
INSERT INTO fitness_classes (class_name, instructor, schedule_date, schedule_time, capacity, description) VALUES
('Morning Yoga', 'Priya Sharma', '2026-06-10', '07:00:00', 20, 'Relaxing morning yoga for all levels'),
('HIIT Blast', 'Jake Miller', '2026-06-11', '09:00:00', 15, 'High intensity interval training'),
('Zumba Dance', 'Maria Lopez', '2026-06-12', '11:00:00', 25, 'Fun dance fitness class'),
('Strength Training', 'Tom Brady', '2026-06-13', '14:00:00', 10, 'Weight and resistance training fundamentals'),
('Pilates Core', 'Emma Stone', '2026-06-14', '08:00:00', 18, 'Core strengthening pilates session');

-- Trainer Slots
INSERT INTO trainer_slots (trainer_id, slot_date, start_time, end_time) VALUES
((SELECT user_id FROM users WHERE email='alex.trainer@gympulse.com'), CURRENT_DATE + INTERVAL 1 DAY, '10:00:00', '11:00:00'),
((SELECT user_id FROM users WHERE email='alex.trainer@gympulse.com'), CURRENT_DATE + INTERVAL 1 DAY, '11:00:00', '12:00:00'),
((SELECT user_id FROM users WHERE email='sarah.trainer@gympulse.com'), CURRENT_DATE + INTERVAL 2 DAY, '09:00:00', '10:00:00');

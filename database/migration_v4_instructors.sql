-- Migration v4 - Adding Instructor Profiles
USE gympulse_db;

-- Update users role to include 'instructor'
ALTER TABLE users MODIFY COLUMN role ENUM('admin', 'member', 'trainer', 'instructor') DEFAULT 'member';

-- Instructor Profiles
CREATE TABLE IF NOT EXISTS instructor_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    bio TEXT,
    specializations VARCHAR(255),
    rating DECIMAL(3,2) DEFAULT 5.00,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Seed Data for Instructors
INSERT INTO users (full_name, email, phone, password, role) VALUES 
('David Miller', 'david.instructor@gympulse.com', '9833333333', '8fed551b621f69ffeb4731ba3818b8b2', 'instructor'),
('Emma Watson', 'emma.instructor@gympulse.com', '9844444444', '8fed551b621f69ffeb4731ba3818b8b2', 'instructor');

INSERT INTO instructor_profiles (user_id, bio, specializations, rating) VALUES
((SELECT user_id FROM users WHERE email='david.instructor@gympulse.com'), 'Expert in HIIT and Strength Training.', 'HIIT, Strength', 4.9),
((SELECT user_id FROM users WHERE email='emma.instructor@gympulse.com'), 'Yoga and Pilates specialist with 10 years experience.', 'Yoga, Pilates', 5.0);

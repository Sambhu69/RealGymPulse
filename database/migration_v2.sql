-- Migration v2 - Adding Trainer features, Waitlist, Notifications, etc.

-- Update users role to include 'trainer'
ALTER TABLE users MODIFY COLUMN role ENUM('admin', 'member', 'trainer') DEFAULT 'member';

-- Trainer Profiles
CREATE TABLE IF NOT EXISTS trainer_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    bio TEXT,
    specializations VARCHAR(255),
    rating DECIMAL(3,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Trainer Availability Slots
CREATE TABLE IF NOT EXISTS trainer_slots (
    slot_id INT AUTO_INCREMENT PRIMARY KEY,
    trainer_id INT NOT NULL,
    slot_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status ENUM('available', 'booked') DEFAULT 'available',
    FOREIGN KEY (trainer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Trainer Bookings
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

-- Trainer Reviews
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

-- Class Waitlist
CREATE TABLE IF NOT EXISTS class_waitlist (
    waitlist_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    user_id INT NOT NULL,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES fitness_classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_waitlist (class_id, user_id)
);

-- Add attendance to class_bookings
ALTER TABLE class_bookings ADD COLUMN attendance ENUM('present', 'absent') DEFAULT NULL;

-- Notifications
CREATE TABLE IF NOT EXISTS notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Member Progress
CREATE TABLE IF NOT EXISTS member_progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    weight DECIMAL(5,2),
    reps INT,
    notes TEXT,
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Announcements
CREATE TABLE IF NOT EXISTS announcements (
    announcement_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seed Data for Trainers
INSERT INTO users (full_name, email, phone, password, role) VALUES 
('Alex Johnson', 'alex.trainer@gympulse.com', '9811111111', '8fed551b621f69ffeb4731ba3818b8b2', 'trainer'),
('Sarah Connor', 'sarah.trainer@gympulse.com', '9822222222', '8fed551b621f69ffeb4731ba3818b8b2', 'trainer');

INSERT INTO trainer_profiles (user_id, bio, specializations, rating) VALUES
((SELECT user_id FROM users WHERE email='alex.trainer@gympulse.com'), 'Expert in strength and conditioning.', 'Strength, Bodybuilding', 4.8),
((SELECT user_id FROM users WHERE email='sarah.trainer@gympulse.com'), 'Focus on core and flexibility.', 'Pilates, Yoga', 4.9);

-- Seed Data for Trainer Slots
INSERT INTO trainer_slots (trainer_id, slot_date, start_time, end_time) VALUES
((SELECT user_id FROM users WHERE email='alex.trainer@gympulse.com'), CURRENT_DATE + INTERVAL 1 DAY, '10:00:00', '11:00:00'),
((SELECT user_id FROM users WHERE email='alex.trainer@gympulse.com'), CURRENT_DATE + INTERVAL 1 DAY, '11:00:00', '12:00:00'),
((SELECT user_id FROM users WHERE email='sarah.trainer@gympulse.com'), CURRENT_DATE + INTERVAL 2 DAY, '09:00:00', '10:00:00');

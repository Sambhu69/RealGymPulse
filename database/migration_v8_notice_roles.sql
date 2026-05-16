USE gympulse_db;

ALTER TABLE notices 
ADD COLUMN target_role ENUM('all', 'member', 'trainer', 'instructor') DEFAULT 'all';

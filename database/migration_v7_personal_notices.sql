USE gympulse_db;

ALTER TABLE notices 
ADD COLUMN receiver_id INT NULL, 
ADD FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE;

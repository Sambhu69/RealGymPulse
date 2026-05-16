-- Migration v5 - Fixing fitness_classes status enum
USE gympulse_db;

-- Update fitness_classes status enum to support in_progress and completed
ALTER TABLE fitness_classes MODIFY COLUMN status ENUM('available', 'full', 'cancelled', 'in_progress', 'completed') DEFAULT 'available';

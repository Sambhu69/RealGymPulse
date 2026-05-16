$mysqlPath = "C:\GymPulse\tooling\mysql-8.0.36-winx64\bin\mysql.exe"
cmd.exe /c "$mysqlPath -u root gympulse_db < C:\GymPulse\database\migration_v4_password_resets.sql"

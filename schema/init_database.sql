-- Initialize the database for cellphone repair service
DROP TABLE IF EXISTS cellphone.technician_device_t;
DROP TABLE IF EXISTS cellphone.device_t;
DROP TABLE IF EXISTS cellphone.technician_t;
DROP TABLE IF EXISTS cellphone.service_t;
DROP TABLE IF EXISTS cellphone.client_t;

-- Create a database for cellphone repair service
CREATE DATABASE IF NOT EXISTS cellphone;
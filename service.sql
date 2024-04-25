-- SQL script to create a database for a cellphone repair service
drop table cellphone.service_t;
drop table cellphone.client_t;
drop table cellphone.device_t;
drop table cellphone.technician_t;

-- Create a client table
CREATE TABLE `cellphone`.`client_t` (
  `Client_ID` INT NOT NULL,
  `First_Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NULL,
  `Phone_Number` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Client_ID`)
);

-- create table service with relartioship to client
CREATE TABLE `cellphone`.`service_t` (
  `Service_ID` INT NOT NULL AUTO_INCREMENT,
  `Client_ID` INT NOT NULL,
  `Part` VARCHAR(45) NULL,
  `Service_Type` VARCHAR(45),
  `Cost` DECIMAL(6, 2),
  CONSTRAINT PRIMARY KEY (`Service_ID`),
  CONSTRAINT FOREIGN KEY (`Client_ID`) REFERENCES client_t(`Client_ID`)
);

-- Create a device table
CREATE TABLE `cellphone`.`device_t` (
  `Serial_Number` INT NOT NULL,
  `Device_Type` VARCHAR(45) NULL,
  PRIMARY KEY (`Serial_Number`)
);

-- Create a technician table with relationship to device table one to many
CREATE TABLE `cellphone`.`technician_t` (
  `Technician_ID` INT NOT NULL,
  `First_Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NULL,
  `Phone_Number` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Technician_ID`)
);

-- Insert data into client table
INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`) VALUES ('1', 'John', 'Doe', '123-456-7890', 'jdoe@email.com');
INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`) VALUES ('2', 'Jane', 'Doe', '123-456-7890', 'janedoe@gmail.come');
INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`) VALUES ('3', 'John', 'Smith', '123-456-7890', 'johnsmith@gmail.com');

-- Insert data into device table
INSERT INTO `cellphone`.`device_t` (`Serial_Number`, `Device_Type`) VALUES ('123456', 'iPhone');
INSERT INTO `cellphone`.`device_t` (`Serial_Number`, `Device_Type`) VALUES ('123457', 'Samsung');
INSERT INTO `cellphone`.`device_t` (`Serial_Number`, `Device_Type`) VALUES ('123458', 'Google Pixel');

-- Insert data into technician table
INSERT INTO `cellphone`.`technician_t` (`Technician_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`) VALUES ('1', 'Anakin', 'Skywalker', '123-456-7890', 'anakin@sith.com');
INSERT INTO `cellphone`.`technician_t` (`Technician_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`) VALUES ('2', 'Obi-Wan', 'Kenobi', '123-456-7890', 'kenobi@jedi.com');

-- Insert data into service table
INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`) VALUES ('1', '1', 'Screen', 'Repair', '100.00');
INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`) VALUES ('2', '2', 'Battery', 'Replace', '50.00');
INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`) VALUES ('3', '3', 'Screen', 'Repair', '100.00');
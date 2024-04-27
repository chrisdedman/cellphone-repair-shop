-- SQL script to create a database for a cellphone repair service
DROP TABLE IF EXISTS cellphone.technician_device_t;
DROP TABLE IF EXISTS cellphone.device_t;
DROP TABLE IF EXISTS cellphone.technician_t;
DROP TABLE IF EXISTS cellphone.service_t;
DROP TABLE IF EXISTS cellphone.client_t;

-- Create a database
CREATE DATABASE IF NOT EXISTS cellphone;

-- Create a client table
CREATE TABLE `cellphone`.`client_t` (
  `Client_ID` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NULL,
  `Phone_Number` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Client_ID`)
);

-- Create table service with relationship to client
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
  `Serial_Number` INT NOT NULL AUTO_INCREMENT,
  `Service_ID` INT NOT NULL,
  `Device_Type` VARCHAR(45) NULL,
  PRIMARY KEY (`Serial_Number`),
  FOREIGN KEY (`Service_ID`) REFERENCES service_t(`Service_ID`)
);

-- Create a technician table with relationship to device table one to many
CREATE TABLE `cellphone`.`technician_t` (
  `Technician_ID` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NULL,
  `Phone_Number` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`Technician_ID`)
);

CREATE TABLE `cellphone`.`technician_device_t` (
  `Technician_ID` INT NOT NULL AUTO_INCREMENT,
  `Serial_Number` INT NOT NULL,
  PRIMARY KEY (`Technician_ID`, `Serial_Number`),
  CONSTRAINT FOREIGN KEY (`Technician_ID`) REFERENCES technician_t(`Technician_ID`),
  CONSTRAINT FOREIGN KEY (`Serial_Number`) REFERENCES device_t(`Serial_Number`)
);

-- Insert data into client table
INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('1', 'John', 'Doe', '123-456-7890', 'jdoe@email.com');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('2', 'Jane', 'Doe', '123-456-7890', 'janedoe@gmail.come');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('3', 'John', 'Smith', '123-456-7890', 'johnsmith@gmail.com');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('4', 'Emily', 'Johnson', '111-222-3333', 'emilyjohnson@example.com');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('5', 'Michael', 'Brown', '444-555-6666', 'michaelbrown@example.com');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('6', 'Sophia', 'Martinez', '777-888-9999', 'sophiamartinez@example.com');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('7', 'Ethan', 'Anderson', '123-456-7890', 'ethananderson@example.com');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('8', 'Olivia', 'Wilson', '987-654-3210', 'oliviawilson@example.com');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('9', 'William', 'Taylor', '555-666-7777', 'williamtaylor@example.com');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('10', 'Amelia', 'Thomas', '222-333-4444', 'ameliathomas@example.com');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('11', 'James', 'Hernandez', '666-777-8888', 'jameshernandez@example.com');

INSERT INTO `cellphone`.`client_t` (`Client_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`)
VALUES ('12', 'Mia', 'Young', '333-444-5555', 'miayoung@example.com');

-- Insert data into technician table
INSERT INTO `cellphone`.`technician_t` (`Technician_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`, `Address`)
VALUES ('1', 'Anakin', 'Skywalker', '123-456-7890', 'anakin@sith.com', '123 Sith Way');

INSERT INTO `cellphone`.`technician_t` (`Technician_ID`, `First_Name`, `Last_Name`, `Phone_Number`, `Email`, `Address`)
VALUES ('2', 'Obi-Wan', 'Kenobi', '123-456-7890', 'kenobi@jedi.com', '123 Jedi Way');

-- Insert data into service table
INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('1', '1', 'Screen', 'Repair', '100.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('2', '2', 'Battery', 'Replace', '50.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('3', '3', 'Screen', 'Repair', '100.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('4', '1', 'Camera', 'Repair', '75.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('5', '2', 'Screen Protector', 'Install', '10.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('6', '4', 'Screen', 'Repair', '120.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('7', '3', 'Charging Port', 'Replace', '30.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('8', '5', 'Headphone Jack', 'Repair', '50.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('9', '6', 'Battery', 'Replace', '45.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('10', '4', 'Back Cover', 'Install', '20.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('11', '2', 'Screen', 'Repair', '120.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('12', '1', 'Charging Port', 'Replace', '30.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('13', '3', 'Headphone Jack', 'Repair', '50.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('14', '9', 'Battery', 'Replace', '45.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('15', '10', 'Back Cover', 'Install', '20.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('16', '11', 'Screen', 'Repair', '120.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('17', '12', 'Charging Port', 'Replace', '30.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('18', '11', 'Headphone Jack', 'Repair', '50.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('19', '11', 'Battery', 'Replace', '45.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('20', '11', 'Back Cover', 'Install', '20.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('21', '4', 'Screen Protector', 'Install', '10.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('22', '5', 'Screen', 'Repair', '120.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('23', '6', 'Charging Port', 'Replace', '30.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('24', '7', 'Headphone Jack', 'Repair', '50.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('25', '8', 'Battery', 'Replace', '45.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('26', '9', 'Back Cover', 'Install', '20.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('27', '10', 'Screen', 'Repair', '120.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('28', '11', 'Charging Port', 'Replace', '30.00');

INSERT INTO `cellphone`.`service_t` (`Service_ID`, `Client_ID`, `Part`, `Service_Type`, `Cost`)
VALUES ('29', '12', 'Headphone Jack', 'Repair', '50.00');

-- Insert data into device table
INSERT INTO `cellphone`.`device_t` (`Serial_Number`, `Service_ID`, `Device_Type`) VALUES ('1', '1', 'iPhone 11');
INSERT INTO `cellphone`.`device_t` (`Serial_Number`, `Service_ID`, `Device_Type`) VALUES ('2', '2', 'Samsung Galaxy S10');
INSERT INTO `cellphone`.`device_t` (`Serial_Number`, `Service_ID`, `Device_Type`) VALUES ('3', '3', 'iPhone 11');
INSERT INTO `cellphone`.`device_t` (`Serial_Number`, `Service_ID`, `Device_Type`) VALUES ('4', '4', 'Samsung Galaxy S10');
INSERT INTO `cellphone`.`device_t` (`Serial_Number`, `Service_ID`, `Device_Type`) VALUES ('5', '5', 'iPhone 15 Pro');

-- Insert data into technician_device table
INSERT INTO `cellphone`.`technician_device_t` (`Technician_ID`, `Serial_Number`) VALUES ('1', '1');
INSERT INTO `cellphone`.`technician_device_t` (`Technician_ID`, `Serial_Number`) VALUES ('1', '2');
INSERT INTO `cellphone`.`technician_device_t` (`Technician_ID`, `Serial_Number`) VALUES ('1', '3');
INSERT INTO `cellphone`.`technician_device_t` (`Technician_ID`, `Serial_Number`) VALUES ('1', '4');
INSERT INTO `cellphone`.`technician_device_t` (`Technician_ID`, `Serial_Number`) VALUES ('1', '5');


-- Demo queries
SELECT * FROM service_t WHERE Client_ID = 11;
SELECT * FROM client_t WHERE Client_ID = 8;

SELECT client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost
  FROM cellphone.client_t
    JOIN cellphone.service_t ON client_t.client_id = service_t.client_id
      GROUP BY client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost
        ORDER BY client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost;

SELECT client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost
  FROM cellphone.client_t
    JOIN cellphone.service_t ON client_t.client_id = service_t.client_id
      WHERE service_t.cost > 100
        GROUP BY client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost
          ORDER BY client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost;

SELECT client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost
  FROM cellphone.client_t
    JOIN cellphone.service_t ON client_t.client_id = service_t.client_id
      WHERE service_t.cost < 100
        GROUP BY client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost
          ORDER BY client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost;

SELECT client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost
  FROM cellphone.client_t
    JOIN cellphone.service_t ON client_t.client_id = service_t.client_id
      WHERE service_t.service_type = 'Repair'
        GROUP BY client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost
          ORDER BY client_t.first_name, client_t.last_name, service_t.service_type, service_t.cost;

SELECT technician_t.first_name, technician_t.last_name, device_t.device_type
  FROM cellphone.technician_t
    JOIN cellphone.technician_device_t ON technician_t.technician_id = technician_device_t.technician_id
      JOIN cellphone.device_t ON technician_device_t.serial_number = device_t.serial_number
        GROUP BY technician_t.first_name, technician_t.last_name, device_t.device_type
          ORDER BY technician_t.first_name, technician_t.last_name, device_t.device_type;
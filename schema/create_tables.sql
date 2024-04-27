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
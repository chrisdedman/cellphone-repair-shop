# Cellphone Repair Shop Database
This is a database for a cellphone repair shop. It is designed to keep track of customers, devices, repairs, and employees. The database is implemented in MySQL. This project was created for my final presentation for my Database Management Systems class at the California States University, Dominguez Hills. The UI was created using JavaSwing.

## Brief Overview
Our cellphone repair shop database manages clients and phone details, service records, and technician information efficiently.

## Business Rules
Our cellphone repair shop database maintains records of clients using a Client ID, their full name, address, and contact method, which may be a phone number or email address. A client must require at least one repair for at least one cellphone to be considered a client at our shop. For each cell phone, we track the unique Serial Number, brand, and model. Additionally, we record details of individual repairs and services, including Service ID, type, cost, and any additional parts needed. Repairs are carried out by one or more technicians, each of whom may work on multiple phones. For each technician, we record their Technician ID, full name, address, phone number, email, and salary.

## Relationships
**Technician (M:1)** - A Technician may repair one or many devices in a given day.

**Device (M:N)** - A Device may have many or one technicians working on repairs based on the technician’s discretion. Furthermore, a device may need many or no repairs. 

**Service (M:N)** - Services may be provided for many devices. Clients may utilize many different repair services for their devices. 

**Client (1:M)** - A Client needs to submit at least one device for repair but may have many devices for repair.

## ER Diagram
![ER Diagram](/assets/ERD.png)

## DEMO
![FULL DATABASE](/assets/full_database.png)
![DATA CLIENT_ID 11](/assets/data_11.png)
![DATA CLIENT_ID 3](/assets/data_3.png)
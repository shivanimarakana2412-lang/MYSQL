/* ================= DATABASE ================= */

CREATE DATABASE Hospital_Management;
-- Hospital_Management નામનો નવો database બનાવે છે

USE Hospital_Management;
-- Hospital_Management database select કરે છે


/* ================= PATIENTS TABLE ================= */

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    registration_date DATE
);
-- Patients ની personal details store કરવા માટે table બનાવે છે

INSERT INTO Patients VALUES
(1,'Amit Sharma','1998-05-10','Male','9876543210','amit@gmail.com','Delhi','2024-01-15'),
(2,'Neha Verma','2000-08-22','Female','9123456789','neha@gmail.com','Mumbai','2024-02-01'),
(3,'Rahul Mehta','1995-12-03','Male','9988776655','rahul@gmail.com','Ahmedabad','2023-11-20');


/* ================= DOCTORS TABLE ================= */

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    specialization VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    available_days VARCHAR(50),
    consultation_fee DECIMAL(10,2),
    years_of_experience INT
);
-- Doctors ની details store કરવા માટે table બનાવે છે

INSERT INTO Doctors VALUES
(1,'Dr. Anil Kumar','Cardiology','9876501234','anil@hospital.com','Mon-Fri',1200,15),
(2,'Dr. Sneha Rao','Dermatology','9123456701','sneha@hospital.com','Tue-Thu',800,8),
(3,'Dr. Rakesh Gupta','Neurology','9988776611','rakesh@hospital.com','Mon-Wed-Fri',1500,20);


/* ================= DEPARTMENTS TABLE ================= */

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100)
);
-- Hospital ના departments store કરવા માટે table

INSERT INTO Departments VALUES
(1,'Cardiology'),
(2,'Dermatology'),
(3,'Neurology');


/* ================= DOCTOR_DEPARTMENT ================= */

CREATE TABLE Doctor_Department (
    doctor_id INT,
    department_id INT,
    PRIMARY KEY (doctor_id, department_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
-- Doctor અને Department વચ્ચે relationship create કરે છે

INSERT INTO Doctor_Department VALUES
(1,1),(2,2),(3,3);


/* ================= APPOINTMENTS TABLE ================= */

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
-- Patients અને Doctors વચ્ચે appointment manage કરે છે

INSERT INTO Appointments VALUES
(1,1,1,'2024-02-15','Completed'),
(2,2,2,'2024-02-16','Completed'),
(3,3,3,'2024-02-17','Cancelled');


/* ================= MEDICAL RECORDS ================= */

CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT,
    prescription TEXT,
    treatment_date DATE,
    admission_date DATE,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
-- Patient ના diagnosis અને treatment details store કરે છે

INSERT INTO Medical_Records VALUES
(1,1,1,'Hypertension','Lisinopril','2024-02-15','2024-02-15','2024-02-18'),
(2,2,2,'Skin Allergy','Cetirizine','2024-02-16','2024-02-16','2024-02-17'),
(3,3,3,'Migraine','Sumatriptan','2024-02-17',NULL,NULL);


/* ================= BILLING TABLE ================= */

CREATE TABLE Billing (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    appointment_id INT,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);
-- Patient billing અને payment details store કરે છે

INSERT INTO Billing VALUES
(1,1,1,1200,'Paid','2024-02-15'),
(2,2,2,800,'Paid','2024-02-16'),
(3,3,3,1500,'Unpaid',NULL);


/* ================= CRUD OPERATIONS ================= */

-- New patient add કરે છે
INSERT INTO Patients (name,dob,gender,phone_number,email,address,registration_date)
VALUES ('Karan Patel','1997-09-09','Male','9345612789','karan@gmail.com','Surat',CURDATE());

-- Patient address update કરે છે
UPDATE Patients SET address='Mumbai' WHERE patient_id=1;

-- 6 મહિના કરતા જુના cancelled appointments delete કરે છે
DELETE FROM Appointments
WHERE status='Cancelled'
AND appointment_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- =====================================
-- 2. WHERE, HAVING, LIMIT
-- =====================================

-- ગયા 1 વર્ષમાં register થયેલા patients શોધે છે
SELECT * 
FROM Patients
WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- સૌથી વધારે payment કરનાર top 5 patients શોધે છે
SELECT patient_id, SUM(amount) AS total_paid
FROM Billing
GROUP BY patient_id
ORDER BY total_paid DESC
LIMIT 5;

-- જે doctors ની consultation fee 1000 કરતા વધારે છે તે બતાવે છે
SELECT * 
FROM Doctors
WHERE consultation_fee > 1000;

-- =====================================
-- 3. AND, OR, NOT
-- =====================================

-- Doctor ID 3 માટે Scheduled status વાળી appointments શોધે છે
SELECT * 
FROM Appointments
WHERE status = 'Scheduled' 
AND doctor_id = 3;

-- Cardiology અથવા Neurology specialization વાળા doctors શોધે છે
SELECT * 
FROM Doctors
WHERE specialization = 'Cardiology' 
OR specialization = 'Neurology';

-- ગયા 1 વર્ષમાં visit ન કરનારા patients શોધે છે
SELECT * 
FROM Patients
WHERE patient_id NOT IN (
    SELECT DISTINCT patient_id 
    FROM Appointments
    WHERE appointment_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);


-- =====================================
-- 4. ORDER BY & GROUP BY
-- =====================================

-- Doctors ને specialization મુજબ sort કરે છે
SELECT * 
FROM Doctors
ORDER BY specialization;

-- દરેક doctor પાસે કેટલા patients આવ્યા છે તે ગણે છે
SELECT doctor_id, COUNT(patient_id) AS total_patients
FROM Appointments
GROUP BY doctor_id;

-- દરેક department મુજબ total revenue calculate કરે છે
SELECT d.department_name, 
       SUM(b.amount) AS total_revenue
FROM Billing b
JOIN Appointments a ON b.appointment_id = a.appointment_id
JOIN Doctor_Department dd ON a.doctor_id = dd.doctor_id
JOIN Departments d ON dd.department_id = d.department_id
GROUP BY d.department_name;


-- =====================================
-- 5. AGGREGATE FUNCTIONS
-- =====================================

-- Hospital દ્વારા collect થયેલું total revenue બતાવે છે
SELECT SUM(amount) AS total_revenue 
FROM Billing;

-- સૌથી વધારે visits વાળો doctor શોધે છે
SELECT doctor_id, COUNT(*) AS visits
FROM Appointments
GROUP BY doctor_id
ORDER BY visits DESC
LIMIT 1;

-- Doctors ની average consultation fee calculate કરે છે
SELECT AVG(consultation_fee) AS avg_fee 
FROM Doctors;

-- =====================================
-- 6. Establish Relationships
-- =====================================

-- Primary Key અને Foreign Key relationships
-- CREATE TABLE સમયે FOREIGN KEY constraints વડે establish કરેલ છે


-- =====================================
-- 7. JOINS
-- =====================================

-- INNER JOIN:
-- જે doctors કોઈ department સાથે mapped છે તે જ records બતાવે છે
SELECT d.name, dept.department_name
FROM Doctors d
INNER JOIN Doctor_Department dd 
    ON d.doctor_id = dd.doctor_id
INNER JOIN Departments dept 
    ON dd.department_id = dept.department_id;

-- LEFT JOIN:
-- Completed appointment ધરાવતા patients બતાવે છે
-- (Appointment complete ન હોય તો record ignore થાય છે)
SELECT p.*
FROM Patients p
LEFT JOIN Appointments a 
    ON p.patient_id = a.patient_id
WHERE a.status = 'Completed';

-- RIGHT JOIN:
-- જે appointments માટે payment થયેલ નથી તે બતાવે છે
SELECT a.*
FROM Billing b
RIGHT JOIN Appointments a 
    ON b.appointment_id = a.appointment_id
WHERE b.invoice_id IS NULL;

-- FULL OUTER JOIN (MySQL workaround):
-- જે patients એ ક્યારેય appointment book નથી કરી
SELECT p.*
FROM Patients p
LEFT JOIN Appointments a 
    ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;


-- =====================================
-- 8. SUBQUERIES
-- =====================================

-- 50 કરતા વધારે patients handle કરનારા doctors શોધે છે
SELECT doctor_id 
FROM Appointments
GROUP BY doctor_id
HAVING COUNT(patient_id) > 50;

-- સૌથી વધારે amount spend કરનાર patient શોધે છે
SELECT patient_id 
FROM Billing
GROUP BY patient_id
ORDER BY SUM(amount) DESC
LIMIT 1;

-- Dermatology department ના doctors ની appointments બતાવે છે
SELECT * 
FROM Appointments
WHERE doctor_id IN (
    SELECT doctor_id 
    FROM Doctors
    WHERE specialization = 'Dermatology'
);


-- =====================================
-- 9. DATE FUNCTIONS
-- =====================================

-- Appointment date માંથી month કાઢીને visits count કરે છે
SELECT MONTH(appointment_date) AS month, 
       COUNT(*) AS visits
FROM Appointments
GROUP BY MONTH(appointment_date);

-- Patient કેટલા દિવસ hospital માં રહ્યો તે calculate કરે છે
SELECT record_id, 
       DATEDIFF(discharge_date, admission_date) AS stay_duration_days
FROM Medical_Records
WHERE discharge_date IS NOT NULL;

-- Treatment date ને readable format માં convert કરે છે
SELECT record_id,
       DATE_FORMAT(treatment_date, '%d-%m-%Y') AS formatted_date
FROM Medical_Records;


-- =====================================
-- 10. STRING FUNCTIONS
-- =====================================

-- Patient name ને uppercase માં convert કરે છે
SELECT UPPER(name) 
FROM Patients;

-- Doctor name માં extra spaces remove કરે છે
SELECT TRIM(name) 
FROM Doctors;

-- Phone number NULL હોય તો 'Not Available' બતાવે છે
SELECT IFNULL(phone_number, 'Not Available') 
FROM Patients;


-- =====================================
-- 11. WINDOW FUNCTIONS
-- =====================================

-- Patients count પ્રમાણે doctors ને rank આપે છે
SELECT doctor_id,
       COUNT(*) AS total_patients,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_no
FROM Appointments
GROUP BY doctor_id;

-- Payment date મુજબ cumulative revenue calculate કરે છે
SELECT payment_date,
       SUM(amount) OVER (ORDER BY payment_date) AS cumulative_revenue
FROM Billing;

-- Appointment date મુજબ running total બતાવે છે
SELECT appointment_date,
       COUNT(*) OVER (ORDER BY appointment_date) AS running_total
FROM Appointments;


-- =====================================
-- 12. CASE EXPRESSIONS
-- =====================================

-- Medical records count મુજબ patient risk level assign કરે છે
SELECT patient_id,
CASE
    WHEN COUNT(record_id) > 5 THEN 'High'
    WHEN COUNT(record_id) BETWEEN 3 AND 5 THEN 'Medium'
    ELSE 'Low'
END AS Patient_Risk_Level
FROM Medical_Records
GROUP BY patient_id;

-- Doctor experience મુજબ category assign કરે છે
SELECT doctor_id,
CASE
    WHEN years_of_experience > 15 THEN 'Senior'
    WHEN years_of_experience BETWEEN 5 AND 15 THEN 'Mid-Level'
    ELSE 'Junior'
END AS Doctor_Level
FROM Doctors;

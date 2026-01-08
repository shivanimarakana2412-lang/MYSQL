-- =====================================
-- Hospital Management System
-- =====================================

CREATE DATABASE Hospital_Management;

USE Hospital_Management;

-- =====================================
-- 1. Patients Table
-- =====================================
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

INSERT INTO Patients (name, dob, gender, phone_number, email, address, registration_date)
VALUES
('Amit Sharma', '1998-05-10', 'Male', '9876543210', 'amit.sharma@gmail.com', 'Delhi', '2024-01-15'),
('Neha Verma', '2000-08-22', 'Female', '9123456789', 'neha.verma@gmail.com', 'Mumbai', '2024-02-01'),
('Rahul Mehta', '1995-12-03', 'Male', '9988776655', 'rahul.mehta@gmail.com', 'Ahmedabad', '2023-11-20'),
('Priya Singh', '2001-04-18', 'Female', '9090909090', 'priya.singh@gmail.com', 'Lucknow', '2024-01-28'),
('Karan Patel', '1997-09-09', 'Male', '9345612789', 'karan.patel@gmail.com', 'Surat', '2023-12-10');

-- =====================================
-- 2. Doctors Table
-- =====================================
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

INSERT INTO Doctors (name, specialization, phone_number, email, available_days, consultation_fee, years_of_experience)
VALUES
('Dr. Anil Kumar', 'Cardiology', '9876501234', 'anil.kumar@hospital.com', 'Mon-Fri', 1200.00, 15),
('Dr. Sneha Rao', 'Dermatology', '9123456701', 'sneha.rao@hospital.com', 'Tue-Thu', 800.00, 8),
('Dr. Rakesh Gupta', 'Neurology', '9988776611', 'rakesh.gupta@hospital.com', 'Mon-Wed-Fri', 1500.00, 20),
('Dr. Pooja Mehta', 'Pediatrics', '9090901234', 'pooja.mehta@hospital.com', 'Mon-Sat', 600.00, 6),
('Dr. Vikram Singh', 'Orthopedics', '9345612345', 'vikram.singh@hospital.com', 'Wed-Fri', 1000.00, 12);

-- =====================================
-- 3. Departments Table
-- =====================================
CREATE TABLE Departments (
department_id INT PRIMARY KEY AUTO_INCREMENT,
department_name VARCHAR(100)
);

INSERT INTO Departments (department_name)
VALUES
('Cardiology'),
('Dermatology'),
('Neurology'),
('Pediatrics'),
('Orthopedics'),
('General Medicine');

-- =====================================
-- 4. Doctor_Department Mapping
-- =====================================
CREATE TABLE Doctor_Department (
doctor_id INT,
department_id INT,
PRIMARY KEY (doctor_id, department_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Doctor_Department (doctor_id, department_id)
VALUES
(1, 1),  
(2, 2), 
(3, 3), 
(4, 4),  
(5, 5); 

-- =====================================
-- 5. Appointments Table
-- =====================================
CREATE TABLE Appointments (
appointment_id INT PRIMARY KEY AUTO_INCREMENT,
patient_id INT,
doctor_id INT,
appointment_date DATE,
status VARCHAR(20),
FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

INSERT INTO Appointments
(patient_id, doctor_id, appointment_date, status)
VALUES
(1, 1, '2024-02-15', 'Completed'),
(2, 2, '2024-02-16', 'Completed'),
(3, 3, '2024-02-17', 'Cancelled'),
(4, 4, '2024-02-18', 'Scheduled'),
(5, 5, '2023-08-10', 'Cancelled'),
(1, 3, '2023-06-05', 'Cancelled'),
(2, 1, '2023-05-12', 'Completed');

-- =====================================
-- 6. Medical Records Table
-- =====================================
CREATE TABLE Medical_Records (
record_id INT PRIMARY KEY AUTO_INCREMENT,
patient_id INT,
doctor_id INT,
diagnosis TEXT,
prescription TEXT,
treatment_date DATE,
admission_date DATE, 
discharge_date DATE ,
FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

INSERT INTO Medical_Records (patient_id, doctor_id, diagnosis, prescription, treatment_date, admission_date, discharge_date)
VALUES
(1, 1, 'Hypertension', 'Lisinopril', '2024-02-15', '2024-02-15', '2024-02-18'),
(2, 2, 'Skin Allergy', 'Cetirizine', '2024-02-16', '2024-02-16', '2024-02-17'),
(3, 3, 'Migraine', 'Sumatriptan', '2024-02-17', NULL, NULL),
(4, 4, 'Fever', 'Paracetamol', '2024-02-18', NULL, NULL),
(1, 3, 'Eczema', 'Hydrocortisone', '2023-01-10', '2023-01-10', '2023-01-10');

-- =====================================
-- 7. Billing Table
-- =====================================
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

INSERT INTO Billing (patient_id, appointment_id, amount, payment_status, payment_date)
VALUES
(1, 1, 1200.00, 'Paid', '2024-02-15'),
(2, 2, 800.00, 'Paid', '2024-02-16'),
(3, 3, 1500.00, 'Unpaid', NULL),
(4, 4, 600.00, 'Paid', '2024-02-18'),
(5, 5, 1000.00, 'Unpaid', NULL),
(1, 7, 1500.00, 'Paid', '2023-05-12');

-- =====================================
-- 1. CRUD OPERATIONS
-- =====================================

-- Insert
INSERT INTO Patients (name, dob, gender, phone_number, email, address, registration_date)
VALUES ('Amit Sharma', '1998-05-10', 'Male', '9876543210', 'amit@gmail.com', 'Delhi', CURDATE());

-- Update
UPDATE Patients
SET address = 'Mumbai'
WHERE patient_id = 1;

-- Delete
DELETE FROM Appointments
WHERE status = 'Cancelled'
AND appointment_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- =====================================
-- 2. WHERE, HAVING, LIMIT
-- =====================================

-- Patients registered in last year
SELECT * FROM Patients
WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Top 5 highest paying patients
SELECT patient_id, SUM(amount) AS total_paid
FROM Billing
GROUP BY patient_id
ORDER BY total_paid DESC
LIMIT 5;

-- Doctors charging more than 1000
SELECT * FROM Doctors
WHERE consultation_fee > 1000;

-- =====================================
-- 3. AND, OR, NOT
-- =====================================

-- Scheduled appointments for Doctor ID 3
SELECT * FROM Appointments
WHERE status = 'Scheduled' AND doctor_id = 3;

-- Doctors in Cardiology OR Neurology
SELECT * FROM Doctors
WHERE specialization = 'Cardiology' OR specialization = 'Neurology';

-- Patients who have NOT visited in the past year
SELECT * FROM Patients
WHERE patient_id NOT IN (
    SELECT DISTINCT patient_id FROM Appointments
    WHERE appointment_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);

-- =====================================
-- 4. ORDER BY & GROUP BY
-- =====================================

-- Doctors sorted by specialization
SELECT * FROM Doctors
ORDER BY specialization;

-- Number of patients assigned to each doctor
SELECT doctor_id, COUNT(patient_id) AS total_patients
FROM Appointments
GROUP BY doctor_id;

-- Total revenue per department
SELECT d.department_name, SUM(b.amount) AS total_revenue
FROM Billing b
JOIN Appointments a ON b.appointment_id = a.appointment_id
JOIN Doctor_Department dd ON a.doctor_id = dd.doctor_id
JOIN Departments d ON dd.department_id = d.department_id
GROUP BY d.department_name;

-- =====================================
-- 5. AGGREGATE FUNCTIONS
-- =====================================

-- Total Revenue Collected
SELECT SUM(amount) AS total_revenue FROM Billing;

-- Most visited doctor
SELECT doctor_id, COUNT(*) AS visits
FROM Appointments
GROUP BY doctor_id
ORDER BY visits DESC
LIMIT 1;

-- Averege cousulatation fee
SELECT AVG(consultation_fee) AS avg_fee 
FROM Doctors;

-- =====================================
-- 6. Establish Relationships
-- =====================================

-- (This was handled in the CREATE TABLE constraints using FOREIGN KEY)

-- =====================================
-- 7. JOINS
-- =====================================

-- INNER JOIN: Doctors and Departments
SELECT d.name, dept.department_name
FROM Doctors d
INNER JOIN Doctor_Department dd ON d.doctor_id = dd.doctor_id
INNER JOIN Departments dept ON dd.department_id = dept.department_id;

-- LEFT JOIN: All patients who completed appointments
SELECT p.*
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
WHERE a.status = 'Completed';

-- RIGHT JOIN: Appointments with no payments
SELECT a.*
FROM Billing b
RIGHT JOIN Appointments a ON b.appointment_id = a.appointment_id
WHERE b.invoice_id IS NULL;

-- FULL OUTER JOIN: Patients never booked 
SELECT p.*
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;

-- =====================================
-- 8. SUBQUERIES
-- =====================================

-- Doctors handling more than 50 patients
SELECT doctor_id FROM Appointments
GROUP BY doctor_id
HAVING COUNT(patient_id) > 50;

-- Patient who spent the most
SELECT patient_id FROM Billing
GROUP BY patient_id
ORDER BY SUM(amount) DESC
LIMIT 1;

-- Appointments for Dermatology
SELECT * FROM Appointments
WHERE doctor_id IN (
    SELECT doctor_id FROM Doctors
    WHERE specialization = 'Dermatology'
);

-- =====================================
-- 9. DATE FUNCTIONS
-- =====================================

-- Extract month
SELECT MONTH(appointment_date) AS month, COUNT(*) AS visits
FROM Appointments
GROUP BY MONTH(appointment_date);

-- Calculate hospital stay duration
SELECT record_id, DATEDIFF(discharge_date, admission_date) as stay_duration_days
FROM Medical_Records
WHERE discharge_date IS NOT NULL;

-- Format Date
SELECT record_id,DATE_FORMAT(treatment_date, '%d-%m-%Y') as formatted_date 
FROM Medical_Records;

-- =====================================
-- 10.STRING FUNCTIONS
-- =====================================

-- UPPER CASE
SELECT UPPER(name) FROM Patients;

-- TRIMMING
SELECT TRIM(name) FROM Doctors;

-- REPLACE
SELECT IFNULL(phone_number, 'Not Available') FROM Patients;

-- =====================================
-- 11. WINDOW FUNCTIONS
-- =====================================

-- Rank doctors by number of patients
SELECT doctor_id,
COUNT(*) AS total_patients,
RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_no
FROM Appointments
GROUP BY doctor_id;

-- Cumulative Revenue per month
SELECT
payment_date,
SUM(amount) OVER (ORDER BY payment_date) AS cumulative_revenue
FROM Billing;

-- Running total of appointments
SELECT
appointment_date,
COUNT(*) OVER (ORDER BY appointment_date) AS running_total
FROM Appointments;

-- =====================================
-- 12. CASE EXPRESSIONS
-- =====================================

-- Patient Risk Level
SELECT patient_id,
CASE
    WHEN COUNT(record_id) > 5 THEN 'High'
    WHEN COUNT(record_id) BETWEEN 3 AND 5 THEN 'Medium'
    ELSE 'Low'
END AS Patient_Risk_Level
FROM Medical_Records
GROUP BY patient_id;

-- Categorize Doctors
SELECT doctor_id,
CASE
    WHEN years_of_experience > 15 THEN 'Senior'
    WHEN years_of_experience BETWEEN 5 AND 15 THEN 'Mid-Level'
    ELSE 'Junior'
END AS Doctor_Level
FROM Doctors;

-- CREATE SAMPLE DATABASE

CREATE DATABASE TBLS;

USE TBLS ;

-- Create a sample table
CREATE TABLE Employees (
	EmpID INT PRIMARY KEY ,
	NAME VARCHAR (100),
	Salary DECIMAL (10,2),
	Department VARCHAR(50),
	JoiningDate DATE
);

-- Insert a single record

INSERT INTO Employees (EmpID , NAME , Salary , Department , JoiningDate)
VALUES (1,'SHIVANI' , '50000.00' , 'HR' , '2025-05-01');

-- Insert multiple record

INSERT INTO Employees (EmpID , NAME , Salary , Department , JoiningDate )
VALUES 
(2 , 'VISHVA' , '60000.41' , 'Cash' , '2025-05-02'),
(3 , 'MANAV' , '61000.41' , 'Fincance' , '2025-05-03'),
(4 , 'KHUSHI' , '50000.41' , 'Fincance' , '2025-05-04'),
(5 , 'KRISH' , '500000.41' , 'HR' , '2025-05-10');




-- read data

-- read all data
select * from Employees;

-- Select specific columns
SELECT Name, Salary FROM Employees;

-- Filter records using WHERE clause
select * from Employees WHERE Salary > 55000 ;




-- update data 

update Employees 
set Salary = 65000.32
WHERE EmpID = 5; 

select * from Employees;




-- DELETE data

-- Delete a specific record
DELETE FROM Employees WHERE EmpID = 3;

-- Delete all records from the table
DROP TABLE Employees;



select * from Employees;

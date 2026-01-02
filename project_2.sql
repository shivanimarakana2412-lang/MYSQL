CREATE DATABASE PROJECT_2;

USE PROJECT_2;

CREATE TABLE CUSTOMERS(
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(100),
LastName VARCHAR(50),
Email varchar(150),
RegistrationDate DATE
);

INSERT INTO CUSTOMERS (CustomerID, FirstName, LastName, Email, RegistrationDate)
VALUES 
(1, 'Ravi', 'Kumar', 'ravi.kumar@email.com', '2022-03-15'),
(2, 'Meera', 'Patel', 'meera.patel@email.com', '2021-11-02'),
(3, 'Arjun', 'Singh', 'arjun.s@corp.com', '2020-05-19'),
(4, 'Divya', 'Desai', 'divya.desai@webmail.org', '2023-01-10'),
(5, 'Kabir', 'Joshi', 'kjoshi88@email.com', '2022-11-25'),
(6, 'Riya', 'Kapoor', 'riya.k@techsol.net', '2019-08-14'),
(7, 'Sanjay', 'Mehta', 's.mehta@email.com', '2023-04-30'),
(8, 'Ishaan', 'Reddy', 'ishaan.reddy@studio.io', '2021-02-05'),
(9, 'Aditi', 'Sharma', 'aditi.sharma@email.com', '2022-07-22'),
(10, 'Aryan', 'Khanna', 'a.khanna@creative.com', '2023-06-12');

CREATE TABLE ORDERS(
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
TotalAmount DECIMAL(10,2),
FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID)
);

INSERT INTO ORDERS (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES 
(101, 1, '2022-04-10', 250.00),   
(102, 2, '2021-12-05', 120.50),   
(103, 1, '2022-05-22', 450.75),  
(104, 3, '2021-06-15', 89.99),
(105, 5, '2022-12-01', 300.00),
(106, 2, '2022-01-20', 55.25),  
(107, 4, '2023-02-14', 150.00),
(108, 6, '2020-09-10', 499.99),
(109, 10, '2023-01-05', 75.00),   
(110, 8, '2021-03-30', 210.20);

CREATE TABLE EMPLOYEES(
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(100),
LastName VARCHAR(100),
Department VARCHAR(150),
HireDate DATE,
Salary DECIMAL(10,2)
);

INSERT INTO EMPLOYEES (EmployeeID, FirstName, LastName, Department, HireDate, Salary)
VALUES 
(201, 'Aarav', 'Patel', 'Sales', '2019-06-15', 65000.00),
(202, 'Rohan', 'Sharma', 'IT', '2018-03-22', 85000.00),
(203, 'Priya', 'Singh', 'HR', '2020-09-10', 58000.00),
(204, 'Vikram', 'Malhotra', 'Finance', '2017-11-05', 72000.00),
(205, 'Anjali', 'Gupta', 'Sales', '2021-02-14', 62000.00),
(206, 'Sneha', 'Reddy', 'IT', '2022-07-01', 82000.00),
(207, 'Amit', 'Kumar', 'Sales', '2019-12-30', 67000.00),
(208, 'Kavita', 'Iyer', 'Marketing', '2021-05-18', 60000.00),
(209, 'Rajesh', 'Verma', 'Finance', '2016-08-20', 75000.00),
(210, 'Neha', 'Joshi', 'HR', '2023-01-10', 55000.00);
 
 
/*=================== JOINS ===================*/


-- 1. INNER JOIN
SELECT CUSTOMERS.FirstName , CUSTOMERS.LastName , ORDERS.OrderID , ORDERS.TotalAmount FROM CUSTOMERS
INNER JOIN ORDERS ON
CUSTOMERS.CustomerID = ORDERS.CustomerID;

-- 2. LEFT JOIN
SELECT CUSTOMERS.FirstName, CUSTOMERS.LastName, ORDERS.OrderID, ORDERS.TotalAmount FROM CUSTOMERS
LEFT JOIN ORDERS ON 
CUSTOMERS.CustomerID = ORDERS.CustomerID;

-- 3. RIGHT JOIN
SELECT CUSTOMERS.FirstName, CUSTOMERS.LastName, ORDERS.OrderID, ORDERS.TotalAmount FROM CUSTOMERS
RIGHT JOIN ORDERS ON 
CUSTOMERS.CustomerID = ORDERS.CustomerID;

-- 4. FULL OUTER JOIN
SELECT CUSTOMERS.FirstName, CUSTOMERS.LastName, ORDERS.OrderID, ORDERS.TotalAmount FROM CUSTOMERS
LEFT JOIN ORDERS ON 
CUSTOMERS.CustomerID = ORDERS.CustomerID
UNION
SELECT CUSTOMERS.FirstName, CUSTOMERS.LastName, ORDERS.OrderID, ORDERS.TotalAmount FROM CUSTOMERS
RIGHT JOIN ORDERS ON 
CUSTOMERS.CustomerID = ORDERS.CustomerID;


/*=================== SUB QUERIES ===================*/


-- 5.SUBQUERY - HIGH VALUE ORDERS
SELECT * FROM ORDERS
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM ORDERS);

-- 6.SUBQUERY - HIGH SALARY EMPLOYEES
SELECT FirstName, LastName, Salary  
FROM EMPLOYEES
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEES);


/*=================== DATE FUNCTION ===================*/


-- 7. EXTRACT YEAR AND MONTH 
SELECT OrderID , OrderDate , YEAR(OrderDate) AS OrderYear ,
MONTH (OrderDate) AS OrderMonth
FROM ORDERS;

-- 8. DATE DIFFERENCE
SELECT OrderID , OrderDate , DATEDIFF(CURRENT_DATE, OrderDate) AS Days_Since_Order 
FROM ORDERS;

-- 9. FORMAT DATE
SELECT OrderID , DATE_FORMAT(OrderDate , '%d-%m-%Y') AS FormattedDate
FROM ORDERS;


/*=================== STRING FUNCTION ===================*/


-- 10.CONCATENATE FULL NAME
SELECT CONCAT(FirstName , ' ' , LastName) AS FullName
FROM CUSTOMERS;

-- 11.REPLACE STRING
SELECT FirstName, REPLACE(FirstName, 'Ravi', 'Ravindra') AS UpdatedName 
FROM CUSTOMERS;

-- 12. UPPER AND LOWER CASE
SELECT 
   FirstName ,
   LastName ,
   UPPER(FirstName) AS FirstName_Upper, 
   LOWER(LastName) AS LastName_Lower 
FROM CUSTOMERS;

-- 13. TRIM SPACES
SELECT 
   Email ,
   TRIM(Email) AS CleanEmail
FROM CUSTOMERS;


/*=================== WINDOW FUNCTION ===================*/


-- 14. RUNNING TOTAL
SELECT OrderID , OrderDate , TotalAmount ,
SUM(TotalAmount) OVER(ORDER BY OrderID ASC) AS RunningTotal
FROM ORDERS;

-- 15. RANK ORDERS
SELECT OrderID , TotalAmount ,
RANK() OVER(ORDER BY TotalAmount DESC) AS RankValue
FROM ORDERS;

/*=================== CASE STATMENT ===================*/


-- 16. ASSIGN DISCOUNT(CASE STATEMENT)
SELECT 
  OrderID , 
  TotalAmount ,
  CASE 
      WHEN TotalAmount BETWEEN 101 AND 300 THEN '5 % OFF'
      WHEN TotalAmount > 400 THEN '10 % OFF'
      ELSE 'NO DISCOUNT'
   END AS DiscoundApplied
FROM ORDERS;
	
-- 17. CATEGORIZE SALARIES
SELECT FirstName , LastName , Salary ,
CASE
   WHEN Salary > 75000 THEN 'HIGH'
   WHEN Salary BETWEEN 60000 AND 75000 THEN 'MEDIUM'
   ELSE 'LOW'
   END AS SalaryCategory
FROM EMPLOYEES;

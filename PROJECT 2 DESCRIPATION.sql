/* ================= DATABASE ================= */

CREATE DATABASE PROJECT_2;
-- PROJECT_2 નામનો નવો database બનાવે છે

USE PROJECT_2;
-- PROJECT_2 database ને select કરે છે


/* ================= CUSTOMERS TABLE ================= */

CREATE TABLE CUSTOMERS(
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(50),
    Email VARCHAR(150),
    RegistrationDate DATE
);
-- Customers ની માહિતી સાચવવા માટે table બનાવે છે

INSERT INTO CUSTOMERS VALUES
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
-- Customers table માં data insert કરે છે


/* ================= ORDERS TABLE ================= */

CREATE TABLE ORDERS(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID)
);
-- Orders ની માહિતી store કરવા માટે table બનાવે છે

INSERT INTO ORDERS VALUES
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
-- Orders table માં data insert કરે છે


/* ================= EMPLOYEES TABLE ================= */

CREATE TABLE EMPLOYEES(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Department VARCHAR(150),
    HireDate DATE,
    Salary DECIMAL(10,2)
);
-- Employees ની માહિતી માટે table બનાવે છે

INSERT INTO EMPLOYEES VALUES
(201, 'Aarav', 'Patel', 'Sales', '2019-06-15', 65000),
(202, 'Rohan', 'Sharma', 'IT', '2018-03-22', 85000),
(203, 'Priya', 'Singh', 'HR', '2020-09-10', 58000),
(204, 'Vikram', 'Malhotra', 'Finance', '2017-11-05', 72000),
(205, 'Anjali', 'Gupta', 'Sales', '2021-02-14', 62000),
(206, 'Sneha', 'Reddy', 'IT', '2022-07-01', 82000),
(207, 'Amit', 'Kumar', 'Sales', '2019-12-30', 67000),
(208, 'Kavita', 'Iyer', 'Marketing', '2021-05-18', 60000),
(209, 'Rajesh', 'Verma', 'Finance', '2016-08-20', 75000),
(210, 'Neha', 'Joshi', 'HR', '2023-01-10', 55000);
-- Employees table માં data insert કરે છે


/* ================= JOINS ================= */

-- INNER JOIN: જે customers ના orders છે તે જ બતાવે છે
SELECT C.FirstName, C.LastName, O.OrderID, O.TotalAmount
FROM CUSTOMERS C
INNER JOIN ORDERS O ON C.CustomerID = O.CustomerID;

-- LEFT JOIN: બધા customers બતાવે છે
SELECT C.FirstName, C.LastName, O.OrderID, O.TotalAmount
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON C.CustomerID = O.CustomerID;

-- RIGHT JOIN: બધા orders બતાવે છે
SELECT C.FirstName, C.LastName, O.OrderID, O.TotalAmount
FROM CUSTOMERS C
RIGHT JOIN ORDERS O ON C.CustomerID = O.CustomerID;

-- FULL OUTER JOIN: બંને table ના બધા records
SELECT C.FirstName, C.LastName, O.OrderID, O.TotalAmount
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON C.CustomerID = O.CustomerID
UNION
SELECT C.FirstName, C.LastName, O.OrderID, O.TotalAmount
FROM CUSTOMERS C
RIGHT JOIN ORDERS O ON C.CustomerID = O.CustomerID;


/* ================= SUBQUERIES ================= */

-- Average કરતા વધારે amount વાળા orders
SELECT *
FROM ORDERS
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM ORDERS);

-- Average કરતા વધારે salary વાળા employees
SELECT FirstName, LastName, Salary
FROM EMPLOYEES
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEES);


/* ================= DATE FUNCTIONS ================= */

-- OrderDate માંથી year અને month કાઢે છે
SELECT OrderID, OrderDate, YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth
FROM ORDERS;

-- આજથી કેટલા દિવસ પહેલા order થયો
SELECT OrderID, OrderDate, DATEDIFF(CURRENT_DATE, OrderDate) AS Days_Since_Order
FROM ORDERS;

-- Date ને format કરે છે
SELECT OrderID, DATE_FORMAT(OrderDate, '%d-%m-%Y') AS FormattedDate
FROM ORDERS;


/* ================= STRING FUNCTIONS ================= */

-- FirstName અને LastName જોડે છે
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM CUSTOMERS;

-- Name replace કરે છે
SELECT FirstName, REPLACE(FirstName, 'Ravi', 'Ravindra') AS UpdatedName
FROM CUSTOMERS;

-- Uppercase અને Lowercase
SELECT UPPER(FirstName), LOWER(LastName)
FROM CUSTOMERS;

-- Extra space દૂર કરે છે
SELECT TRIM(Email) AS CleanEmail
FROM CUSTOMERS;


/* ================= ANALYTICAL ================= */

-- Running Total ગણતરી
SELECT OrderID, OrderDate, TotalAmount,
SUM(TotalAmount) OVER (ORDER BY OrderID) AS RunningTotal
FROM ORDERS;

-- Orders ને rank આપે છે
SELECT OrderID, TotalAmount,
RANK() OVER (ORDER BY TotalAmount DESC) AS RankValue
FROM ORDERS;

-- Discount assign કરે છે
SELECT OrderID, TotalAmount,
CASE
    WHEN TotalAmount BETWEEN 101 AND 300 THEN '5% OFF'
    WHEN TotalAmount > 400 THEN '10% OFF'
    ELSE 'NO DISCOUNT'
END AS DiscountApplied
FROM ORDERS;

-- Salary category કરે છે
SELECT FirstName, LastName, Salary,
CASE
    WHEN Salary > 75000 THEN 'HIGH'
    WHEN Salary BETWEEN 60000 AND 75000 THEN 'MEDIUM'
    ELSE 'LOW'
END AS SalaryCategory
FROM EMPLOYEES;

CREATE DATABASE PROJECT1;

USE PROJECT1 ;

DROP TABLE CUSTOMERS;
/*===================================== 1. COUSTOMER TABLE=====================================*/

CREATE TABLE CUSTOMERS (
CustomerID INT PRIMARY KEY ,
Name VARCHAR(50) ,
Email VARCHAR (100) ,
Address VARCHAR (150)
);

-- INSERT INTO CUSTOMERS - 5 COLUMNS 
INSERT INTO Customers (CustomerID, Name, Email, Address) VALUES
(1, 'Alice', 'alice1@gmail.com', 'Mumbai'),
(2, 'Bob', 'bob2@gmail.com', 'Delhi'),
(3, 'Charlie', 'charlie3@gmail.com', 'Pune'),
(4, 'David', 'david4@gmail.com', 'Ahmedabad');


-- RETRIVE COSTUMES DETAILS
SELECT * FROM CUSTOMERS ;

-- UPDATE A CUSTOMER DETAILS
UPDATE CUSTOMERS
SET ADDRESS = 'INDIA'
WHERE CustomerID = 2;

-- DELETE A CUSTOMER
DELETE FROM CUSTOMERS
WHERE CustomerID = 2;

-- DISPLAY ALICE
SELECT * FROM CUSTOMERS
WHERE NAME = 'ALICE';

/*===================================== 2. ORDER TABLE =====================================*/
DROP TABLE ORDERS ;

CREATE TABLE ORDERS(
OrderID INT PRIMARY KEY ,
CustomerID INT ,
OrderDate DATE ,
TotalAmount DECIMAL (10 , 2),
FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS (CustomerID)
);

-- INSERT
INSERT INTO Orders VALUES
(101, 1, '2025-08-01', 2500),
(102, 2, '2025-08-05', 1800),
(103, 1, '2025-08-10', 3200),
(104, 3, '2025-08-15', 1500),
(105, 4, '2025-08-20', 4000);

-- RETRIVE ORDER
SELECT * FROM ORDERS
WHERE CustomerID = 2 ;

-- UPDATE ORDERS
UPDATE Orders 
SET TotalAmount = 2000
WHERE OrderID = 102;

-- DELETE
DELETE FROM ORDERS 
WHERE OrderID = 103;

-- ORDER PLACED IN LAST 30 DAYS
SELECT * FROM Orders
WHERE OrderDate >= '2025-08-20';


-- HIGHEST , LOWEST AND AVERAGE
SELECT 
    MAX(TotalAmount) AS Highest,
    MIN(TotalAmount) AS Lowest,
	AVG(TotalAmount) AS Average
FROM ORDERS;

/*===================================== 3. PRODUCT TABLE =====================================*/

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

-- INSERT
INSERT INTO Products VALUES
(1, 'Laptop', 55000, 10),
(2, 'Mobile', 20000, 15),
(3, 'Headphones', 1500, 0),
(4, 'Keyboard', 800, 20),
(5, 'Mouse', 500, 25);

-- ORDER BY DESC
SELECT * FROM Products
ORDER BY Price DESC;

-- UPDATE
UPDATE Products
SET PRICE = 1000
WHERE ProductID = 5;

-- DELETE
DELETE FROM Products
WHERE ProductID = 3;

-- USE BETWEEN
SELECT * FROM Products
WHERE PRICE BETWEEN 500 AND 2000 ;

-- MAX AND MIN
SELECT 
    MIN(Price) AS Chepest ,
    MAX(Price) AS MostExpensive
FROM Products;

/*===================================== 4. ORDERLIST TABLE =====================================*/

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert
INSERT INTO OrderDetails VALUES
(1, 101, 1, 1, 55000),
(2, 101, 5, 2, 1000),
(3, 102, 2, 1, 18000),
(4, 103, 4, 3, 2400),
(5, 105, 1, 1, 55000);

-- RETRIVE
SELECT * FROM OrderDetails
WHERE OrderID = 101;

-- SUM
SELECT SUM(SubTotal) AS TotalRevenue
FROM OrderDetails;

-- LIMIT 
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalQuantity DESC
LIMIT 3;

-- COUNT
SELECT COUNT(*) AS TimesSold
FROM OrderDetails
WHERE ProductID = 1;






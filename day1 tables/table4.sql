CREATE DATABASE TBLS ;

USE TBLS ;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE ,
    CustomerName VARCHAR(50)
);

INSERT INTO Orders (OrderID, CustomerID, ProductID, Quantity, OrderDate, CustomerName)
VALUES
(1, 201, 301, 2, '2026-07-01', 'Shubham'),
(2, 202, 302, 1, '2026-07-01', 'Dipak'),
(3, 203, 303, 5, '2026-07-02', 'Sapna'),
(4, 204, 304, 3, '2026-07-02', 'Suhani'),
(5, 205, 305, 4, '2026-07-03', 'Kavya'),
(6, 206, 306, 2, '2026-07-03', 'Nax'),
(7, 207, 307, 1, '2026-07-04', 'Dipati'),
(8, 208, 308, 6, '2026-07-04', 'Hitansh'),
(9, 209, 309, 2, '2026-07-05', 'Hasti'),
(10, 210, 310, 3, '2026-07-05', 'Renish'),
(11, 211, 311, 5, '2026-07-06', 'Riya'),
(12, 212, 312, 4, '2026-07-06', 'Karan'),
(13, 213, 313, 1, '2026-07-07', 'Meera'),
(14, 214, 314, 2, '2026-07-07', 'Aarav'),
(15, 215, 315, 3, '2026-07-08', 'Isha'),
(16, 216, 316, 4, '2026-07-08', 'Vivaan'),
(17, 217, 317, 1, '2026-07-09', 'Tara'),
(18, 218, 318, 2, '2026-07-09', 'Rohan'),
(19, 219, 319, 5, '2026-07-10', 'Anika'),
(20, 220, 320, 3, '2026-07-10', 'Dhruv');



-- read 

SELECT * FROM Orders;

SELECT OrderID, CustomerName, ProductID, Quantity, OrderDate FROM Orders;

SELECT OrderID, CustomerName, ProductID
FROM Orders
WHERE CustomerName = 'Shubham';




-- update

UPDATE Orders
SET Quantity = 10
WHERE OrderID = 5;



-- delete

-- for one
DELETE FROM Orders
WHERE OrderID = 20;





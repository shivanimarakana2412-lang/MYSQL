use TBLS ;

CREATE TABLE customer (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    CustomerName VARCHAR(50),
    ProductID INT,
    ProductName VARCHAR(50),
    Quantity INT,
    OrderDate DATE
);

INSERT INTO customer (OrderID, CustomerID, CustomerName, ProductID, ProductName, Quantity, OrderDate)
VALUES
(1, 301, 'Amit', 401, 'Laptop Bag', 2, '2026-08-01'),
(2, 302, 'Neha', 402, 'Mouse Pad', 1, '2026-08-01'),
(3, 303, 'Raj', 403, 'Gaming Mouse', 3, '2026-08-02'),
(4, 304, 'Priya', 404, 'Keyboard Mechanical', 2, '2026-08-02'),
(5, 305, 'Sneha', 405, 'Desk Chair', 1, '2026-08-03'),
(6, 306, 'Vikas', 406, 'Table Lamp', 2, '2026-08-03'),
(7, 307, 'Anjali', 407, 'External HDD', 1, '2026-08-04'),
(8, 308, 'Rohit', 408, 'Smart Speaker', 3, '2026-08-04'),
(9, 309, 'Pooja', 409, 'Wireless Earphones', 2, '2026-08-05'),
(10, 310, 'Kunal', 410, 'Monitor 24inch', 1, '2026-08-05'),
(11, 311, 'Simran', 411, 'Printer Laser', 1, '2026-08-06'),
(12, 312, 'Aditya', 412, 'Tablet Pro', 2, '2026-08-06'),
(13, 313, 'Tanya', 413, 'Smartphone X', 1, '2026-08-07'),
(14, 314, 'Siddharth', 414, 'USB Hub', 2, '2026-08-07'),
(15, 315, 'Riya', 415, 'Webcam HD', 1, '2026-08-08'),
(16, 316, 'Tanmay', 416, 'Power Adapter', 3, '2026-08-08'),
(17, 317, 'Isha', 417, 'Desk Organizer', 2, '2026-08-09'),
(18, 318, 'Dhruv', 418, 'Bluetooth Mouse', 1, '2026-08-09'),
(19, 319, 'Megha', 419, 'Notebook Laptop', 2, '2026-08-10'),
(20, 320, 'Arjun', 420, 'Pen Drive 64GB', 1, '2026-08-10');




-- Read all orders
SELECT * FROM customer;

SELECT OrderID, CustomerName, ProductName, Quantity, OrderDate
FROM customer;





-- update
UPDATE customer
SET Quantity = 5
WHERE OrderID = 8;




-- delete
DELETE FROM Orders
WHERE OrderID = 20;

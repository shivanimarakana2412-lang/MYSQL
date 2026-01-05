CREATE DATABASE WINDOW_FUNCTION;

USE WINDOW_FUNCTION;

CREATE TABLE sales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    salesperson VARCHAR(50),
    region VARCHAR(50),
    revenue INT,
    sale_date DATE
);

INSERT INTO sales (salesperson, region, revenue, sale_date) VALUES
('Alice', 'North', 1000, '2024-02-01'),
('Bob', 'North', 1500, '2024-02-02'),
('Charlie', 'North', 1200, '2024-02-03'),
('David', 'South', 800, '2024-02-01'),
('Emma', 'South', 1300, '2024-02-02'),
('Frank', 'South', 1100, '2024-02-03'),
('Grace', 'East', 900, '2024-02-01'),
('Hank', 'East', 1400, '2024-02-02'),
('Ivy', 'East', 1000, '2024-02-03');

SELECT 
    salesperson, 
    region, 
    revenue, 
    SUM(revenue) OVER () AS total_revenue
FROM sales;
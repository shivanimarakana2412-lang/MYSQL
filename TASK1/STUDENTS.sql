CREATE DATABASE TASK1;

USE TASK1 ;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    marks INT,
    city VARCHAR(50)
);

INSERT INTO Students (student_id, name, age, marks, city) 
VALUES
(1, 'Rahul Sharma', 20, 85, 'Delhi'),
(2, 'Anita Verma', 22, 90, 'Mumbai'),
(3, 'Aman Gupta', 19, 78, 'Pune'),
(4, 'Neha Singh', 21, 88, 'Jaipur'),
(5, 'Rohit Mehta', 23, 92, 'Ahmedabad'),
(6, 'Pooja Patel', 20, 81, 'Surat'),
(7, 'Karan Malhotra', 22, 76, 'Chandigarh'),
(8, 'Sneha Iyer', 21, 89, 'Chennai'),
(9, 'Vikas Yadav', 23, 67, 'Gurgaon'),
(10, 'Ritu Joshi', 19, 91, 'Udaipur'),
(11, 'Arjun Nair', 24, 84, 'Kochi'),
(12, 'Meenal Shah', 20, 88, 'Vadodara'),
(13, 'Saurabh Mishra', 22, 73, 'Bhopal'),
(14, 'Nikita Kulkarni', 21, 95, 'Nagpur'),
(15, 'Aditya Rao', 23, 79, 'Bengaluru');

/*==================================SHOW ALL COLUMNS==================================*/

SELECT * FROM Students ;

/*==================================SHOW NAME AND MARKS COLUMNS==================================*/

SELECT NAME , MARKS FROM Students ;

/*==================================WHERE CLAUSES==================================*/

-- GRATER THAN 70
SELECT * FROM Students WHERE MARKS > 70 ;

-- BELONG TO DELHI
SELECT * FROM Students WHERE CITY = 'DELHI';

/*==================================AND==================================*/

SELECT * FROM Students WHERE CITY = 'DELHI' AND MARKS > 60 ;

/*==================================ORDER BY==================================*/

SELECT * 
FROM Students 
ORDER BY MARKS DESC ;

/*==================================LIMIT==================================*/

SELECT *
FROM Students
ORDER BY marks DESC
LIMIT 5;

/*==================================HAVING==================================*/

SELECT city, COUNT(*) AS student_count
FROM Students
GROUP BY city
HAVING COUNT(*) > 2;


/*==================================AGGREGATE FUNCTION==================================*/	

-- MAX
SELECT MAX(marks) AS MAXIUMUM_MARKS
FROM Students;

-- AVG 
SELECT AVG(marks) AS AVERAGE_MARKS
FROM Students;

-- COUNT
SELECT COUNT(*)  AS TOTAL_MARKS
FROM Students;



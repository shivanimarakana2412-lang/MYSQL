USE TASK1;

CREATE TABLE EMPLOYEES (
EMP_ID INT PRIMARY KEY ,
EMP_NAME VARCHAR(100) ,
SALARY DECIMAL(10,2) , 
DEPARTMENT VARCHAR(100),
JOINING_DATE DATE
);

INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, DEPARTMENT, JOINING_DATE) 
VALUES
(1, 'Amit Sharma', 55000.00, 'HR', '2021-03-15'),
(2, 'Neha Verma', 29000.50, 'IT', '2020-07-22'),
(3, 'Rohit Mehta', 68000.00, 'Finance', '2019-11-10'),
(4, 'Pooja Patel', 60000.75, 'Marketing', '2022-01-05'),
(5, 'Arjun Singh', 82000.00, 'IT', '2018-09-18'),
(6, 'Kavita Rao', 58000.00, 'HR', '2021-06-30'),
(7, 'Suresh Nair', 75000.25, 'Operations', '2019-04-12'),
(8, 'Meenal Shah', 90000.00, 'Finance', '2017-12-01'),
(9, 'Vikas Yadav', 64000.00, 'Sales', '2020-10-08'),
(10, 'Rina Joshi', 30000.00, 'Marketing', '2022-05-20');

-- READ
SELECT * FROM EMPLOYEES;

-- WHERE
SELECT * FROM EMPLOYEES WHERE SALARY < 30000 ;

-- DESENDING
SELECT *
FROM EMPLOYEES 
ORDER BY SALARY DESC;

-- LIMIT
SELECT *
FROM EMPLOYEES 
LIMIT 3;

-- GROUP BY
SELECT department, COUNT(*) AS total_employees
FROM Employees
GROUP BY department;


SELECT department, AVG(salary) AS average_salary
FROM Employees
GROUP BY department;

-- HAVING
SELECT department, AVG(salary) AS average_salary
FROM Employees
GROUP BY department
HAVING AVG(salary) > 40000;

-- AGGREGATE FUNCTION
SELECT MIN(salary) AS minimum_salary
FROM Employees;


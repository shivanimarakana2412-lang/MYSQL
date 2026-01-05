create database constraints;

use constraints;

create table employees(
EmpID INT PRIMARY KEY ,
NAME VARCHAR(100) , 
DEPARTMENT CHAR(150),
AGE INT ,
SALARY DECIMAL(10,2)
);

INSERT INTO employees(EmpID ,NAME, DEPARTMENT, AGE , SALARY )
values
(101, 'Amit Sharma', 'HR', 29, 35000),
(102, 'Neha Verma', 'Finance', 34, 42000),
(103, 'Rahul Mehta', 'IT', 26, 30000),
(104, 'Pooja Singh', 'Marketing', 31, 38000),
(105, 'Rohit Patel', 'Sales', 28, 32000),
(106, 'Sneha Iyer', 'IT', 35, 45000),
(107, 'Arjun Kumar', 'Operations', 40, 50000),
(108, 'Kavita Joshi', 'HR', 27, 36000);

/*============================================SHOW DATA============================================*/
select * from employees;

/*============================================WHERE============================================*/

SELECT * FROM employees WHERE DEPARTMENT = "IT" ;

/*============================================AND / OR / NOT / BETWEEN / IN============================================*/

-- AND
SELECT * FROM employees WHERE DEPARTMENT = "IT" AND SALARY = '30000';

-- OR
SELECT * FROM employees WHERE DEPARTMENT = 'HR' OR SALARY = '30000';

-- BETWWEN
SELECT * FROM employees WHERE SALARY BETWEEN 35000 AND 45000;

-- NOT
SELECT * FROM employees WHERE AGE NOT IN (40 , 23) ;

-- IN
SELECT * FROM employees WHERE AGE IN (28) ;

/*============================================WHERE CLAUSE============================================*/

select * FROM employees WHERE SALARY > 35000;

/*============================================LIMIT CLAUSE============================================*/

select * FROM employees LIMIT 5 ;

/*============================================ORDER BY CLAUSE============================================*/

-- ASENDING
SELECT * FROM employees
ORDER BY SALARY ASC;

-- DESENDING
SELECT * FROM employees
ORDER BY SALARY DESC;

/*============================================AGGREGATE FUNCTIONS============================================*/

-- COUNT
SELECT COUNT(*) FROM employees ;

-- MIN
SELECT MIN(SALARY) FROM employees ;

-- MAX
SELECT MAX(SALARY) FROM employees ;

-- AVG
SELECT AVG(SALARY) FROM employees ;

-- SUM
SELECT SUM(SALARY) FROM employees ;

/*============================================GROUP BY STATMENT============================================*/

-- TOTAL SALARY BY DEPARTMENT
SELECT DEPARTMENT , SUM(SALARY)
FROM employees
GROUP BY DEPARTMENT ;

-- AVERAGE SALARY BY DEPARTMENT
SELECT DEPARTMENT  , AVG(SALARY)
FROM employees
GROUP BY DEPARTMENT ;

/*============================================HAVING CLAUSE============================================*/

-- DEPARTMENT WITH AVG SALARY > 45000
SELECT DEPARTMENT , AVG(SALARY)
FROM employees
GROUP BY DEPARTMENT
HAVING AVG (SALARY) > 45000 ;

/*============================================ALL QUIERS IN ONE============================================*/

SELECT DEPARTMENT,
      COUNT(*) AS TOTAL_EMPLOYEES ,
      AVG(SALARY) AS AVG_SALARY 
FROM employees 
WHERE AGE > 24
GROUP BY DEPARTMENT 
HAVING AVG(SALARY) > 45000
ORDER BY AVG_SALARY DESC 
LIMIT 2 ;




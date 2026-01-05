CREATE DATABASE FINAL_PROJECT;

USE FINAL_PROJECT;

CREATE TABLE STUDENTS (
STUDENT_ID INT PRIMARY KEY,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(50),
EMAIL VARCHAR(100),
BIRTH_DATE DATE,
ENROLLMENT_DATE DATE
);

CREATE TABLE DEPARTMENTS(
DEPARTMENT_ID INT PRIMARY KEY,
DEPARTMENT_NAME VARCHAR(100)
);

CREATE TABLE COURSES(
COURSE_ID INT PRIMARY KEY ,
COURSE_NAME VARCHAR(100),
DEPARTMENT_ID INT ,
CREDITS INT ,
FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID)
);

CREATE TABLE INSTRUCTORS (
INSTRUCTOR_ID INT PRIMARY KEY,
FIRST_NAME VARCHAR(100),
LAST_NAME VARCHAR(50),
EMAIL VARCHAR(100),
DEPARTMENT_ID INT,
SALARY DECIMAL(10,2),
FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID)
);

CREATE TABLE ENROLLMENTS(
ENROLLMENT_ID INT PRIMARY KEY,
STUDENT_ID INT,
COURSE_ID INT,
ENROLLMENT_DATE DATE,
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENTS(STUDENT_ID),
FOREIGN KEY (COURSE_ID) REFERENCES COURSES(COURSE_ID)
);


/* ===================== 1. CRUD OPERATIONS ===================== */


-- CREATE
INSERT INTO STUDENTS (STUDENT_ID, FIRST_NAME, LAST_NAME, EMAIL, BIRTH_DATE, ENROLLMENT_DATE)
VALUES
(1, 'Aarav', 'Patel', 'aarav.patel@example.com', '2003-05-15', '2023-08-01'),
(2, 'Ishita', 'Sharma', 'ishita.sharma@student.net', '2002-11-20', '2022-07-15'),
(3, 'Rohan', 'Verma', 'rohan.v@university.in', '2004-02-10', '2024-08-01'),
(4, 'Priya', 'Reddy', 'priya.reddy@mail.com', '2003-08-22', '2023-08-05'),
(5, 'Aditya', 'Iyer', 'aditya.iyer@webmail.org', '2001-12-05', '2021-09-01'),
(6, 'Zoya', 'Khan', 'zoya.khan@example.in', '2004-04-12', '2024-07-20'),
(7, 'Karthik', 'Nair', 'k.nair@school.edu', '2002-06-30', '2022-08-10'),
(8, 'Sneha', 'Das', 'sneha.das@connect.com', '2003-09-18', '2023-08-02'),
(9, 'Vikram', 'Singh', 'vikram.singh@tech.net', '2001-01-25', '2021-08-15'),
(10, 'Meera', 'Kulkarni', 'meera.k@institute.in', '2002-03-14', '2022-09-01');

INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) 
VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Information Technology'),
(4, 'Marketing'),
(5, 'Sales'),
(6, 'Operations'),
(7, 'Customer Support'),
(8, 'Mathematical'),
(9, 'Administration'),
(10, 'Quality Assurance');

INSERT INTO COURSES (COURSE_ID, COURSE_NAME, DEPARTMENT_ID, CREDITS) 
VALUES
(101, 'Introduction to Programming', 6, 4),
(102, 'Data Structures', 3, 4),
(103, 'Database Management Systems', 3, 3),
(104, 'Financial Accounting', 2, 3),
(105, 'Marketing Fundamentals', 4, 3),
(106, 'Human Resource Management', 1, 3),
(107, 'Sales Strategy', 5, 2),
(108, 'Operations Management', 6, 3),
(109, 'Customer Relationship Management', 7, 2),
(110, 'Software Testing', 10, 3);

INSERT INTO INSTRUCTORS (INSTRUCTOR_ID, FIRST_NAME, LAST_NAME, EMAIL, DEPARTMENT_ID, SALARY)
VALUES
(1, 'Amit', 'Sharma', 'amit.sharma@college.edu', 1, 75000.00),
(2, 'Neha', 'Verma', 'neha.verma@college.edu', 2, 68000.00),
(3, 'Rahul', 'Mehta', 'rahul.mehta@college.edu', 3, 82000.00),
(4, 'Priya', 'Iyer', 'priya.iyer@college.edu', 4, 60000.00),
(5, 'Suresh', 'Patel', 'suresh.patel@college.edu', 5, 72000.00),
(6, 'Anjali', 'Singh', 'anjali.singh@college.edu', 6, 65000.00),
(7, 'Vikram', 'Rao', 'vikram.rao@college.edu', 7, 78000.00),
(8, 'Kavita', 'Nair', 'kavita.nair@college.edu', 8, 69000.00),
(9, 'Manoj', 'Kulkarni', 'manoj.kulkarni@college.edu', 9, 73000.00),
(10, 'Pooja', 'Desai', 'pooja.desai@college.edu', 10, 62000.00);

INSERT INTO ENROLLMENTS (ENROLLMENT_ID, STUDENT_ID, COURSE_ID, ENROLLMENT_DATE) 
VALUES
(1, 1, 101, '2024-07-01'),
(2, 2, 102, '2024-07-02'),
(3, 3, 103, '2024-07-03'),
(4, 4, 104, '2024-07-03'),
(5, 5, 105, '2024-07-04'),
(6, 6, 106, '2024-07-05'),
(7, 7, 107, '2024-07-06'),
(8, 8, 108, '2024-07-06'),
(9, 9, 109, '2024-07-07'),
(10, 10, 110, '2024-07-08');

-- READ
SELECT * FROM STUDENTS;
SELECT DEPARTMENT_ID FROM DEPARTMENTS;
SELECT FIRST_NAME , LAST_NAME FROM INSTRUCTIONS;
SELECT * FROM ENROLLMENTS WHERE ENROLLMENT_ID = 5 ;

-- UPDATE
UPDATE STUDENTS
SET BIRTH_DATE = '2022-09-02'
WHERE STUDENT_ID = 10;

-- DELETE
DELETE FROM COURSES WHERE COURSE_ID = 10;

/* ===================== 2. STUDENTSS ENROLLED AFTER 2022 ===================== */

SELECT * FROM STUDENTS
WHERE ENROLLMENT_DATE > '2022-12-31';

/* ===================== 3. MATH DEPARTMENT COURSE (LIMIT 5) ===================== */

SELECT C.*
FROM COURSES C
JOIN DEPARTMENTS D ON C.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_NAME = 'Mathematics' 
LIMIT 1;

/* ===================== 4. STUDENTS COUNT PER COURSE (>5) ===================== */

SELECT COURSE_ID, COUNT(STUDENT_ID) AS TOTAL_STUDENTS
FROM ENROLLMENTS
GROUP BY COURSE_ID
HAVING COUNT(STUDENT_ID) > 5;

/* ===================== 5. STUDENTS IN BOTH SQL & DATA STRUCTURES ===================== */

SELECT STUDENT_ID
FROM ENROLLMENTS
WHERE COURSE_ID IN (
    SELECT COURSE_ID FROM COURSES
    WHERE COURSE_NAME IN ('Introduction to SQL','Data Structures')
)
GROUP BY STUDENT_ID
HAVING COUNT(DISTINCT COURSE_ID) = 2;

/* ===================== 6. STUDENTS IN SQL OR DATA STRUCTURES ===================== */

SELECT DISTINCT STUDENT_ID
FROM ENROLLMENTS
WHERE COURSE_ID IN (
    SELECT COURSE_ID FROM COURSES
    WHERE COURSE_NAME IN ('Introduction to SQL','Data Structures')
);

/* ===================== 7. AVERAGE CREDITS ===================== */

SELECT AVG(CREDITS) AS AVG_CREDITS
FROM COURSES;

/* ===================== 8. MAX SALARY (COMPUTER SCIENCE) ===================== */

SELECT MAX(I.SALARY) AS MAX_SALARY
FROM INSTRUCTORS I
JOIN DEPARTMENTS D
ON I.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_NAME = 'Computer Science';

/* ===================== 9. STUDENTS COUNT PER DEPARTMENT ===================== */

SELECT D.DEPARTMENT_NAME, COUNT(E.STUDENT_ID) AS TOTAL_STUDENTS
FROM ENROLLMENTS E
JOIN COURSES C ON E.COURSE_ID = C.COURSE_ID
JOIN DEPARTMENTS D ON C.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME;

/* ===================== 10. INNER JOIN ===================== */

SELECT S.FIRST_NAME, S.LAST_NAME, C.COURSE_NAME FROM STUDENTS S
INNER JOIN ENROLLMENTS E 
ON S.STUDENT_ID = E.STUDENT_ID
INNER JOIN COURSES C 
ON E.COURSE_ID = C.COURSE_ID;

/* ===================== 11. LEFT JOIN ===================== */

SELECT S.FIRST_NAME, S.LAST_NAME, C.COURSE_NAME
FROM STUDENTS S
LEFT JOIN ENROLLMENTS E 
ON S.STUDENT_ID = E.STUDENT_ID
LEFT JOIN COURSES C 
ON E.COURSE_ID = C.COURSE_ID;

/* ===================== 12. SUBQUERY(>10 STUDENTS COURSES) ===================== */

SELECT *
FROM STUDENTS
WHERE STUDENT_ID IN (
    SELECT STUDENT_ID
    FROM ENROLLMENTS
    WHERE COURSE_ID IN (
        SELECT COURSE_ID
        FROM ENROLLMENTS
        GROUP BY COURSE_ID
        HAVING COUNT(STUDENT_ID) > 10
    )
);

/* ===================== 13. Extract year ===================== */

SELECT STUDENT_ID, YEAR(ENROLLMENT_DATE) AS ENROLL_YEAR
FROM STUDENTS;

/* ===================== 14. CONCATE INSTRUCTOR NAME ===================== */

SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS FULL_NAME
FROM INSTRUCTORS;

/* ===================== 15. Running total of students ===================== */

SELECT ENROLLMENT_DATE,
COUNT(STUDENT_ID) AS DAILY_COUNT,
SUM(COUNT(STUDENT_ID)) OVER (ORDER BY ENROLLMENT_DATE) AS RUNNING_TOTAL
FROM ENROLLMENTS
GROUP BY ENROLLMENT_DATE;

/* ===================== 16. SENIOR / JUNIOR ===================== */

SELECT STUDENT_ID, ENROLLMENT_DATE,
CASE
    WHEN ENROLLMENT_DATE <= DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
    THEN 'Senior'
    ELSE 'Junior'
END AS STATUS
FROM STUDENTS;
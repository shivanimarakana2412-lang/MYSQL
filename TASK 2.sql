CREATE DATABASE TASK2 ;

USE TASK2 ;

-- 1. Create Tables

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50),
    dept_id INT,
    marks INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Enrollments (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- 2. Insert Sample Data

-- Departments
INSERT INTO Departments VALUES 
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Literature');

-- Teachers
INSERT INTO Teachers VALUES
(101, 'Dr. Alice Smith', 1),
(102, 'Prof. Bob Jones', 2),
(103, 'Dr. Carol White', 1),
(104, 'Mr. Dave Brown', 3);

-- Students
INSERT INTO Students VALUES
(1, 'John Doe', 20, 'Delhi', 1, 85),
(2, 'Jane Roe', 21, 'Mumbai', 1, 92),
(3, 'Mike Lee', 22, 'Chicago', 2, 78),
(4, 'Sarah Kim', 20, 'New York', 3, 88),
(5, 'Chris Green', 23, 'Boston', 1, 65);

-- Courses
INSERT INTO Courses VALUES
(501, 'Database Systems', 1),
(502, 'Algorithms', 1),
(503, 'Calculus I', 2),
(504, 'Quantum Mechanics', 3);

-- Enrollments
INSERT INTO Enrollments VALUES
(1001, 1, 501), -- John takes DB
(1002, 1, 502), -- John takes Algo
(1003, 2, 501), -- Jane takes DB
(1004, 3, 503), -- Mike takes Calc
(1005, 4, 504), -- Sarah takes QM
(1006, 5, 501); -- Chris takes DB

-- 1. Show all students.
SELECT * FROM Students;

-- 2. Show only student name and city.
SELECT name, city FROM Students;

-- 3. Show students whose age is greater than 18.
SELECT * FROM Students WHERE age > 18;

-- 4. Show students who live in “Delhi”.
SELECT * FROM Students WHERE city = 'Delhi';

-- 5. Show students with marks greater than or equal to 80.
SELECT * FROM Students WHERE marks >= 80;


/*================ Sorting & Limiting================*/


-- 6. Show all students sorted by marks (highest first).
SELECT * FROM Students ORDER BY marks DESC;

-- 7. Show top 5 students by marks.
SELECT * FROM Students ORDER BY marks DESC LIMIT 5;

-- 8. Show students sorted by name (A → Z).
SELECT * FROM Students ORDER BY name ASC;


/*================ Filtering (WHERE with AND/OR)================*/


-- 9. Show students who are older than 18 and have marks above 75.
SELECT * FROM Students WHERE age > 18 AND marks > 75;

-- 10. Show students who live in “Delhi” or “Mumbai”.
SELECT * FROM Students WHERE city = 'Delhi' OR city = 'Mumbai';
-- Alternative:
SELECT * FROM Students WHERE city IN ('Delhi', 'Mumbai');

-- 11. Show students whose name starts with “A”.
SELECT * FROM Students WHERE name LIKE 'A%';

-- 12. Show students whose marks are between 60 and 90.
SELECT * FROM Students WHERE marks BETWEEN 60 AND 90;


/*================ Aggregates (COUNT, AVG, MAX, MIN, SUM) ================*/


-- 13. Count how many students are in the table.
SELECT COUNT(*) FROM Students;

-- 14. Find the average marks of all students.
SELECT AVG(marks) FROM Students;

-- 15. Find the highest marks.
SELECT MAX(marks) FROM Students;

-- 16. Show total students from each city (GROUP BY city).
SELECT city, COUNT(*) AS TotalStudents 
FROM Students 
GROUP BY city;

/*================ JOINS ================*/

-- 17. Show each student with their department name.
SELECT s.name, d.dept_name 
FROM Students s
JOIN Departments d ON s.dept_id = d.dept_id;

-- 18. Show each course with its department name.
SELECT c.course_name, d.dept_name 
FROM Courses c
JOIN Departments d ON c.dept_id = d.dept_id;

-- 19. Show students enrolled in courses.
SELECT s.name AS StudentName, c.course_name 
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- 20. Show teachers with the departments they belong to.
SELECT t.name AS TeacherName, d.dept_name 
FROM Teachers t
JOIN Departments d ON t.dept_id = d.dept_id;

-- 21. Show students and their courses, only for “Computer Science” department.Assuming this means courses offered by the CS department.
SELECT s.name, c.course_name 
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Departments d ON c.dept_id = d.dept_id
WHERE d.dept_name = 'Computer Science';

-- 22. Show students who do not have a department (LEFT JOIN).This finds students where the department ID doesn't exist in the departments table.
SELECT s.name 
FROM Students s
LEFT JOIN Departments d ON s.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- 23. Show departments that have no students.
SELECT d.dept_name 
FROM Departments d
LEFT JOIN Students s ON d.dept_id = s.dept_id
WHERE s.student_id IS NULL;

-- 24. Show how many students are in each department.
SELECT d.dept_name, COUNT(s.student_id) AS StudentCount
FROM Departments d
LEFT JOIN Students s ON d.dept_id = s.dept_id
GROUP BY d.dept_name;


/*================  Basic Sub-Queries ================*/


-- 25. Show students whose marks are higher than the average marks.
SELECT name, marks 
FROM Students 
WHERE marks > (SELECT AVG(marks) FROM Students);

-- 26. Show students who have the highest marks in the table.
SELECT name, marks 
FROM Students 
WHERE marks = (SELECT MAX(marks) FROM Students);

-- 27. Show students who belong to the same department as a student named ‘Ravi’.
SELECT name 
FROM Students 
WHERE dept_id = (SELECT dept_id FROM Students WHERE name = 'Ravi')
AND name != 'Ravi'; -- Optional: excludes Ravi himself

-- 28. Show courses that have at least one student enrolled.
SELECT course_name 
FROM Courses 
WHERE course_id IN (SELECT DISTINCT course_id FROM Enrollments);

-- 29. Show students who are enrolled in more than one course.
SELECT s.name 
FROM Students s
WHERE s.student_id IN (
    SELECT student_id 
    FROM Enrollments 
    GROUP BY student_id 
    HAVING COUNT(course_id) > 1
);

-- 30. Show departments where average marks of students are above 75.
SELECT d.dept_name 
FROM Departments d
JOIN Students s ON d.dept_id = s.dept_id
GROUP BY d.dept_name
HAVING AVG(s.marks) > 75;
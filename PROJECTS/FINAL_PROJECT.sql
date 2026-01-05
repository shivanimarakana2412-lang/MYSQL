
CREATE DATABASE final_project;

USE final_project;

-- ===============================
-- Students Table
-- ===============================
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,     
    FirstName VARCHAR(50),          
    LastName VARCHAR(50),            
    Email VARCHAR(100),              
    BirthDate DATE,                
    EnrollmentDate DATE              
);

-- ===============================
-- Departments Table
-- ===============================
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,    
    DepartmentName VARCHAR(100)      
);

-- ===============================
-- Courses Table
-- ===============================
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,       
    CourseName VARCHAR(100),          
    DepartmentID INT,                
    Credits INT,                     
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- ===============================
-- Instructors Table
-- ===============================
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,    
    FirstName VARCHAR(50),            
    LastName VARCHAR(50),             
    Email VARCHAR(100),            
    DepartmentID INT,              
    Salary DECIMAL(10,2),             
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- ===============================
-- Enrollments Table
-- ===============================
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,   
    StudentID INT,                   
    CourseID INT,                   
    EnrollmentDate DATE,            
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 1.CRUD
-- ===============================
-- Insert Data into Departments
-- ===============================
INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Chemistry'),
(5, 'Biology'),
(6, 'English');

-- ===============================
-- Insert Data into Students
-- ===============================
INSERT INTO Students VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01'),
(3, 'Ali', 'Khan', 'ali.khan@email.com', '2001-03-10', '2023-08-01'),
(4, 'Sara', 'Ahmed', 'sara.ahmed@email.com', '2000-07-18', '2020-08-01'),
(5, 'David', 'Brown', 'david.brown@email.com', '1998-11-22', '2019-08-01'),
(6, 'Ayesha', 'Malik', 'ayesha.malik@email.com', '2002-02-05', '2024-08-01');

-- ===============================
-- Insert Data into Courses
-- ===============================
INSERT INTO Courses VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 1, 4),
(103, 'Calculus', 2, 4),
(104, 'Linear Algebra', 2, 3),
(105, 'Physics Basics', 3, 3),
(106, 'Organic Chemistry', 4, 4);

-- ===============================
-- Insert Data into Instructors
-- ===============================
INSERT INTO Instructors VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 80000),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 75000),
(3, 'Michael', 'Smith', 'michael.smith@univ.com', 3, 72000),
(4, 'Linda', 'Brown', 'linda.brown@univ.com', 4, 78000),
(5, 'Robert', 'Taylor', 'robert.taylor@univ.com', 5, 70000),
(6, 'Emma', 'Wilson', 'emma.wilson@univ.com', 6, 68000);

-- ===============================
-- Insert Data into Enrollments
-- ===============================
INSERT INTO Enrollments VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01'),
(3, 3, 101, '2023-08-01'),
(4, 4, 103, '2020-08-01'),
(5, 5, 104, '2019-08-01'),
(6, 6, 105, '2024-08-01');

-- ===============================
-- SELECT (Read) Operations
-- ===============================
SELECT * FROM Students;      
SELECT * FROM Departments;   
SELECT * FROM Courses;      
SELECT * FROM Instructors;  
SELECT * FROM Enrollments;   

-- ===============================
-- UPDATE Operations
-- ===============================
UPDATE Students
SET Email = 'newemail@email.com'
WHERE StudentID = 1;

UPDATE Departments
SET DepartmentName = 'Applied Mathematics'
WHERE DepartmentID = 2;

UPDATE Courses
SET Credits = 5
WHERE CourseID = 102;

UPDATE Instructors
SET Salary = 90000
WHERE InstructorID = 1;

-- ===============================
-- DELETE Operations
-- ===============================
DELETE FROM Students WHERE StudentID = 6;
DELETE FROM Departments WHERE DepartmentID = 7;
DELETE FROM Courses WHERE CourseID = 107;
DELETE FROM Instructors WHERE InstructorID = 7;
DELETE FROM Enrollments WHERE EnrollmentID = 7;

-- ===============================
-- 2️.Retrieve students who enrolled after 2022
-- ============================================
SELECT * FROM Students
WHERE EnrollmentDate > '2022-12-31';

-- ============================================
-- 3. Retrieve courses offered by the Mathematics department (limit 5)
-- ============================================
SELECT c.*
FROM Courses c
JOIN Departments d ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
limit 5;

-- ============================================
-- 4.Number of students in each course (more than 5 students)
-- ============================================
SELECT CourseID, COUNT(StudentID) AS TotalStudents
FROM Enrollments
GROUP BY CourseID
HAVING COUNT(StudentID) > 5;

-- ============================================
-- 5. Students enrolled in both Introduction to SQL & Data Structures
-- ============================================
SELECT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (101, 102)
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(DISTINCT e.CourseID) = 2;

-- ============================================
-- 6. Students enrolled in either Introduction to SQL or Data Structures
-- ============================================
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (101, 102);

-- ============================================
-- 7. Average number of credits for all courses
-- ============================================
SELECT AVG(Credits) AS AvgCredits
FROM Courses;

-- ============================================
-- 8. Maximum salary of instructors in Computer Science department
-- ============================================
SELECT MAX(Salary) AS MaxSalary
FROM Instructors i
JOIN Departments d ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';

-- ============================================
-- 9. Count number of students in each department
-- ============================================
SELECT d.DepartmentName, COUNT(e.StudentID) AS TotalStudents
FROM Departments d
JOIN Courses c ON d.DepartmentID = c.DepartmentID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY d.DepartmentName;

-- ============================================
-- 10.INNER JOIN – Students and their corresponding courses
-- ============================================
SELECT s.FirstName, s.LastName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

-- ============================================
-- 11. LEFT JOIN – All students and their courses (if any)
-- ============================================
SELECT s.FirstName, s.LastName, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;

-- ============================================
-- 12. Subquery – Students in courses with more than 10 students
-- ============================================
SELECT *
FROM Students
WHERE StudentID IN (
    SELECT StudentID
    FROM Enrollments
    WHERE CourseID IN (
        SELECT CourseID
        FROM Enrollments
        GROUP BY CourseID
        HAVING COUNT(StudentID) > 10
    )
);

-- ============================================
-- 13. Extract year from EnrollmentDate
-- ============================================
SELECT StudentID, YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;

-- ============================================
-- 14. Concatenate instructor first & last name
-- ============================================
SELECT CONCAT(FirstName, '_', LastName) AS FullName
FROM Instructors;

-- ============================================
-- 15. Running total of students enrolled in courses
-- ============================================
SELECT CourseID,
       COUNT(StudentID) OVER (ORDER BY CourseID) AS RunningTotal
FROM Enrollments;

-- ============================================
-- 16. Label students as Senior / Junior
-- ============================================
SELECT StudentID, FirstName, LastName,
CASE
    WHEN EnrollmentDate <= DATE_SUB(CURDATE(), INTERVAL 4 YEAR) THEN 'Senior'
    ELSE 'Junior'
END AS Status
FROM Students;

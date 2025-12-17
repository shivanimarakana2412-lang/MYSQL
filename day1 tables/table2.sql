CREATE DATABASE TBLS ;



USE TBLS ;



CREATE TABLE students (
NAME VARCHAR(150),
ROllNO INT PRIMARY KEY,
STREAM VARCHAR (52) ,
RESULT DECIMAL (10,2) ,
LEAVINGDATE DATE 

) ;

-- for insert single value
INSERT INTO students (NAME , ROLLNO , STREAM , RESULT , LEAVINGDATE )
VALUES ('Shubham' , 1 , 'commarce' , '89.20' , '2025-12-01' ) ;

-- for multiple values
INSERT INTO students (NAME , ROLLNO , STREAM , RESULT , LEAVINGDATE)
VALUES 
('Dipak' , 2 , 'science' , '63.20' , '2026-07-30'  ) ,
('Sapna' , 3 , 'arts' , '70' , '2026-07-14'  ) ,
('Suhani' , 4 , 'diploma' , '79' , '2026-07-15'  ) ,
('Kavya' , 5 , 'science' , '53.20' , '2026-07-16'  ) ,
('Nax' , 6 , 'commarce' , '63.40' , '2026-07-23'  ) ,
('Dipati' , 7 , 'diploma' , '90.70' , '2026-07-30'  ) ,
('Hitansh' , 8 , 'commarce' , '45.78' , '2026-07-31'  ) ,
('Hasti' , 9 , 'science' , '62.42' , '2026-07-04'  ) ,
('Renish' , 10 , 'arts' , '63.56' , '2026-07-30'  );


-- Read

-- Full record
SELECT * FROM students ;

-- specific columns
SELECT NAME , RESULT , LEAVINGDATE FROM students ;

-- filterd columns
SELECT * FROM students WHERE RESULT > 63 ;




-- Update 

update students
set STREAM = 'commerce'
WHERE ROLLNO = 5 ;

SELECT * FROM students WHERE ROLLNO = 5 ;





-- Delete record
DELETE FROM students WHERE ROLLNO = 10 ;
SELECT * FROM students ;


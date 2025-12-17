CREATE DATABASE TBLS ;

USE TBLS ;

CREATE TABLE IssueRecords (
    IssueID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    ReturnDate DATE
);

INSERT INTO IssueRecords (IssueID, BookID, MemberID, IssueDate, ReturnDate)
VALUES
(1, 101, 201, '2026-07-01', '2026-07-10'),
(2, 102, 202, '2026-07-02', '2026-07-12'),
(3, 103, 203, '2026-07-03', '2026-07-13'),
(4, 104, 204, '2026-07-04', NULL),
(5, 105, 205, '2026-07-05', NULL),
(6, 106, 206, '2026-07-06', '2026-07-16'),
(7, 107, 207, '2026-07-07', NULL),
(8, 108, 208, '2026-07-08', '2026-07-18'),
(9, 109, 209, '2026-07-09', NULL),
(10, 110, 210, '2026-07-10', '2026-07-20'),
(11, 111, 211, '2026-07-11', NULL),
(12, 112, 212, '2026-07-12', '2026-07-22'),
(13, 113, 213, '2026-07-13', NULL),
(14, 114, 214, '2026-07-14', '2026-07-24'),
(15, 115, 215, '2026-07-15', NULL),
(16, 116, 216, '2026-07-16', '2026-07-26'),
(17, 117, 217, '2026-07-17', '2026-07-27'),
(18, 118, 218, '2026-07-18', '2026-07-28'),
(19, 119, 219, '2026-07-19', '2026-07-29'),
(20, 120, 220, '2026-07-20', '2026-07-30'),
(21, 121, 221, '2026-07-21', '2026-07-31'),
(22, 122, 222, '2026-07-22', '2026-08-01'),
(23, 123, 223, '2026-07-23', '2026-08-02'),
(24, 124, 224, '2026-07-24', '2026-08-03'),
(25, 125, 225, '2026-07-25', '2026-08-04');




-- read 

SELECT * FROM IssueRecords;

SELECT BookID, MemberID, ReturnDate FROM IssueRecords;

SELECT * FROM IssueRecords WHERE IssueDate = '2026-07-20';



-- update

UPDATE IssueRecords
SET ReturnDate = '2026-08-10'
WHERE IssueID = 18;




-- delete

DELETE FROM IssueRecords WHERE IssueID = 22;

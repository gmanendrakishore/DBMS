CREATE DATABASE u4;
USE u4;
-- 1. Create Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    Major VARCHAR(50)
);
-- 2. Create Courses table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT
);
-- 3. Create Enrollments table
CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
-- 4. Create Instructors table
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(50) NOT NULL,
    Phone VARCHAR(15)
);
-- 5. Create Course_Instructors table
CREATE TABLE Course_Instructors (
    CourseID INT,
    InstructorID INT,
    PRIMARY KEY (CourseID, InstructorID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);
-- Insert Students
INSERT INTO Students VALUES
(101, 'Rahul', 'CSE'),
(102, 'Priya', 'AIML'),
(103, 'Arjun', 'ECE'),
(104, 'Sneha', 'AIML');
-- Insert Courses
INSERT INTO Courses VALUES
(201, 'Database Management Systems', 4),
(202, 'Operating Systems', 4),
(203, 'Machine Learning', 3),
(204, 'Computer Networks', 3);
-- Insert Enrollments
INSERT INTO Enrollments VALUES
(101, 201, '2026-07-01'),
(101, 202, '2026-07-01'),
(102, 201, '2026-07-02'),
(102, 203, '2026-07-02'),
(103, 204, '2026-07-03'),
(104, 203, '2026-07-03');
-- Insert Instructors
INSERT INTO Instructors VALUES
(301, 'Dr. Kumar', '9876543210'),
(302, 'Dr. Anitha', '9876543211'),
(303, 'Dr. Ramesh', '9876543212');
-- Insert Course Instructors
INSERT INTO Course_Instructors VALUES
(201, 301),
(202, 302),
(203, 303),
(204, 301);
-- =========================
-- BASIC QUERIES
-- =========================
-- Display all students
SELECT * FROM Students;
-- Display all courses
SELECT * FROM Courses;
-- Display AIML students
SELECT StudentID, StudentName
FROM Students
WHERE Major = 'AIML';
-- Display students and their courses
SELECT S.StudentID, S.StudentName, C.CourseName
FROM Students S
JOIN Enrollments E
    ON S.StudentID = E.StudentID
JOIN Courses C
    ON E.CourseID = C.CourseID;
-- Display courses and instructors
SELECT C.CourseName, I.InstructorName
FROM Courses C
JOIN Course_Instructors CI
    ON C.CourseID = CI.CourseID
JOIN Instructors I
    ON CI.InstructorID = I.InstructorID;
-- Display student, course and enrollment date
SELECT S.StudentName,
       C.CourseName,
       E.EnrollmentDate
FROM Students S
JOIN Enrollments E
    ON S.StudentID = E.StudentID
JOIN Courses C
    ON E.CourseID = C.CourseID;
-- Display tables
SHOW TABLES;
-- =========================
-- USER AND PRIVILEGES
-- =========================
-- Create user
CREATE USER 'u4_user'@'localhost'
IDENTIFIED BY 'U4user@123';
-- Give SELECT permission on Students
GRANT SELECT
ON u4.Students
TO 'u4_user'@'localhost';
-- Create university user
CREATE USER 'university_user'@'localhost'
IDENTIFIED BY 'University@123';
-- Give SELECT, INSERT and UPDATE permissions
GRANT SELECT, INSERT, UPDATE
ON u4.Students
TO 'university_user'@'localhost';
-- Give all privileges on the u4 database
GRANT ALL PRIVILEGES
ON u4.*
TO 'university_user'@'localhost';
-- Remove UPDATE privilege
REVOKE UPDATE
ON u4.Students
FROM 'university_user'@'localhost';
-- Remove INSERT privilege
REVOKE INSERT
ON u4.Students
FROM 'university_user'@'localhost';
-- Give SELECT privilege again
GRANT SELECT
ON u4.Students
TO 'university_user'@'localhost';
-- Check data
SELECT * FROM Students;
-- Finally remove SELECT privilege
REVOKE SELECT
ON u4.Students
FROM 'university_user'@'localhost';
-- Check privileges
SHOW GRANTS FOR 'university_user'@'localhost';
-- ============================================================
-- PROJECT: university_course_management
-- ============================================================

CREATE DATABASE student_course_management;
USE student_course_management_db;


-- 1. CREATE TABLES
-- ============================================================

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    BirthDate DATE NOT NULL,
    EnrollmentDate DATE NOT NULL
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    Credits INT NOT NULL,
    CONSTRAINT chk_course_credits CHECK (Credits > 0),
    CONSTRAINT fk_courses_department
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    DepartmentID INT NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_instructor_salary CHECK (Salary >= 0),
    CONSTRAINT fk_instructors_department
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    CONSTRAINT fk_enrollments_student
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_enrollments_course
        FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    CONSTRAINT uq_student_course UNIQUE (StudentID, CourseID)
);

-- 2. INSERT SAMPLE DATA
-- ============================================================

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

INSERT INTO Students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES
(1,  'John',   'Doe',      'john.doe@email.com',       '2000-01-15', '2022-08-01'),
(2,  'Jane',   'Smith',    'jane.smith@email.com',     '1999-05-25', '2021-08-01'),
(3,  'Aarav',  'Patel',    'aarav.patel@email.com',    '2001-03-12', '2023-07-15'),
(4,  'Diya',   'Shah',     'diya.shah@email.com',      '2002-11-04', '2024-01-10'),
(5,  'Rohan',  'Mehta',    'rohan.mehta@email.com',    '2000-09-22', '2020-06-20'),
(6,  'Mira',   'Joshi',    'mira.joshi@email.com',     '2001-12-02', '2023-08-01'),
(7,  'Dev',    'Trivedi',  'dev.trivedi@email.com',    '1999-07-19', '2019-08-01'),
(8,  'Nisha',  'Desai',    'nisha.desai@email.com',    '2002-04-08', '2022-09-01'),
(9,  'Karan',  'Dave',     'karan.dave@email.com',     '2000-02-28', '2021-07-25'),
(10, 'Pooja',  'Parikh',   'pooja.parikh@email.com',   '2001-06-16', '2024-08-01'),
(11, 'Ishaan', 'Raval',    'ishaan.raval@email.com',   '2003-01-30', '2023-06-15'),
(12, 'Tara',   'Pandya',   'tara.pandya@email.com',    '2002-10-11', '2020-08-15'),
(13, 'Neel',   'Bhatt',    'neel.bhatt@email.com',     '2001-05-07', '2025-01-15');

INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures',     2, 4),
(103, 'Calculus',             2, 3),
(104, 'Statistics',           2, 4),
(105, 'Database Design',      1, 3);

INSERT INTO Instructors
(InstructorID, FirstName, LastName, Email, DepartmentID, Salary) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 72000.00),
(2, 'Bob',   'Lee',     'bob.lee@univ.com',       2, 68000.00),
(3, 'Sara',  'Miller',  'sara.miller@univ.com',   1, 81000.00);

-- Course 101 has 11 students; Course 102 has 6 students.
-- Some students are in both courses so Task 5 returns results.
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1,  1, 101, '2022-08-01'),
(2,  2, 101, '2021-08-01'),
(3,  3, 101, '2023-07-15'),
(4,  4, 101, '2024-01-10'),
(5,  5, 101, '2020-06-20'),
(6,  6, 101, '2023-08-01'),
(7,  7, 101, '2019-08-01'),
(8,  8, 101, '2022-09-01'),
(9,  9, 101, '2021-07-25'),
(10, 10, 101, '2024-08-01'),
(11, 11, 101, '2023-06-15'),
(12, 1,  102, '2022-08-01'),
(13, 2,  102, '2021-08-01'),
(14, 3,  102, '2023-07-15'),
(15, 4,  102, '2024-01-10'),
(16, 5,  102, '2020-06-20'),
(17, 12, 102, '2020-08-15'),
(18, 3,  103, '2023-07-20'),
(19, 6,  103, '2023-08-05'),
(20, 12, 104, '2020-08-20'),
(21, 13, 105, '2025-01-15');

-- ============================================================
-- TASK 1: CRUD OPERATIONS ON ALL TABLES
-- C = INSERT, R = SELECT, U = UPDATE, D = DELETE.
-- ============================================================

-- Students CRUD
INSERT INTO Students VALUES
(99, 'Demo', 'Student', 'demo.student@email.com', '2000-01-01', '2025-01-01');
SELECT * FROM Students WHERE StudentID = 99;
UPDATE Students SET LastName = 'UpdatedStudent' WHERE StudentID = 99;
DELETE FROM Students WHERE StudentID = 99;

-- Courses CRUD
INSERT INTO Courses VALUES (199, 'Demo Course', 1, 2);
SELECT * FROM Courses WHERE CourseID = 199;
UPDATE Courses SET Credits = 3 WHERE CourseID = 199;
DELETE FROM Courses WHERE CourseID = 199;

-- Instructors CRUD
INSERT INTO Instructors VALUES
(99, 'Demo', 'Instructor', 'demo.instructor@univ.com', 1, 50000.00);
SELECT * FROM Instructors WHERE InstructorID = 99;
UPDATE Instructors SET Salary = 52000.00 WHERE InstructorID = 99;
DELETE FROM Instructors WHERE InstructorID = 99;

-- Departments CRUD
INSERT INTO Departments VALUES (99, 'Demo Department');
SELECT * FROM Departments WHERE DepartmentID = 99;
UPDATE Departments SET DepartmentName = 'Updated Demo Department'
WHERE DepartmentID = 99;
DELETE FROM Departments WHERE DepartmentID = 99;

-- Enrollments CRUD: use existing student 13 and course 103.
INSERT INTO Enrollments VALUES (99, 13, 103, '2025-02-01');
SELECT * FROM Enrollments WHERE EnrollmentID = 99;
UPDATE Enrollments SET EnrollmentDate = '2025-02-02'
WHERE EnrollmentID = 99;
DELETE FROM Enrollments WHERE EnrollmentID = 99;

-- ============================================================
-- TASK 2: Retrieve students who enrolled after 2022
-- ============================================================
SELECT *
FROM Students
WHERE EnrollmentDate >= '2023-01-01'
ORDER BY EnrollmentDate;

-- ============================================================
-- TASK 3: Courses offered by Mathematics, limit 5 courses
-- ============================================================
SELECT c.CourseID, c.CourseName, c.DepartmentID, c.Credits
FROM Courses AS c
INNER JOIN Departments AS d
    ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
ORDER BY c.CourseID
LIMIT 5;

-- ============================================================
-- TASK 4: Number of students enrolled in each course;
-- show only courses with more than 5 students
-- ============================================================
SELECT c.CourseID, c.CourseName,
       COUNT(DISTINCT e.StudentID) AS StudentCount
FROM Courses AS c
INNER JOIN Enrollments AS e
    ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(DISTINCT e.StudentID) > 5
ORDER BY StudentCount DESC;

-- ============================================================
-- TASK 5: Students enrolled in BOTH named courses
-- ============================================================
SELECT s.StudentID, s.FirstName, s.LastName
FROM Students AS s
INNER JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
INNER JOIN Courses AS c
    ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(DISTINCT c.CourseName) = 2
ORDER BY s.StudentID;

-- ============================================================
-- TASK 6: Students enrolled in EITHER named course (or both)
-- ============================================================
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students AS s
INNER JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
INNER JOIN Courses AS c
    ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
ORDER BY s.StudentID;

-- ============================================================
-- TASK 7: Average credits for all courses
-- ============================================================
SELECT AVG(Credits) AS AverageCredits
FROM Courses;

-- ============================================================
-- TASK 8: Maximum instructor salary in Computer Science
-- Salary was added to Instructors because it is required by task 8
-- but was missing from the supplied field list.
-- ============================================================
SELECT MAX(i.Salary) AS MaximumSalary
FROM Instructors AS i
INNER JOIN Departments AS d
    ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';

-- ============================================================
-- TASK 9: Count students enrolled in each department
-- Count distinct students through their enrolled courses.
-- Departments with no enrolled students are included.
-- ============================================================
SELECT d.DepartmentID, d.DepartmentName,
       COUNT(DISTINCT e.StudentID) AS StudentCount
FROM Departments AS d
LEFT JOIN Courses AS c
    ON d.DepartmentID = c.DepartmentID
LEFT JOIN Enrollments AS e
    ON c.CourseID = e.CourseID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY d.DepartmentID;


-- TASK 10: INNER JOIN - students and their corresponding courses
-- ============================================================
SELECT s.StudentID,
       CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
       c.CourseID, c.CourseName, e.EnrollmentDate
FROM Students AS s
INNER JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
INNER JOIN Courses AS c
    ON e.CourseID = c.CourseID
ORDER BY s.StudentID, c.CourseID;


-- TASK 11: LEFT JOIN - all students and any corresponding courses
-- ============================================================
SELECT s.StudentID,
       CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
       c.CourseID, c.CourseName, e.EnrollmentDate
FROM Students AS s
LEFT JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
LEFT JOIN Courses AS c
    ON e.CourseID = c.CourseID
ORDER BY s.StudentID, c.CourseID;


-- TASK 12: Subquery - students enrolled in courses with >10 students
-- ============================================================
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students AS s
INNER JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
WHERE e.CourseID IN (
    SELECT e2.CourseID
    FROM Enrollments AS e2
    GROUP BY e2.CourseID
    HAVING COUNT(DISTINCT e2.StudentID) > 10
)
ORDER BY s.StudentID;


-- TASK 13: Extract year from students' EnrollmentDate
-- ============================================================
SELECT StudentID, FirstName, LastName, EnrollmentDate,
       YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students
ORDER BY StudentID;


-- TASK 14: Concatenate instructor first and last names
-- ============================================================
SELECT InstructorID,
       CONCAT(FirstName, ' ', LastName) AS InstructorFullName,
       Email, DepartmentID
FROM Instructors
ORDER BY InstructorID;


-- TASK 15: Running total of enrollments, ordered by enrollment date
-- ============================================================
SELECT EnrollmentID, StudentID, CourseID, EnrollmentDate,
       COUNT(*) OVER (
           ORDER BY EnrollmentDate, EnrollmentID
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS RunningEnrollmentTotal
FROM Enrollments
ORDER BY EnrollmentDate, EnrollmentID;


-- TASK 16: Label each student Senior if enrolled more than 4 years
-- ============================================================
SELECT StudentID, FirstName, LastName, EnrollmentDate,
       CASE
           WHEN EnrollmentDate < DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
               THEN 'Senior'
           ELSE 'Junior'
       END AS StudentLevel
FROM Students
ORDER BY StudentID;

-- ============================================================
-- SELECT * FROM Students;
-- SELECT * FROM Courses;
-- SELECT * FROM Instructors;
-- SELECT * FROM Enrollments;
-- SELECT * FROM Departments;

# Student Course Management System (SQL Project)

## Project Overview
This MySQL project manages students, courses, instructors, enrollments, and departments. It demonstrates relational database design and answers all 16 SQL tasks from the supplied assignment.

## Database
- **DBMS:** MySQL 8.0 or later
- **Database name:** `student_course_management_db`
- **Main script:** `student_course_management.sql`

## Tables and Relationships
1. **Departments** — department identifier and name.
2. **Students** — student name, email, birth date, and enrollment date.
3. **Courses** — course name, department, and credits.
4. **Instructors** — instructor details, department, and salary.
5. **Enrollments** — bridge table linking students to courses, with enrollment date.

Relationships:
- `Courses.DepartmentID` references `Departments.DepartmentID`.
- `Instructors.DepartmentID` references `Departments.DepartmentID`.
- `Enrollments.StudentID` references `Students.StudentID`.
- `Enrollments.CourseID` references `Courses.CourseID`.
- A unique constraint prevents the same student from being enrolled in the same course more than once.

## Files
- `student_course_management.sql` — database creation, tables, sample data, CRUD demonstrations, and solutions for Tasks 1–16.
- `README.md` — setup, schema, assumptions, and execution notes.
- `Project_Documentation.docx` — Word report with project overview, schema, task mapping, assumptions, and submission checklist.

## How to Run
1. Open MySQL Workbench, phpMyAdmin, or the MySQL command-line client.
2. Open `student_course_management.sql`.
3. Execute the script from the beginning. The script creates the database and tables, then inserts sample records and runs the required queries.
4. Review each task heading in the SQL file to match each query to the assignment requirement.

**Important:** The script drops and recreates the five project tables for a clean run. Do not run it against a database containing data you need to preserve.

## Assignment Tasks Covered
1. CRUD operations on all tables.
2. Students enrolled after 2022.
3. Mathematics courses, limited to 5.
4. Student count per course, only courses with more than 5 students.
5. Students enrolled in both Introduction to SQL and Data Structures.
6. Students enrolled in either of those courses.
7. Average course credits.
8. Maximum salary of instructors in Computer Science.
9. Student count in each department.
10. INNER JOIN: students and corresponding courses.
11. LEFT JOIN: all students and any corresponding courses.
12. Subquery: students in courses with more than 10 students.
13. Extract enrollment year.
14. Concatenate instructor first and last names.
15. Running total of enrollments using a window function.
16. Senior/Junior labels based on enrollment date and the current date.

## Assumptions and Design Decisions
- The supplied Instructors field list did not contain `Salary`, although Task 8 requires maximum instructor salary. A `Salary DECIMAL(10,2)` column and reasonable sample salaries have therefore been added.
- The assignment's two sample departments, courses, students, and instructors are retained. Additional sample records are added so that the `> 5` and `> 10` enrollment-count queries return meaningful results.
- The assignment uses “after 2022” to mean dates on or after 2023-01-01.
- Department enrollment counts are based on distinct students enrolled in courses belonging to each department. A student enrolled in courses from two departments is counted once in each relevant department.
- “Enrolled in both” means a student has enrollment records for both named courses. “Either” includes students enrolled in one or both courses.
- “More than 4 years from the current date” is interpreted as an enrollment date earlier than the current date minus four years. The label changes over time because `CURDATE()` is evaluated when the query runs.
- The running total counts enrollment records in ascending `EnrollmentDate`, with `EnrollmentID` as a tie-breaker.
- The SQL uses MySQL 8.0+ for window functions and check constraints. The script is intended for a fresh/re-creatable project database.

## Notes
- CRUD examples use dedicated demonstration IDs and are included in the script.
- Keep the SQL file and this README together in the GitHub repository.
- Review the output in your own MySQL environment before submission.

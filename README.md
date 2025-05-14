# Student-record-management-system
Overview
The Student Records Management System is a relational database management system (RDBMS) built using MySQL, designed to handle the management of student records, courses, instructors, departments, and grades. This system allows for efficient tracking of student enrollments, course prerequisites, grades, and instructor assignments.

Features:
Student Information: Manage student details such as name, email, date of birth, and registration date.

Course Management: Manage courses including their name, code, description, and prerequisites.

Instructor Management: Store details of instructors and assign them to specific courses.

Enrollment Tracking: Students can enroll in multiple courses, and the system tracks the enrollments.

Grades Management: Track student grades for each course they are enrolled in.

Department Categorization: Courses are categorized by departments, such as Computer Science, Business Administration, and Electrical Engineering.

Tables Overview
Departments: Stores department information like department name.

Instructors: Stores instructor details with a foreign key to the department.

Students: Stores student details such as name, email, and registration date.

Courses: Stores course information and a self-referencing foreign key to track prerequisites.

Enrollments: Tracks which students are enrolled in which courses (many-to-many relationship).

Grades: Stores grades assigned to students for their enrolled courses.

SQL Script
Database Creation
The SQL script will create the following tables with relationships:

Departments Table: Contains department names.

Instructors Table: Contains instructor information, linked to departments.

Students Table: Contains student information.

Courses Table: Contains course details, including prerequisites, linked to departments.

Enrollments Table: Many-to-many relationship table between students and courses.

Grades Table: Stores grades for students in each course.

Relationships:
One-to-Many (1:M):

A department can have multiple courses.

An instructor belongs to one department.

Many-to-Many (M:N):

A student can enroll in multiple courses, and a course can have many students.

One-to-One (1:1):

A student can have only one grade for a specific course.

Getting Started
Prerequisites
MySQL or a MySQL-compatible database server installed on your machine.

A MySQL client or GUI (e.g., MySQL Workbench, phpMyAdmin).

Setup Instructions
Clone the repository (if applicable) or download the .sql file.

Create the Database:

Log in to MySQL:

bash
Copy
Edit
mysql -u root -p
Run the SQL script to create the database and tables:

sql
Copy
Edit
source /path/to/your/file.sql;
Populate Data:

The SQL script includes sample INSERT statements to populate the tables with data for students, courses, instructors, and grades.

Run Queries:

Example queries are included in the script for retrieving student enrollments, grades, and instructor assignments.

Sample Queries
Here are some example queries you can run to retrieve data from the system:

1. Get all students enrolled in a specific course:
sql
Copy
Edit
SELECT Students.first_name, Students.last_name
FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
WHERE Enrollments.course_id = (SELECT course_id FROM Courses WHERE course_name = 'Introduction to Programming');
2. Get a student’s grades:
sql
Copy
Edit
SELECT Students.first_name, Students.last_name, Courses.course_name, Grades.grade
FROM Grades
JOIN Students ON Grades.student_id = Students.student_id
JOIN Courses ON Grades.course_id = Courses.course_id
WHERE Students.student_id = 1;
3. Find instructors teaching a specific course:
sql
Copy
Edit
SELECT Instructors.first_name, Instructors.last_name
FROM Instructors
JOIN Courses ON Instructors.department_id = Courses.department_id
WHERE Courses.course_name = 'Database Systems';
Additional Features & Enhancements
In the future, you can extend this system to include additional features such as:

Course Scheduling: Add scheduling information for each course.

Student Attendance: Track student attendance in each class.

Course Fees: Track the fee associated with each course.

Student Contact Information: Add additional student information, such as phone numbers and addresses.

Contributing
Feel free to fork this repository, create an issue, or submit a pull request to suggest enhancements or fix bugs.

License
This project is licensed under the MIT License - see the LICENSE file for details.



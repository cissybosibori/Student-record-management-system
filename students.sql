-- Create Database
CREATE DATABASE IF NOT EXISTS StudentRecords;
USE StudentRecords;

-- Create Departments table
CREATE TABLE IF NOT EXISTS Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL UNIQUE
);

-- Create Instructors table
CREATE TABLE IF NOT EXISTS Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Create Students table
CREATE TABLE IF NOT EXISTS Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Courses table with prerequisite relationship
CREATE TABLE IF NOT EXISTS Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    course_code VARCHAR(50) UNIQUE NOT NULL,
    course_description TEXT,
    credits INT NOT NULL CHECK (credits > 0),
    department_id INT,
    prerequisite_course_id INT, -- Self-referencing relationship for prerequisites
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (prerequisite_course_id) REFERENCES Courses(course_id) -- Referencing itself for prerequisites
);

-- Create Enrollments table (many-to-many relationship between students and courses)
CREATE TABLE IF NOT EXISTS Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE (student_id, course_id) -- A student can enroll in a course only once
);

-- Create Grades table
CREATE TABLE IF NOT EXISTS Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade VARCHAR(2), -- For example, A, B, C, etc.
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE (student_id, course_id) -- A student can only have one grade per course
);

-- Example Data Insertion:

-- Insert departments
INSERT INTO Departments (department_name) VALUES
('Computer Science'),
('Business Administration'),
('Electrical Engineering');

-- Insert instructors
INSERT INTO Instructors (first_name, last_name, email, department_id) VALUES
('John', 'Doe', 'john.doe@university.com', 1),
('Jane', 'Smith', 'jane.smith@university.com', 2),
('Emily', 'Clark', 'emily.clark@university.com', 1);

-- Insert students
INSERT INTO Students (first_name, last_name, email, date_of_birth) VALUES
('John', 'Doe', 'john.doe@example.com', '2000-03-25'),
('Jane', 'Smith', 'jane.smith@example.com', '1998-07-14'),
('Emily', 'Clark', 'emily.clark@example.com', '2001-01-10');

-- Insert courses
INSERT INTO Courses (course_name, course_code, course_description, credits, department_id) VALUES
('Introduction to Programming', 'CS101', 'Basic programming concepts', 3, 1),
('Database Systems', 'CS102', 'Introduction to databases and SQL', 3, 1),
('Business Ethics', 'BUS101', 'Ethical principles in business', 3, 2),
('Electrical Circuits', 'EE101', 'Fundamentals of electrical circuits', 3, 3);

-- Insert prerequisite relationship (Database Systems is a prerequisite for Introduction to Programming)
UPDATE Courses SET prerequisite_course_id = 2 WHERE course_code = 'CS101';

-- Enroll students in courses
INSERT INTO Enrollments (student_id, course_id) VALUES
(1, 1),  -- John Doe in Introduction to Programming
(1, 2),  -- John Doe in Database Systems
(2, 1),  -- Jane Smith in Introduction to Programming
(3, 4);  -- Emily Clark in Electrical Circuits

-- Assign grades to students
INSERT INTO Grades (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'A'),
(3, 4, 'B');

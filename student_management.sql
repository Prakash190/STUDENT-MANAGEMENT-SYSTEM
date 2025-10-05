use student_management;
show tables;
select * from students;
select * from courses;
select * from enrollments;
-- 🎓 Create Database
CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

-- 🧑‍🎓 Create Students Table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    dob DATE
);

-- 📘 Create Courses Table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(50),
    duration INT -- duration in months
);

-- 📝 Create Enrollments Table (with grades)
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    numeric_grade INT,
    letter_grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 📚 Insert 5 Courses
INSERT INTO courses (course_name, duration) VALUES
('Python Programming', 3),
('Web Development', 6),
('Data Science', 8),
('Database Management', 4),
('Machine Learning', 6);

-- 👨‍🎓 Insert 200 Students (Sample)
-- (Names are just placeholders, you can customize them)
INSERT INTO students (name, email, dob) VALUES
('Student 1', 'student1@mail.com', '2005-01-12'),
('Student 2', 'student2@mail.com', '2004-02-14'),
('Student 3', 'student3@mail.com', '2006-03-16'),
('Student 4', 'student4@mail.com', '2005-04-18'),
('Student 5', 'student5@mail.com', '2004-05-20'),
('Student 6', 'student6@mail.com', '2006-06-22'),
('Student 7', 'student7@mail.com', '2005-07-24'),
('Student 8', 'student8@mail.com', '2004-08-26'),
('Student 9', 'student9@mail.com', '2006-09-28'),
('Student 10', 'student10@mail.com', '2005-10-30'),
-- 👉 continue similarly up to Student 200
('Student 200', 'student200@mail.com', '2006-12-12');

-- 💡 Optional: If writing 200 INSERTs manually is too long,
-- you can generate them using Python or Excel and paste them here.

-- 🧪 Insert Enrollments with Grades (Sample for first 10 students)
INSERT INTO enrollments (student_id, course_id, enrollment_date, numeric_grade, letter_grade) VALUES
(1, 1, '2025-09-01', 92, 'A'),
(2, 2, '2025-09-01', 78, 'C'),
(3, 3, '2025-09-01', 85, 'B'),
(4, 4, '2025-09-01', 69, 'D'),
(5, 5, '2025-09-01', 95, 'A'),
(6, 1, '2025-09-01', 88, 'B'),
(7, 2, '2025-09-01', 73, 'C'),
(8, 3, '2025-09-01', 99, 'A'),
(9, 4, '2025-09-01', 55, 'F'),
(10, 5, '2025-09-01', 91, 'A');

-- You would repeat similar INSERTs for all 200 students.

-- 📊 BONUS REPORT QUERIES --

-- 1️⃣ Show all students with their courses and grades
SELECT s.name, c.course_name, e.numeric_grade, e.letter_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.student_id;

-- 2️⃣ Top 10 students based on grade
SELECT s.name, c.course_name, e.numeric_grade, e.letter_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY e.numeric_grade DESC
LIMIT 10;


-- 3️⃣ Average grade per course
SELECT c.course_name, ROUND(AVG(e.numeric_grade),2) AS avg_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- 4️⃣ Count of students in each grade category
SELECT letter_grade, COUNT(*) AS total_students
FROM enrollments
GROUP BY letter_grade
ORDER BY letter_grade;

-- 5️⃣ Students who failed (F grade

SELECT s.name, c.course_name, e.numeric_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.letter_grade = 'F';

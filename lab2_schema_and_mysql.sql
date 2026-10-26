-- VUA-SEN307 Week 4 Practical
-- Student: Alu Benjamin Yusuf
-- Matric No: VUG/SEN/24/12114
-- Run in MySQL Workbench after selecting your sen307_<matric_number> schema.

CREATE TABLE IF NOT EXISTS Department (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    matric_no VARCHAR(30) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    dept_id INT NOT NULL,
    CONSTRAINT fk_student_department
        FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE IF NOT EXISTS Lecturer (
    lecturer_id INT AUTO_INCREMENT PRIMARY KEY,
    lecturer_name VARCHAR(100) NOT NULL,
    dept_id INT NOT NULL,
    CONSTRAINT fk_lecturer_department
        FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE IF NOT EXISTS Course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_title VARCHAR(150) NOT NULL,
    dept_id INT NOT NULL,
    CONSTRAINT fk_course_department
        FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE IF NOT EXISTS Enrolment (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    session VARCHAR(20) NOT NULL,
    PRIMARY KEY (student_id, course_id, session),
    CONSTRAINT fk_enrolment_student
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
    CONSTRAINT fk_enrolment_course
        FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE IF NOT EXISTS TeachingAssignment (
    lecturer_id INT NOT NULL,
    course_id INT NOT NULL,
    session VARCHAR(20) NOT NULL,
    PRIMARY KEY (lecturer_id, course_id, session),
    CONSTRAINT fk_teaching_lecturer
        FOREIGN KEY (lecturer_id) REFERENCES Lecturer(lecturer_id),
    CONSTRAINT fk_teaching_course
        FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Optional sample data based on the handout's scenario.
INSERT IGNORE INTO Department (dept_name)
VALUES ('Software Engineering'), ('Computer Science');

INSERT IGNORE INTO Student (matric_no, full_name, dept_id)
SELECT '20231234', 'Ada Obi', dept_id FROM Department WHERE dept_name = 'Software Engineering';
INSERT IGNORE INTO Student (matric_no, full_name, dept_id)
SELECT '20231235', 'John Musa', dept_id FROM Department WHERE dept_name = 'Computer Science';
INSERT IGNORE INTO Student (matric_no, full_name, dept_id)
SELECT '20231236', 'Grace Okon', dept_id FROM Department WHERE dept_name = 'Software Engineering';

INSERT IGNORE INTO Lecturer (lecturer_name, dept_id)
SELECT 'Dr A. Okafor', dept_id FROM Department WHERE dept_name = 'Software Engineering';
INSERT IGNORE INTO Lecturer (lecturer_name, dept_id)
SELECT 'Dr M. Bello', dept_id FROM Department WHERE dept_name = 'Software Engineering';
INSERT IGNORE INTO Lecturer (lecturer_name, dept_id)
SELECT 'Mrs F. Eze', dept_id FROM Department WHERE dept_name = 'Computer Science';

INSERT IGNORE INTO Course (course_code, course_title, dept_id)
SELECT 'SEN307', 'Database Systems', dept_id FROM Department WHERE dept_name = 'Software Engineering';
INSERT IGNORE INTO Course (course_code, course_title, dept_id)
SELECT 'SEN301', 'Software Architecture', dept_id FROM Department WHERE dept_name = 'Software Engineering';
INSERT IGNORE INTO Course (course_code, course_title, dept_id)
SELECT 'COS301', 'Operating Systems', dept_id FROM Department WHERE dept_name = 'Computer Science';

INSERT IGNORE INTO Enrolment (student_id, course_id, session)
SELECT s.student_id, c.course_id, '2026/2027'
FROM Student s JOIN Course c ON c.course_code IN ('SEN307', 'SEN301')
WHERE s.matric_no = '20231234';

INSERT IGNORE INTO Enrolment (student_id, course_id, session)
SELECT s.student_id, c.course_id, '2026/2027'
FROM Student s JOIN Course c ON c.course_code IN ('SEN307', 'COS301')
WHERE s.matric_no = '20231235';

INSERT IGNORE INTO Enrolment (student_id, course_id, session)
SELECT s.student_id, c.course_id, '2026/2027'
FROM Student s JOIN Course c ON c.course_code = 'SEN301'
WHERE s.matric_no = '20231236';

INSERT IGNORE INTO TeachingAssignment (lecturer_id, course_id, session)
SELECT l.lecturer_id, c.course_id, '2026/2027'
FROM Lecturer l JOIN Course c ON c.course_code = 'SEN307'
WHERE l.lecturer_name = 'Dr A. Okafor';
INSERT IGNORE INTO TeachingAssignment (lecturer_id, course_id, session)
SELECT l.lecturer_id, c.course_id, '2026/2027'
FROM Lecturer l JOIN Course c ON c.course_code = 'SEN301'
WHERE l.lecturer_name = 'Dr M. Bello';
INSERT IGNORE INTO TeachingAssignment (lecturer_id, course_id, session)
SELECT l.lecturer_id, c.course_id, '2026/2027'
FROM Lecturer l JOIN Course c ON c.course_code = 'COS301'
WHERE l.lecturer_name = 'Mrs F. Eze';

-- Verify the tables:
SHOW TABLES;

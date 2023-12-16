 DROP table if EXISTS results; DROP table if EXISTS students; 
 DROP table if EXISTS st_groups; DROP table if EXISTS subject_teacher;  
 DROP table if EXISTS subjects; DROP table if EXISTS teachers;
-- Группы
CREATE table st_groups (
group_id VARCHAR(10) PRIMARY KEY,
speciality VARCHAR(10) NOT NULL -- специальность
);
-- Студенты
CREATE TABLE students (
student_id VARCHAR(20) PRIMARY KEY, -- номер зачетки
student_name VARCHAR(50) NOT NULL,
group_id VARCHAR(10) NOT NULL, -- группа 
DOB DATE NOT NULL , -- дата рождения
phone  CHAR(12) UNIQUE,
FOREIGN KEY(group_id) REFERENCES st_groups(group_id) 
);
-- Преподаватели
CREATE TABLE teachers(
teacher_id INTEGER PRIMARY KEY, -- номер пропуска
teacher_name VARCHAR(50) NOT NULL, 
DOB DATE NOT NULL, -- дата рождения
phone  CHAR(12) UNIQUE
);
-- Предметы
CREATE TABLE subjects (
subject_id INTEGER PRIMARY KEY,
subject_name VARCHAR(50) NOT NULL, -- название предмета
subject_type VARCHAR(50) NOT NULL CHECK(subject_type IN('гуманитарный','математический'))
);
-- Курсы, которые читают преподаватели. Один курс могут читать разные препродаватели
CREATE TABLE subject_teacher(
st_id INTEGER PRIMARY KEY, 
subject_id INTEGER,
teacher_id INTEGER NOT NULL,
UNIQUE (subject_id, teacher_id),
FOREIGN KEY(teacher_id) REFERENCES teachers(teacher_id), 
FOREIGN KEY(subject_id) REFERENCES subjects(subject_id) 
);
-- Результаты
CREATE TABLE results (
student_id VARCHAR(20) NOT NULL,
st_id INTEGER NOT NULL, -- предмет и преподаватель
mark INTEGER CHECK(mark BETWEEN 1 AND 5), -- оценка
mark_date DATE NOT NULL, -- дата сдачи
PRIMARY KEY(student_id, st_id),
FOREIGN KEY(student_id) REFERENCES students(student_id),
FOREIGN KEY(st_id) REFERENCES subject_teacher(st_id)
);
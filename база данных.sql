/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица students.results
DROP TABLE IF EXISTS `results`;
CREATE TABLE IF NOT EXISTS `results` (
  `student_id` varchar(20) NOT NULL,
  `st_id` int(11) NOT NULL,
  `mark` int(11) DEFAULT NULL CHECK (`mark` between 1 and 5),
  `mark_date` date NOT NULL,
  PRIMARY KEY (`student_id`,`st_id`),
  KEY `st_id` (`st_id`),
  CONSTRAINT `results_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `results_ibfk_2` FOREIGN KEY (`st_id`) REFERENCES `subject_teacher` (`st_id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- Дамп данных таблицы students.results: ~12 rows (приблизительно)
DELETE FROM `results`;
INSERT INTO `results` (`student_id`, `st_id`, `mark`, `mark_date`) VALUES
	('13-ГНФз-417', 2, 4, '2022-05-21'),
	('13-ГНФз-421', 4, 4, '2022-05-26'),
	('13-ГНФз-422', 5, 5, '2022-05-17'),
	('13-ГНФз-423', 6, 4, '2022-05-10'),
	('13-ГНФз-426', 3, 3, '2021-05-22'),
	('13-ГНФз-428', 2, 5, '2022-05-21'),
	('13-ГНФз-430', 1, 4, '2022-05-21'),
	('13-ГНФз-432', 1, 3, '2022-05-21'),
	('13-ГНФз-435', 5, 5, '2022-05-17'),
	('13-ГНФз-437', 4, 5, '2022-05-26'),
	('13-ГНФз-438', 3, 3, '2021-05-22'),
	('777', 1, 2, '2023-12-03');

-- Дамп структуры для таблица students.students
DROP TABLE IF EXISTS `students`;
CREATE TABLE IF NOT EXISTS `students` (
  `student_id` varchar(20) NOT NULL,
  `student_name` varchar(50) NOT NULL,
  `group_id` varchar(10) NOT NULL,
  `DOB` date NOT NULL,
  `phone` char(12) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `phone` (`phone`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `st_groups` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- Дамп данных таблицы students.students: ~12 rows (приблизительно)
DELETE FROM `students`;
INSERT INTO `students` (`student_id`, `student_name`, `group_id`, `DOB`, `phone`) VALUES
	('13-ГНФз-417', 'ГЕРДТ ВЯЧЕСЛАВ СЕРГЕЕВИЧ', '411', '2000-08-19', '79881234578'),
	('13-ГНФз-421', 'БУРЦЕВ АНДРЕЙ АЛЕКСАНДРОВИЧ', '311', '2003-04-15', '76541234534'),
	('13-ГНФз-422', 'БЫЧИН ЕВГЕНИЙ ВАЛЕРЬЕВИЧ', '411', '2001-05-16', '78671234545'),
	('13-ГНФз-423', 'ГАЛИАХМЕТОВ РАДМИР АЛФИЗОВИЧ', '511', '2002-06-17', '79851234556'),
	('13-ГНФз-426', 'ГОЛДОБИН ПАВЕЛ МИХАЙЛОВИЧ', '511', '2001-09-20', '79061234589'),
	('13-ГНФз-428', 'БОТАЛОВ АНТОН ВИКТОРОВИЧ', '411', '2002-02-13', '79261234512'),
	('13-ГНФз-430', 'БЛИНОВ ИВАН НИКОЛАЕВИЧ', '311', '2001-01-11', '79161234567'),
	('13-ГНФз-432', 'ГАЛКИН ДАНИИЛ АЛЕКСЕЕВИЧ', '311', '2003-07-18', '76581234567'),
	('13-ГНФз-435', 'ДУДИН ДЕНИС НИКОЛАЕВИЧ', '411', '2003-11-23', '78451234501'),
	('13-ГНФз-437', 'ДЕЕСТИНОВ АЛЕКСАНДР ТАГИРОВИЧ', '311', '2002-10-21', '79781234590'),
	('13-ГНФз-438', 'БУЗАНОВ АРТЁМ ПЕТРОВИЧ', '511', '2001-03-14', '73951234523'),
	('777', 'Иванов Иван Иванович', '1', '2004-10-13', '+79283366772');

-- Дамп структуры для таблица students.st_groups
DROP TABLE IF EXISTS `st_groups`;
CREATE TABLE IF NOT EXISTS `st_groups` (
  `group_id` varchar(10) NOT NULL,
  `speciality` varchar(10) NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- Дамп данных таблицы students.st_groups: ~1 rows (приблизительно)
DELETE FROM `st_groups`;
INSERT INTO `st_groups` (`group_id`, `speciality`) VALUES
	('1', 'IT'),
	('311', 'право'),
	('411', 'экономика'),
	('511', 'социология');

-- Дамп структуры для таблица students.subjects
DROP TABLE IF EXISTS `subjects`;
CREATE TABLE IF NOT EXISTS `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(50) NOT NULL,
  `subject_type` varchar(50) NOT NULL CHECK (`subject_type` in ('гуманитарный','математический')),
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- Дамп данных таблицы students.subjects: ~6 rows (приблизительно)
DELETE FROM `subjects`;
INSERT INTO `subjects` (`subject_id`, `subject_name`, `subject_type`) VALUES
	(31, 'право', 'гуманитарный'),
	(32, 'психология', 'гуманитарный'),
	(41, 'математика ', 'математический'),
	(42, 'информатика', 'математический'),
	(43, 'статистика', 'математический'),
	(51, 'социология', 'гуманитарный');

-- Дамп структуры для таблица students.subject_teacher
DROP TABLE IF EXISTS `subject_teacher`;
CREATE TABLE IF NOT EXISTS `subject_teacher` (
  `st_id` int(11) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`st_id`),
  UNIQUE KEY `subject_id` (`subject_id`,`teacher_id`),
  KEY `teacher_id` (`teacher_id`),
  CONSTRAINT `subject_teacher_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`),
  CONSTRAINT `subject_teacher_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- Дамп данных таблицы students.subject_teacher: ~0 rows (приблизительно)
DELETE FROM `subject_teacher`;
INSERT INTO `subject_teacher` (`st_id`, `subject_id`, `teacher_id`) VALUES
	(1, 31, 123456),
	(4, 32, 254388),
	(3, 41, 287693),
	(5, 42, 176987),
	(6, 43, 287693),
	(2, 51, 154728);

-- Дамп структуры для таблица students.teachers
DROP TABLE IF EXISTS `teachers`;
CREATE TABLE IF NOT EXISTS `teachers` (
  `teacher_id` int(11) NOT NULL,
  `teacher_name` varchar(50) NOT NULL,
  `DOB` date NOT NULL,
  `phone` char(12) DEFAULT NULL,
  PRIMARY KEY (`teacher_id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- Дамп данных таблицы students.teachers: ~6 rows (приблизительно)
DELETE FROM `teachers`;
INSERT INTO `teachers` (`teacher_id`, `teacher_name`, `DOB`, `phone`) VALUES
	(555, 'Петров Петр Петрович', '1977-07-23', '+78282939874'),
	(123456, 'Анисимов Игорь Владимирович', '1980-03-25', '79135148766'),
	(154728, 'Алексеев Дмитрий Александрович', '1988-07-20', '79234123456'),
	(176987, 'Николаева Наталия Николаевна', '1990-07-05', '79167134576'),
	(254388, 'Гаврилова Ирина Игоревна', '1993-05-15', '79269876543'),
	(287693, 'Бобырь Галина Юрьевна', '1977-10-31', '79176134236');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- 1. список студентов по определённому предмету (право)
SELECT student_name FROM students 
	JOIN results ON students.student_id=results.student_id
	JOIN subject_teacher ON subject_teacher.st_id=results.st_id
	JOIN subjects ON subjects.subject_id=subject_teacher.subject_id
WHERE subject_name='право'
ORDER BY student_name;

-- 2.	список предметов, которые преподает конкретный преподаватель (Анисимов Игорь Владимирович)
SELECT subject_name FROM subjects
	JOIN subject_teacher ON subjects.subject_id=subject_teacher.subject_id
	JOIN teachers ON subject_teacher.teacher_id=teachers.teacher_id
WHERE teacher_name='Анисимов Игорь Владимирович'
ORDER BY subject_name;

-- 3. средний балл студента по всем предметам ГЕРДТ ВЯЧЕСЛАВ СЕРГЕЕВИЧ
SELECT AVG(mark) FROM results 
	JOIN students ON students.student_id=results.student_id
WHERE student_name='ГЕРДТ ВЯЧЕСЛАВ СЕРГЕЕВИЧ';

-- 4. рейтинг преподавателей по средней оценке студентов
SELECT RANK() OVER(order by avg_mark DESC) rating, teacher, avg_mark
FROM(
SELECT AVG(mark) avg_mark, teachers.teacher_name teacher FROM results
	JOIN subject_teacher ON subject_teacher.st_id=results.st_id
	JOIN teachers ON teachers.teacher_id=subject_teacher.teacher_id
GROUP BY teachers.teacher_id, teachers.teacher_name
) mark_teacher
ORDER BY 1;

-- 5. список преподавателей, которые преподавали более 3 предметов за последний год
SELECT teachers.teacher_name FROM results
	JOIN subject_teacher ON subject_teacher.st_id=results.st_id
	JOIN teachers ON teachers.teacher_id=subject_teacher.teacher_id
WHERE year(mark_date)=(SELECT MAX(YEAR(mark_date)) FROM results)	
GROUP BY teachers.teacher_id, teachers.teacher_name
HAVING COUNT(DISTINCT results.st_id)>3
ORDER BY teachers.teacher_name;

-- 6.  список студентов, которые имеют средний балл выше 4 по математическим предметам, но ниже 3 по гуманитарным
SELECT students.student_name  FROM results 
	JOIN subject_teacher ON subject_teacher.st_id=results.st_id
	JOIN subjects ON subject_teacher.subject_id=subjects.subject_id
	JOIN students ON students.student_id=results.student_id
GROUP BY students.student_id, students.student_name
HAVING AVG(case when subject_type='математический' then mark END)>4 
	AND AVG(case when subject_type='гуманитарный' then mark END)<3
ORDER BY students.student_name;

-- 7. предметы, по которым больше всего двоек в текущем семестре
SELECT subjects.subject_name, COUNT(*) qty2 FROM results 
	JOIN subject_teacher ON subject_teacher.st_id=results.st_id
	JOIN subjects ON subject_teacher.subject_id=subjects.subject_id
WHERE mark=2 AND quarter(mark_date) = (SELECT MAX(quarter(mark_date)) FROM results)	AND year(mark_date) = (SELECT MAX(year(mark_date)) FROM results)
GROUP BY subjects.subject_id,subjects.subject_name
ORDER BY qty2 desc LIMIT 1;

-- 8. студенты, которые получили высший балл по всем своим экзаменам, и преподаватели, которые вели эти предметы
WITH 5th AS
(SELECT results.student_id FROM results 
GROUP BY results.student_id
HAVING COUNT(*) = SUM(case mark when 5 then 1 ELSE 0 END)
)
SELECT students.student_name, GROUP_CONCAT(teachers.teacher_name,',') teachers FROM results 
	JOIN subject_teacher ON subject_teacher.st_id=results.st_id
	JOIN students ON students.student_id=results.student_id
	JOIN teachers ON subject_teacher.teacher_id=teachers.teacher_id 
WHERE students.student_id IN (SELECT student_id FROM 5th)	
GROUP BY students.student_id, students.student_name
ORDER BY students.student_name;

-- 9. изменение среднего балла студента по годам обучения
SELECT students.student_name, AVG(mark) _avg_, YEAR(mark_date) _year_ FROM results
	JOIN students ON students.student_id=results.student_id
GROUP BY students.student_id, students.student_name, YEAR(mark_date)
ORDER BY students.student_name, _year_;

/* 10. группы, в которых средний балл выше, чем в других, по аналогичным предметам, чтобы выявить лучшие методики преподавания или особенности состава группы */
WITH gr_sub AS
(SELECT students.group_id, st_id, AVG(mark) _avg_ FROM results
	JOIN students ON students.student_id=results.student_id
GROUP BY students.group_id, st_id)
SELECT * FROM gr_sub
WHERE _avg_ >= ALL(SELECT _avg_ FROM gr_sub t WHERE t.st_id=gr_sub.st_id);

-- 11. вставка записи о новом студенте с его личной информацией
INSERT INTO st_groups VALUES(1,'IT');
INSERT INTO students VALUES(777,'Иванов Иван Иванович', 1,'2004-10-13','+79283366772');

-- 12. обновление контактной информации преподавателя
DELETE FROM teachers WHERE teacher_id=555; 
INSERT INTO teachers VALUES(555, 'Петров Петр Петрович', '1977-07-23','89337766333');
-- Обновляем телефон
UPDATE teachers SET phone='+78282939874'
WHERE teacher_id=555;

/* 13. удаления записи о предмете, который больше не преподают в учебном заведении. Учтите возможные зависимости, такие как оценки студентов по этому предмету;
*/
-- Добавим записи для тестирования удаления
INSERT INTO subjects VALUES(888,'test for delete','гуманитарный');
INSERT INTO subject_teacher VALUES(666,888,555);
INSERT INTO results VALUES(777,666,5,'2000-01-25');
-- Удаление
DELETE FROM results WHERE st_id=666; -- удаление результатов
DELETE FROM subject_teacher WHERE st_id=666; -- удаление инфы о том, кто преподавал
DELETE FROM subjects WHERE subject_id=888; -- удаление предмета

/* 14. вставки новой записи об оценке, выставленной студенту по определённому предмету, с указанием даты, преподавателя и полученной оценки.
*/
DELETE FROM results WHERE student_id=777; -- удалим, если есть
INSERT INTO results VALUES(777,1,2,'2023-12-03');
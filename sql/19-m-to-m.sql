-- 19-m-to-m.sql
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM students_courses;


-- 각 학생별 수강 수업 확인
SELECT * 
FROM students s
INNER JOIN students_courses sc ON s.id = sc.student_id
INNER JOIN courses c ON sc.course_id = c.id;

-- 각 강의 별 학생 확인
SELECT *
FROM courses c
INNER JOIN students_courses sc ON c.id = sc.course_id
INNER JOIN students s ON sc.student_id = s.id
ORDER BY c.name;

-- 한번에 묶어서 보기
SELECT s.id, s.name, COUNT(c.id) AS 수업수, STRING_AGG(c.name, ', ')
FROM students s
INNER JOIN students_courses sc ON s.id = sc.student_id
INNER JOIN courses c ON sc.course_id = c.id
GROUP BY s.id, s.name;

-- 과목별 정리
-- 수업 id, 수업 이름, 강의실, 수강인원, 학생들 이름 한번에, 학점 평균
-- 학점평균(A+=4.3, A=4, A-=3.7, B+=3.5, B=3.0)
SELECT c.id, c."name", c.classroom, COUNT(sc.student_id), STRING_AGG(s."name", ', '), 
		ROUND(AVG(
		    CASE
		        WHEN sc.grade='A+' THEN 4.3
		        WHEN sc.grade = 'A'  THEN 4.0
		        WHEN sc.grade = 'A-' THEN 3.7
		        WHEN sc.grade = 'B+' THEN 3.3
		        WHEN sc.grade = 'B'  THEN 3.0
		        ELSE 0
		    END), 2) AS 평균학점
FROM courses c
INNER JOIN students_courses sc ON c.id = sc.course_id
INNER JOIN students s ON sc.student_id = s.id
GROUP BY c.id
ORDER BY c.name;

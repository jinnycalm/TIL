-- 08_where.sql

SELECT * FROM students;

CREATE TABLE students(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(10),
	age INT
)

INSERT INTO students (name, age) VALUES
('정 민수', 50),
('서 지훈', 30),
('윤 하늘', 20),
('최 도윤', 25),
('강 수빈', 33),
('문 태오', 18),
('백 현우', 45),
('한 유진', 10),
('임 주원', 88),
('송 민재', 67),
('박 혁거세', 40),
('박 수민', 30);

INSERT INTO students (name, age) VALUES


-- 특정 컬럼과
-- 같음
SELECT * FROM students WHERE name='송 민재';
-- 아님
SELECT * FROM students WHERE id != 1;
-- 이상
SELECT * FROM students WHERE age >= 30;
-- 초과
SELECT * FROM students WHERE age > 50;
-- 범위(이상 - 이하)
SELECT * FROM students WHERE age BETWEEN 20 AND 40;
-- 다중 선택
SELECT * FROM students WHERE id=1 OR age=30 OR id=5;
SELECT * FROM students WHERE id IN (1, 3, 5);

-- 문자열 패턴 찾기(% -> 있을수도 없을수도, _ -> 개수만큼 있다)
-- 최씨 찾기
SELECT * FROM students WHERE name LIKE '최%';
-- 이름이 '민'글자가 있으면 모두
SELECT * FROM students WHERE name LIKE '%민%';
-- 이름이 '훈'으로 끝나는 사람 모두
SELECT * FROM students WHERE name LIKE '%훈';
-- '박'이후에 글자가 3개 있어야 한다.
SELECT * FROM students WHERE name LIKE '박 __';






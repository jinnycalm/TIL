-- 11_number_functions.sql

-- 실수 관련 함수들
SELECT
	name,
	score AS 원점수,
	ROUND(score) AS 반올림점수,
	CEIL(score) AS 올림,
	FLOOR(score) AS 내림
FROM dt_demo;

-- 사칙연산
SELECT
	10 + 5 AS plus,
	10 - 5 AS minus,
	10 * 5 AS multiply,
	10 / 5 AS divide,
	10 / 3 AS 몫,
	10 % 3 AS 나머지,
	POWER(10, 3) AS 거듭제곱,
	SQRT(16) AS 루트,
	ABS(-5) AS 절댓값;

-- IF, CASE
SELECT 
	name, 
	score,
	-- IF(score >= 80.0, '우수', '보통')
	CASE
		WHEN score >= 90 THEN 'A'
		WHEN score >= 80 THEN 'B'
		WHEN score >= 70 THEN 'C'
		ELSE 'D'
	END AS 학점
FROM dt_demo;

-- dt-demo에서 id가 홀수인지 짝수인지 판별하는 컬럼을 추가하여 확인
-- id, name, 홀짝

SELECT
	id,
	name,
	CASE
		WHEN id % 2 = 0 THEN '짝'
		ELSE '홀'
	END AS 홀짝
FROM dt_demo;




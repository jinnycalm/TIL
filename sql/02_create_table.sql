-- 02-create.table.sql

CREATE TABLE sample (
	name VARCHAR(30),
	age INT
);

DROP TABLE sample;
DROP TABLE members;

CREATE TABLE members (
	-- 자동으로 1씩 올라가고, 해당 테이블의 PK
	id 			INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	-- 비어있지 않게
	name 		VARCHAR(30) NOT NULL,
	-- 중복허용하지 않게
	email 		VARCHAR(100) UNIQUE,
	-- 기본값 20
	age			INT DEFAULT 20,
	-- 자동으로 오늘 날짜
	join_date	DATE DEFAULT CURRENT_DATE
);



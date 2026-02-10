-- 05_update.sql

-- 데이터 추가 (name='익명')

INSERT INTO members (name)
VALUES ('익명');'

SELECT * FROM members;

UPDATE members
SET name='홍길동'
WHERE name ='익명'

UPDATE members
SET email = 'hong@gil',
age = 25
WHERE id = 7;

UPDATE members
SET age = age+1
WHERE age = 20;
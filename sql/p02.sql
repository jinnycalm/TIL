-- p02.sql

SELECT * FROM userinfo;

CREATE TABLE userinfo (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nickname VARCHAR(20),
	phone VARCHAR(11) UNIQUE,
	reg_date DATE DEFAULT CURRENT_DATE
)

INSERT INTO userinfo (nickname, phone)
VALUES
('alice', '0104567890'),
('bob', '0104561234'),
('charlie', '01112345678'),
('david', '01874562131'),
('eric', '01054687913');

-- userinfo 에 email 컬럼 추가 40글자 제한, 기본값은 ex@gmail.com
ALTER TABLE userinfo ADD COLUMN email VARCHAR(40) NOT NULL DEFAULT 'ex@gmail.com';

-- nickname 길이제한 100자로 늘리기
ALTER TABLE userinfo
ALTER COLUMN nickname TYPE VARCHAR(100);

-- reg_date 컬럼 삭제
ALTER TABLE userinfo
DROP COLUMN reg_date;


-- 실제 한명의 email 을 수정하기
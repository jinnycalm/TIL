SELECT * FROM members;

-- 컬럼 추가
ALTER TABLE members ADD COLUMN address VARCHAR(100) NOT NULL DEFAULT '';

-- 컬럼 이름 수정
ALTER TABLE members
RENAME COLUMN address TO juso;

-- 컬럼 데이터 타입 수정
ALTER TABLE members
ALTER COLUMN juso TYPE VARCHAR(50);

ALTER TABLE members
ALTER COLUMN age SET DEFAULT 10;

-- 컬럼 삭제
ALTER TABLE members
DROP COLUMN address;


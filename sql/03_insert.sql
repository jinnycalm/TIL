-- 03_insert.sql

INSERT INTO members (name, email, age, join_date)
VALUES ('jinny', 'jinny@gmail.com', 20, '2026-01-12');

INSERT INTO members (name, email) 
VALUES ('b', 'b@b.com')
VALUES ('c', 'c@c.com')
VALUES ('d', 'd@d.com')
;

SELECT * FROM members; 

DELETE FROM members where id =4;

INSERT INTO members (name, email, age, join_date)
VALUES ('sony', ''2026-01-12');

INSERT INTO members (name)
VALUES ('jisoo'), (4, 'chaerin');
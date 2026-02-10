-- 17.join.sql
SELECT * FROM sales;
SELECT * FROM customers;

-- 지루하고 현학적임
SELECT customer_name FROM customers WHERE customer_id = 'C001';

SELECT 
	(SELECT customer_name FROM customers c WHERE c.customer_id = s.customer_id) AS 고객명,
	(SELECT customer_type From customers c WHERE c.customer_id = s.customer_id) AS 고객등급,
	*
FROM sales s;

-- INNER JOIN -> 왼쪽(c)와 오른쪽(s)를 모두 만족하는 교집합 데이터.
SELECT COUNT(*) FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id;

-- LEFT JOIN -> 왼쪽(c)의 모든 데이터 + (있을경우) 매칭되는 오른쪽 데이터.
SELECT COUNT(*) FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id;
-- WHERE s.id IS NULL; --> 구매한적 없는 사람만 확인

-- UNION -> 
SELECT 
	'1. INNER JOIN' AS 구분,
	COUNT(*) AS 줄수,
	COUNT(DISTINCT c.customer_id) AS 고객수
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
UNION
SELECT
	'2. LEFT JOIN' AS 구분,
	COUNT(*) AS 줄수,
	COUNT(DISTINCT c.customer_id) AS 고객수
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id;

-- 12-aggr-func.sql

SELECT * From sales;

-- COUNT
SELECT 
	COUNT(*) AS 매출건수
FROM sales;

SELECT
	COUNT(*) AS 총주문건수,
	COUNT(DISTINCT customer_id) AS 고객수,
	COUNT(DISTINCT product_name) AS 상품수
FROM sales;


-- SUM
SELECT
	SUM(total_amount) AS 총매출액,
	SUM(quantity) AS 총판매수량,
	TO_CHAR(SUM(total_amount), 'FM999,999,999') || '원' AS 총매출
FROM sales;

-- QUIZ
SELECT TO_CHAR(SUM(total_amount), 'FM999,999,999') || '원' AS 서울총매출
FROM sales
WHERE region = '서울';

-- AVG(평균)
SELECT 
ROUND(AVG(total_amount)) AS 회당평균주문액,
ROUND(AVG(quantity)) AS 평균구매수량,
ROUND(AVG(unit_price)) AS 평균단가
FROM sales;

-- MIN/MAX
SELECT 
	MIN(total_amount) AS 최소매출액,
	MAX(total_amount) AS 최대매출액,
	MIN(order_date) AS 첫주문일,
	MAX(order_date) AS 마지막주문일
FROM sales;

-- 매출 대시보드
SELECT
	COUNT(*) AS 주문건수,
	SUM(total_amount) AS 총매출,
	ROUND(AVG(total_amount)) AS 평균매출,
	MIN(total_amount) AS 최소매출액,
	MAX(total_amount) AS 최대매출액,
	ROUND(AVG(quantity), 1) AS 평균수량 -- ROUND(x, 1) -> 소숫점 한자리 반올림
FROM sales
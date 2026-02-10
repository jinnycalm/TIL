-- 16-subquery2.sql
/*
Scala  -> 데이터 1개 | 14.56
Vector -> 데이터 1줄 | ("인천", "대구", "부산", "광주", "서울")
Matrix -> 행*열
*/

-- Scala
SELECT AVG(total_amount) FROM sales;
-- Vector
SELECT DISTINCT region from sales;

-- VIP들의 주문내역만 확인
SELECT customer_id FROM customers WHERE customer_type='VIP';

SELECT * FROM sales 
WHERE customer_id 
IN (SELECT customer_id FROM customers WHERE customer_type='VIP');

-- [전자제품을 구매한 고객들의 customer_id]의 모든 주문
SELECT customer_id FROM sales WHERE category='전자제품'; -- 벡터
SELECT DISTINCT customer_id FROM sales WHERE category='전자제품'; -- 중복제거

SELECT * FROM sales
WHERE customer_id IN (SELECT customer_id FROM sales WHERE category='전자제품');


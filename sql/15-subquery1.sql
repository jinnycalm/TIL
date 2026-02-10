-- 15-subquery1.sql

-- subquery -> 쿼리 안의 쿼리
-- 평균 주문 금액 보다 더 높은 금액을 주문한 판매 데이터(*)를 보려면?

-- 평균을 구해서
SELECT AVG(total_amount) FROM sales;
-- 그 값으로 WHERE
SELECT * FROM sales WHERE total_amount >= 612862;

-- 특정 값을 매번 계산해서 잘 가져옴
SELECT * FROM sales 
WHERE total_amount >= (SELECT AVG(total_amount) FROM sales);

-- 특정 판매데이터에 평균금액과의 차이를 함께 보고싶다면?
SELECT
    product_name AS 이름,
    total_amount AS 판매액,
    total_amount - (SELECT AVG(total_amount) FROM sales) AS 평균차이
FROM sales
WHERE total_amount >= (SELECT AVG(total_amount) FROM sales); 

-- sales 에서 [가장 비싼 total_amount]를 가진 데이터
SELECT * FROM sales ORDER BY total_amount DESC LIMIT 1;
SELECT * FROM sales WHERE total_amount=(SELECT MAX(total_amount) FROM sales);


-- [주문 금액 평균]과 실제 주문액수의 차이가 가장 적은 5개 데이터
SELECT
    id,
    order_date,
    total_amount,
    ABS((SELECT AVG(total_amount) FROM sales) - total_amount) AS 평균차이
FROM sales
ORDER BY 평균차이
LIMIT 5;
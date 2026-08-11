-- orders 테이블의 모든 컬럼 조회
SELECT * FROM ORDERS o;

-- 주문번호(order_id)와 주문일시(order_tms)만 조회
SELECT o.ORDER_ID , o.ORDER_TMS 
FROM ORDERS o;

-- 주문상태가 OPEN인 주문만 조회
SELECT *
FROM ORDERS o 
WHERE o.ORDER_STATUS = 'OPEN';


-- 주문상태가 CANCELLED OR REFUNDED 인 주문 조회
SELECT *
FROM ORDERS o 
WHERE o.ORDER_STATUS IN ('CANCELLED', 'REFUNDED');
 
-- STORE_ID가 1인 주문 중에서 주문 상태가 COMPLETE가 아닌 주문 조회
SELECT *
FROM ORDERS o 
WHERE o.STORE_ID = 1 AND o.ORDER_STATUS != 'COMPLETE';

-- 2022년 1월 1일 이후 주문된 건만 조회
SELECT *
FROM ORDERS o 
WHERE o.ORDER_TMS >= '2022-01-01';


-- 전체 주문을 최신 주문일시 순으로 정렬하여 조회
SELECT *
FROM ORDERS o 
ORDER BY o.ORDER_TMS DESC;
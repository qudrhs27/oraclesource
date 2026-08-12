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



-- CUSTOMERS 테이블

-- 이름이 'K'로 시작하는 고객의 CUSTOMER_ID, FULL_NAME 조회
SELECT c.CUSTOMER_ID , c.FULL_NAME 
FROM CUSTOMERS c 
WHERE c.FULL_NAME LIKE 'K%';


-- 이름이 'son'로 끝나는 고객의 CUSTOMER_ID, FULL_NAME 조회
SELECT c.CUSTOMER_ID , c.FULL_NAME 
FROM CUSTOMERS c 
WHERE c.FULL_NAME LIKE '%son';


-- 이메일에서 '@' 앞부분(아이디) 추출하기
SELECT SUBSTR(c.EMAIL_ADDRESS, 1, INSTR(c.EMAIL_ADDRESS,'@') - 1) AS email_id
FROM CUSTOMERS c;


-- 이름에서 공백 위치 찾기
SELECT c.FULL_NAME, INSTR(c.FULL_NAME, ' ')
FROM CUSTOMERS c;


-- 이름과 이메일을 하나의 문자열로 합치기
-- ex) name (name@gmail.com)
SELECT c.FULL_NAME || '(' || c.EMAIL_ADDRESS || ')' AS name_with_email
FROM CUSTOMERS c;


-- 이름 앞, 뒤 공백 제거 후 조회(customer_id, full_name)
SELECT c.CUSTOMER_ID , TRIM(c.FULL_NAME)
FROM CUSTOMERS c; 


-- customer_id를 5자리로, 빈자리는 0
SELECT c.CUSTOMER_ID, LPAD(c.CUSTOMER_ID,5,'0')
FROM CUSTOMERS c;


-- PRODUCTS 테이블
-- 상품명에 'Shirt'가 포함된 상품 정보 조회
SELECT *
FROM PRODUCTS p
WHERE p.PRODUCT_NAME LIKE '%Shirt%';


-- 상품명에 Boy 로 시작하는 상품 정보 조회
SELECT *
FROM PRODUCTS p
WHERE p.PRODUCT_NAME LIKE 'Boy%';


-- 상품명에 앞 10글자만 추출 후 short_name 컬럼명으로 추출
SELECT SUBSTR(p.PRODUCT_NAME,1,10) AS short_name
FROM PRODUCTS p;


-- 상품명 20자 초과시 앞 20자 + '...'
-- case~when 사용(컬럼명 display_name)
SELECT
	p.PRODUCT_NAME, 
	CASE 
		WHEN LENGTH(p.PRODUCT_NAME) > 20 THEN SUBSTR(p.PRODUCT_NAME,1,20) || '...'
		ELSE p.PRODUCT_NAME
	END AS display_name
FROM
	PRODUCTS p;


-- 상품명 길이가 짝수/홀수 인 상품 구분
-- product_id,name, 상품명 길이 (name_len 으로 지정),
-- 짝수,홀수 컬럼명은 len_type 으로 지정
-- case~when 사용
SELECT 
	p.PRODUCT_ID,
	p.PRODUCT_NAME,
	length(p.PRODUCT_NAME) AS name_len,
	CASE 
		WHEN MOD(length(p.PRODUCT_NAME), 2) = 0 THEN '짝수'
		ELSE '홀수'
	END AS len_type
FROM PRODUCTS p;



-- STORE 테이블
-- WEB_ADDRESS가 NULL이 아니면서 'https'로 시작하는 매장 조회
-- store_id, store_name, web_address 조회
SELECT s.STORE_ID , s.STORE_NAME , s.WEB_ADDRESS
FROM STORES s 
WHERE s.WEB_ADDRESS IS NOT NULL AND s.WEB_ADDRESS LIKE 'https%';



-- ORDERS 테이블
-- ORDER_ID 를 'ORD-00001' 형태로
-- ORDER_ID,'ORD-00001' (ORDER_CODE 컬럼명 사용) 추출
SELECT 'ORD-' || LPAD(o.ORDER_ID,5,'0') AS ORDER_CODE
FROM ORDERS o;
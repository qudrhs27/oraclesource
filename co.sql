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




-- 모든 주문에 대해 주문한 고객의 이름을 함께 출력
SELECT 
	o.*,
	c.FULL_NAME
FROM
	ORDERS o
JOIN CUSTOMERS c 
ON 
	o.CUSTOMER_ID = c.CUSTOMER_ID;


-- 모든 주문에 대해 주문이 발생한 매장 이름(STORE_NAME)을 함께 조회
SELECT
	o.*,
	s.STORE_NAME
FROM
	ORDERS o
JOIN STORES s 
ON
	o.STORE_ID = s.STORE_ID;


-- 모든 주문상세(ORDER_ITEMS)에 대해 상품명(PRODUCT_NAME) 조회
SELECT
	oi.*,
	p.PRODUCT_NAME
FROM
	ORDER_ITEMS oi
JOIN PRODUCTS p 
ON
	oi.PRODUCT_ID = p.PRODUCT_ID;


-- 모든 배송에 대해 배송받는 고객의 이름 조회
SELECT
	c.FULL_NAME,
	s.DELIVERY_ADDRESS 
FROM
	CUSTOMERS c
JOIN SHIPMENTS s  
ON 
	c.CUSTOMER_ID = s.CUSTOMER_ID;



-- 재고(inventory) + 매장이름 + 상품명
SELECT
	i.PRODUCT_INVENTORY ,
	s.STORE_NAME ,
	p.PRODUCT_NAME
FROM
	INVENTORY i
JOIN STORES s ON
	i.STORE_ID = s.STORE_ID
JOIN PRODUCTS p ON
	i.PRODUCT_ID = p.PRODUCT_ID;


-- 고객이름, 주문일시(ORDER_TMS), 매장이름 조회
SELECT
	c.FULL_NAME ,
	o.ORDER_TMS ,
	s.STORE_NAME
FROM
	CUSTOMERS c
JOIN ORDERS o ON
	c.CUSTOMER_ID = o.CUSTOMER_ID
JOIN STORES s ON
	o.STORE_ID = s.STORE_ID;



-- 각 주문 상세 건에 대해 고객이름, 상품명, 수량을 조회
-- customers, orders, order_items, products
SELECT
	c.FULL_NAME ,
	p.PRODUCT_NAME ,
	oi.QUANTITY
FROM
	CUSTOMERS c
JOIN ORDERS o ON
	o.CUSTOMER_ID = c.CUSTOMER_ID
JOIN ORDER_ITEMS oi ON
	 o.ORDER_ID = oi.ORDER_ID
JOIN PRODUCTS p ON
	oi.PRODUCT_ID = p.PRODUCT_ID;




-- 각 배송 건에 대해 고객이름, 배송지, 매장이름 조회
SELECT
	c.FULL_NAME ,
	s.DELIVERY_ADDRESS ,
	s2.STORE_NAME
FROM
	CUSTOMERS c
JOIN SHIPMENTS s ON
	c.CUSTOMER_ID = s.CUSTOMER_ID
JOIN STORES s2 ON
	s.STORE_ID = s2.STORE_ID;



-- 각 주문 상세 건에 대해 상품명과 그 상품을 실제로 배송한 배송상태(shipment_status)를 조회
SELECT
	oi.ORDER_ID ,
	oi.LINE_ITEM_ID ,
	p.PRODUCT_NAME ,
	s.SHIPMENT_STATUS
FROM
	ORDER_ITEMS oi
JOIN PRODUCTS p ON
	oi.PRODUCT_ID = p.PRODUCT_ID
JOIN SHIPMENTS s ON oi.SHIPMENT_ID = s.SHIPMENT_ID;



-- left join
-- 한 번도 주문하지 않은 고객이 있는지 조회(customers, orders)
SELECT
	*
FROM
	CUSTOMERS c 
LEFT JOIN ORDERS o ON
	c.CUSTOMER_ID = o.CUSTOMER_ID
WHERE o.ORDER_ID IS NULL;



-- 아직 배송 정보가 없는 주문상세 건 조회(order_items, shipments)
SELECT
	oi.ORDER_ID ,
	oi.PRODUCT_ID ,
	s.SHIPMENT_ID
FROM
	ORDER_ITEMS oi
LEFT JOIN SHIPMENTS s ON
	oi.SHIPMENT_ID = s.SHIPMENT_ID
WHERE
	s.SHIPMENT_ID IS NULL;



-- 어떤 매장에도 배송된 적 없는 고객 정보 조회(customers, shipments)
SELECT
	c.CUSTOMER_ID ,
	c.FULL_NAME
FROM
	CUSTOMERS c
LEFT JOIN SHIPMENTS s ON
	c.CUSTOMER_ID = s.CUSTOMER_ID
WHERE
	s.SHIPMENT_ID IS NULL;


-- sum(), count(), avg()...
-- 고객별 총 주문건수
-- customer_id, full_name, 5
SELECT
	c.CUSTOMER_ID ,
	c.FULL_NAME,
	count(o.ORDER_ID)
FROM
	CUSTOMERS c
JOIN ORDERS o ON
	c.CUSTOMER_ID = o.CUSTOMER_ID
GROUP BY
	c.CUSTOMER_ID,
	c.FULL_NAME
ORDER BY 
	c.CUSTOMER_ID;



-- 매장별 재고 등록 상품 수와 총 재고수량 조회
SELECT
	s.STORE_ID,
	s.STORE_NAME,
	count(i.PRODUCT_ID) AS product_count,
	sum(i.PRODUCT_INVENTORY) AS total_inventory
FROM
	STORES s
JOIN INVENTORY i ON
	s.STORE_ID = i.STORE_ID
GROUP BY
	s.STORE_ID,
	s.STORE_NAME
ORDER BY
	s.STORE_ID;



-- 고객별 총 구매금액(unit_price * quantity)을 구하고 금액이 높은 순으로 정렬
SELECT
	c.CUSTOMER_ID ,
	c.FULL_NAME ,
	sum(oi.QUANTITY * oi.UNIT_PRICE) AS total_amount
FROM
	CUSTOMERS c
JOIN ORDERS o ON
	c.CUSTOMER_ID = o.CUSTOMER_ID
JOIN ORDER_ITEMS oi ON
	o.ORDER_ID = oi.ORDER_ID
GROUP BY 
	c.CUSTOMER_ID,
	c.FULL_NAME 
ORDER BY
	total_amount desc;


-- 매장별 매출 순위 조회(store + orders + order_items)
SELECT
	s.STORE_ID ,
	s.STORE_NAME ,
	sum(oi.unit_price * oi.quantity) AS total_amount
FROM
	ORDERS o
JOIN STORES s ON
	s.STORE_ID = o.STORE_ID
JOIN ORDER_ITEMS oi ON
	o.ORDER_ID = oi.ORDER_ID
GROUP BY
	s.STORE_ID ,
	s.STORE_NAME
ORDER BY
	total_amount desc;


-- 서브쿼리

-- 전체 상품의 평균단가보다 비싼 상품 조회
SELECT *
FROM PRODUCTS p 
WHERE p.UNIT_PRICE > (SELECT avg(p.UNIT_PRICE) FROM PRODUCTS p);


-- 각 상품에 대해 전체 평균단가와의 차액을 함께 조회(select 절 서브쿼리)
SELECT
	p.PRODUCT_ID ,
	p.PRODUCT_IMAGE ,
	p.UNIT_PRICE ,
	p.UNIT_PRICE - (
	SELECT
		avg(p.UNIT_PRICE)
	FROM
		PRODUCTS p) AS diff_from_avg
FROM
	PRODUCTS p;


-- 가장 최근에 주문한 건의 주문 정보 조회
SELECT *
FROM ORDERS o
WHERE o.ORDER_TMS = (SELECT max(o.ORDER_TMS) FROM ORDERS o);


-- 됴쿄지역 매장에서 발생한 주문만 조회
-- orders의 store_id가 서브쿼리 결과 in 인 경우
SELECT *
FROM
	ORDERS o
WHERE
	o.STORE_ID IN (
	SELECT
		s.STORE_ID
	FROM
		STORES s
	WHERE
		s.PHYSICAL_ADDRESS LIKE '%Tokyo%');


-- 'CANCELLED' 상태인 주문을 한 번이라도 한 적 있는 고객 조회
SELECT
	*
FROM
	CUSTOMERS c
WHERE
	c.CUSTOMER_ID IN
	(
	SELECT
		o.CUSTOMER_ID
	FROM
		ORDERS o
	WHERE
		o.ORDER_STATUS = 'CANCELLED');


-- 재고에 한번도 등록된 적 없는 상품 조회
SELECT
	p.PRODUCT_ID ,
	p.PRODUCT_NAME
FROM
	PRODUCTS p
WHERE
	p.PRODUCT_ID 
NOT IN (
	SELECT
		i.PRODUCT_ID
	FROM
		INVENTORY i);



-- 주문을 한 번이라도 한 고객 조회(EXISTS 사용)
SELECT
	c.CUSTOMER_ID ,
	c.FULL_NAME
FROM
	CUSTOMERS c
WHERE
	EXISTS (
	SELECT
		1
	FROM
		ORDERS o
	WHERE
		c.CUSTOMER_ID = o.CUSTOMER_ID
);



-- 재고수량이 0인 상품이 하나라도 있는 매장 조회(EXISTS 사용)
SELECT
	s.STORE_ID ,
	s.STORE_NAME
FROM
	STORES s
WHERE
	EXISTS (
	SELECT
		1
	FROM
		INVENTORY i
	WHERE
		i.PRODUCT_INVENTORY = 0 AND s.STORE_ID = i.STORE_ID);



-- 매장별 평균 상품 단가를 구하는 서브쿼리를 생성 뒤 전체 매장 평균보다 높은 매장만 다시 추출
SELECT
	*
FROM
	(
	SELECT
		s.STORE_ID,
		s.STORE_NAME,
		avg(p.UNIT_PRICE) AS avg_price
	FROM
		STORES s
	JOIN INVENTORY i ON
		s.STORE_ID = i.STORE_ID
	JOIN PRODUCTS p ON
		i.PRODUCT_ID = p.PRODUCT_ID
	GROUP BY
		s.STORE_ID,
		s.STORE_NAME) AS store_avg
WHERE
	avg_price > (
	SELECT
		avg(p.UNIT_PRICE)
	FROM
		PRODUCTS p);	




-- 각 고객에 대해 가장 최근 주문일을 서브쿼리로 구하고 그 주문의 매장 이름가지 함께 조회
SELECT
	c.CUSTOMER_ID ,
	c.FULL_NAME ,
	o.ORDER_TMS ,
	s.STORE_NAME
FROM
	CUSTOMERS c
JOIN ORDERS o ON
	c.CUSTOMER_ID = o.CUSTOMER_ID
	AND 
		o.ORDER_TMS = (
	SELECT
		max(o2.ORDER_TMS)
	FROM
		ORDERS o2
	WHERE
		o2.CUSTOMER_ID = c.CUSTOMER_ID)
JOIN STORES s ON
	s.STORE_ID = o.STORE_ID;



-- 상품별 판매 순위를 매기되 판매된 적이 한 번도 없는 상품도 0건으로 함께 조회
-- rank() over()


SELECT p.PRODUCT_ID ,p.UNIT_PRICE , RANK() OVER(ORDER BY p.UNIT_PRICE desc)
FROM PRODUCTS p;


SELECT
	p.PRODUCT_ID,
	p.PRODUCT_NAME ,
	NVL(sum(oi.QUANTITY), 0) AS total_sold,
	RANK() OVER(ORDER BY NVL(sum(oi.QUANTITY), 0) DESC) AS sales_rank
FROM
	PRODUCTS p
LEFT JOIN ORDER_ITEMS oi ON
	p.PRODUCT_ID = oi.PRODUCT_ID
GROUP BY
	p.PRODUCT_ID ,
	p.PRODUCT_NAME;
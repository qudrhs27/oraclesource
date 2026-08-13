-- scott 데이터베이스 접속

-- select : read

-- EMP 테이블의 모든 내용 보기
SELECT * FROM EMP e;

-- 조회할 때 특정 행 단위로 조회 (selection)
-- 조회할 때 특정 열 단위로 조회 (projection)

SELECT e.EMPNO , e.ENAME , e.MGR 
FROM EMP e;

-- 중복 데이터 제거
SELECT DISTINCT deptno FROM EMP e;

-- job 중복 데이터 제거
SELECT DISTINCT e.JOB FROM EMP e;

-- as 별칭
-- "별칭" or 별칭 (단, 별칭에 공백이 있다면 반드시 "" 사용)
-- as 키워드 생략 가능
SELECT e.EMPNO "사원 번호" , e.SAL * 12 AS 연봉
FROM EMP e

-- 정렬 : order by
-- 오름차순(default) : asc / 내림차순 : desc
SELECT e.EMPNO , e.ENAME 
FROM EMP e
ORDER BY e.EMPNO DESC;

-- e.EMPNO , e.ENAME, e.SAL / sal 내림차순
SELECT e.EMPNO , e.ENAME , e.SAL 
FROM EMP e
ORDER BY e.SAL DESC;

-- e.EMPNO , e.ENAME, e.SAL / deptno 오름차순, sal 내림차순
SELECT e.EMPNO , e.ENAME , e.SAL 
FROM EMP e
ORDER BY e.DEPTNO ASC, e.SAL DESC ;

-- emp 테이블의 별칭 deptno 내림, ename 오름
-- empno(EMPLOYEE_NO), ename(EMPLOYEE_NAME), mgr(MANAGER)
-- sal(SALARY), comm(COMMISSION), deptno(DEPARTMENT_NO)
SELECT
	e.empno AS EMPLOYEE_NO,
	e.ename AS EMPLOYEE_NAME,
	e.mgr AS MANAGER,
	e.sal AS SALARY,
	e.comm AS COMMISSION,
	e.deptno AS DEPARTMENT
FROM
	EMP e
ORDER BY
	e.DEPTNO DESC,
	e.ENAME ASC;

-- 조건
-- 부서번호가 30번인 직원 조회
-- = : 같다
SELECT *
FROM EMP e
WHERE e.DEPTNO = 30;

-- empno가 7782인 직원 조회
SELECT *
FROM EMP e
WHERE e.EMPNO = 7782;

-- 부서번호가 30번이고, 사원직책이 salesman 직원 조회
SELECT *
FROM EMP e
WHERE e.DEPTNO = 30 AND e.JOB = 'SALESMAN';

-- 사원번호가 7499이고 부서번호가 30인 사원 조회
SELECT *
FROM EMP e
WHERE e.EMPNO = 7499 AND e.DEPTNO = 30;

-- 부서번호가 30 이거나(or) 사원직책이 CLERK 사원 조회
SELECT *
FROM EMP e
WHERE e.DEPTNO = 30 OR e.JOB = 'CLERK';

-- sal(월급) 일때
-- 연봉이 36000 인 사원의 전체 정보 조회
SELECT *
FROM EMP e 
WHERE e.SAL * 12 >= 36000;

-- 월급여가 3000 초과인 사원의 전체 정보 조회
SELECT *
FROM EMP e
WHERE e.SAL > 3000;

-- 월급여가 2500 이상이고 사원직책이 ANALYST 인 사원의 전체 정보 조회
SELECT *
FROM EMP e 
WHERE e.SAL >= 2500 AND e.JOB = 'ANALYST';

-- 사원직책이 MANAGER, SALESMAN, CLERK 인 사원정보 조회
SELECT *
FROM EMP e
WHERE e.JOB = 'MANAGER' OR e.JOB = 'SALESMAN' OR e.JOB = 'CLERK';

-- ename의 시작이 f 이후의 문자로 시작하는 사원정보 조회
SELECT *
FROM EMP e 
WHERE e.ENAME >= 'F';

-- =(같다) !=(같이 않다)
SELECT * FROM EMP e WHERE e.SAL != 3000;
SELECT * FROM EMP e WHERE e.SAL <> 3000;
SELECT * FROM EMP e WHERE e.SAL ^= 3000;

-- IN
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- NOT IN
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- 부서번호가 10 이거나 20번인 사원 조회
SELECT *
FROM EMP e 
WHERE e.DEPTNO IN (10, 20);

-- 특정 범위 있는 값 추출할 때 사용 : BETWEEN A AND B
-- 급여가 2000 이상 3000 이하인 사원정보 조회
SELECT *
FROM EMP e 
WHERE e.SAL >= 2000 AND e.SAL <= 3000;

SELECT *
FROM EMP e 
WHERE e.SAL BETWEEN 2000 AND 3000;

-- 2000 이상 3000 이하가 아닌
SELECT *
FROM EMP e 
WHERE e.SAL NOT BETWEEN 2000 AND 3000;


-- like : 특정 문자 또는 특정 문자열을 포함하는 데이터를 조회
-- _ : 한 개의 문자 데이터를 의미
-- % : 길이와 상관없이 모든 문자 데이터를 의미

-- 사원 이름이 S로 시작하는 사원 정보 조회
SELECT *
FROM EMP e 
WHERE e.ENAME LIKE 'S%';

-- 사원 이름의 두번째 글자가 L인 사원 정보 조회
SELECT *
FROM EMP e 
WHERE e.ENAME LIKE '_L%';

-- 사원 이름에 AM이 포함되어 있는 사원만 조회
SELECT *
FROM EMP e 
WHERE e.ENAME LIKE '%AM%';

-- 사원 이름에 AM이 포함되어 있지 않는 사원만 조회
SELECT *
FROM EMP e 
WHERE e.ENAME NOT LIKE '%AM%';


-- IS NULL
-- comm이 NULL인 직원 조회
SELECT * FROM EMP e WHERE e.COMM IS NULL;

--mgr이 NULL인 직원 조회
SELECT * FROM EMP e WHERE e.MGR IS NULL;


-- NULL 에 산술, 비교 연산시 결과값은 모두 NULL 임
SELECT e.SAL , e.COMM , e.SAL * e.COMM, e.SAL + e.COMM  
FROM EMP e 


-- 집합 연산자
-- UNION, UNION ALL(중복인 결과값도 출력), MINUS, INTERSECT
SELECT e.EMPNO , e.ENAME , e.SAL , e.DEPTNO 
FROM EMP e WHERE e.DEPTNO = 10
UNION ALL 
SELECT e.EMPNO , e.ENAME , e.SAL, e.DEPTNO 
FROM EMP e WHERE e.DEPTNO = 10;


SELECT e.EMPNO , e.ENAME , e.SAL , e.DEPTNO 
FROM EMP e
MINUS 
SELECT e.EMPNO , e.ENAME , e.SAL, e.DEPTNO 
FROM EMP e WHERE e.DEPTNO = 10;


SELECT e.EMPNO , e.ENAME , e.SAL , e.DEPTNO 
FROM EMP e
INTERSECT 
SELECT e.EMPNO , e.ENAME , e.SAL, e.DEPTNO 
FROM EMP e WHERE e.DEPTNO = 10;


-----
-- 연습문제
-- 1. 사원명이 S로 끝나는 사원 데이터 조회
SELECT *
FROM EMP e
WHERE e.ENAME LIKE '%S';


-- 2. 30번 부서에서 근무하고 있는 사원 중에서 job이 SALESMAN인 사원의 사원번호,이름,직책,급여,부서번호 조회
SELECT e.EMPNO , e.ENAME , e.JOB , e.SAL , e.DEPTNO 
FROM EMP e 
WHERE e.DEPTNO = 30 AND e.JOB ='SALESMAN';


-- 3. 20번,30번 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원을 다음 두가지 방식의
-- SELECT 문을 사용하여 사원번호,이름,직책,급여,부서번호를 출력
-- 집합 연산자를 사용하지 않는 방식
SELECT e.EMPNO , e.ENAME , e.JOB , e.SAL , e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO IN (20, 30) AND e.SAL > 2000;
-- 집합 연산자를 사용한 방식
SELECT e.EMPNO , e.ENAME , e.JOB , e.SAL , e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO = 20 AND e.SAL > 2000
UNION 
SELECT e.EMPNO , e.ENAME , e.JOB , e.SAL , e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO = 30 AND e.SAL > 2000;

-- 4. NOT BETWEEN A AND B 연산자를 사용하지 않고 급여 열이 2000 이상 3000 이하 범위 이외의 값을
-- 가진 데이터만 출력
SELECT *
FROM EMP e 
WHERE e.SAL < 2000 OR e.SAL > 3000;


-- 5. 사원 이름에 E가 포함된 30번 부서의 사원 중 급여가 1000~2000 사이가 아닌 사원이름,사원번호,급여,부서번호 출력
SELECT e.ENAME , e.EMPNO , e.SAL , e.DEPTNO 
FROM EMP e 
WHERE e.ENAME LIKE '%E%' AND e.DEPTNO = 30 AND e.SAL NOT BETWEEN 1000 AND 2000;


-- 6. 추가수당이 존재하지 않고 상급자가 있으며, 직책이 MANAGER, CLERK인 사원 중에서 사원 이름의
-- 두번째 글자가 L이 아닌 사원의 정보 출력
SELECT
	*
FROM
	EMP e
WHERE
	e.COMM IS NULL
	AND e.MGR IS NOT NULL
	AND e.JOB IN ('MANAGER', 'CLERK')
	AND e.ENAME NOT LIKE '_L%';


-- 오라클 함수
-- 1. 문자 함수
-- upper(), lower(), initcap()

SELECT e.ENAME , upper(e.ENAME), lower(e.ENAME), initcap(e.ENAME)
FROM EMP e;

-- job이 salesman 인 직원 조회
SELECT *
FROM EMP e
WHERE lower(e.JOB) = 'salesman'


-- length(), lengthb() : 바이트 수 반환
SELECT e.ENAME , length(e.ENAME), lengthb(e.ENAME)
FROM EMP e;


-- dual : 더미 테이블
-- 한글 한자당 : 3byte
SELECT length('한글'), lengthb('한글')
FROM dual;


-- 직책 이름이 6자리 이상인 사원 조회
SELECT *
FROM EMP e 
WHERE length(e.JOB) >= 6;


-- substr(문자열데이터,시작위치,추출길이) : 부분 문자열 추출
SELECT e.JOB , substr(e.JOB,1,2) , substr(e.JOB,3,2) , substr(e.JOB,5)
FROM EMP e;

SELECT
	e.JOB ,
	substr(e.JOB, -LENGTH(e.JOB)) ,
	substr(e.JOB, -LENGTH(e.JOB), 2) ,
	substr(e.JOB, -3)
FROM
	EMP e;


-- instr(원본문자열,찾을문자,시작위치,찾으려는 문자가 몇번째인지) : 문자열 데이터 안에서 특정 문자 위치 찾기
-- index : 1부터 시작
SELECT
	instr('HELLO ORACLE!', 'L') AS INSTR_1,
	instr('HELLO ORACLE!', 'L', 5) AS INSTR_2,
	instr('HELLO ORACLE!', 'L', 2, 2) AS INSTR_3
FROM
	dual;


-- instr() 이용해서 사원이름에 S가 있는 사원 조회
SELECT *
FROM EMP e
WHERE instr(e.ENAME, 'S') > 0;


-- replace(원본,찾는문자,대체문자)
-- 010-1234-5678 에서 - 를 찾아서 공백으로 변경
SELECT '010-1234-5678' , replace('010-1234-5678', '-', ' ') , replace('010-1234-5678', '-')
FROM dual;


-- concat(문자1,문자2) : 두 문자열 데이터 연결
-- 7369 : SMITH
SELECT e.EMPNO , e.ENAME , concat(e.EMPNO,e.ENAME) , concat(e.EMPNO,concat(':',e.ENAME )) 
FROM EMP e 


-- ||
SELECT e.EMPNO , e.ENAME , e.EMPNO || e.ENAME, e.EMPNO || ':' || e.ENAME  
FROM EMP e 


-- 데이터의 공간을 특정 문자로 채우는 LPAD, RPAD
SELECT
	'Oracle',
	LPAD('Oracle', 10, '#'),
	RPAD('Oracle', 10, '*'),
	LPAD('Oracle', 10),
	RPAD('Oracle', 10)
FROM
	dual;


SELECT rpad('971225-',14,'*')
FROM dual;


-- 특정 문자를 지우는 TRIM, LTRIM, RTRIM
-- 삭제할 문자 미지정 시 공백 제거
SELECT
	'[' || trim(' __Oracle__ ') || ']' AS trim,
	'[' || ltrim(' __Oracle__ ') || ']' AS ltrim,
	'[' || rtrim(' __Oracle__ ') || ']' AS rtrim
FROM
	dual;


SELECT
	'[' || trim('_' FROM '__Oracle__') || ']' AS trim,
	'[' || ltrim('<__Oracle__>', '_<') || ']' AS ltrim,
	'[' || rtrim('<__Oracle__>', '>_') || ']' AS rtrim
FROM
	dual;


-- 2. 숫자함수
-- round(), trunc(), ceil(), floor(), mod()
SELECT
	round(1234.5678) AS round,
	round(1234.5678, 0) AS round0,
	round(1234.5678, 1) AS round1,
	round(1234.5678, 2) AS round2,
	round(1234.5678, -1) AS round_minus1,
	round(1234.5678, -2) AS round_minus2
FROM
	dual;


-- trunc : 특정위치에서 버림
SELECT
	trunc(1234.5678) AS trunc,
	trunc(1234.5678, 0) AS trunc0,
	trunc(1234.5678, 1) AS trunc1,
	trunc(1234.5678, 2) AS trunc2,
	trunc(1234.5678, -1) AS trunc_minus1,
	trunc(1234.5678, -2) AS trunc_minus2
FROM
	dual;


-- ceil() : 지정한 숫자와 가까운 큰 정수
-- floor() : 지정한 숫자와 가까운 작은 정수

SELECT ceil(3.14), floor(3.14), ceil(-3.14), floor(-3.14)
FROM dual;


-- mod() == %
SELECT mod(15,6), mod(10,2), mod(11,2)
FROM dual;


-- 3. 날짜함수
SELECT SYSDATE, SYSDATE - 1, SYSDATE + 1
FROM dual;


-- 현재 날짜를 기준으로 3개월 이후 날짜 조회 : add_months()
SELECT SYSDATE, ADD_MONTHS(sysdate, 3)
FROM dual;

-- 두 날짜간의 개월 수 차이 : months_between()

SELECT
	e.EMPNO ,
	e.HIREDATE ,
	SYSDATE,
	MONTHS_BETWEEN(e.HIREDATE, sysdate) AS month1,
	MONTHS_BETWEEN(sysdate, e.HIREDATE) AS month2,
	trunc(MONTHS_BETWEEN(sysdate, e.HIREDATE)) AS month3
FROM
	EMP e;



-- last_day(날짜) : 날짜가 속한 달의 마지막 날짜 출력
-- next_day(날짜 ,요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜를 출력

SELECT SYSDATE , last_day(sysdate), next_day(sysdate, '금요일')
FROM dual;



-- 형변환 함수
-- 1. to_char() : 숫자,날짜 데이터 => 문자 데이터 변환
-- 2. to_number() : 문자 데이터 => 숫자 데이터 변환
-- 3. to_date() : 문자 데이터 => 날짜 데이터 변환

SELECT sysdate, to_char(sysdate, 'YYYY/MM/DD')
FROM dual;

SELECT
	sysdate,
	to_char(sysdate, 'MM'),
	to_char(sysdate, 'MON'),
	to_char(sysdate, 'MONTH'),
	to_char(sysdate, 'DD'),
	to_char(sysdate, 'DY'),
	to_char(sysdate, 'DAY')
FROM dual;


SELECT
	sysdate,
	to_char(sysdate, 'HH24:MI:SS'),
	to_char(sysdate, 'HH12:MI:SS AM'),
	to_char(sysdate, 'HH:MI:SS P.M.')
FROM dual;


-- 문자숫자와 산술연산 시 자동으로 숫자데이터로 형변환 발생
SELECT 1300-'1500', '1300'+1500
FROM dual;

--SELECT '1,300'-'1,500', '1,300'+'1,500'
--FROM dual;


SELECT
	to_number('1,300', '999,999') - to_number('1,500', '999,999')
FROM
	dual;


-- 널 처리함수
-- NVL(널값,널일때변경할값), NVL2(널값,널이아닐때,널일때변경할값)

SELECT e.EMPNO , e.ENAME , e.SAL , NVL(e.COMM, 0) , e.SAL +  NVL(e.COMM ,0)
FROM EMP e;

SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL ,
	NVL2(e.COMM, 'O', 'X') ,
	NVL2(e.COMM , e.SAL * 12 + e.COMM , e.SAL * 12)
FROM
	EMP e;

-- SQL Error [1722] [42000]: ORA-01722: 수치가 부적합합니다
SELECT NVL(e.COMM, 'N/A')
FROM EMP e;

SELECT NVL(to_char(e.COMM), 'N/A')
FROM EMP e;


-- DECODE(검사대상이 될 열,
--       조건1, 조건1이 만족하면 반환할 값,
--       조건2,조건2이 만족하면 반환할 값,
--       '위 조건과 일치하지 않는 경우'
--)

-- 직책이 MANAGER 인 사원은 SAL * 10%, SALESMAN 5%, ANALYST 는 그대로, 나머지 3%
-- 사원번호, 이름, 직책, 급여 출력
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	DECODE(e.JOB,
	'MANAGER', e.SAL * 1.1,
	'SALESMAN', e.SAL * 1.05,
	'ANALSY', e.SAL,
	e.SAL * 1.03
	) AS 급여
FROM
	EMP e;
	
	
-- CASE 검사대상이 될 열,
--      WHEN 조건1 THEN 조건1이 만족하면 반환할 결과
--      WHEN 조건2 THEN 조건2이 만족하면 반환할 결과
--      ELSE '위 조건과 일치하지 않는 경우'
-- END
	
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	CASE 
		e.JOB
		WHEN 'MANAGER' THEN e.SAL * 1.1
		WHEN 'SALESMAN' THEN e.SAL * 1.05
		WHEN 'ANALSY' THEN e.SAL
		ELSE e.SAL * 1.03
	END AS 급여
FROM
	EMP e;


-- COMM 널이면 '해당없음' / COMM = 0 '수당없음' / COMM > 0 '수당 : 800'
-- COMM_TEXT 컬럼명 사용

SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	CASE 
		WHEN e.COMM IS NULL THEN '해당없음'
		WHEN e.COMM = 0 THEN '수당없음'
		WHEN e.COMM > 0 THEN  '수당 : ' || e.COMM
	END AS COMM_TEXT
FROM
	EMP e;


-- 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원이 정직원이 되는 날짜를 YYYY-MM-DD 형식으로 출력(R_JOB)
-- 단, 추가수당이 없는 사원의 추가수당은 N/A 로 출력(COMM)
-- 사원번호,이름,고용일
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.HIREDATE ,
	to_char(next_day(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	NVL(to_char(e.COMM), 'N/A') AS COMM
FROM
	EMP e;


-- MGR 을 기준으로 CHG_MGR 컬럼에 출력
-- 직속상관 번호가 없는 경우 0000
-- 직속상관 앞 번호 2자리가 75 5555
-- 직속상관 앞 번호 2자리가 76 6666
-- 직속상관 앞 번호 2자리가 77 7777
-- 직속상관 앞 번호 2자리가 78 8888
-- 그외는 본래 직속상관의 사번 그대로 출력
SELECT
	e.MGR,
	CASE
		WHEN e.MGR IS NULL THEN '0000'
		WHEN SUBSTR(to_char(e.MGR), 1, 2) = '75' THEN '5555'
		WHEN SUBSTR(to_char(e.MGR), 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(to_char(e.MGR), 1, 2) = '77' THEN '7777'
		WHEN SUBSTR(to_char(e.MGR), 1, 2) = '78' THEN '8888'
		ELSE to_char(e.MGR)
	END AS CHG_MGR
FROM
	EMP e;




-- 다중행 함수
-- sum(), avg(), count(), max(), min()

-- 추가 수당 총계
SELECT sum(e.COMM)
FROM EMP e;

-- 급여 총계
SELECT sum(e.SAL), sum(DISTINCT e.SAL), sum (ALL e.SAL)
FROM EMP e;


-- 개수
SELECT
	count(e.COMM),
	count(*),
	count(e.SAL),
	count(DISTINCT e.SAL),
	count(ALL e.SAL)
FROM
	EMP e;


-- 최대값, 최소값
SELECT max(e.SAL), min(e.SAL)
FROM EMP e;

-- 10번 부서의 최고급여와 최저급여 조회
SELECT max(e.SAL), min(e.SAL)
FROM EMP e
WHERE e.DEPTNO = 10;

SELECT max(e.HIREDATE), min(e.HIREDATE)
FROM EMP e;


-- 평균
SELECT
	avg(e.SAL),
	avg(DISTINCT e.SAL),
	avg(ALL e.SAL)
FROM
	EMP e;

-- SQL Error [937] [42000]: ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
SELECT e.EMPNO, sum(e.COMM)
FROM EMP e;


-- 결과값을 원하는 열로 묶어 출력 : group by

-- 부서별 급여 평균 구하기
SELECT
	e.DEPTNO,
	avg(e.SAL)
FROM
	EMP e
GROUP BY
	e.DEPTNO;

-- 부서별,직책별 급여 평균 구하기
SELECT
	e.DEPTNO,
	e.JOB,
	avg(e.SAL)
FROM
	EMP e
GROUP BY
	e.DEPTNO,
	e.JOB
ORDER BY
	e.DEPTNO,
	e.JOB;


-- group by ~~ having
-- where 절에 그룹함수 사용 불가
-- having : 만든 그룹을 조건별로 출력할 때 사용
-- where 절과 having 이 존재 시 where 가 먼저 실행 됨

-- SQL Error [934] [42000]: ORA-00934: 그룹 함수는 허가되지 않습니다
SELECT
	e.DEPTNO,
	e.JOB,
	avg(e.SAL)
FROM
	EMP e
WHERE
	avg(e.SAL) > 200
GROUP BY
	e.DEPTNO,
	e.JOB;

-- 부서별, 직책별 급여 평균 구하기(단, 급여가 2000 이상인 평균그룹만 출력)
SELECT
	e.DEPTNO,
	e.JOB,
	avg(e.SAL)
FROM
	EMP e
GROUP BY
	e.DEPTNO,
	e.JOB
HAVING
	avg(e.SAL) >= 200
ORDER BY
	e.DEPTNO, e.JOB;


-- 급여가 3000 이하인 직원들의 부서별,직책별 급여 평균 구하기(단, 급여가 2000 이상인 평균그룹만 출력)
SELECT
	e.DEPTNO,
	e.JOB,
	avg(e.SAL)
FROM
	EMP e
WHERE
	e.SAL <= 3000
GROUP BY
	e.DEPTNO,
	e.JOB
HAVING
	avg(e.SAL) >= 2000
ORDER BY
	e.DEPTNO, e.JOB;


-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원 수를 출력
-- MANAGER 3
SELECT
	e.JOB,
	count(*)
FROM
	EMP e
GROUP BY
	e.JOB
HAVING
	count(e.JOB) >= 3;
	

-- 사원들의 입사연도를 기준으로 부서별로 몇명이 입사했는지 출력
-- 입사연도 to_char()
-- 1981 10 1
SELECT to_char(e.HIREDATE, 'YYYY') , e.DEPTNO , count(*)
FROM EMP e 
GROUP BY to_char(e.HIREDATE, 'YYYY') , e.DEPTNO;


-- 데이터베이스 설계
-- 데이터를 효율적으로 저장하고 관리하기 위해 테이블의 구조를 미리 정하는 것

-- 조인 : 여러 테이블을 하나의 테이블처럼 사용
-- 1) 내부조인(INNER JOIN)
-- 2) 외부조인(OUTER JOIN)
--    - LEFT OUTER JOIN
--    - RIGHT OUTER JOIN
--    - FULL OUTER JOIN

-- 48행
SELECT *
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO
ORDER BY e.EMPNO;

-- (INNER) JOIN ~ ON
-- 두 개의 테이블에서 일치한 정보(등가조인)를 기준으로 특정 열 가져오기
SELECT
	e.EMPNO , e.ENAME , e.DEPTNO , d.DNAME , d.LOC 
FROM
	EMP e
JOIN DEPT d
ON
	e.DEPTNO = d.DEPTNO
ORDER BY
	e.EMPNO;

-- 비등가 조인
-- EMP + SALGRADE
-- SAL 800 => 700 ~ 1200 => GRADE 추출

SELECT *
FROM EMP e, SALGRADE s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY e.EMPNO;


SELECT
	e.EMPNO , e.ENAME , e.SAL , s.GRADE 
FROM
	EMP e
INNER JOIN SALGRADE s
ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY
	e.EMPNO;


-- SELF JOIN
-- 자체 조인
SELECT e.EMPNO , e.ENAME , e.MGR , e2.ENAME
FROM EMP e, EMP e2
WHERE e.MGR = e2.EMPNO
ORDER BY e.EMPNO;


-- 열의 정의가 애매합니다
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.MGR ,
	e2.ENAME
FROM
	EMP e
JOIN EMP e2
ON
	e.MGR = e2.EMPNO
ORDER BY
	e.EMPNO;


-- 외부조인 : 일치하지 않는 정보 가져오기(단, 왼쪽테이블 기준? 오른쪽테이블 기준)
-- LEFT OUTER JOIN (왼쪽 외부 조인)
SELECT e.EMPNO , e.ENAME , e.MGR , e2.ENAME
FROM EMP e, EMP e2
WHERE e.MGR = e2.EMPNO(+)
ORDER BY e.EMPNO;

-- RIGHT OUTER JOIN (오른쪽 외부 조인)
SELECT e.EMPNO , e.ENAME , e.MGR , e2.ENAME
FROM EMP e, EMP e2
WHERE e.MGR(+) = e2.EMPNO
ORDER BY e.EMPNO;


-- LEFT (OUTER) JOIN / RIGHT (OUTER) JOIN

SELECT
	e.EMPNO ,
	e.ENAME ,
	e.MGR ,
	e2.ENAME
FROM
	EMP e
LEFT JOIN EMP e2
ON
	e.MGR = e2.EMPNO
ORDER BY
	e.EMPNO;


SELECT
	e.EMPNO ,
	e.ENAME ,
	e.MGR ,
	e2.ENAME
FROM
	EMP e
RIGHT JOIN EMP e2
ON
	e.MGR = e2.EMPNO
ORDER BY
	e.EMPNO;


SELECT
	e.EMPNO ,
	e.ENAME ,
	e.MGR ,
	e2.ENAME
FROM
	EMP e
FULL JOIN EMP e2
ON
	e.MGR = e2.EMPNO
ORDER BY
	e.EMPNO;


-- 사원,부서 정보 출력(단, 급여가 2000초과인 사원만)
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.DEPTNO ,
	d.DNAME ,
	d.LOC
FROM
	EMP e
JOIN DEPT d
ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.SAL > 2000
ORDER BY
	e.EMPNO;



-- 서브쿼리
--SELECT
--FROM EMP e
--WHERE e.EMPNO = (SELECT FROM EMP e)

-- 왼쪽 메인쿼리  오른쪽 (서브쿼리)

-- 단일행 서브 쿼리
-- =, >=, <, <=, <>, ^=, !=

-- jones의 급여보다 높은 급여를 받는 사원 조회
SELECT * FROM EMP e WHERE e.SAL > (SELECT e2.SAL FROM EMP e2 WHERE e2.ENAME = 'JONES');

-- WARD 의 입사일보다 빨리 입사한 사원 조회
SELECT * FROM EMP e WHERE e.HIREDATE < (SELECT e2.HIREDATE FROM EMP e2 WHERE e2.ENAME = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균급여보다 높은 급여를 받는 사원 조회
-- 부서정보(부서명,위치) 조회
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	d.DNAME ,
	d.LOC 
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.DEPTNO = 20
	AND e.SAL > (
	SELECT
		avg(e2.SAL)
	FROM
		EMP e2);


-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
SELECT * FROM EMP e WHERE e.SAL > (SELECT e2.SAL FROM EMP e2 WHERE e2.JOB = 'MANAGER');
SELECT * FROM EMPLOYEES e;

-- EMPLOYEES에서 first_name, last_name, job_id 컬럼만 조회
SELECT e.FIRST_NAME , e.LAST_NAME , e.JOB_ID FROM EMPLOYEES e;

-- EMPLOYEES에서 연봉이 12000 이상 되는 직원들의 LAST_NAME, SALARY 조회
SELECT e.LAST_NAME , e.SALARY 
FROM EMPLOYEES e
WHERE e.SALARY >= 12000;

-- 사원번호가 176인 직원의 LAST_NAME, DEPARTMENT_ID 조회
SELECT e.LAST_NAME , e.DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE e.EMPLOYEE_ID = 176;

-- 연봉이 5000에서 12000 범위 이외인 사람들의 LAST_NAME, SALARY 조회
SELECT e.LAST_NAME , e.SALARY 
FROM EMPLOYEES e 
WHERE e.SALARY < 5000 OR e.SALARY > 12000;

-- 20번 OR 50번 부서에서 근무하는 모든 사원들의
-- LAST_NAME, DEPARTMENT_ID 오름차순
SELECT e.LAST_NAME , e.DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE e.DEPARTMENT_ID IN (20, 50)
ORDER BY e.LAST_NAME, e.DEPARTMENT_ID;

-- 커미션이 0보다 큰 사원들의 LAST_NAME, SALARY, COMMISSION_PCT 조회
-- 단, SALARY 내림차순, COMMISSION_PCT 내림차순
SELECT
	e.LAST_NAME ,
	e.SALARY ,
	e.COMMISSION_PCT
FROM
	EMPLOYEES e
WHERE
	e.COMMISSION_PCT > 0
ORDER BY
	e.SALARY DESC,
	e.COMMISSION_PCT DESC;

-- SALARY가 2500 OR 3500 OR 7000 이 아니며 JOB_ID가
-- SA_REP OR ST_CLERK 인 직원 조회
SELECT
	*
FROM
	EMPLOYEES e
WHERE
	e.SALARY NOT IN (2500, 3500, 7000) AND e.JOB_ID IN ('SA_REP', 'ST_CLERK');

-- 2015년도에 고용된 직원 조회 후 입사일(HIRE_DATE) 기준으로 오름차순
SELECT *
FROM EMPLOYEES e 
WHERE e.HIRE_DATE >= '2015-01-01' AND e.HIRE_DATE <= '2015-12-31'
ORDER BY e.HIRE_DATE;

-- 20번 OR 50번 부서에서 근무하는 모든 사원들의
-- LAST_NAME, DEPARTMENT_ID 오름차순
-- 단, SALARY가 5000 ~ 12000 이하인
SELECT e.LAST_NAME , e.DEPARTMENT_ID 
FROM EMPLOYEES e 
WHERE e.DEPARTMENT_ID IN (20, 50) AND e.SALARY BETWEEN 5000 AND 12000
ORDER BY e.LAST_NAME, e.DEPARTMENT_ID;


-- SALARY가 5000 ~ 12000 범위가 아닌 직원들의
-- LAST_NAME, SALARY 조회
SELECT e.LAST_NAME , e.SALARY 
FROM EMPLOYEES e 
WHERE e.SALARY NOT BETWEEN 5000 AND 12000;

-- 2015년도에 고용된 직원 조회
SELECT *
FROM EMPLOYEES e 
WHERE e.HIRE_DATE BETWEEN '2015-01-01' AND '2015-12-31';


-- last_name에 u가 포함된 사원들의 first_name, last_name, employee_id 조회
SELECT e.FIRST_NAME , e.LAST_NAME , e.EMPLOYEE_ID 
FROM EMPLOYEES e
WHERE e.LAST_NAME LIKE '%U%';


-- last_name 의 네번째 글자가 a인 사원들의 employee_id, first_name, last_name 조회
SELECT e.FIRST_NAME , e.LAST_NAME , e.EMPLOYEE_ID 
FROM EMPLOYEES e
WHERE e.LAST_NAME LIKE '___a%';


-- last_name 에 a 혹은 e 글자가 있는 사원들의 employee_id, first_name, last_name 조회
SELECT e.FIRST_NAME , e.LAST_NAME , e.EMPLOYEE_ID 
FROM EMPLOYEES e
WHERE e.LAST_NAME LIKE '%a%' OR e.LAST_NAME LIKE '%e%';


-- manager_id가 없는 직원들의 last_name, job_id 조회
SELECT e.LAST_NAME , e.JOB_ID 
FROM EMPLOYEES e 
WHERE e.MANAGER_ID IS NULL;


-- ST_CLERK인 직업 id를 가진 사원이 없는 부서 id 조회(단, 부서번호가 NULL인 경우 제외)
SELECT DISTINCT e.DEPARTMENT_ID 
FROM EMPLOYEES e 
WHERE e.JOB_ID != 'ST_CLERK' AND e.DEPARTMENT_ID IS NOT NULL;


-- COMMISSION_PCT가 NULL이 아닌 사원들 중에서 COMMISSION = SALARY * COMMISSION_PCT를 구한 후
-- EMPLOYEE_ID, FIRST_NAME, JOB_ID 조회
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.JOB_ID, SALARY * COMMISSION_PCT AS COMMISSION
FROM EMPLOYEES e 
WHERE e.COMMISSION_PCT IS NOT NULL;


-- 문자열 함수
-- first_name 이 Curtis인 사람의 first_name,last_name,email,phone_number,job_id 조회
-- 단, job_id의 결과는 소문자로 출력
SELECT e.FIRST_NAME , e.LAST_NAME , e.EMAIL , e.PHONE_NUMBER , lower(e.JOB_ID)
FROM EMPLOYEES e 
WHERE e.FIRST_NAME = 'Curtis';


-- 부서번호가 60,70,80,90인 사원들의 employee_id, first_name, hire_date, job_id를 조회
-- 단, job_id 가 IT_PROG인 사원의 경우 '프로그래머'로 변경후 출력
SELECT
	e.EMPLOYEE_ID ,
	e.FIRST_NAME ,
	e.HIRE_DATE ,
	REPLACE(e.JOB_ID, 'IT_PROG', '프로그래머')
FROM
	EMPLOYEES e
WHERE
	e.DEPARTMENT_ID IN (60, 70, 80, 90)


-- JOB_ID가 AD_PRES, PU_CLERK인 사원들의 EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
-- JOB_ID를 조회, 단, 사원명은 FIRST_NAME, LAST_NAME을 연결하여 출력(사이에 공백 하나 포함)
SELECT
	e.EMPLOYEE_ID ,
	e.FIRST_NAME || ' ' || e.LAST_NAME ,
	e.DEPARTMENT_ID ,
	e.JOB_ID
FROM
	EMPLOYEES e
WHERE
	e.JOB_ID IN ('AD_PRES', 'PU_CLERK'); 


-- 입사 10주년이 되는 날짜
-- 사원번호, 이름(f,l), 입사일
SELECT e.EMPLOYEE_ID , e.FIRST_NAME  || ' ' || e.LAST_NAME, ADD_MONTHS(e.HIRE_DATE, 120)
FROM EMPLOYEES e;



-- 회사 내의 최대연봉 및 최소연봉 차이를 조회(SAL_GAP)
SELECT MAX(e.SALARY) - min(e.SALARY) AS SAL_GAP
FROM EMPLOYEES e;


-- 매니저로 근무하는 사원들의 총 수 조회(매니저수)
SELECT count(DISTINCT e.MANAGER_ID) AS "매니저수"
FROM EMPLOYEES e;


-- 부서별 급여의 평균 연봉 출력(평균은 반올림)
-- 부서번호, 평균
SELECT e.DEPARTMENT_ID , round(avg(e.SALARY))
FROM EMPLOYEES e
GROUP BY e.DEPARTMENT_ID
ORDER BY e.DEPARTMENT_ID;


-- 동일한 직업을 가진 사원들의 총 수를 출력
-- 부서번호, job_id
SELECT e.DEPARTMENT_ID, count(*)
FROM EMPLOYEES e
GROUP BY e.DEPARTMENT_ID , e.JOB_ID
ORDER BY e.DEPARTMENT_ID , e.JOB_ID;


-- 매니저가 없는 사원들은 제외하고 매니저가 관리하는 사원들 중에서 최소 급여를 받는 사원들 출력
-- 단, 매니저가 관리하는 사원들 중에서 연봉이 6000 미만인 사원 제외
SELECT e.MANAGER_ID , min(e.SALARY) 
FROM EMPLOYEES e
WHERE e.MANAGER_ID IS NOT NULL
GROUP BY e.MANAGER_ID
HAVING min(e.SALARY) >= 6000;


-- 실행순서
-- from -> where -> group by -> having -> select -> order by -> 최종결과에서 N 개 가져오기


-- 자신의 담당 매니저의 입사일보다 빠른 입사자 찾기
-- SELF JOIN
SELECT
	e.EMPLOYEE_ID AS 사번,
	e.FIRST_NAME AS 이름,
	e.MANAGER_ID AS 매니저아이디,
	e.HIRE_DATE AS 내입사일,
	m.FIRST_NAME AS 매니저명,
	m.HIRE_DATE AS 매니저입사일
FROM
	EMPLOYEES e
JOIN EMPLOYEES m
ON
	e.MANAGER_ID = m.EMPLOYEE_ID
WHERE
	e.HIRE_DATE < m.HIRE_DATE;
	



-- 위치 아이디가 1700인 사원들의 LAST_NAME, DEPARTMENT_ID, SALARY 조회
-- E,D
SELECT
	e.LAST_NAME ,
	e.DEPARTMENT_ID ,
	e.SALARY
FROM
	EMPLOYEES e
JOIN DEPARTMENTS d
ON 
	e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE d.LOCATION_ID = 1700;



-- Executive 부서에 근무하는 모든 사원들의 부서번호, LAST_NAME, DEPARTMENT_ID, SALARY,JOB_IB 조회
SELECT
	e.DEPARTMENT_ID ,
	e.LAST_NAME ,
	e.DEPARTMENT_ID ,
	e.SALARY ,
	e.JOB_ID 
FROM
	EMPLOYEES e
JOIN DEPARTMENTS d
ON 
	e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE d.DEPARTMENT_NAME = 'Executive';
	


-- 각 사원별 소속부서에서 자신보다 늦게 고용되었으나 더 많은 연봉을 받는 사원이 존재하는 사원정보 조회
-- 사번, 이름(FI + LAS)
SELECT
	DISTINCT
	e1.EMPLOYEE_ID ,
	e1.FIRST_NAME || ' ' || e1.LAST_NAME
FROM
	EMPLOYEES e1
JOIN EMPLOYEES e2 
ON 
	e1.EMPLOYEE_ID = e2.EMPLOYEE_ID
WHERE
	e1.HIRE_DATE < e2.HIRE_DATE
	AND e1.SALARY < e2.SALARY;
 


-- 도시 이름이 T로 시작하는 지역에 사는 사원들의 사번,LAST_NAME,부서번호
SELECT
	e.EMPLOYEE_ID , e.LAST_NAME , e.DEPARTMENT_ID, l.CITY 
FROM
	DEPARTMENTS d
JOIN EMPLOYEES e ON
	d.DEPARTMENT_ID = e.DEPARTMENT_ID
JOIN LOCATIONS l ON
	d.LOCATION_ID = l.LOCATION_ID
WHERE
	l.CITY LIKE 'T%';


-- 서브쿼리
-- JOB_ID가 'SA_MAN'인 사원들의 최대 연봉보다 높게 받는 사원들의 정보 조회
-- 사원번호,LAST_NAME,JOB_ID,SALARY 조회
SELECT e.EMPLOYEE_ID , e.LAST_NAME , e.JOB_ID , e.SALARY
FROM EMPLOYEES e 
WHERE e.SALARY > (SELECT max(e2.SALARY) FROM EMPLOYEES e2 WHERE e2.JOB_ID = 'SA_MAN');


-- 커미션을 받는 사원들의 부서와 연봉이 동일한 사원들의 정보 조회
-- 사원번호,LAST_NAME,JOB_ID,SALARY,부서번호 조회
SELECT e.EMPLOYEE_ID , e.LAST_NAME , e.JOB_ID , e.SALARY
FROM EMPLOYEES e
WHERE (e.DEPARTMENT_ID e.SALARY) IN (SELECT e2.DEPARTMENT_ID, e2.SALARY FROM EMPLOYEES e2 WHERE e2.COMMISSION_PCT IS NOT NULL);


-- from 절 서브쿼리
-- 회사 전체 평균 연봉보다 더 받는 사원들 중 LAST_NAME에 u가 들어있는 사원들이 근무하는 부서에서
-- 커미션을 받는 사원들의 부서와 연봉이 동일한 사원들의 정보 조회
-- 사원번호,LAST_NAME,JOB_ID,SALARY 조회
SELECT
	e.EMPLOYEE_ID ,
	e.LAST_NAME ,
	e.JOB_ID ,
	e.SALARY
FROM
	EMPLOYEES e,
	(
	SELECT
		DISTINCT e2.DEPARTMENT_ID
	FROM
		employees e2
	WHERE
		e2.SALARY >
		(
		SELECT
			round(avg(e3.SALARY))
		FROM
			EMPLOYEES e3)
		AND e2.LAST_NAME LIKE '%u%') dept
WHERE
	e.DEPARTMENT_ID = dept.DEPARTMENT_ID;



-- 위치 id가 1700인 사원들의 급여,커미션 추출 후 추출된 사원들의 급여와 커미션이 동일한 사원 정보 조회
-- 사원번호,FIRST_NAME + LAST_NAME,SALARY 조회
SELECT
	e.EMPLOYEE_ID ,
	e.FIRST_NAME || ' ' || e.LAST_NAME ,
	e.DEPARTMENT_ID ,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	(e.SALARY,
	NVL(e.COMMISSION_PCT, 0)) IN (
	SELECT
		e2.SALARY,
		NVL(e2.COMMISSION_PCT, 0)
	FROM
		EMPLOYEES e2
	JOIN DEPARTMENTS d ON
		e2.DEPARTMENT_ID = d.DEPARTMENT_ID
	WHERE
		d.LOCATION_ID = 1700
);


-- 스칼라서브쿼리 사용
-- 총 사원수 및 각 년도별로 고용된 사원들의 총 숫자 조회
-- 총사원수 2011입사자 2012입사자...
SELECT (SELECT count(*) FROM EMPLOYEES e) AS 총사원수,
(SELECT count(*) FROM EMPLOYEES e WHERE to_char(e.HIRE_DATE, 'YYYY') = '2011') AS "2011입사자",
(SELECT count(*) FROM EMPLOYEES e WHERE to_char(e.HIRE_DATE, 'YYYY') = '2012') AS "2012입사자",
(SELECT count(*) FROM EMPLOYEES e WHERE to_char(e.HIRE_DATE, 'YYYY') = '2013') AS "2013입사자",
(SELECT count(*) FROM EMPLOYEES e WHERE to_char(e.HIRE_DATE, 'YYYY') = '2014') AS "2014입사자",
(SELECT count(*) FROM EMPLOYEES e WHERE to_char(e.HIRE_DATE, 'YYYY') = '2015') AS "2015입사자",
(SELECT count(*) FROM EMPLOYEES e WHERE to_char(e.HIRE_DATE, 'YYYY') = '2016') AS "2016입사자",
(SELECT count(*) FROM EMPLOYEES e WHERE to_char(e.HIRE_DATE, 'YYYY') = '2017') AS "2017입사자",
(SELECT count(*) FROM EMPLOYEES e WHERE to_char(e.HIRE_DATE, 'YYYY') = '2018') AS "2018입사자"
FROM EMPLOYEES e;
-- 대소문자 구별 안함
-- 비밀번호만 대소문자 구별 함
ALTER SESSION SET "_oracle_script"=TRUE;
@C:\Users\soldesk\Downloads\db-sample-schemas-main\db-sample-schemas-main\human_resources\hr_install.sql
@C:\Users\soldesk\Downloads\db-sample-schemas-main\db-sample-schemas-main\customer_orders\co_install.SQL
@C:\Users\soldesk\Downloads\db-sample-schemas-main\db-sample-schemas-main\sales_history\sh_install.SQL
@C:\app\soldesk\product\21c\dbhomeXE\rdbms\admin\scott.SQL

SELECT * FROM dba_tables;
SELECT * FROM dba_users WHERE username = 'SCOTT';

-- scott 에게 view 생성 권한 부여
GRANT CREATE VIEW TO scott;

-- 사용자 관리
-- 사용자 생성
-- CREATE USER 사용자이름 IDENTIFIED BY 비밀번호;

-- 공통 사용자 또는 롤 이름이 부적합합니다.
-- 'C##' 키워드 앞에 붙이기
CREATE USER C##TEST_USER1 IDENTIFIED BY 12345;
DROP USER C##TEST_USER1;


-- 'C##' 키워드 없이 사용자 생성
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER TEST_USER2 IDENTIFIED BY 12345;

GRANT CREATE SESSION TO TEST_USER2;

-- 개별권한 묶어서 관리 => 롤
-- 필수 권한 한꺼번에 주기
GRANT CONNECT, resource TO TEST_USER2;

-- 권한 취소
REVOKE CONNECT, resource FROM TEST_USER2;

DROP USER TEST_USER2 CASCADE;


-- python 사용자
CREATE USER python_user IDENTIFIED BY 12345
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
quota 10M ON users;

GRANT CONNECT, resource TO python_user;

-- 비밀번호 변경
ALTER USER python_user IDENTIFIED BY 54321;

-- 오라클은 사용자별로 객체 생성
-- 스키마 : 관계, 데이터 구조, 제약조건 등 데이터를 관리하고자 정의한 데이터베이스 구조 범위
-- 사용자 == 스키마
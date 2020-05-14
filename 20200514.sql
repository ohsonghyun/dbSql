실행계획 : SQL을 내부적으로 어떤 절차를 거쳐서 실행할지 로직을 작성
        * 계산하는데 비싼 연산 비용이 필요(시간)
        

2개의 테이블을 조인하는 SQL
2개의 테이블에 각각 인덱스가 5개가 있다면
가능한 실행계획 조합 몇개?? 굉장히 많다 ==> 짧은 시간안에 해내야 한다(응답을 빨리 해야하므로)


만약 동일한 SQL이 실행될 경우 기존에 작성된 실행계획이 존재할 경우
새롭게 만들지 않고 재활용을 한다(리소스 절약)

테이블 접근 방법 : 테이블 전체(1), 각각의 인덱스(5)
a => b
b => a
경우의 수 : 36개 * 2개 = 72개
 
동일한 SQL 이란 : SQL 문장의 대소문자 공백까지 일치하는 SQL
아래 두개의 sql 을 서로 다른 SQL 로 인식한다
SELECT * FROM emp;
Select * FROM emp;

특정직원의 정보를 조회하고 싶은데 : 사번을 이용해서 
Select /*202004_B*/*
FROM emp
WHERE empno = :empno;
--바인드 변수가 더 중요한 이유 sql실행결과를 공유할 수 있다

SELECT *
FROM user_tables;

SELECT *
FROM ALL_tables;

SELECT *
FROM DBA_tables;

SELECT *
FROM dictionary;

Multiple insert :여러건의 데이터를 동시에 입력하는 insert 의 확장구문

1. uncoditional insert : 동일한 값을 여러 테이블에 입력하는 경우
문법:
    INSERT ALL
        INTO 테이블명
        [,INTO 테이블명]
    VALUES(....) | SELECT QUERY;

SELECT *
FROM emp_test;

mp_test 테아블을 이용하여 emp_test2 테이블 생성

CREATE TABLE emp_test2 AS
SELECT *
FROM emp_test
WHERE 1 = 2; --데이터는 복사하지 않겠다

EMPNO, ENAME, DEPTNO

emp_test, emp_test2 테이블에 동시에 입력
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9998, 'brown', 88 FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

select *
from emp_test;

2. conditional insert : 조건에 따라서 입력할 테이블을 결정
문법
INSERT ALL 
    WHEN 조건 ..... THEN
        INTO 입력 테이블 VALUES
    WHEN 조건 ..... THEN
        INTO 입력 테이블2 VALUES
    ELSE
        INTO 입력 테이블3 VALUES

SELECT 결과의 행의 값이 EMPNO = 9998 이면  EMP_TEST 에만 데이터를 입력
                    그 외에는 EMP_TEST2에 데이터를 입력
;                   
INSERT ALL
    WHEN empno = 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    ELSE
        INTO emp_test2 (empno, deptno) VALUES (empno, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

ROLLBACK;

conditional insert (all) ==> first : 조건을 만족하는 첫 번째 WHEN 절만 실행
;
INSERT ALL
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;     

ROLLBACK;

INSERT FIRST
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;     

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;


MERGE : 하나의 데이터 셋을 다른 테이블로 데이터를 신규 입력, 또는 업데이트 하는 쿼리
문법 :
MERGE INTO 머지 대상(emp_test)
USING (다른 테이블| VIEW | subquery)
ON (머지대상과 USING 절의 연결 조건 기술)
WHEN NOT MATCHED THEN
    INSERT (coll, coll2...) VALUES (values1, values2...)
WHEN MATCHED THEN
    UPDATE SET coll = values , coll2 = values2

1. 다른 데이터로 부터 특정 테이블로 데이터를 머지 하는 경우
2. KEY가 없을 경우 INSERT
   KEY가 있을 때 UPDATE

emp 테이블의 데이터를 emp_test 테이블로 통합
emp 테이블에는 존재하고 emp_test 테이블에는 존재하지 않는 직원의 신규입력
emp 테이블에는 존재하고 emp_test 테이블에는 존재하는 직원의 이름 신규입력
;
/*
9998	brown	88
9997	cony	88
7369	cony	88
*/
INSERT INTO emp_test VALUES(7369, 'cony', 88);
emp테이블의 14건 데이터를 emp_test테이블에 동일한 empno 가 존재하는지 건사해서
동일한 empno가 없으면 insert-empno, ename, 동일한 empno 가 없으면 update_ename

SELECT *
FROM emp_test;
MERGE INTO emp_test
USING emp
ON (emp_test.empno = emp.empno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (emp.empno, emp.ename)
WHEN MATCHED THEN
    UPDATE SET ename = emp.ename;

위의 시나리오는 하나의 테이블에서 다른 테이블을 머지하는 경우

9999번 사번으로 신규 입력하거나, 업데이트를 하고 싶을 때
(사용ㅇ자가 9999번, james 사원을 등록하거나, 업데이트 하고 싶을 때)
위의 경우는 테이블 ==> 다른 테이블로 머지

이번에 하는 시나리오 : 데이터를 ==> 특정 테이블로 머지
(9999, james)

MERGE 구문을 사용하지 않은면 

데이터존재 유무를 위해 SELECT 실행
SELECT *
FROM emp_test
WHERE empno = 9999;

데이터가 있으면 ==> UPDATE
데이터가 없으면 ==> INSERT

MERGE INTO emp_test
USING dual
 ON (emp_test.empno = 9999)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';
    
SELECT *
FROM emp_test;

MERGE INTO emp_test
USING (SELECT 9999 eno, 'james' enm
       FROM dual) a
 ON (emp_test.empno = a.eno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';

emp 테이블의 7698번 직원의 이름을 
emp_test 테이블의 9999번 직원의 이름으로 업데이트 하는 merge 구문 작성
만약 9999번 직워이 emp_test 에 없으면 empno = 9999,
                                 ename = emp 테이블의 7698직원의 이름, deptno = null 로 신규입력

MERGE INTO emp
USING (SELECT empno, ename
       FROM emp_test
       WHERE empno = 9999) a
 ON (emp.empno = a.eno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';


SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno

UNION

SELECT null, SUM(sal)
FROM emp;


REPORT GROUP FUNCTION
emp 테이블을 이용하여 부서번호별 짓원의 급여 합과, 전체직원의 급여합을 조회하기 위해
GROUP BY 를 사용하는 두개의 SQL 로 나눠서 하나로 합치는 (UNION ==> UNION ALL) 작업을 진행

확장된 GROUP BY 3가지
1. GROUP BY BOLLUP
문법 : GROUP BY ROLLUP (컬럼, 컬럼2...)
목적 : 서브그룹을 만들어주는 용도
서브그룹 생성 방식 : ROLLUP 절에 기술항 컬럼을 오른쪽에서 부터 하나씩 제거하면서 서브그룹을 생성
생성된 서브그룹을 UNION 한 결과를 반환

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

서브그룹 : 1. GROUP BY job, deptno
            UNION
         2. GROUP BY job
            UNION
         3. 전체형 GROUP BY
;

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY job, deptno

UNION

SELECT job, NULL, SUM(sal) sal
FROM emp
GROUP BY job

UNION

SELECT NULL, NULL, SUM(sal) sal
FROM emp;

==> GROUP BY ROLLUP 으로 변경

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno);

서브그룹의 개수는 : ROLLUP 절에 기술한 컬럼 개수 : +1;









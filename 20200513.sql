CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM dept;

idx1]
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_dept_test2_03 ON dept_test2 (deptno, dname);

idx2]
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_dept_test2_02;
DROP INDEX idx_dept_test2_03;

idx1]
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_dept_test2_03 ON dept_test2 (deptno, dname);

idx2]
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_dept_test2_02;
DROP INDEX idx_dept_test2_03;

idx3]
--1
SELECT *
FROM emp
WHERE empno = :empno; -- 사번을 입력받아서 해당 사번의 직원정보를 조회

--2
SELECT *
FROM emp
WHERE ename = :ename; -- 이름을 입력받아서 해당 이름의 직원정보를 조회

--3
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno = :deptno
  AND emp.empno LIKE :empno || '%'; -- 입력한 사번, 입력된 사번으로 시작하는 직원의 정보를 부서정보까지 전부 조회
 
 --4 
SELECT *
FROM emp
WHERE sal BETWEEN :st_sal AND :ed_sal
  AND deptno = :deptno;  -- 입력받은 사원이 내가 설정한 급여의 범위에 들어오는지 확인

--5
SELECT B.*
FROM emp A, emp B
WHERE A.mgr = B.empno
  AND A.deptno = :deptno; -- 내가 입력한 부서의 매니저 정보조회 

--6  
SELECT deptno, TO_CHAR(hiredate, 'yyyymm'), COUNT(*) cnt
FROM emp
GROUP BY deptno, TO_CHAR(hiredate, 'yyyymm'); -- 입사일자별,각각의 부서에 입사한 사람의 수 
  

1] empno(=) x
2] ename(=) x
3] deptno(=), empno(LIKE :empno || '%') x 

4] deptno(=), sal( BETWEEN :st_sal AND :ed_sal ) x -- sal 먼저 접근하는게 좋아보임
5] deptno(=), mgr(=)
6] deptno(GROUP), hiredate(GROUP) -- 그냥 full


실행계획

수업시간에 배운 조인
===> 논리적 조인 형태를 이야기 함, 기술적인 이야기가 아님
inner join  : 조인에 성공하는 데이터만 조회하는 조인 기법
outer join  : 조인에 실패해도 기준이되는 테이블의 컬럼정보는 조회하는 조인 기법
cross join  : 묻지마 조인 (커티션 프러덕트), 조인 조건을 기술하지 않아서
             연결 가능한 모든 경우의 수로 조인되는 기법
self join   : 닽은 테이블 끼리 조인하는 형태

개발자가 DBMS 에 SQL 을 실행 요청 하면 DBMS 는 SQL 을 분석해서
어떻게 두 테이블 연결할 지를 결정, 3가지 방식의 조인 방식(물리적인 조인 방식, 기술적인 이야기)
1. Nested Loop Join
2. Sort Merge Join
3. Hash Join

OLTP Online Transaction Processing : 실시간 처리 
                                ==> 응답이 빨라야 하는 시스템 (일반적인 웹 서비스)
                                
Online Analysis Processing : 일괄처리 ==> 전체 처리속도가 중요한 경우
                                        (은행 이자 계산, 새벽 한번에 계산)














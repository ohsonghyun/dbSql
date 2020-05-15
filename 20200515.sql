ROLLUP : 서브그룹 생성 - 기술된 컬럼을 오른쪽에서부터 지워나가며 GROUP BY 를 실행

아래 쿼리의 서브 그룹
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==> 전체

ROLLUP 사용시 생성되는 서브그룹의 수는 : ROLLUP 에 기술한 컬럼수 +1;

GROUP_AD2]
SELECT NVL(job, '총계') job, deptno,
       GROUPING (job), GROUPING (deptno), SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT CASE 
            WHEN GROUPING (job) = 1 THEN '총계' 
            ELSE job
        END job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD2-1]
SELECT CASE 
            WHEN GROUPING (job) = 1 THEN '총'
            ELSE job
        END job,
        CASE 
            WHEN GROUPING (job) = 1 THEN '계'
            WHEN GROUPING (deptno) = 1 THEN '소계' 
            ELSE TO_CHAR(deptno)
        END deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);
DECODE(GROUPING(job) + GROUPING(deptno), 2, '', 1,'',

GROUP_AD3]
SELECT deptno, job, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno, job);

ROLLUP 절에 기술 되는 컬럼의 순서는 조회 결과에 영향을 미친다
(***** 서브 그룹을 기술된 컬럼의 오른쪽 부터 제거해 나가면서 생성)
GROUP BY ROLLUP (deptno, job);
GROUP BY ROLLUP (job, deptno);

GROUP_AD4]
SELECT dept.dname, emp.job, SUM(emp.sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);


SELECT dept.dname, a.job, a.sal
FROM (SELECT deptno, job, SUM(sal) sal
      FROM emp
      GROUP BY ROLLUP (deptno, job)) a, dept
WHERE a.deptno = dept.deptno(+);

GROUP_AD5]
SELECT NVL(dept.dname, '총계'), emp.job, SUM(emp.sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);


2. GROUPING SETS
ROLLUP 의 단점 : 관심없는 서브그룹도 생성 해야한다
                ROLLUP 절에 기술한 컬럼을 오르쪽에서 지워나가기 때문에
                만약 중간과정에 있는 서브그룹이 불필요 할 경우 낭비.
GROUPING SETS : 개발자가 직접 생성할 서브그룹을 명시
                ROLLUP 과는 다른게 방향성이 없다

사용법 : GROUP BY GROUPING SETS (coll,coll2)
GROUP BY call
UNION ALL
GROUP BY coll2

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS (job, deptno);

SELECT job, null, SUM(sal) sal
FROM emp
GROUP BY job

UNION ALL

SELECT null, deptno, SUM(sal) sal
FROM emp
GROUP BY deptno;

그룹기준을
1.job, deptno
2. mgr

GROUP BY GROUPING SETS(job, deptno), mgr);

SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);


REPORT GROUP FUNCTION ==> 확장된 GROUP BY
REPORT GROUP FUNCTION 의 사용을 안하면
여러개 SQL 작성, UNION ALL 을 통해서 하나의 결과로 합치는 과정

==> 좀 더 편하게 하는 REPORT GROUP FUNCTION 

3. CUBE
사용법 : GROUP BY CUBE (coll,coll2....)
기술된 컬럼의 가능한 모든 조합 (순선는 지킨다)

GROUP BY CUBE (job, deptno);
    1       2
   job,   deptno
   job,     X
    X,    deptno
    X,      X

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY CUBE (job, deptno);

여러개의 REPORT GROUP 사용하기
SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY job, deptno, CUBE (mgr);

**발생 가능한 조합을 계산
1         2         3
job       deptno    mgr ==> GROUP BY job, deptno, mgr
job       X         mgr ==> GROUP BY job, mgr
job       deptno    X   ==> GROUP BY job, deptno
job       X         X   ==> GROUP BY job

SELECT job, deptno, mgr, SUM(sal+ NVL(comm, 0)) sal
FROM emp
GROUP BY job, ROLLUP(job, deptno), CUBE (mgr);

상호연관 서브쿼리 업데이트
1. emp 테이블을 이용하여 emp_test 테이블 생성
    ==> 기존에 생성된 emp_test 테이블 삭제 먼저 진행
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

2. emp_test 테이블에 dname 컬럼 추가 (dept 테이블 참고)
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));
DESC emp_test;

3. subquery를 이용하여 emp_test 테이블에 추가된 dname 컬럼을 업데이트 해주는 쿼리 작성
emp_test의 dname 컬럼의 값을 dept 테이블의 dname 컬럼으로 update
emp_test테이블의 deptno 값을 확인해서 dept테이블의 deptno 값이랑 일치하는 dname 컬럼값을 가져와 update

SELECT *
FROM emp_test;

--emp_test 테이블의 dname 커럼을 dept 테이블을 이용해서 dname 값 조회하여 업데이트
update 대상이 되는 행 : 14 ==> WHERE 절을 기술하지 않음

모든 직원을 대상으로 dname 컬럼을 dept 테이블에서 조회하여 업데이트;
UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);
sub_a1]
DROP TABLE dept_test;
CREATE TABLE dept_test AS 
SELECT *
FROM dept
WHERE 1=1;

ALTER TABLE dept_test ADD (empcnt NUMBER);

UPDATE dept_test SET empcnt = (SELECT COUNT(*) cnt
                               FROM emp
                               WHERE dept_test.deptno = emp.deptno
                               GROUP BY deptno);

UPDATE dept_test SET empcnt = (SELECT COUNT(*) cnt
                               FROM emp
                               WHERE dept_test.deptno = emp.deptno);
==> 이번 쿼리는 굳이 GROUP BY 할 필요가 없다


SELECT 결과 전체를 대상으로 그룹 함수를 적용한 경우
대상되는 행이 없더라도 0값이 리턴
;
SELECT COUNT(*)
FROM dept
WHERE 1 = 2;            ==> 값 0

GROUP BY  절을 기술할 경우 대상이 되는 행이 없을 경우 조회되는 행이 없다
SELECT COUNT(*)
FROM dept
WHERE 1 = 2
GROUP BY deptno;        ==> 값이 나오지 않는다
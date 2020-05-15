ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY �� ����

�Ʒ� ������ ���� �׷�
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==> ��ü

ROLLUP ���� �����Ǵ� ����׷��� ���� : ROLLUP �� ����� �÷��� +1;

GROUP_AD2]
SELECT NVL(job, '�Ѱ�') job, deptno,
       GROUPING (job), GROUPING (deptno), SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT CASE 
            WHEN GROUPING (job) = 1 THEN '�Ѱ�' 
            ELSE job
        END job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD2-1]
SELECT CASE 
            WHEN GROUPING (job) = 1 THEN '��'
            ELSE job
        END job,
        CASE 
            WHEN GROUPING (job) = 1 THEN '��'
            WHEN GROUPING (deptno) = 1 THEN '�Ұ�' 
            ELSE TO_CHAR(deptno)
        END deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);
DECODE(GROUPING(job) + GROUPING(deptno), 2, '', 1,'',

GROUP_AD3]
SELECT deptno, job, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno, job);

ROLLUP ���� ��� �Ǵ� �÷��� ������ ��ȸ ����� ������ ��ģ��
(***** ���� �׷��� ����� �÷��� ������ ���� ������ �����鼭 ����)
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
SELECT NVL(dept.dname, '�Ѱ�'), emp.job, SUM(emp.sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);


2. GROUPING SETS
ROLLUP �� ���� : ���ɾ��� ����׷쵵 ���� �ؾ��Ѵ�
                ROLLUP ���� ����� �÷��� �����ʿ��� ���������� ������
                ���� �߰������� �ִ� ����׷��� ���ʿ� �� ��� ����.
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
                ROLLUP ���� �ٸ��� ���⼺�� ����

���� : GROUP BY GROUPING SETS (coll,coll2)
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

�׷������
1.job, deptno
2. mgr

GROUP BY GROUPING SETS(job, deptno), mgr);

SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);


REPORT GROUP FUNCTION ==> Ȯ��� GROUP BY
REPORT GROUP FUNCTION �� ����� ���ϸ�
������ SQL �ۼ�, UNION ALL �� ���ؼ� �ϳ��� ����� ��ġ�� ����

==> �� �� ���ϰ� �ϴ� REPORT GROUP FUNCTION 

3. CUBE
���� : GROUP BY CUBE (coll,coll2....)
����� �÷��� ������ ��� ���� (������ ��Ų��)

GROUP BY CUBE (job, deptno);
    1       2
   job,   deptno
   job,     X
    X,    deptno
    X,      X

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY CUBE (job, deptno);

�������� REPORT GROUP ����ϱ�
SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY job, deptno, CUBE (mgr);

**�߻� ������ ������ ���
1         2         3
job       deptno    mgr ==> GROUP BY job, deptno, mgr
job       X         mgr ==> GROUP BY job, mgr
job       deptno    X   ==> GROUP BY job, deptno
job       X         X   ==> GROUP BY job

SELECT job, deptno, mgr, SUM(sal+ NVL(comm, 0)) sal
FROM emp
GROUP BY job, ROLLUP(job, deptno), CUBE (mgr);

��ȣ���� �������� ������Ʈ
1. emp ���̺��� �̿��Ͽ� emp_test ���̺� ����
    ==> ������ ������ emp_test ���̺� ���� ���� ����
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

2. emp_test ���̺� dname �÷� �߰� (dept ���̺� ����)
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));
DESC emp_test;

3. subquery�� �̿��Ͽ� emp_test ���̺� �߰��� dname �÷��� ������Ʈ ���ִ� ���� �ۼ�
emp_test�� dname �÷��� ���� dept ���̺��� dname �÷����� update
emp_test���̺��� deptno ���� Ȯ���ؼ� dept���̺��� deptno ���̶� ��ġ�ϴ� dname �÷����� ������ update

SELECT *
FROM emp_test;

--emp_test ���̺��� dname Ŀ���� dept ���̺��� �̿��ؼ� dname �� ��ȸ�Ͽ� ������Ʈ
update ����� �Ǵ� �� : 14 ==> WHERE ���� ������� ����

��� ������ ������� dname �÷��� dept ���̺��� ��ȸ�Ͽ� ������Ʈ;
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
==> �̹� ������ ���� GROUP BY �� �ʿ䰡 ����


SELECT ��� ��ü�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����
;
SELECT COUNT(*)
FROM dept
WHERE 1 = 2;            ==> �� 0

GROUP BY  ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ����
SELECT COUNT(*)
FROM dept
WHERE 1 = 2
GROUP BY deptno;        ==> ���� ������ �ʴ´�
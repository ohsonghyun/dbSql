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
WHERE empno = :empno; -- ����� �Է¹޾Ƽ� �ش� ����� ���������� ��ȸ

--2
SELECT *
FROM emp
WHERE ename = :ename; -- �̸��� �Է¹޾Ƽ� �ش� �̸��� ���������� ��ȸ

--3
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno = :deptno
  AND emp.empno LIKE :empno || '%'; -- �Է��� ���, �Էµ� ������� �����ϴ� ������ ������ �μ��������� ���� ��ȸ
 
 --4 
SELECT *
FROM emp
WHERE sal BETWEEN :st_sal AND :ed_sal
  AND deptno = :deptno;  -- �Է¹��� ����� ���� ������ �޿��� ������ �������� Ȯ��

--5
SELECT B.*
FROM emp A, emp B
WHERE A.mgr = B.empno
  AND A.deptno = :deptno; -- ���� �Է��� �μ��� �Ŵ��� ������ȸ 

--6  
SELECT deptno, TO_CHAR(hiredate, 'yyyymm'), COUNT(*) cnt
FROM emp
GROUP BY deptno, TO_CHAR(hiredate, 'yyyymm'); -- �Ի����ں�,������ �μ��� �Ի��� ����� �� 
  

1] empno(=) x
2] ename(=) x
3] deptno(=), empno(LIKE :empno || '%') x 

4] deptno(=), sal( BETWEEN :st_sal AND :ed_sal ) x -- sal ���� �����ϴ°� ���ƺ���
5] deptno(=), mgr(=)
6] deptno(GROUP), hiredate(GROUP) -- �׳� full


�����ȹ

�����ð��� ��� ����
===> ���� ���� ���¸� �̾߱� ��, ������� �̾߱Ⱑ �ƴ�
inner join  : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
outer join  : ���ο� �����ص� �����̵Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join  : ������ ���� (ĿƼ�� ������Ʈ), ���� ������ ������� �ʾƼ�
             ���� ������ ��� ����� ���� ���εǴ� ���
self join   : ���� ���̺� ���� �����ϴ� ����

�����ڰ� DBMS �� SQL �� ���� ��û �ϸ� DBMS �� SQL �� �м��ؼ�
��� �� ���̺� ������ ���� ����, 3���� ����� ���� ���(�������� ���� ���, ������� �̾߱�)
1. Nested Loop Join
2. Sort Merge Join
3. Hash Join

OLTP Online Transaction Processing : �ǽð� ó�� 
                                ==> ������ ����� �ϴ� �ý��� (�Ϲ����� �� ����)
                                
Online Analysis Processing : �ϰ�ó�� ==> ��ü ó���ӵ��� �߿��� ���
                                        (���� ���� ���, ���� �ѹ��� ���)














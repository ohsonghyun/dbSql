grp7]
dept ���̺��� Ȯ���ϸ� �� 4���� �μ� ������ ���� ==> ȸ�系�� �����ϴ� ��� �μ� ����
emp ���̺��� �����Ǵ� �������� ���� ���� �μ������� ���� ==> 10, 20, 30 ==> 3��

SELECT COUNT(*) cnt
FROM
    (SELECT deptno  /*deptno �÷��� 1�� ����, row�� 3���� ���̺�*/
    FROM emp
    GROUP BY deptno);
    
DBMS : DataBase Management System
 ==> db
RDBMS : Relational DataBase Management System
 ==> ������ �����ͺ��̽� ���� �ý���(�ߺ��� �ּ�ȭ �� �� ����)
     80�� �ʹ�
     
SELECT *
FROM emp;

SELECT *
FROM dept;

JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE)

JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
SELECT �� �� �ִ� �÷��� ������ ��������(���� Ȯ��)

���տ��� ==> ���� Ȯ�� (���� ��������)

NATURAL JOIN 
    . �����Ϸ��� �� ���̺��� ����� �÷��� �̸� ���� ���
    . emp, dept ���̺���  deptno��� ���뱭( ������ �̸���, Ÿ�Ե� ����) ����� �÷��� ����
    . �ٸ� ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ�, ���� ���̺���� �÷����� �������� ������
      ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����
      
.emp ���̺� : 14��
.dept ���̺� : 4��

SElECT *
FROM dept;

�����Ϸ��� �ϴ� �÷��� ������ ������� ����
SElECT *
FROM emp NATURAL JOIN dept;
�� ���̺��� �̸��� ������ �÷����� �����Ѵ�
 ==> deptno

ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
����Ŭ ���� ����
 1. ������ ���̺� ����� FROM ���� ����ϸ� �����ڴ� �ݷ�(,)
 2. ����� ������ WHERE���� ����ϸ� �ȴ� (ex : WHERE emp.deptno = dept.deptno)
 
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno�� 10���� �����鸸 dept ���̺�� ���� �Ͽ� ��ȸ

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno = 10;

ANSI- SQL : JOIN with USING
    . join �Ϸ��� ���̺� �̸��� ���� �÷��� 2�� �̻��� ��
    . �����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���

SELECT *
FROM emp JOIN dept USING (deptno);

ANSI-SQL : JOIN with ON
    . ���� �Ϸ��� �� ���̺� �÷����� �ٸ� ��
    . ON���� ����� ������ ���;
    
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

ORACLE �������� �� SQL�� �ۼ�
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

JOIN�� ������ ����
SELF JOIN : �����Ϸ��� ���̺��� ���� ���� ��
emp ���̺��� ������ ������ ������ ��Ÿ���� ������ ������ mgr �÷��� �ش� ������ ������ ����� ����.
�ش� ������ �������� �̸��� �ϰ���� ��

ANSI-SQL�� SQL ���� : 
 �����Ϸ��� �ϴ� ���̺� emp(����), emp(������ ������)
                ����� �÷� : ����.mgr = ������.empno
                 ==> ���� �÷� �̸��� �ٸ���(mgr, empno)
                    ==> NATURAL JOIN, JOIN with USING�� ����� �Ұ����� ����
                        ==> JOIN with ON
SELECT  *
FROM emp;

ANSI-SQL�� �ۼ�;
                  
SELECT  *
FROM emp e JOIN emp m ON (e.mgr = m.empno);

NONEUQI JOIN :����� ������ =�� �ƴ� ��

�׵��� WHERE���� ����� ������ : =, !=, <>, <=, <, >, >=
                             AND, OR, NOT
                             LIKE %, _
                             OR - IN
                             BETWEEN AND ==> >=, <=

SELECT *
FROM emp;

SELECT *
FROM salgrade;

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

 ==> ORACLE ���� �������� ����
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

join0]
-- ANSI-SQL
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
ORDER BY deptno;

-- ORACLE
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp , dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;

join0_1]
-- ANSI-SQL
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno IN (10,30)
ORDER BY deptno DESC;

-- ORACLE
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp , dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno  IN (10,30)
ORDER BY deptno DESC;

����Ŭ�� ���� �ӵ��� �� �����ڴٰ� �����ϴ°ź��� �����Ѵ�

join0_2]
-- ANSI-SQL
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE sal > 2500
ORDER BY deptno;

-- ORACLE
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp , dept
WHERE emp.deptno = dept.deptno
  AND sal > 2500
ORDER BY deptno;

join0_3~4] ����

join0_3]
-- ANSI-SQL
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.sal > 2500
  AND emp.empno > 7600;

-- ORACLE
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.sal > 2500
  AND emp.empno > 7600;

join0_4]
-- ANSI-SQL
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.sal > 2500
  AND emp.empno > 7600
  AND dname = 'RESEARCH';

-- ORACLE
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.sal > 2500
  AND emp.empno > 7600
  AND dname = 'RESEARCH';

�����غ���
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp , dept
WHERE emp.deptno != dept.deptno;

SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp , dept
WHERE emp.deptno <= dept.deptno;

join1]
SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;














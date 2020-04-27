NULL ó���ϴ� ��� 4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���

DESC emp;

SELECT NVL(empno, 0), ename, NVL(sal, 0), NVL(comm, 0)
FROM emp;

���������� ���� empno�� NOT NULL �����̶� null���� ���ü� �����Ƿ� NVL�� �ʿ�ġ ����

condition : CASE, DECODE �� �ϱ�

�����ȹ : �����ȹ�� ����, ���� ���� �˱�


 emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
 �ش� ������ job�� SALESMAN�� ��� sal 5% �λ�� �ݾ��� ���ʽ��� ����
 
 �ش� ������ job�� MANAGER�̸鼭 deptno�� 10�̸� sal 30% �λ�� �ݾ��� ���ʽ��� ����
                            �� ���� �μ��� ���ϴ� ����� 10% �λ�� �ݾ��� ���ʽ��� ����
                            
 �ش� ������ job�� PRESIDENT�� ��� sal 20% �λ�� �ݾ��� ���ʽ��� ����
 �׿� �������� sal��ŭ�� ����
  SELECT empno, ename, job, deptno, sal,
       DECODE( job, 'SALESMAN', sal * 1.05, 'MANAGER', DECODE(deptno, 10, sal * 1.3, sal * 1.1), 'PRESIDENT', sal * 1.2, sal) as bonus_sal
 FROM emp;
 
 
 SELECT *
 FROM emp
 ORDER BY deptno;



 ���� A = {10, 15 ,18, 23, 24, 25 ,29 ,30 ,35 ,37}
 Prime Number �Ҽ� : { 23, 29, 37} COUNT 3, MAX 23, AVG 29.6 SUM 89
 ��Ҽ� : { 10, 15, 18, 24, 25, 30, 35}
 
 SELECT *
 FROM emp
 ORDER BY deptno;
 
 
 
 GROUP FUNCTION
 �������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
 �������� �Է¹޾� �ϳ��� ������ ����� ���δ�
 EX : �μ��� �޿� ���
    emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ� (10,20,30)�� ���� �ִ�
    �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�.
 
 SELECT �׷��� ���� Į��, �׷��Լ�
 FROM ���̺�
 GROUP BY �׷��� ���� �÷�
 [ORDER BY];
 
 GROUP BY ����� ���� ���� : SELECT�� ����� �� �ִ� �÷��� ���ѵ�
 
 SELECT deptno, sal
 FROM emp
 GROUP BY deptno, sal;
 
 �μ����� ���� ���� �޿� ��
 SELECT deptno, MAX(sal)
 FROM emp
 GROUP BY deptno;
 
 SELECT deptno, ename, MAX(sal) ==> ������ �ȵ�, deptno�� �׷��� ���� 10, 20, 30 �س��µ� ename�� ��ȸ��, ������� deptno 10���� ename�� 3���� ����
 FROM emp                           ���߿� ������ ��ȸ������ ���������� ���� MIN(ename), MAX(ename)�̷����� ������
 GROUP BY deptno;
 
 SELECT deptno, ROUND(AVG(sal), 2)as sal_avg,
                MAX(sal),
                MIN(sal),
                SUM(sal),
                COUNT(sal), -- �μ��� �޿� �Ǽ�, sal �÷��� ���� NULL�� �ƴ� row�� ��
                COUNT(*), -- �μ��� ���� ��
                COUNT(mgr)
 FROM emp
 GROUP BY deptno;
 
 * �׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� �� �� ������
   ���� ���� �޿��� �޴� ����� �̸��� �� ���� ����
    ==> ���� WINDOW/�м� FUCTION�� ���� �ذ� ����
 
 
 
 emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� ���� �ϴ� ���
  SELECT ROUND(AVG(sal), 2)as sal_avg,
                MAX(sal), -- ��ü ������ ���� ���� �޿� ��
                MIN(sal), -- ��ü ������ ���� ���� �޿� ��
                SUM(sal), -- ��ü ������ �޿� ���
                COUNT(sal), -- ��ü ������ �޿� �Ǽ�, sal �÷��� ���� NULL�� �ƴ� row�� ��
                COUNT(*), -- ��ü ���� ��
                COUNT(mgr) -- mgr Į���� NULL�� �ƴ� �Ǽ�
 FROM emp;
 
 GROUP BY ���� ����� �÷���
    SELECT ���� ������ ������ ��������� 
 
 GROUP BY ���� ������� ���� �÷��� 
    SELECT ���� ������ ������ ����
    
 �׷�ȭ�� ���� ���� ���ڿ�, ��� ���� SELECT ���� ǥ�� �� �� �ִ� (���� �ƴ�);
  SELECT deptno, 'TEST', 1,
                ROUND(AVG(sal), 2)as sal_avg,
                MAX(sal),
                MIN(sal),
                SUM(sal),
                COUNT(sal), -- �μ��� �޿� �Ǽ�, sal �÷��� ���� NULL�� �ƴ� row�� ��
                COUNT(*), -- �μ��� ���� ��
                COUNT(mgr)
 FROM emp
 GROUP BY deptno;

 GROUP �Լ� ����� NULL ���� ���ܰ� �ȴ�
 30�� �μ����� NULL���� ���� ���� ������ SUM(comm)�� ���� ���������� ���� �� Ȯ�� �� �� �ִ�
 20, 10�� ���� NULL�̶� ���ܵ����Ƿ� ����� NULL�� ����
 SELECT deptno, SUM(comm)
 FROM emp
 GROUP BY deptno;

10, 20�� �μ��� SUM(comm) �÷��� NULL�� �ƴ϶� 0�� �������� NULL ó��
SELECT deptno, NVL(SUM(comm), 0)
 FROM emp
 GROUP BY deptno;
* Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ°� ���ɻ� �����ϴ�

NVL(SUM(comm), 0) : COMM �÷��� SUM �׷��Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��)
SUM(NVL(comm, 0)) : ��� COMM �÷��� NVL �Լ��� ������(�ش� �׷��� ROW ����ŭ ����) SUM �׷��Լ� ����

single row �Լ��� WHERE���� ����Ҽ� ������
multi row �Լ���(group �Լ�)�� WHERE���� ����� �� ����
GROUP BY �� ���� HAVING ���� ������ ���

single row �Լ��� WHERE ������ ��밡��
SELECT *
FROm emp
WHERE LOWER(ename) = 'smith'; -- �º��� ������������, ȿ�� ������

�μ��� �޿� ���� 5000�� �Ѵ� �μ��� ��ȸ
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 5000   <== ���� �߻� WHERE���� ���Ұ�
GROUP BY deptno;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;


-- group function �ǽ� grp1

SELECT MAX(sal) MAX_SAL,
       MIN(sal) MIN_SAL,
       ROUND(AVG(sal), 2) AVG_SAL,
       SUM(sal) SUM_SAL,
       COUNT(sal) COUNT_SAL,
       COUNT(mgr) COUNT_MGR,
       COUNT(*) COUNT_ALL
       
FROM emp;

-- group function �ǽ� grp2

SELECT deptno,
       MAX(sal) MAX_SAL,
       MIN(sal) MIN_SAL,
       ROUND(AVG(sal), 2) AVG_SAL,
       SUM(sal) SUM_SAL,
       COUNT(sal) COUNT_SAL,
       COUNT(mgr) COUNT_MGR,
       COUNT(*) COUNT_ALL
       
FROM emp
GROUP BY deptno;

SELECT deptno,
       MAX(sal) MAX_SAL,
       MIN(sal) MIN_SAL,
       ROUND(AVG(sal), 2) AVG_SAL,
       SUM(sal) SUM_SAL,
       COUNT(CASE
                WHEN sal > 3000 THEN sal
             END) COUNT_SAL,
       COUNT(mgr) COUNT_MGR,
       COUNT(*) COUNT_ALL
       
FROM emp
GROUP BY deptno;


-- group function �ǽ� grp3
SELECT *
FROM emp;

SELECT *
FROM dept;


SELECT DECODE(deptno, '10', 'ACCOUNTING', '20', 'RESEARCH', '30', 'SALES', '40', 'OPERATIONS') DNAME,
       MAX(sal) MAX_SAL,
       MIN(sal) MIN_SAL,
       ROUND(AVG(sal), 2) AVG_SAL,
       SUM(sal) SUM_SAL,
       COUNT(sal) COUNT_SAL,
       COUNT(mgr) COUNT_MGR,
       COUNT(*) COUNT_ALL
       
FROM emp
GROUP BY deptno;


-- grp4

SELECT TO_CHAR(hiredate, 'yyyymm') as HIRE_YYYYMM, COUNT(*) as CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyymm')
ORDER BY TO_CHAR(hiredate, 'yyyymm') ASC;

-- grp5

SELECT TO_CHAR(hiredate, 'yyyy') as HIRE_YYYYMM, COUNT(*) as CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy')
ORDER BY CNT ASC;

-- grp6

SELECT *
FROM dept;

SELECT COUNT(*) CNT
FROM dept;

-- grp7

SELECT COUNT(*) as CNT
FROM
    (SELECT deptno
    FROM emp
    GROUP BY deptno);
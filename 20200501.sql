�Ѱ��� ��, �ϳ��� �÷��� �����ϴ� ��������
ex: ��ü ������ �޿� ���, SMITH ������ ���� �μ��� �μ���ȣ

WHERE���� ��밡���� ������
WHERE deptno = 10
==> 

�μ���ȣ�� 10 Ȥ�� 30���� ���
WHERE deptno IN (10, 30)
WHERE deptno = 10 OR deptno = 30

WHERE deptno = (10, 30)

������ ������
�������� ��ȸ�ϴ� ���������� ��� = �����ڸ� ���Ұ�
WHERE deptno IN (�������� ���� �����ϰ�, �ϳ��� �÷����� �̷���� ����)

SMITH - 20, ALLEN�� 30�� �μ��� ����

SMITH �Ǵ� ALLEN�� ���ϴ� �μ��� ������ ������ ��ȸ

���� ��������, �÷��� �ϳ��� ==> ������������ ��밡���� ������ IN(���� �� �߿�), (AND, ALL �󵵰� ����)


IN :  ���������� ����� �� ������ ���� ���� ��  TRUE
    WHERE �÷�|ǥ���� IN (��������)

ANY : �����ڸ� �����ϴ� ���� �ϳ��� ���� �� TRUE
    WHERE �÷�|ǥ���� ������ ANY (��������)
    
ALL : ���������� ��� ���� �����ڸ� ������ �� TRUE
    WHERE �÷�|ǥ���� ������ ALL (��������)
    
SMITH�� ALLEN�� ���� �μ����� �ٹ��ϴ� ��� ������ ��ȸ

1. ���������� ������� ���� ��� : �ΰ��� ������ ����
1-1] SMITH, ALLEN�� ���� �μ��� �μ���ȣ�� Ȯ���ϴ� ����
20, 30
SELECT deptno
FROM emp
WHERE ename IN ('SMITH', 'ALLEN');


1-2] 1-1]���� ���� �μ���ȣ�� IN������ ���� �ش� �μ��� ���ϴ� ���� ���� ��ȸ
==>���������� �̿��ϸ� �ϳ��� SQL���� ���� ����
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'ALLEN'));

sub3]          
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));
                 
ANY, ALL
SMITH(800)�� WARD(1250) �� ����� �޿��� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ
==> sal < 1250
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));
    
SMITH(800)�� WARD(1250) �� ����� �޿����� ���� �޿��� �޴� ���� ��ȸ    
==> sal > 1250
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

IN �������� ����
�ҼӺμ��� 20, Ȥ�� 30�� ���
WHERE deptno IN (20, 30)

�ҼӺμ��� 20, 30�� ������ �ʴ� ���
WHERE deptno NOT IN (20, 30)
NOT IN�����ڸ� ����� ��� ���������� ���� NULL�� �ִ��� ���� �߿�

�Ʒ� ������ ��ȸ�ϴ� ����� � �ǹ��ΰ�?

NULL ���� ���� ���� ����
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL);

NULL ó�� �Լ��� ���� ������ ������ ���� �ʴ� ������ ġȯ
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NUL(mgr, -1)
                    FROM emp);

���� �÷��� �����ϴ� ���������� ���� ���� ==> ���� �÷��� �����ϴ� ��������
PAIRWISE ���� (������) ==> ���ÿ� ����

SELECT empno, mgr, deptno
FROM emp
WHERE empno IN (7499, 7782);

7499, 7782����� ������ ���� �μ�, ���� �Ŵ����� ��� ���� ������ȸ
�Ŵ����� 7698�̸鼭 �ҼӺμ��� 30�� ���
�Ŵ����� 7839�̸鼭 �ҼӺμ��� 10�� ���
(7698, 30)
(7839, 10)


mgr �÷��� deptno �÷��� �������� ����
(mgr, deptno)
(7698, 10)
(7698, 30)
(7839, 10)
(7839, 30);
SELECT *
FROM emp
WHERE mgr IN (7698, 7839)
  AND deptno IN (10, 30);

PAIRWISE ���� (���� �������� ����� �� �� ����)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT  mgr, deptno
                        FROM emp
                        WHERE empno IN (7499,7782));
                        

�������� ���� - �����ġ
SELECT - ��Į�� ���� ����
FROM - �ζ��� ��
WHERE - ��������

�������� ���� - ��ȯ�ϴ� ��, �÷��� ��
���� ��
    ���� �÷�(��Į�� ���� ����)
    ���� �÷�
���� ��
    ���� �÷�(���� ���� ����)
    ���� �÷�
    
��Į�� ��������
SELECT ���� ǥ���Ǵ� ��������
���� �� ���� �÷��� �����ϴ� ���������� ��� ����
���� ������ �ϳ��� �÷� ó�� �ν�;

SELECT 'X', (SELECT SYSDATE FROM dual)
FROM dual;

��Į�� ���� ������ �ϳ��� ��, �ϳ��� �÷��� ��ȯ�ؾ� �Ѵ�

���� �ϳ����� �÷��� 2������ ����
SELECT 'X', (SELECT empno, ename FROM emp WHERE ename = 'SMITH')
FROM dual;

������ �ϳ��� �÷��� �����ϴ� ��Į�� �������� ==> ����
SELECT 'X', (SELECT empno FROM emp)
FROM dual;

emp ���̺� ����� ��� �ش� ������ �Ҽ� �μ� �̸��� �˼��� ���� ==> ����

Ư�� �μ��� �μ� �̸��� ��ȸ�ϴ� ����
SELECT dname
FROM dept
WHERE deptno = 10;

�� ������ ��Į�� ���������� ����

join���� ����
SELECT empno, ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

�� ������ ��Į�� ���������� ����
SELECT empno, ename, dept.deptno,(SELECT dname FROM dept WHERE deptno = 10) --, �μ��̸�
FROM emp, dept;


SELECT empno, ename, dept.deptno,(SELECT dname FROM dept WHERE deptno = emp.deptno) --, �μ��̸�
FROM emp, dept;

�������� ���� - ���������� �÷��� ������������ ����ϴ��� ���ο� ���� ����
��ȣ���� ��������(corelated sub query)
    .���� ������ ���� �Ǿ�� ���� ������ ������ �����ϴ�
    
���ȣ ���� ��������(non corelated sub query)
    .main ������ ���̺��� ���� ��ȸ�� ���� �ְ�
     sub ������ ���̺��� ���� ��ȸ�� ���� �ִ�
     ==> ����Ŭ�� �Ǵ����� �� ���ɻ� ������ �������� ���� ������ ����
��� ������ �޿� ��պ��� ���� �޿��� �޴� ������ ��ȸ�ϴ� ������ �ۼ� �ϼ���(���� ���� �̿�)
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

�����غ� ����, ���� ������ ��ȣ ���� ���� �����ΰ�? ���ȣ ���� ���� �����ΰ�?

������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴� ����
��ü ������ �޿� ��� ==> ������ ���� �μ��� �޿� ���

Ư�� �μ�(10)�� �޿� ����� ���ϴ� SQL
SELECT *
FROM emp e
WHERE sal > (SELECT AVG(sal)
             FROM emp
             WHERE deptno = e.deptno);


SELECT *
FROM emp e
WHERE sal > (SELECT AVG(sal)
             FROM emp
             WHERE emp.deptno = e.deptno);


�ƿ��� ���� ==> ������ �����ϴ���� �������� ���� ���̺��� �÷� ������ ��ȸ�� �ǵ��� �ϴ� ���� ���
table LEFT OUTER JOIN table2
==> table�� �÷��� ���ο� �����ϴ��� ��ȸ�� �ȴ�
(oracle 9i ���� ������ ������ �Ǵ� ���̺� ���� �д´�
==> oracle 10g���� ���ʹ� ���ɻ� ������ ���̺� ���� �д´�);

SELECT *
FROM dept;

INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

emp���̺� ��ϵ� �������� 10, 20, 30�� �μ����� �Ҽ��� ������
���� �Ҽӵ��� ���� �μ� : 40, 99

sub4]
SELECT deptno, dname
FROM dept
WHERE deptno NOT IN(SELECT deptno
                    FROM emp);
                    
���������� �̿��Ͽ� IN �����ڸ� ���� ��ġ�ϴ� ���� �ִ��� ������ ��
���� ������ �־ ��� ����(����)

������ �μ���ȣ�� ������������ ��ȸ���� �ʵ��� ���� �ҷ��� �׷� ������ �� ���(���� �´�)    
SELECT deptno, dname
FROM dept
WHERE deptno NOT IN(SELECT emp.deptno
                    FROM emp
                    WHERE emp.deptno = dept.deptno
                    GROUP BY emp.deptno);
���� ���� = , 
���� �� �� = ��� ����
    IN, [ANY, ALL] 
    
    
������ ���� �μ� ���� ��ȸ (������ �Ѹ��̶� �����ϴ� �μ�)

SELECT *
FROM Cycle;

SELECT *
FROM product;

sub5]
SELECT pid, pnm
FROM product
WHERE pid NOT IN(SELECT pid
                 FROM cycle 
                 WHERE cid = 1);

sub6]
1�� ���� ������ǰ ������ ��ȸ�� �Ѵ�.
�� 2�� ���� �Դ� ������ǰ����
SELECT *
FROM cycle
WHERE cid = 1
  AND pid IN (SELECT pid
              FROM cycle 
              WHERE cid = 2);

sub7]
������ �̿��� ���
SELECT c.cid, cnm, c.pid, pnm, day, cnt
FROM cycle c, customer cus, product p
WHERE c.cid = cus.cid
  AND p.pid = c.pid
  AND c.cid = 1
  AND c.pid IN (SELECT pid
                FROM cycle 
                WHERE cid = 2);

��Į�� ���������� �̿��� ���
SELECT cid,(SELECT cnm FROM customer WHERE cid = 3) cnm, pid, (SELECT pnm FROM product WHERE pid = 100) pnm, day, cnt
FROM cycle
WHERE cid = 1
  AND pid IN (SELECT pid
                FROM cycle 
                WHERE cid = 2);

SELECT cnm FROM customer WHERE cid = 3;
SELECT pnm FROM product WHERE pid = 100;






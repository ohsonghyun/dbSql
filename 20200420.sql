����¡ ó���� �ϴ� ����
1. ����ó�� �ʹ� �����ϱ�
 �� ȭ�鿡 ������ �ǿ伺�� ��������
 ���ɸ鿡�� ��������
 
 ����Ŭ���� ����¡ ó�� ��� ==> ROWNUM
 
 ROWNUM : SELECT ������� 1������ ������� ��ȣ�� �ο����ִ� Ư�� KEYWORD
 
 SELECT ROWNUM, empno, ename
 FROM emp;
 
 SELECT���� * ǥ���ϰ� �޸��� ���� 
 �ٸ� ǥ�� (ex ROWNUM) �� ����� ���
 *�տ� � ���̺� ���Ѱ��� ���̺� ��Ī/��Ī��
 ����ؾ� �Ѵ�
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;

����¡ ó���� ���� �ʿ��� ���� 
1. ������ ������(10)
2. ������ ���� ����

1-page: 1-10
2-page: 11-20 (���������δ� 11~14)

1 ������ �� ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;


1 ������ �� ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20;

ROWNUM�� Ư¡
1. ORACLE���� ����
    .�ٸ� DBMS�� ��� ü��¡ ó���� ���� ������ Ű���尡 ����(LIMIT)
2. 1������ ���������� �д� ��츸 ����
    ROWNUM BETWEEN 1 AND 10; ==> (1~10)
    ROWNUM BETWEEN 1 AND 10; ==> 1~10�� SKIP�ϰ� 11~20�� �������� �õ�
    
    WHERE ������ ROWNUM�� ����� ��� ���� ����
    ROWNUM =1;
    ROWNUM BETWEEN 1 AND N;
    ROWNUM <, <= n (1~N)
    
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY empno;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

ROWNUM�� ORDER BY ������ ����
SELECT -> ROWNUM -> ORDER BY

ROWNUM�� ��������� ���� ������ �Ȼ��·� ROWNUM�� �ο��Ϸ��� IN-LINE VIEW�� ����ؾ� �Ѵ�
** IN-LINE : ���� ����� �ߴ�;

SELECT ROWNUM, a.*
FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a
WHERE ROWNUM BETWEEN 11 AND 20;
--���� ROWNUM�� �����͸� ���������� �о�� �Ѵ�

SELECT *
FROM
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
        FROM emp
        ORDER BY ename) a) a
WHERE rn BETWEEN 1+ (:page - 1) * :pageSize AND :page * :pageSize;
����ǥ�� :

WHERE rn BETWEEN 1 AND 10; 1 PAGE
WHERE rn BETWEEN 11 AND 20; 2 PAGE
WHERE rn BETWEEN 21 AND 30; 3 PAGE
.
.
.
WHERE rn BETWEEN 1+(n-1)*10 AND pageSize * n; n PAGE



����

SELECT *
FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename);
    
    INLINE -VIEW�� �񱳸� ���� VIEW�� ���� ����(�����н�, ���߿� ���´�)
    VIEW - ����
    
    DML - Data Manipulation Language : SELECT, INSERT, UPDATE, DELETE
    DDL - Data DefiniTiON Language : CREATE, DROP, MODIFY, RENAME
    
    CREATE OR REPLACE VIEW emp_ord_by_ename AS
        SELECT empno, ename
        FROM emp
        ORDER BY ename;



IN_LINE VIEW �� �ۼ��� ����
SELECT *
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename);

view�� �ۼ��� ����
SELECT *
FROM emp_ord_by_ename;

emp ���̺� �����͸� �߰��ϸ� 
in_line view, view�� ����� ������ ����� ��� ������ ������??? ���� �޴´�.]


���� �ۼ��� ������ ã�ư���
BUG ??? : ����
���� ��ǻ�� : ������
������ ������ ���̿� ���� ������ �߻� ==> ���� ������ ����(�����)

java : �����
SQL : ����� ���� ����

����¡ ó�� ==> ����, ROWNUM 
����, ROWNUM�� �ϳ��� �������� ������ ��� ROWNUM���� ������ �Ͽ�
���ڰ� ���̴� ���� �߻� ==> INLINE - VIEW
    ���Ŀ� ���� INLINE-VIEW
    ROWNUM�� ���� INLINE-VIEW
    
    
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT empno, ename
        FROM emp
        ORDER BY ename) a) 
    WHERE rn BETWEEN 11 AND 20;

row_2]
SELECT *
FROM
    ( SELECT ROWNUM rn, a.*
     FROM
        (SELECT empno, ename
        FROM emp
        ORDER BY ename ) a
        ) 
    WHERE rn BETWEEN 11 AND 20;
 
 
 
 �űԹ��� 
 PROD ���̺��� PROD_LGU (��������), PROD_COST(��������)���� �����Ͽ�
 ����¡ ó�� ������ �ۼ��ϼ���
 �� ������ ������� 5 
 ���ε� ���� ����� ��
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM 
         (SELECT *
          FROM prod
          ORDER BY prod_lgu DESC, prod_cost) a)
WHERE rn BETWEEN  1+ (:page - 1) * :pageSize AND :page * :pageSize;

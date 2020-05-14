�����ȹ : SQL�� ���������� � ������ ���ļ� �������� ������ �ۼ�
        * ����ϴµ� ��� ���� ����� �ʿ�(�ð�)
        

2���� ���̺��� �����ϴ� SQL
2���� ���̺� ���� �ε����� 5���� �ִٸ�
������ �����ȹ ���� �?? ������ ���� ==> ª�� �ð��ȿ� �س��� �Ѵ�(������ ���� �ؾ��ϹǷ�)


���� ������ SQL�� ����� ��� ������ �ۼ��� �����ȹ�� ������ ���
���Ӱ� ������ �ʰ� ��Ȱ���� �Ѵ�(���ҽ� ����)

���̺� ���� ��� : ���̺� ��ü(1), ������ �ε���(5)
a => b
b => a
����� �� : 36�� * 2�� = 72��
 
������ SQL �̶� : SQL ������ ��ҹ��� ������� ��ġ�ϴ� SQL
�Ʒ� �ΰ��� sql �� ���� �ٸ� SQL �� �ν��Ѵ�
SELECT * FROM emp;
Select * FROM emp;

Ư�������� ������ ��ȸ�ϰ� ������ : ����� �̿��ؼ� 
Select /*202004_B*/*
FROM emp
WHERE empno = :empno;
--���ε� ������ �� �߿��� ���� sql�������� ������ �� �ִ�

SELECT *
FROM user_tables;

SELECT *
FROM ALL_tables;

SELECT *
FROM DBA_tables;

SELECT *
FROM dictionary;

Multiple insert :�������� �����͸� ���ÿ� �Է��ϴ� insert �� Ȯ�屸��

1. uncoditional insert : ������ ���� ���� ���̺� �Է��ϴ� ���
����:
    INSERT ALL
        INTO ���̺��
        [,INTO ���̺��]
    VALUES(....) | SELECT QUERY;

SELECT *
FROM emp_test;

mp_test �׾ƺ��� �̿��Ͽ� emp_test2 ���̺� ����

CREATE TABLE emp_test2 AS
SELECT *
FROM emp_test
WHERE 1 = 2; --�����ʹ� �������� �ʰڴ�

EMPNO, ENAME, DEPTNO

emp_test, emp_test2 ���̺� ���ÿ� �Է�
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9998, 'brown', 88 FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

select *
from emp_test;

2. conditional insert : ���ǿ� ���� �Է��� ���̺��� ����
����
INSERT ALL 
    WHEN ���� ..... THEN
        INTO �Է� ���̺� VALUES
    WHEN ���� ..... THEN
        INTO �Է� ���̺�2 VALUES
    ELSE
        INTO �Է� ���̺�3 VALUES

SELECT ����� ���� ���� EMPNO = 9998 �̸�  EMP_TEST ���� �����͸� �Է�
                    �� �ܿ��� EMP_TEST2�� �����͸� �Է�
;                   
INSERT ALL
    WHEN empno = 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    ELSE
        INTO emp_test2 (empno, deptno) VALUES (empno, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

ROLLBACK;

conditional insert (all) ==> first : ������ �����ϴ� ù ��° WHEN ���� ����
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


MERGE : �ϳ��� ������ ���� �ٸ� ���̺�� �����͸� �ű� �Է�, �Ǵ� ������Ʈ �ϴ� ����
���� :
MERGE INTO ���� ���(emp_test)
USING (�ٸ� ���̺�| VIEW | subquery)
ON (�������� USING ���� ���� ���� ���)
WHEN NOT MATCHED THEN
    INSERT (coll, coll2...) VALUES (values1, values2...)
WHEN MATCHED THEN
    UPDATE SET coll = values , coll2 = values2

1. �ٸ� �����ͷ� ���� Ư�� ���̺�� �����͸� ���� �ϴ� ���
2. KEY�� ���� ��� INSERT
   KEY�� ���� �� UPDATE

emp ���̺��� �����͸� emp_test ���̺�� ����
emp ���̺��� �����ϰ� emp_test ���̺��� �������� �ʴ� ������ �ű��Է�
emp ���̺��� �����ϰ� emp_test ���̺��� �����ϴ� ������ �̸� �ű��Է�
;
/*
9998	brown	88
9997	cony	88
7369	cony	88
*/
INSERT INTO emp_test VALUES(7369, 'cony', 88);
emp���̺��� 14�� �����͸� emp_test���̺� ������ empno �� �����ϴ��� �ǻ��ؼ�
������ empno�� ������ insert-empno, ename, ������ empno �� ������ update_ename

SELECT *
FROM emp_test;
MERGE INTO emp_test
USING emp
ON (emp_test.empno = emp.empno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (emp.empno, emp.ename)
WHEN MATCHED THEN
    UPDATE SET ename = emp.ename;

���� �ó������� �ϳ��� ���̺��� �ٸ� ���̺��� �����ϴ� ���

9999�� ������� �ű� �Է��ϰų�, ������Ʈ�� �ϰ� ���� ��
(��뤷�ڰ� 9999��, james ����� ����ϰų�, ������Ʈ �ϰ� ���� ��)
���� ���� ���̺� ==> �ٸ� ���̺�� ����

�̹��� �ϴ� �ó����� : �����͸� ==> Ư�� ���̺�� ����
(9999, james)

MERGE ������ ������� ������ 

���������� ������ ���� SELECT ����
SELECT *
FROM emp_test
WHERE empno = 9999;

�����Ͱ� ������ ==> UPDATE
�����Ͱ� ������ ==> INSERT

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

emp ���̺��� 7698�� ������ �̸��� 
emp_test ���̺��� 9999�� ������ �̸����� ������Ʈ �ϴ� merge ���� �ۼ�
���� 9999�� ������ emp_test �� ������ empno = 9999,
                                 ename = emp ���̺��� 7698������ �̸�, deptno = null �� �ű��Է�

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
emp ���̺��� �̿��Ͽ� �μ���ȣ�� ������ �޿� �հ�, ��ü������ �޿����� ��ȸ�ϱ� ����
GROUP BY �� ����ϴ� �ΰ��� SQL �� ������ �ϳ��� ��ġ�� (UNION ==> UNION ALL) �۾��� ����

Ȯ��� GROUP BY 3����
1. GROUP BY BOLLUP
���� : GROUP BY ROLLUP (�÷�, �÷�2...)
���� : ����׷��� ������ִ� �뵵
����׷� ���� ��� : ROLLUP ���� ����� �÷��� �����ʿ��� ���� �ϳ��� �����ϸ鼭 ����׷��� ����
������ ����׷��� UNION �� ����� ��ȯ

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

����׷� : 1. GROUP BY job, deptno
            UNION
         2. GROUP BY job
            UNION
         3. ��ü�� GROUP BY
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

==> GROUP BY ROLLUP ���� ����

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno);

����׷��� ������ : ROLLUP ���� ����� �÷� ���� : +1;









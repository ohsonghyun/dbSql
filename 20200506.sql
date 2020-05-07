--2����

SELECT job, count(*) cnt
FROM emp
GROUP BY JOB;

SELECT mgr, count(*) cnt
FROM emp
GROUP BY mgr;

--1����

SELECT manager_id, department_id, count(*) cnt
FROM employees
GROUP BY manager_id, department_id;

-- ������ ����, tax�� �ִ� �õ�, �ñ����� fastfood�� ���� Ȯ��
SELECT sido, sigungu
FROM tax

MINUS

SELECT sido, sigungu
FROM fastfood;





DML
�����͸� �Է�(INSERT), ����(UPDATE), ����(DELETE) �� �� ����ϴ� SQL

INSERT

����
INSERT INTO ���̺�� [(���̺��� �÷���, ....)] VALUES (�Է��� ��, ....);

ũ�� ���� �ΰ��� ���·� ���
1. ���̺��� ��� �÷��� ���� �Է��ϴ� ���, �÷Ÿ��� �������� �ʾƵ� �ȴ�
   ��, �Է��� ���� ������ ���̺� ���ǵ� �÷� ������ �νĵȴ�
INSERT INTO ���̺�� VALUES (�Է��� ��, �Է��� ��2, ....);

2. �Է��ϰ��� �ϴ� �÷��� ����ϴ� ���
   ����ڰ� �Է��ϰ��� �ϴ� �÷��� �����Ͽ� �����͸� �Է��� ���
   �� ���̺� NOT NULL ������ �Ǿ��ִ� �÷��� �����Ǹ� INSERT�� �����Ѵ�
INSERT INTO ���̺�� (�÷�1, �÷�2) VALUES (�Է��� ��, �Է��� ��2);

3. SELECT ����� INSERT
   SELECT ������ �̿��ؼ� ������ ���� ��ȸ�Ǵ� ����� ���̺� �Է� ����
   ==> �������� �����͸� �ϳ��� ������ �Է� ����(ONE-QUERY) ==> ���� ����

   ����ڷ� ���� �����͸� ���� �Է� �޴� ���(ex ȸ������)�� ������ �Ұ�
   db�� �����ϴ� �����͸� ���� �����ϴ� ��� Ȱ�� ����(�̷� ��찡 ����)
   
   INSERT INTO ���̺�� [(�÷���1, �÷���2, ....)]
   SELECT ....
   FROM ....



dept ���̺� deptno 99, dname ddit, loc daejeon ���� �Է��ϴ� INSERT ���� �ۼ�
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept (deptno, dname, loc) VALUES ( 99, 'ddit', 'daejeon' );
INSERT INTO dept (loc, deptno, dname) VALUES ( 'daejeon', 99, 'ddit' );

������ �Է��� Ȯ�� �������� : commit - Ʈ����� �Ϸ�
������ �Է��� ��� �Ϸ��� : rollback - Ʈ����� ���

rollback;

SELECT *
FROM dept;

���� INSERT ������ ������ ���ڿ�, ����� �Է��� ���
INSERT �������� ��Į�� ��������, �Լ��� ��� ����
EX : ���̺� �����Ͱ� �� ����� �Ͻ������� ��� �ϴ� ��찡 ���� ==> SYSDATE
;
SELECT *
FROM emp;

emp ���̺��� ��� �÷� �� ������ 8��, NOT NULL�� 1�� (EMPNO)
empno�� 9999�̰�, ename�� �����̸�, hiredate�� ���� �Ͻø� �����ϴ� INSERT ������ �ۼ�
INSERT INTO emp (empno, ename, hiredate) VALUES (9999, 'chanhee', SYSDATE);

9999�� ������� jw ����� �Է�, �Ի����ڴ� 2020�� 4�� 13�Ϸ� �����Ͽ� ������ �Է�
INSERT INTO emp (empno, ename, hiredate) VALUES (9999, 'jw', TO_DATE('20200413', YYYYMMDD));


SELECT ����� ���̺� �Է��ϱ� (�뷮 �Է�)
;
DESC dept;

dept ���̺��� 4���� �����Ͱ� ���� (10~40)
�Ʒ������� �����ϸ� ���� ���� 4�� + SELECT�� �ԷµǴ� 4�� �� 8���� �����Ͱ� dept ���̺� �Էµ�
INSERT INTO dept
SELECT *
FROM dept;

������ Ȯ��
SELECT *
FROM dept;

������ �۾��� INSERT ������ ���
ROLLBACK;

UPDATE : ������ ����
UPDATE ���̺�� SET ������ �÷�1 = ������ ��1,
                  [������ �÷�2 = ������ ��2, ....]
[WHERE condition-SELECT ������ ��� WHERE ���� ����
       ������ ���� �ν��ϴ� ������ ���];
       
INSERT INTO dept VALUES (99, 'DDIT', 'daejeon');

������ �Է� Ȯ��
SELECT *
FROM dept;

99�� �μ��� �μ����� ���IT��, ��ġ�� ���κ������� ����
WHERE ���� ������ ���̺��� ��� ���� �μ���� ��ġ�� �����ع���

UPDATE dept SET dname = '���IT',
                loc = '���κ���'
WHERE deptno = 99;

INSERT : ���� �� ���� ����
UPDATE, DELETE : ������ �ִ°� ����, ����
    ==> ������ �ۼ��� ��� ����
        1. WHERE ���� �������� �ʾҴ���
        2. UPDATE, DELETE ���� �����ϱ� ���� WHERE���� �����ؼ� SELECT�� �ϸ�
           ������ ���� ���� ������ Ȯ��
           
ORACLE ����ڿ��Դ� UPDATE, DELETE�� �Ǽ� ���� ��� �ѹ��� ��ȸ�� ����
ROLLBACK;



���������� �̿��� ������ ����
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brwon', NULL);

9999�� ������ deptno, job �ΰ��� �÷��� SMITH ����� ������ �����ϰ� ����

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
               job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

�Ϲ����� UPDATE ���������� �÷����� ���������� �ۼ��Ͽ� ��ȿ���� ����
==> MERGE ������ ���� ��ȿ���� ������ �� �ִ�.



DELETE : ���̺� �����ϴ� �����͸� ����
����
DELETE [FROM] ���̺��
[WHERE condition]

������
1. Ư�� �÷��� ���� ���� ==> �ش� �÷��� NULL�� UPDATE
   DELETE���� �� ��ü�� ����
2. UPDATE ���������� DELETE ������ �����ϱ� ���� SELECT�� ���� ���� ����̵Ǵ� ���� ��ȸ, Ȯ������

���� �׽�Ʈ ������ �Է�
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brwon', NULL);

����� 9999���� ���� �����ϴ� ���� �ۼ�
DELETE emp
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

�Ʒ� ������ �ǹ� : emp ���̺��� ��� ���� ����
DELETE emp;

UPDATE, DELETE ���� ��� ���̺� �����ϴ� �����Ϳ� ����, ������ �ϴ� ���̱� ������
��� ���� �����ϱ� ���� WHERE ���� ����� �� �ְ�
WHERE ���� SELECT ������ ����� ������ ������ �� �ִ�
���� ��� ���������� ���� ���� ������ ����

�Ŵ����� 7698�� �������� ��� �����ϰ� ���� ��
DELETE emp
WHERE mgr = 7698;

SELECT *
FROM emp;

ROLLBACK;

DML : SELECT, INSERT, UPDATE, DELETE
WHERE ���� ��� ������ DML : SELECT, UPDATE, DELETE
    3���� ������ �����͸� �ĺ��ϴ� WHERE ���� ��� �� �� �ִ�
    �����͸� �ĺ��ϴ� �ӵ��� ���� ������ ���� ������ �¿� �ȴ�.
    ==> INDEX ��ü�� ���� �ӵ� ����� ����
    
INSERT : ������� �ű� �����͸� �Է� �ϴ� ��
         ������� �ĺ��ϴ°� �߿�
         ==> �����ڰ� �� �� �ִ� Ʃ�� ����Ʈ�� ���� ����
         
���̺��� �����͸� ����� ��� (��� ������ �����)
1. DELETE : WHERE���� ������� ������ ��
2. TRUNCATE 
   ���� : TRUNCATE TABLE ���̺��
   Ư¡ : 1) ������ �α׸� ������ ����
            ==> ������ �Ұ���
         2) �α׸� ������ �ʱ� ������ ���� �ӵ��� ������
            ==> �ȯ�濡���� �� ������� ���� (������ �ȵǱ� ������)
                �׽�Ʈ ȯ�濡�� �ַ� ���
                
;
�����͸� �����Ͽ� ���̺� ����(���� �غ���)
CREATE TABLE emp_cp AS
SELECT *
FROM emp;

SELECT *
FROM emp_cp;

emp_cp ���̺��� TRUNCATE ����� ���� ��� �����͸� ����
TRUNCATE TABLE emp_cp;

Ʈ����� : ������ ���� ����
ex : ATM - ��ݰ� �Ա��� �Ѵ� ���������� �̷������ ������ �߻����� ����
           ����� ���� ó�� �Ǿ����� �Ա��� ������ ó�� �Ǿ��ٸ�
           ���� ó���� ��ݵ� ��Ҹ� ����� �Ѵ�
           
���
�Ա�(����)
ROLLBACK;

����Ŭ������ ù��° DML�� ������ �Ǹ� Ʈ���� �������� �ν�
Ʈ������� ROLLACK, COMMIT�� ���� ���ᰡ �ȴ�

Ʈ����� ������ ���ο� DML�� ����Ǹ� ���ο� Ʈ������� ����

��� ����ϴ� �Խ����� �����غ���
�Խñ� �Է��� �� �Է� �ϴ� �� : ����(1��), ����(1��), ÷������(���� ����)
RDBMS������ �Ӽ��� �ߺ��� ��� ������ ����Ƽ(���̺�)�� �и��� �Ѵ�
�Խñ� ���̺�(����, ����) / �Խñ� ÷������ ���̺�(÷�����Ͽ� ���� ����)

�Խñ��� �ϳ� ����� �ϴ���
�Խñ� ���̺��, �Խñ� ÷������ ���̺� �����͸� �űԷ� ����� �Ѵ�
INSERT INTO �Խñ� ���̺� (����, ����, �����, ����Ͻ�, ...) VALUES (...);
INSERT INTO �Խñ� ÷������ ���̺� (÷�����ϸ�, ÷������ ������, ...) VALUES (...);

�� ���� INSERT ������ �Խñ� ����� Ʈ����� ����
�� �ΰ��߿� �ϳ��� ������ ����� �Ϲ������� ROLLBACK�� ���� �� ���� INSERT ������ ���


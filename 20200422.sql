7. ������� �������� ���� �����ȹ(Execution plan)�� ������ ������ ������ ����(If Then Else)�� ������ ������ �ϳ��� SQL�� �ӹ��� �ϼ���� �϶�


�־�����: ����� ��� �ִ� ���ڿ� ==>'201912' ==> 31

���ڿ�     =>      ��¥      ==>     ������ ��¥�� ����      ==>     ����

fn3]
SELECT '201912' PARAM,
       TO_CHAR((LAST_DAY(TO_DATE('201912', 'YYYYMM'))), 'DD') AS DT,
       TO_CHAR((LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM'))), 'DD') AS DT2
FROM dual;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7367';


SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3956160932

�����ȹ�� ���� ����(id)
* �鿩���Ⱑ �Ǿ������� �ڽ� ���۷��̼�
1. ������ �Ʒ���
    *�� �ڽ� ���۷��̼��� ������ �ڽ� ���� �д´�

    1 ==> 0
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 ==> 14���� �� �а� 7367�� ���״�(?)

Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7367)
 
Note
-----
   - dynamic sampling used for this statement (level=2)



EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369')
 
Note
-----
   - dynamic sampling used for this statement (level=2)


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 +'69';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

   1 - filter("EMPNO"=7369) ==> ���ڿ��� �־��µ� ���ڰ� �Ǽ� ���� ��������(������ ����ȯ)

0009000
0010000


SELECT ename, sal, TO_CHAR(sal, 'L009,999.00')
FROM emp;


NULL�� ���õ� �Լ�
NVL
NVL2
NULLIF
COALESCE;

�� null ó���� �ؾ��ұ�?
NULL�� ���� �������� NULL�̴�

������ emp ���̺� �����ϴ� sal, comm �ΰ��� ���� ���� ���� �˰� �;
������ ���� SQL�� �ۼ�

SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1�� null�̸� expr2���� �����ϰ�
expr1�� null�� �ƴϸ� expr1�� ����

SELECT empno, ename, sal, comm, sal + NVL(comm, 0) AS sal_plus_comm
FROM emp;
==>sal + NVL(comm, 0) ���� ���� ���� NULL���̸� 

REG_DT �÷��� NULL�� ��� ���� ��¥�� ���� ���� ������ ���ڷ� ǥ��
SELECT userid, usernm, reg_dt, NVL(reg_dt, LAST_DAY(SYSDATE))
FROM users;

REG_DT �÷��� NULL�� ��� ���� ��¥�� ���� ���� ������ ���ڷ� ǥ��
SELECT userid, usernm, reg_dt, NVL(TO_CHAR(reg_dt, 'yyyymmdd'), TO_CHAR((LAST_DAY(SYSDATE)), 'DD'))
FROM users;








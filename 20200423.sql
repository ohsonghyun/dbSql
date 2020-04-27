NVL(expr1, expr2)
if expr1 == null
    return expr2
else
    return expr1;

NVL2(expr1, expr2, expr3)
if expr1 != null
    return expr2
else
    return expr3;


SELECT empno, ename, sal, comm, NVL2(comm, 100, 200)
FROM emp;

NULLIF(expr1, expr2)
if expr1 == expr2
    return null;
else
    return expr1

sal�÷��� ���� 3000�̸� null�� �����ض�
SELECT empno, ename, sal, NULLIF(sal, 3000)
FROM emp;

�������� : �Լ��� ������ ������ ������ ���� ����
          �������ڵ��� Ÿ���� ���� �ؾ���
          disply("test"), display("test1", "test2", "test3")

���ڵ��߿� ���� ���������� null�� �ƴ� ���� ���� ����
coalesce(expr1, expr2, expr3....)
if expr1 != null
    return expr
else
    coalesce(ewxpr2, expr3....)

mgr �÷� null
comm �÷� null

SELECT empno, ename, comm, sal, coalesce(comm, sal)
FROM emp;

fn4]
SELECT empno, ename, mgr, NVL(mgr, 9999) mgr_n, NVL2(mgr, mgr, 9999) mgr_n_1, coalesce(mgr, 9999) mgr_n_2
FROM emp;

fn5]
SELECT userid, usernm, reg_dt, NVL(reg_dt, SYSDATE) N_REG_DT
FROM users
WHERE userid != 'brown';

condition
���ǿ� ���� �÷� Ȥ�� ǥ������ �ٸ� ������ ��ü
java if, switch ���� ����
1. ����
2. decode �Լ�

1.CASE
CASE
        WHERE ��//������ �Ǻ��� �� �ִ� �� THEN ������ ��
        [WHERE ��//������ �Ǻ��� �� �ִ� �� THEN ������ ��]
        [ELSE ������ �� )(�Ǻ����� ���� WHEN���� ������� ����)]
END

emp���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� MANAGER�� ��� SAL���� 10% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿� �������� sal��ŭ�� ����

SELECT empno, ename, job, sal,
       CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
       END bonus
FROM emp;

2. DECODE(EXPR1, search1, return1, search2, return2, search3, return3..... [default])
DECODE(EXPR1, 
          search1, return1,
          search2, return2,
          search3, return3,
          default)
if EXPR1 == search1
    return return1
else if EXPR1 == search2
    return return2
else if EXPR1 == search3
    return return3
else 
    return defualt;
    
SELECT empno, ename, job, sal,
       DECODE(job, 'SALESMAN', sal * 1.05,
                   'MANAGER', sal * 1.10,
                   'PERSIDENT', sal * 1.20,
                   sal) bonus
FROM emp;

cond1_1]
SELECT empno, ename,
       CASE 
           WHEN deptno = 10 THEN 'ACCOUNTING'
           WHEN deptno = 20 THEN 'RESERCH'
           WHEN deptno = 30 THEN 'SALES'
           WHEN deptno = 40 THEN 'OPERATION'
           ELSE 'DDIT'
       END dname
FROM emp;

cond1_2]
SELECT empno, ename,
       DECODE(deptno, 10, 'ACCOUNTING',
                      20, 'RESERCH',
                      30, 'SALES',
                      40, 'OPERATION',
                     'DDIT') dname
FROM emp;

cond2] ���س⵵�� ¦��/Ȧ��, ������ ����⵵�� ¦��/Ȧ��
MOD����� ������ ���� �������� Ŭ���� ����.
SELECT empno, ename, hiredate, 
       CASE
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = 0 AND MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 0 THEN '�˰����� �����'
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = 0 AND MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 1 THEN '�˰����� ������'
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = 1 AND MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 1 THEN '�˰����� �����'
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = 1 AND MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 0 THEN '�˰����� ������'
       END conact_to_doctor,
       DECODE(MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), MOD(TO_CHAR(hiredate, 'YYYY'), 2), '�˰����� �����', '�˰����� ������') conact_to_doctor2
FROM emp;
--���� WHEN�� �� �ٷ� ǥ���ϴ� ��� ==> WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = AND MOD(TO_CHAR(hiredate, 'YYYY'), 2) THEN '�˰����� �����'
--                                   ELSE '�˰����� ������'


cond3]
SELECT userid, usernm, alias, reg_dt, 
      CASE
          WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(reg_dt, 'YYYY'), 2) THEN '�˰����� �����'
          ELSE '�ǰ����� ������'
      END contacttodoctor
FROM users;







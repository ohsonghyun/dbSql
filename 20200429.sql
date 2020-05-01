join13]
SELECT e. manager_id as mgr_id, m.first_name || m.last_name as mgr_name,
       e.employee_id, e.first_name || e.last_name as name,
       j.job_id, j.job_title
FROM employees e, jobs j, employees m
WHERE e.job_id = j.job_id
  AND e.manager_id = m.employee_id;
  
OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ���
<===>
INNER JOIN (�츮�� ���ݱ��� ��� ���)

LEFT OUTER JOIN     : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN    : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
FULL OUTER JOIN     : LEFT OUTER JOIN + RIGHT OUTER JOIN - (�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)

emp ���̺��� �÷��� mgr�÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������ KING������ ��� ����ڰ� ���� ������ �Ϲ������� inner ���� ó����
���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ�� ��

INNER ���� ����
����� ���, ����� �̸�, ���� ���, ���� �̸�


������ �����ؾ����� ������ ��ȸ�ȴ�
==> KING�� ����� ����(mgr)�� NULL�̱� ������ ���ο� �����ϰ�
    KING

SELECT e. manager_id as mgr_id, m.first_name || m.last_name as mgr_name,
       e.employee_id, e.first_name || e.last_name as name
FROM employees e, employees m
WHERE  e.manager_id = m.employee_id;

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE  e.mgr = m.empno;

ANSI-SQL(�÷����� �ٸ��ϱ� JOIN ON)
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

���� ������ OUTER �������� ����
(KING ������ ���ο� �����ص� ���� ������ ���ؼ��� �������� ������ ����� ������ ���� ������ ������ �ʴ´�);

ANSI-SQL : OUTER
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON (e.mgr = m.empno);

ORACLE : OUTER
oracle-join
1. FROM ���� ������ ���̺� ���(�޸��� ����)
2. WHERE ���� ���� ������ ���
3. ���� �÷�(�����)�� ������ �����Ͽ� �����Ͱ� ���� ���� Ŀ���� (+)�� �ٿ� �ش�
  ==> ������ ���̺� �ݴ����� ���̺��� �÷�
  
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m  
WHERE e.mgr = m.empno(+);

OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 �����ؼ�;

������ ON���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND e.deptno = 10);

������ WHERE���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE e.deptno = 10;

OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ� �� �´�

SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno
  AND e.deptno = 10;


outerjoin1]
SELECT *
FROM buyprod
WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON(b.buy_prod = p.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod b, prod p 
WHERE b.buy_prod(+) = p.prod_id 
  AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

outerjoin2]
SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD') buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON(b.buy_prod = p.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

outerjoin3]
NVL, NVL2, COALESCE
SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD') buy_date, buy_prod, prod_id, prod_name, NVL(buy_qty, 0) buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON(b.buy_prod = p.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

outerjoin4]
ANSI-SQL
SELECT p.pid, pnm, NVL(cid, 1) cid, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM cycle c RIGHT OUTER JOIN product p ON(c.pid = p.pid AND cid = 1); 

ORACLE SQL
SELECT p.pid, pnm, NVL(cid, 1) cid, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM cycle c ,product p 
WHERE c.pid(+) = p.pid 
  AND cid(+) = 1; 

outerjoin5]
ANSI-SQL
SELECT rm.pid, rm.pnm, 1 cid, cnm, NVL(rm.day, 0) day, NVL(rm.cnt, 0) cnt
FROM
(SELECT p.pid, pnm, NVL(cid, 1) cid, NVL(day, 0) day, NVL(cnt, 0) cnt
 FROM cycle c RIGHT OUTER JOIN product p ON(c.pid = p.pid AND cid = 1)) rm JOIN customer cs ON(rm.cid = cs.cid); 

ORACLE-SQL
SELECT p.pid, pnm, NVL(c.cid, 1) cid, NVL(cnm, 'brown') cnm, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM cycle c ,product p, customer cs
WHERE c.pid(+) = p.pid 
  AND c.cid(+) = 1
  AND c.cid = cs.cid(+);

15 ==> 45
3�� ==> customer 

SELECT *
FROM product, cycle
WHERE product.pid = cycle.pid;

CROSS JOIN 
���� ������ ������� ���� ���
��� ������ ���� �������� ����� ��ȸ�ȴ�

emp 14 * dept 4 = 56
SELECT *
FROM emp CROSS JOIN dept;           

ORACLE (���� ���̺� ����ϰ� WHERE ���� ������ ������� �ʴ´�)
SELECT *
FROM emp, dept;           

crossjoin1]
SELECT cid, cnm, pid, pnm
FROM customer, product;

��������

WHERE : ������ �����ϴ� �ุ ��ȸ�ϵ��� ����
SELECT *
FROM emp
WHERE 1 = 1
   OR 1 != 1;
   
   1 = 1 OR 1 != 1
   TRUE OR FALSE ==> TRUE
   
SELECT *
FROM emp
WHERE deptno = 10;

���� <==> ����
���������� �ٸ� ���� �ȿ� �ۼ��� ����
�������� ������ ��ġ

1. SELECT
    SCALAR SUB QUERY 
    * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̾�� �Ѵ�
    EX) DUAL���̺�
    
2. FROM
    INLINE-VIEW
    SELECT ������ ��ȣ�� ���� ��
    
3.WHERE
    SUB QUERY
    WHERE ���� ���� ����

SMITH�� ���� �μ��� ���� �������� ���� ������?

1. SMITH�� ���� �μ��� �������??
2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ

==> �������� 2���� ������ ���� ����
    �ι�° ������ ù��°�� ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�
    (SMITH(20) => WARD(30) ==> �ι�° ���� �ۼ��� 10������ 30������ ������ ����
    ==> �������� ���鿡�� ����)

ù��° ����;
SELECT deptno       --20
FROM emp
WHERE ename = 'SMITH';

�ι�° ����
SELECT *
FROM emp
WHERE deptno = 20;

���������� ���� ���� ����
SELECT *
FROM emp
WHERE deptno = (SELECT deptno       --20
                FROM emp
                WHERE ename = 'SMITH');
                
sub1]
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

sub2]
SELECT count(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);



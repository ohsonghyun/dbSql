������

��Ģ ������ : +, -, *, / % : ���� ������
���� ������ : ? 1==1 ? TRUE�϶� ���� : FALSE�� �� ����

SQL ������
= : �÷�|ǥ���� = �� ==> ���� ������

IN ������ : �÷�|ǥ���� IN (����)
    deptno  IN (10, 30) ==> deptno (10,30), IN (10,30)

EXISTS ������
����� : EXISTS (��������)
���������� ��ȸ����� �Ѱ��̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISTS (��������)

���������� ���� ���� ���� ���������� ���� ����� �׻� �����ϱ� ������
emp ���̺��� ��� �����Ͱ� ��ȸ �ȴ�

�Ʒ� ������ ���ȣ ��������
�Ϲ������� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���

EXISTS �������� ����
�����ϴ� ���� �ϳ��� �߰��� �ϸ� ���̻� Ž���� ���� �ʰ� �ߴ�
���� ���� ���ο� ������ ���� �� ���

SELECT *
FROM emp
WHERE EXISTS (SELECT 'X'
              FROM dept);

�Ŵ����� ���� ���� : KING
�Ŵ����� ������ �����ϴ� ���� : 14-KING = 13���� ����
EXISTS �����ڸ� Ȱ���Ͽ� ��ȸ

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);

IS NOT NULL�� ���ؼ� ������ ����� ����� �� �� �ִ�
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

join�� ���ؼ� ������ ����� ����� �� �� �ִ�
SELECT *
FROM emp e, emp m
WHERE e.mgr = m.empno;

-------------------------------------------------------
sub9]
SELECT *
FROM product p
WHERE EXISTS (SELECT 'X'
              FROM cycle c
              WHERE cid = 1
                AND c.pid = p.pid);

1�� �� �Դ� ��ǰ����
SELECT *
FROM product;

SELECT *
FROM cycle 
WHERE cid = 1;

sub10]
SELECT *
FROM product p
WHERE NOT EXISTS (SELECT 'X'
                  FROM cycle c
                  WHERE cid = 1
                  AND c.pid = p.pid);

���տ���
������
{1, 5, 3} U {2, 3} = {1, 2, 3, 5}

SQL���� �����ϴ� UNION ALL (�ߺ� �����͸� ���� ���� �ʴ´�)
{1, 5, 3} U {2, 3} = {1, 2, 3, 3, 5}

������
{1, 5, 3} ������ {2, 3} = {3}

������
{1, 5, 3} - {2, 3} = {1, 5}

SQL���� ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL�� �������� ���� Ȯ�� (��, �Ʒ��� ���� �ȴ�)

UNION ������ : �ߺ�����(������ ������ ���հ� ����);

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--------------------------------------

UNION ALL ������ : �ߺ����

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--------------------------------------

INTERSECT ������ : �� ���հ� �ߺ��Ǵ� ��Ҹ� ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--------------------------------------

MINUS ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

SQL ���տ������� Ư¡

���� �̸� : ù��° SQL�� �÷��� ���󰣴�

ù��° ������ �÷����� ��Ī �ο�
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7698);

2. ������ �ϰ� ���� ��� �������� ���� ����
   ���� SQL���� ORDER BY �Ұ� (�ζ��� �並 ����Ͽ� ������������ ORDER BY �� ������� ������ ����)
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)
--ORDER BY nm, �߰� ������ ���� �Ұ�
UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7698)
ORDER BY nm;

3. SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�(������ ���� ����� ����), �� UNION ALL�� �ߺ� ���

4. �ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �����ϴ� �۾��� �ʿ�
    ==> ����ڿ��� ����� �����ִ� �������� ������
        ==> UNION ALL�� ���� �� �ִ� ��Ȳ�� ��� UNION �� ������� �ʾƾ� �ӵ����� ���鿡�� �����ϴ�

�˰���(����-��������, ��������...
           �ڷ� ���� : Ʈ������(���� Ʈ��, �뷱�� Ʈ��)
                      heap
                      stack, queue
                      list
  ���տ��꿡�� �߿��� ���� : �ߺ�����
  ���� ����
  for(int i =  0;...){
    for(int j = 0;...){
        code.....
    }
  }

���ù�������

SELECT *
FROM FASTFOOD;

SELECT gb, COUNT(gb)
FROM fastfood 
GROUP BY gb;

SELECT s.sigungu, s.gb, COUNT(s.gb) num
FROM (SELECT *
      FROM fastfood a, (SELECT sido
                        FROM fastfood
                        GROUP BY sido) b
      WHERE a.sido = b.sido) s, 
      (SELECT gb, COUNT(gb)
       FROM fastfood 
       GROUP BY gb) f
WHERE s.gb = f.gb
GROUP BY s.sigungu, s.gb;

SELECT
FROM (SELECT s.sigungu, s.gb, COUNT(s.gb) num
      FROM fastfood s, (SELECT gb, COUNT(gb)
                        FROM fastfood 
                        GROUP BY gb) f
      WHERE s.gb = f.gb
        AND 
      GROUP BY s.sigungu, s.gb) a

SELECT sido
FROM fastfood
GROUP BY sido

SELECT a.sigungu
FROM fastfood a, (SELECT sido
                  FROM fastfood
                  GROUP BY sido) b
WHERE a.sido = b.sido
GROUP BY a.sigungu



SELECT *
FROM fastfood;

�õ�, �ñ���, ����ŷ �Ǽ�, kfc �Ǽ�, �Ƶ����� �Ǽ�, �Ե����� �Ǽ�

�õ�, �ñ���, ����ŷ �Ǽ�
�õ�, �ñ���, kfc �Ǽ�
�õ�, �ñ���, �Ƶ����� �Ǽ�
�õ�, �ñ���, �Ե����� �Ǽ�

���� SQL ���� : WHERE, �׷쿬���� ���� GROUP BY, ������ �Լ�(COUNT)
                �ζ��� ��, ROWNUM, ORDER BY, ��Ī(�÷�, ���̺�), ROUND, JOIN

SELECT sido, sigungu, COUNT(*) num FROM fastfood WHERE gb = '����ŷ' GROUP BY sido, sigungu;

SELECT ROWNUM rn, sido, sigungu, city_idx
FROM
    (SELECT bu.sido, bu.sigungu, bu.num, k.num, mac.num, lo.num, 
           ROUND((bu.num + k.num + mac.num)/lo.num, 2) city_idx
    FROM (SELECT sido, sigungu, COUNT(*) num FROM fastfood WHERE gb = '����ŷ' GROUP BY sido, sigungu) bu,
         (SELECT sido, sigungu, COUNT(*) num FROM fastfood WHERE gb = 'KFC' GROUP BY sido, sigungu) k,
         (SELECT sido, sigungu, COUNT(*) num FROM fastfood WHERE gb = '�Ƶ�����' GROUP BY sido, sigungu) mac,
         (SELECT sido, sigungu, COUNT(*) num FROM fastfood WHERE gb = '�Ե�����' GROUP BY sido, sigungu) lo
    WHERE bu.sido = k.sido AND bu.sigungu = k.sigungu
      AND bu.sido = mac.sido AND bu.sigungu = mac.sigungu
      AND bu.sido = lo.sido AND bu.sigungu = lo.sigungu
    ORDER BY city_idx DESC) a;

SELECT ROWNUM rn, sido, sigungu, city_idx
FROM
(SELECT ROWNUM, bk.sido, bk.sigungu, bk.cnt, kfc.cnt, mac.cnt, lot.cnt,
                ROUND((bk.cnt + kfc.cnt + mac.cnt) / lot.cnt, 2) city_idx
FROM
(SELECT SIDO, SIGUNGU, count(*) cnt
FROM fastfood
WHERE gb = '����ŷ'
GROUP BY sido, sigungu) bk,

(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = 'KFC'
 GROUP BY sido, sigungu)kfc,
                       
(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = '�Ƶ�����'
 GROUP BY sido, sigungu) mac,
                                                 
(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = '�Ե�����'
 GROUP BY sido, sigungu) lot
 
 WHERE bk.sido = kfc.sido
 AND bk.sigungu = kfc.sigungu
 AND bk.sido = mac.sido
 AND bk.sigungu = mac.sigungu
 AND bk.sido = lot.sido
 AND bk.sigungu = lot.sigungu
 ORDER BY city_idx DESC)a;

SELECT *
FROM tax;

�ʼ�

����1] fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL �ۼ�
  1. ���ù��������� ���ϰ� (������ ���� ���ð� ������ ����)
  2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
  3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�
  
����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������, ����û �õ�, ����û �ñ���, ����û �������� �ݾ� 1�δ� �Ű��

����2]
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ��� �Ͽ��µ� (fastfood ���̺� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ���� (fastfood ���̺� 1���� ���)
CASE, DECODE

����3]
�ܹ��� ���� SQL �� �ٸ� ���·� �����ϱ�
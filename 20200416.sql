SELECT *        --��� �÷������� ��ȸ
FROM prod;      -- �����͸� ��ȸ�� ���̺� ���
���̺��� ��� �÷�(��)���� �̷���� �ִ�

Ư�� �÷��� ���ؼ��� ��ȸ : SElECT �÷�1, �÷�2...
prod_id, prod_name �÷��� prod ���̺��� ��ȸ;

SELECT prod_id, prod_name
FROM prod;

select1]
SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

SQL����: JAVA�� �ٸ��� ����X, �Ϲ��� ��Ģ���� 
int b = 2;  = ���� ������, == �� ������;

SQL ������ Ÿ��: ����, ����, ��¥{date}

USERS ���̺��� (4/14 ����� ����) ���� //spl���� ������ �ͼ� �������ָ� ���̺� ������
USERS ���̺��� ��� �����͸� ��ȸ;

��¥ Ÿ�Կ� ���� ����: ��¥�� +, - ���� ����
date type + ���� : date���� ������¥��ŭ �̷� ��¥�� �̵�
date type - ���� : date���� ������¥��ŭ ���� ��¥�� �̵�

SELECT userid, reg_dt, reg_dt + 5, reg_dt -  5(reg_dt + 5 after_5days)
FROM users;

�÷� ��Ī: ���� �÷����� �����ϰ� ���� ��
syntax: ���� �÷��� [as]��Ī ��Ī
��Ī ��Ī�� ������ ǥ���Ǿ�� �� ��� ���� �����̼����� ���´�.
���� ����Ŭ������ ��ü���� �빮�� ó�� �ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ���
���� �����̼��� ����Ѵ�.

SELECT userid as id, user id2, userid "  �� �� ��"
FROM users;

SELECT prod_id id,  prod_name name
FROM prod;

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

SELECT buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer

���ڿ� ����(���տ���) : ||   (���ڿ� ������ + �����ڰ� �ƴϴ�)
String str = "test"
str = str + ", world"   // str : hello, world
-- SELECT userid + 'test', reg_dt + 5 ���ڿ� ������ ||�� ����ؾ� �Ѵ�.
--����ڰ� ���Ƿ� ���� ������ �� ����
SELECT userid || 'test', reg_dt + 5, 'test', 15 
FROM users;

SELECT '�� ' ||  userid || ' ��' 
FROM users;

SELECT userid || usernm
FROM users;

--userid || usernm id_name -> userid�� usernm�� ���ս�Ű�� �� ���� �̸��� id_name ���� �����ض� & AS�� �Ƚᵵ �ȴ�.
SELECT userid, usernm,  userid || usernm id_name 
FROM users;

SELECT userid || usernm AS id_name,
        CONCAT(userid, usernm) AS concat_id_name
FROM users;

sel_con1]
user_tables: oracle �����ϴ� ���̺� ������ ��� �ִ� ���̺�(�̶�� ������ �������� ����� view��� �Ѵ� ==> data dicrionary)
SELECT *
FROM user_tables;

���ڿ� ���� ���ڿ� ���� ���ڿ�
1      +     3    +    5
SELECT 'SELECT * FROM ' ||table_name || ';' AS QUERY
FROM user_tables;

���̺��� ���� �÷��� Ȯ��
1. tool(sql developer)�� ���� Ȯ��
    ���̺� - Ȯ���ϰ��� �ϴ� ���̺�
2.  SELECT *
    FROM ���̺�
    �ϴ� ��ü ��ȸ --> ��� �÷��� ǥ��
3. DESC ���̺��
4. data dictionary: user_table_columns

DESC emp;

SELECT *
FROM user_tab_columns;
    
���ݱ��� ��� SELECT ����
��ȸ�ϰ��� �ϴ� �÷� ���: SELECT
��ȸ�� ���̺� ���: FROM
��ȸ�� ���� �����ϴ� ������ ���: WHERE
WHERE ���� ����� ������ ��(TRUE)�� �� ����� ��ȸ

java�� �� ����: a������ b������ ���� ������ �� ==
sql�� �� ���� : =
int a = 5;
int b = 2;
a�� b�� ���� ���� ���� Ư������ ����
if(a == b){
}

SELECT *
FROM users
WHERE userid = 'cony';

SELECT *
FROM users
WHERE userid =userid;

emp���̺��� �÷��� ������ Ÿ���� Ȯ��;
DESC emp;

SELECT *
FROM emp;
emp: employee(���� ���̺�)
empo: �����ȣ
ename: ��� �̸�
job: ������(��å)
mgr: �����(������)
hiredate: �Ի�����
sal: �޿�
comm: ������
deptno: �μ���ȣ

SELECT 

SELECT *
FROM dept;

emp ���̺��� ������ ���� �μ���ȣ�� 30�� ���� ū(>) �μ��� ���� �������� ��ȸ;
SELECT *
FROM emp
WHERE deptno >= 30;

!= �ٸ� ��
users ���̺��� ����� ���̵�(userid)�� brown�� �ƴ� ����ڸ� ��ȸ
SELECT *
FROM users
WHERE userid != 'brown';

SQL ���ͷ�
����: 20 , 30 ...
����: ��Ŭ �����̼�: 'hello world'
��¥: TO_DATE('��¥���ڿ�','��¥ ���ڿ��� ����')

1980�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ
������ �Ի�����: hiredate �÷�
emp���̺��� ���� : 14��
1982�� 01�� 01�� ���� �Ի��ڰ� : 3��
1982�� 01�� 01�� ���� �Ի��ڰ� : 11��

SELECT ename , hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'yyyy/mm/dd');
        hiredate >= TO_DATE('19820101', 'yyyymmdd');
        hiredate >= TO_DATE('1982.01.01', 'yyyy.mm.dd');

--('19820101','yyyymmdd' / '1982.01.01', 'yyyy.mm.dd')�� ���� ���ĸ� �� ���߸� ��










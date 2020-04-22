7. 결과에만 만족하지 말고 실행계획(Execution plan)에 관심을 가지고 절차형 로직(If Then Else)을 버리고 집합적 하나의 SQL로 임무를 완수토록 하라


주어진것: 년월을 담고 있는 문자열 ==>'201912' ==> 31

문자열     =>      날짜      ==>     마지막 날짜로 변경      ==>     일자

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

실행계획을 보는 순서(id)
* 들여쓰기가 되어있으면 자식 오퍼레이션
1. 위에서 아래로
    *단 자식 오퍼레이션이 있으면 자식 부터 읽는다

    1 ==> 0
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 ==> 14행을 다 읽고 7367을 빼뒀다(?)

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

   1 - filter("EMPNO"=7369) ==> 문자열로 넣었는데 숫자가 되서 둘이 더해졌다(묵시적 형변환)

0009000
0010000


SELECT ename, sal, TO_CHAR(sal, 'L009,999.00')
FROM emp;


NULL과 관련된 함수
NVL
NVL2
NULLIF
COALESCE;

왜 null 처리를 해야할까?
NULL에 대한 연산결과는 NULL이다

예를들어서 emp 테이블에 존재하는 sal, comm 두개의 값을 합한 값을 알고 싶어서
다음과 같이 SQL을 작성

SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1이 null이면 expr2값을 리턴하고
expr1이 null이 아니면 expr1을 리턴

SELECT empno, ename, sal, comm, sal + NVL(comm, 0) AS sal_plus_comm
FROM emp;
==>sal + NVL(comm, 0) 둘이 더한 값이 NULL값이면 

REG_DT 컬럼이 NULL일 경우 현재 날짜가 속한 월의 마지막 일자로 표현
SELECT userid, usernm, reg_dt, NVL(reg_dt, LAST_DAY(SYSDATE))
FROM users;

REG_DT 컬럼이 NULL일 경우 현재 날짜가 속한 월의 마지막 일자로 표현
SELECT userid, usernm, reg_dt, NVL(TO_CHAR(reg_dt, 'yyyymmdd'), TO_CHAR((LAST_DAY(SYSDATE)), 'DD'))
FROM users;








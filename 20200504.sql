연산자

사칙 연산자 : +, -, *, / % : 이항 연산자
삼항 연산자 : ? 1==1 ? TRUE일때 실행 : FALSE일 때 실행

SQL 연산자
= : 컬럼|표현식 = 값 ==> 이항 연산자

IN 연산자 : 컬럼|표현식 IN (집합)
    deptno  IN (10, 30) ==> deptno (10,30), IN (10,30)

EXISTS 연산자
사용방법 : EXISTS (서브쿼리)
서브쿼리의 조회결과가 한거이라도 있으면 TRUE
잘못된 사용방법 : WHERE deptno EXISTS (서브쿼리)

메인쿼리의 값과 관계 없이 서브쿼리의 실행 결과는 항상 존재하기 때문에
emp 테이블의 모든 데이터가 조회 된다

아래 쿼리는 비상호 서브쿼리
일반적으로 EXISTS 연산자는 상호연관 서브쿼리로 많이 사용

EXISTS 연산자의 장점
만족하는 행을 하나라도 발견을 하면 더이상 탐색을 하지 않고 중단
행의 존재 여부에 관심이 있을 때 사용

SELECT *
FROM emp
WHERE EXISTS (SELECT 'X'
              FROM dept);

매니저가 없는 직원 : KING
매니저가 정보가 존재하는 직원 : 14-KING = 13명의 직원
EXISTS 연산자를 활용하여 조회

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);

IS NOT NULL을 통해서 동일한 결과를 만들어 낼 수 있다
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

join을 통해서 동일한 결과를 만들어 낼 수 있다
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

1번 고객 먹는 제품정보
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

집합연산
합집합
{1, 5, 3} U {2, 3} = {1, 2, 3, 5}

SQL에만 존재하는 UNION ALL (중복 데이터를 제거 하지 않는다)
{1, 5, 3} U {2, 3} = {1, 2, 3, 3, 5}

교집합
{1, 5, 3} 교집합 {2, 3} = {3}

차집합
{1, 5, 3} - {2, 3} = {1, 5}

SQL에의 집합연산
연산자 : UNION, UNION ALL, INTERSECT, MINUS
두개의 SQL의 실행결과를 행을 확장 (위, 아래로 결합 된다)

UNION 연산자 : 중복제거(수학적 개념의 집합과 동일);

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--------------------------------------

UNION ALL 연산자 : 중복허용

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--------------------------------------

INTERSECT 교집합 : 두 집합간 중복되는 요소만 조회

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--------------------------------------

MINUS 연산자 : 위쪽 집합에서 아래쪽 집합 요소를 제거
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

SQL 집합연산자의 특징

열의 이름 : 첫번째 SQL의 컬럼을 따라간다

첫번째 쿼리의 컬럼영에 별칭 부여
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7698);

2. 정렬을 하고 싶을 경우 마지막에 적용 가능
   개별 SQL에는 ORDER BY 불가 (인라인 뷰를 사용하여 메인쿼리에소 ORDER BY 가 기술되지 않으면 가능)
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)
--ORDER BY nm, 중간 쿼리에 정렬 불가
UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7698)
ORDER BY nm;

3. SQL의 집합 연산자는 중복을 제거한다(수학적 집합 개념과 동일), 단 UNION ALL은 중복 허용

4. 두개의 집합에서 중복을 제거하기 위해 각각의 집합을 정렬하는 작업이 필요
    ==> 사용자에게 결과를 보내주는 반응성이 느려짐
        ==> UNION ALL을 상툥할 수 있는 상황일 경우 UNION 을 사용하지 않아야 속도적인 측면에서 유리하다

알고리즘(정렬-버블정렬, 삽입정렬...
           자료 구조 : 트리구조(이진 트리, 밸런스 트리)
                      heap
                      stack, queue
                      list
  집합연산에서 중요한 사항 : 중복제거
  버블 정렬
  for(int i =  0;...){
    for(int j = 0;...){
        code.....
    }
  }

도시발전지수

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

시도, 시군구, 버거킹 건수, kfc 건수, 맥도날드 건수, 롯데리아 건수

시도, 시군구, 버거킹 건수
시도, 시군구, kfc 건수
시도, 시군구, 맥도날드 건수
시도, 시군구, 롯데리아 건수

사용된 SQL 문법 : WHERE, 그룹연산을 위한 GROUP BY, 복수행 함수(COUNT)
                인라인 뷰, ROWNUM, ORDER BY, 별칭(컬럼, 테이블), ROUND, JOIN

SELECT sido, sigungu, COUNT(*) num FROM fastfood WHERE gb = '버거킹' GROUP BY sido, sigungu;

SELECT ROWNUM rn, sido, sigungu, city_idx
FROM
    (SELECT bu.sido, bu.sigungu, bu.num, k.num, mac.num, lo.num, 
           ROUND((bu.num + k.num + mac.num)/lo.num, 2) city_idx
    FROM (SELECT sido, sigungu, COUNT(*) num FROM fastfood WHERE gb = '버거킹' GROUP BY sido, sigungu) bu,
         (SELECT sido, sigungu, COUNT(*) num FROM fastfood WHERE gb = 'KFC' GROUP BY sido, sigungu) k,
         (SELECT sido, sigungu, COUNT(*) num FROM fastfood WHERE gb = '맥도날드' GROUP BY sido, sigungu) mac,
         (SELECT sido, sigungu, COUNT(*) num FROM fastfood WHERE gb = '롯데리아' GROUP BY sido, sigungu) lo
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
WHERE gb = '버거킹'
GROUP BY sido, sigungu) bk,

(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = 'KFC'
 GROUP BY sido, sigungu)kfc,
                       
(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = '맥도날드'
 GROUP BY sido, sigungu) mac,
                                                 
(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = '롯데리아'
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

필수

과제1] fastfood 테이블과 tax 테이블을 이용하여 다음과 같이 조회되도록 SQL 작성
  1. 도시발전지수를 구하고 (지수가 높은 도시가 순위가 높다)
  2. 인당 연말 신고액이 높은 시도 시군구별로 순위를 구하여
  3. 도시발전지수와 인당 신고액 순위가 같은 데이터 끼리 존인하여 아래와 같이 컬럼이 조회되도록 SQL 작성
  
순위, 햄버거 시도, 햄버거 시군구, 햄버거 도시발전지수, 국세청 시도, 국세청 시군구, 국세청 연말정산 금액 1인당 신고액



과제2]
햄버거 도시발전 지수를 구하기 위해 4개의 인라인 뷰를 사용 하였는데 (fastfood 테이블 4번 사용)
이를 개선하여 테이블을 한번만 읽는 형태로 쿼리를 개선 (fastfood 테이블 1번만 사용)
CASE, DECODE

과제3]
햄버거 지수 SQL 을 다른 형태로 도전하기
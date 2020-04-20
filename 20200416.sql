SELECT *        --모든 컬럼정보를 조회
FROM prod;      -- 데이터를 조회할 테이블 기술
테이블은 행과 컬럼(열)으로 이루어져 있다

특정 컬럼에 대해서만 조회 : SElECT 컬럼1, 컬럼2...
prod_id, prod_name 컬럼만 prod 테이블에서 조회;

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

SQL연산: JAVA와 다르게 대입X, 일반적 사칙연산 
int b = 2;  = 대입 연산자, == 비교 연산자;

SQL 데이터 타입: 문자, 숫자, 날짜{date}

USERS 테이블이 (4/14 만들어 놓음) 존재 //spl문장 복사해 와서 실행해주면 테이블 생성됨
USERS 테이블이 모든 데이터를 조회;

날짜 타입에 대한 연산: 날짜는 +, - 연산 가능
date type + 정수 : date에서 정수날짜만큼 미래 날짜로 이동
date type - 정수 : date에서 정수날짜만큼 과거 날짜로 이동

SELECT userid, reg_dt, reg_dt + 5, reg_dt -  5(reg_dt + 5 after_5days)
FROM users;

컬럼 별칭: 기존 컬럼명을 변경하고 싶을 때
syntax: 기존 컬럼명 [as]별칭 명칭
별칭 명칭에 공백이 표현되어야 할 경우 더블 퀘테이션으로 묶는다.
또한 오라클에서는 객체명을 대문자 처리 하기 때문에 소문자로 별칭을 저장하기 위해서도
더블 퀘데이션을 사용한다.

SELECT userid as id, user id2, userid "  아 이 디"
FROM users;

SELECT prod_id id,  prod_name name
FROM prod;

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer

문자열 연산(결합연산) : ||   (문자열 결합은 + 연산자가 아니다)
String str = "test"
str = str + ", world"   // str : hello, world
-- SELECT userid + 'test', reg_dt + 5 문자열 결합은 ||를 사용해야 한다.
--사용자가 임의로 열을 생성할 수 있음
SELECT userid || 'test', reg_dt + 5, 'test', 15 
FROM users;

SELECT '경 ' ||  userid || ' 축' 
FROM users;

SELECT userid || usernm
FROM users;

--userid || usernm id_name -> userid랑 usernm을 결합시키고 그 열의 이름은 id_name 으로 지정해라 & AS는 안써도 된다.
SELECT userid, usernm,  userid || usernm id_name 
FROM users;

SELECT userid || usernm AS id_name,
        CONCAT(userid, usernm) AS concat_id_name
FROM users;

sel_con1]
user_tables: oracle 관리하는 테이블 정보를 담고 있는 테이블(이라고 지금은 말하지만 사실은 view라고 한다 ==> data dicrionary)
SELECT *
FROM user_tables;

문자열 결합 문자열 결합 문자열
1      +     3    +    5
SELECT 'SELECT * FROM ' ||table_name || ';' AS QUERY
FROM user_tables;

테이블의 구성 컬럼을 확인
1. tool(sql developer)을 통해 확인
    테이블 - 확인하고자 하는 테이블
2.  SELECT *
    FROM 테이블
    일단 전체 조회 --> 모든 컬럼이 표시
3. DESC 테이블명
4. data dictionary: user_table_columns

DESC emp;

SELECT *
FROM user_tab_columns;
    
지금까지 배운 SELECT 구문
조회하고자 하는 컬럼 기술: SELECT
조회할 테이블 기술: FROM
조회할 행을 제한하는 조건을 기술: WHERE
WHERE 절에 기술한 조건이 참(TRUE)일 때 결과를 조회

java의 비교 연산: a변수와 b변수의 값이 같은지 비교 ==
sql의 비교 연산 : =
int a = 5;
int b = 2;
a랑 b의 값이 같을 때만 특정로직 실행
if(a == b){
}

SELECT *
FROM users
WHERE userid = 'cony';

SELECT *
FROM users
WHERE userid =userid;

emp테이블에서 컬럼과 데이터 타입을 확인;
DESC emp;

SELECT *
FROM emp;
emp: employee(직원 테이블)
empo: 사원번호
ename: 사원 이름
job: 담당업무(직책)
mgr: 담당자(관리자)
hiredate: 입사일자
sal: 급여
comm: 성과급
deptno: 부서번호

SELECT 

SELECT *
FROM dept;

emp 테이블에서 직원이 속한 부서번호가 30번 보다 큰(>) 부서에 속한 직원으로 조회;
SELECT *
FROM emp
WHERE deptno >= 30;

!= 다를 때
users 테이블에서 사용자 아이디(userid)가 brown이 아닌 사용자를 조회
SELECT *
FROM users
WHERE userid != 'brown';

SQL 리터럴
숫자: 20 , 30 ...
문자: 싱클 퀘테이션: 'hello world'
날짜: TO_DATE('날짜문자열','날짜 문자열의 형식')

1980년 1월 1일 이후에 입사한 직원만 조회
직원의 입사일자: hiredate 컬럼
emp테이블의 직원 : 14명
1982년 01월 01일 이후 입사자가 : 3명
1982년 01월 01일 이전 입사자가 : 11명

SELECT ename , hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'yyyy/mm/dd');
        hiredate >= TO_DATE('19820101', 'yyyymmdd');
        hiredate >= TO_DATE('1982.01.01', 'yyyy.mm.dd');

--('19820101','yyyymmdd' / '1982.01.01', 'yyyy.mm.dd')도 가능 형식만 잘 맞추면 됨










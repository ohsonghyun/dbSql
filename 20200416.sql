SELECT *        --모든 컬럼정보를 조회
FROM prod;      -- 데이터를 조회할 테이블 기술

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

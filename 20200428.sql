join2]
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod JOIN buyer ON (prod.prod_buyer = buyer.buyer_id);

join2_1] 결과 건수를 구하는 SQL
SELECT COUNT(*)
FROM
    (SELECT buyer_id, buyer_name, prod_id, prod_name
     FROM prod JOIN buyer ON(prod.prod_buyer = buyer.buyer_id));
    
SELECT COUNT (*)
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

BUYER_NAME 별 건수 조회 쿼리 작설
BUYER_NAME, 건수

SELECT buyer_name, COUNT(*)
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id
GROUP BY buyer.buyer_name;

join3]
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member
  And prod.prod_id = cart.cart_prod;
--조건을 기술하지 않을 경우 가능한 모든 경우의 수가 나온다

테이블 JOIN 테이블 ON/USING

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON (member.mem_id = cart.cart_member) 
            JOIN prod ON (prod.prod_id = cart.cart_prod);

참고사항
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;
  
SELECT *
FROM
    (SELECT deptno, COUNT(*)
     FROM emp
     GROUP BY deptno)
WHERE deptno = 30;
  
SELECT deptno, COUNT(*)
FROM emp
WHERE deptno = 30
GROUP BY deptno;
  
cid : customer id
cnm : customer name
SELECT *
FROM customer;

pid : product id
pnm : product name
SELECT *
FROM product;

cycle : 애음주기
cid : 고객 id
prid : 제품 id
day : 애음요일 (일요일-1, 월요일-2, 화요일-3...)
cnt(count) : 수량
SELECT *
FROM cycle;

join4]
SELECT customer.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
  AND (customer.cnm = 'brown' OR customer.cnm = 'sally');

--SELECT customer.cid, cnm, pid, day, cnt
--FROM customer, cycle
--WHERE customer.cid = cycle.cid
--  AND cnm IN ('brown','sally');

--SELECT cid, cnm, pid, day, cnt
--FROM customer NATURAL cycle
--WHERE customer.cnm IN ('brown','sally');

join5]
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND product.pid = cycle.pid
  AND (customer.cnm = 'brown'
   OR customer.cnm = 'sally');
   
--SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
--FROM customer, cycle, product
--WHERE customer.cid = cycle.cid
--  AND product.pid = cycle.pid
--  AND cnm IN ('brown','sally');

join6]
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, SUM(cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND product.pid = cycle.pid
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm, cnt;

--SELECT customer.cid, cnm, cycle.pid, pnm, SUM(cnt)
--FROM customer, cycle, product
--WHERE customer.cid = cycle.cid
--  AND product.pid = cycle.pid
--GROUP BY customer.cid, cnm, cycle.pid, pnm;
 ==> count 함수는 행의 갯수를 나타낸다

join7]
SELECT cycle.pid, pnm, SUM(cnt)
FROM cycle, product
WHERE product.pid = cycle.pid
GROUP BY cycle.pid, pnm;

SELECT a.pid, b.pnm, a.cnt
FROM
    (SELECT pid, pnm, SUM(cnt) cnt
     FROM cycle
     GROUP BY cycle.pid) a, product b
WHERE a.pid = b.pid;

join8]
SELECT c.region_id, region_name, country_name
FROM countries c, regions r
WHERE c.region_id = r.region_id
  AND region_name = 'Europe';
  
join9]
SELECT c.region_id, region_name, country_name, city
FROM countries c, regions r, locations l
WHERE c.region_id = r.region_id
  AND c.country_id = l.country_id
  AND region_name = 'Europe'; 

join10]
SELECT c.region_id, region_name, country_name, city, department_name
FROM countries c, regions r, locations l, departments d
WHERE c.region_id = r.region_id
  AND c.country_id = l.country_id
  AND l.location_id = d.location_id
  AND region_name = 'Europe'; 

join11]
SELECT c.region_id, region_name, country_name, city, department_name, e.first_name || e.last_name as name
FROM countries c, regions r, locations l, departments d, employees e
WHERE c.region_id = r.region_id
  AND c.country_id = l.country_id
  AND l.location_id = d.location_id
  AND d.department_id = e.department_id
  AND region_name = 'Europe'; 

join12]
SELECT employee_id, e.first_name || e.last_name as name, j.job_id, job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id;

join13] ==> 못함
SELECT manager_id as mgr_id, employee_id, e.first_name || e.last_name as name, j.job_id, job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id;

SELECT e. manager_id as mgr_id, m.first_name || m.last_name as mgr_name,
       e.employee_id, e.first_name || e.last_name as name,
       j.job_id, j.job_title
FROM employees e, jobs j, employees m
WHERE e.job_id = j.job_id
  AND e.manager_id = m.employee_id;

SELECT *
FROM jobs;

SELECT *
FROM employees
WHERE job_id = null;

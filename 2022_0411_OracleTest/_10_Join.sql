/*

2개 이상의 테이블을 연결하여 데이터를 검색하는 방법이다

보통 둘 이상의 행들이 공통된 값 PRIMARY KEY 및 FOREIGN KEY 값을 사용하여 조인한다.

두 개의 테이블을 SELECT 문장 안에서 조인하려면 적어도 하나의 컬럼이 두 테이블 사이에서 공유되어야한다.

종류 - 
	1. A Inner join B : 행과 행이 1:1로 연결
	2. Outer join 
	: A Left outer join B: A테이블 행은 모두 추출, B테이블의 행 조건에 만족하는 행만 추출
	: A Right outer join B: B 테이블행은 모두 추출, A테이블의 행 조건에 만족하는 행만 추출
	: A Full outer join B: 조건에 맞는 행을 결합 + 조건에 맞지 않더라도 A,B나머지 행 모두 추출
	3. A Cross join B: A행 갯수 * B행 갯수 
	4. Self join: 테이블과 연결하는 대상이 자신인 것
	
*/

-- 1. inner join (equi join):
select sabun, saname, dname, loc from dept, sawon
where dept.deptno = sawon.deptno

-- ANSI-92 SQL (표준 SQL): 현존하는 모든 DBMS에서 공통적으로 사용되는 명령
select * from dept inner join sawon

select * from dept d inner join sawon s on d.deptno = s.deptno
--					 (조인방식) 		    on (조인조건)

-- 2. cross join: 조인 조건없이 연결:
select * from dept,sawon
-- ANSI-92
select * from dept cross join sawon



-- 3. self join + inner join
select 
	s1.sabun, s1.sajob, s1.saname, 
	s2.sabun, s2.sajob, s2.saname 
from sawon s1, sawon s2
where s1.samgr = s2.sabun(+) -- (+) 하면 null값이 있어도 테이블이 나온다.
order by s1.sabun

-- cf) MS-SQL server
where s1.samgr * = s2.sabun

-- ANSI-92
SELECT
S1.SABUN, S1.SAJOB, S1.SANAME,
S2.SABUN, S2.SAJOB, S2.SANAME
FROM SAWON S1 LEFT OUTER JOIN SAWON S2 ON S1.SAMGR = S2.SABUN
ORDER BY S1.SABUN

-- FULL OUTER JOIN (ANSI-92)
SELECT
* 
FROM DEPT D FULL OUTER JOIN SAWON S ON D.DEPTNO = S.DEPTNO

-- sawon + gogek

select * from sawon s inner join gogek g on s.sabun = g.godam
where gobun is null
order by s.sabun

-- 사번 사원명 부서번호 부서명 고객번호 고객명
SELECT 
D.DEPTNO, DNAME,
S.SABUN, SANAME,
G.GOBUN, GONAME
FROM SAWON S LEFT OUTER JOIN DEPT D ON D.DEPTNO = S.SABUN -- 부서와 사번을 먼저 이어줌
			LEFT OUTER JOIN GOGEK G ON S.SABUN = G.GODAM -- 그다음 부서가연결된 사번을 고객담당자와 이어줌
ORDER BY SABUN

-- 사번 사원명 / 부서번호 부서명 / 고객번호 고객명 / 상사번호 상사명 / 상사고객번호 상사고객명

SELECT
S1.SABUN 사번, S1.SANAME 사원명,
D.DEPTNO 부서번호, D.DNAME 부서명,
G1.GOBUN 고객번호, G1.GONAME 고객명,
S2.SABUN 상사번호, S2.SANAME 상사명,
G2.GOBUN 상사고객번호, G2.GONAME 상사고객명
FROM SAWON S1 INNER JOIN DEPT D ON S1.DEPTNO = D.DEPTNO
			  LEFT OUTER JOIN GOGEK G1 ON S1.SABUN = G1.GODAM
			  LEFT OUTER JOIN SAWON S2 ON S1.SAMGR = S2.SABUN
			  LEFT OUTER JOIN GOGEK G2 ON S2.SABUN = G2.GODAM
ORDER BY S1.SABUN














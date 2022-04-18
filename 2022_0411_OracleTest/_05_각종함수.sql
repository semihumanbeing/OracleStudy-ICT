-- 문자열 함수

-- concat 예제
select concat('www.','oracleclub')||'.com' name from dual;

-- Lpad Rpad : 출력할 문자 자리수보다 전체 자리수가 클때 빈공간을 무엇으로 채울지 정하는 함수
select LPad('oracleclub', 12, '*') name from dual
union all
select Rpad('oracleclub', 12, '*') name from dual

-- substr : 특정 문자열 반환 (자바와는 다르게 배열이 1부터 시작한다)
select substr('oracleclub', 3) name from dual;
-- n번째 이후 m개의 문자열 반환
select substr('oracleclub', 3, 4) name from dual
-- 뒤에서 n번째 이후 m개의 문자열 반환
select substr('oracleclub', -3, 2) name from dual

-- 문자열의 length 를 조회하는 함수
select length('oracleclub') len from dual

-- 문자열을 replace 하는 함수(대소문자를 구별한다)
select replace('oracleclub', 'oracle', 'sql') name from dual

-- union : 동일한 레코드는 1번만 추출
-- union all : 모두 추출
select * from dept
union all
select * from dept where deptno<30

-- 군복무: 18개월
select '입대일자', sysdate, '제대일자', add_months(sysdate,18) from dual;

-- 내가 살아온 일수 
select months_between(sysdate, to_date('1996-3-12', 'YYYY-MM-DD')) as 살아온월수,
	   sysdate - to_date('1996-3-12', 'YYYY-MM-DD') as 살아온일수
from dual

-- 소수점 1자리수 까지만 구할 때 trunc(숫자,몇자리수까지 지정) 하면 된다.
select 
	   trunc(months_between(sysdate, to_date('1996-3-12', 'YYYY-MM-DD')),1) as 살아온월수,
	   trunc(sysdate - to_date('1996-3-12', 'YYYY-MM-DD'),1) as 살아온일수
from dual

-- 사원테이블에서 각 직원들의 근무년수, 근무월수 구하기
select * from  sawon

select sabun, saname, sahire, sapay,
	floor(months_between(sysdate, sahire)/12) as 근무년수,
	floor(mod(months_between(sysdate,sahire),12)) as 잔여월수,
	floor(months_between(sysdate,sahire)) as 총근무월수,
	floor(sapay/13)||'만원' as 월급,
	-- 퇴직금1 월급 * 근무년수 + 월급 * 잔여월수 / 12
	floor(sapay/13) * floor(months_between(sysdate,sahire)/12) + 
	floor(floor(sapay/13) * floor(mod(months_between(sysdate,sahire),12))/12) ||'만원' as 퇴직금1,
	-- 퇴직금2 월급/12 * 총근무월수
	floor(trunc((sapay/13/12),1) * floor(months_between(sysdate,sahire)))||'만원' as 퇴직금2
from sawon

-- 연봉제 퇴직금 계산법 (연봉에 퇴직금 포함된경우)
-- 포함: 월급 = 연봉/13 
select sabun, saname, sapay,
	floor(months_between(sysdate, sahire)/12) as 근무년수,
	floor(mod(months_between(sysdate,sahire),12)) as 잔여월수,
	floor(months_between(sysdate,sahire)) as 총근무월수,
from sawon

-- 별도: 월급 = 연봉/12

-- 함수식
select * from gogek
where substr(goaddr,1,2) = '서울'

select * from gogek
where substr(gojumin,8,1) in ('0', '2', '4', '6', '8') as test1
where mod(to_number(substr(gojumin,8,1)),2)=0




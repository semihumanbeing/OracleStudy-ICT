/*
연산자
1. 산술연산자: * / + - mod
2. 관계연산자: > >= < <= =
3. 논리연산자: and or not
4. 기타연산자: 필드 between a and b
			필드 in (A,B,C)
5. 문자열결합: ||
6. 문자열 유사검색: 필드 like ''
				% : 모든 문자(길이관계없이)
			    _ : 모든 문자(1문자)
			    
			    ex) 이로 시작하는 문자를 찾고싶으면 필드 like '이%'
			
-- 산술연산자
*/
select saname || '님 새해복 많이 받으세요' 연하장 from sawon

select 5+3, 6-4, 3*5, 10/3, mod(10,3) from dual
select * from test.sawon

select * from GOGEK


select sabun as 사번, saname 사원명,sajob,sapay from sawon

-- 사원테이블에서 10번 부서 직원만 추출
select * from SAWON where deptno = 10

-- 필드명을 as 로 설정할 수 있다.
select
	sabun as 사번,
	saname 사원명,
	sajob as "직 급",
	sapay,
	sapay * 0.1 as bonus
from sawon

-- 사원테이블에서 과장만 추출
select * from SAWON
where sajob = '과장'

-- 사원테이블에서 10번 부서의 과장만 추출
select * from sawon
	where sajob = '과장' and deptno = 10

-- 사원테이블에서 직급이 과장, 대리일때 추출
select * from sawon
	where sajob = '과장' or sajob = '대리'
	
	
-- 연봉 3000 이상 받는 사람
select * from sawon
	where sapay >= 3000
	

-- 연봉 3500 이상 4000이하 받는 사람
select * from sawon
	where sapay >= 3500 and sapay <=4000
	
select * from sawon
where sapay between 3500 and sapay
	
-- samgr 가 null인 직원 추출
-- null 체크하는 연산자
select * from sawon
where samgr is null
-- null이 아닌 것을 체크할때
select * from sawon
where samgr is not null
-- not을 where not samgr is null 로 사용하면 sql을 2번 연산하게 하므로 느려진다.

-- 사원테이블에서 20번 부서의 여자직원만 추출하세요
select * from sawon
where sasex = '여자' and deptno = 20
	
-- 부서장 중에서 연봉이 4000초과인 직원을 추출하세요
select * from sawon
where sajob = '부장' and sapay > 4000

-- 사원테이블에서 성씨 '이씨인 직원추출(문자열 유사검색식: %)
select * from sawon
where saname like '이%'

-- 사원테이블에서 이름의 2번째 글자가 '미' 인 직원 추출
select * from sawon
where saname like '_미'

-- 고객테이블에서 남자만 출력
select * from gogek
where gojumin like '______-1%' or 
	  gojumin like '______-3%' or 
	  gojumin like '______-5%' or 
	  gojumin like '______-7%'

	
-- 사원테이블에서 2000년 이후에 입사한 직원 추출
select * from SAWON
where sahire >= to_date('2000-1-1','YYYY-MM-DD')
	
select to_date('2000-1-1', 'YYYY-MM-DD') FROM dual

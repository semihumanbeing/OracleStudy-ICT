-- subquery 
-- subquery의 실행 결과를 이용해서 mainquery를 수행하는 쿼리문

-- 사원테이블에서 최불암과 동일한 부서 직원들을 추출하기
-- 1. 최불암의 부서정보 구하기
select deptno from sawon where saname = '최불암'
-- 2. 10번 부서 직원 추출
select * from sawon where deptno = 10

select * from sawon 
where deptno in (select deptno from sawon where saname = '최불암')-- 이것이 서브쿼리

-- 사원테이블에서 이미자보다 급여를 많이 받는 직원을 추출하기
select * from sawon
where sapay >= (select sapay from sawon where saname = '이미자')

-- 사원테이블에서 차범근과 동일한 년도에 입사한 직원 추출
select to_char(sahire, 'YYYY') from sawon where saname = '차범근'

where to_char(sahire,'YYYY') = (select to_char(sahire,'YYYY') from sawon where saname = '차범근')

--사원테이블에서 장동건과 동일한 달에 입사한 직원
select to_char(sahire,'MM') from sawon where saname = '장동건'
select * from sawon
where to_char(sahire,'MM') = (select to_char(sahire,'MM') from sawon where saname = '장동건')

-- 사원테이블에서 이미자와 동일한 계절에 입사한 직원 추출
select floor(to_number(to_char(sahire,'MM'))/3) from sawon where saname = '이미자'

select * from sawon
where floor(to_number(to_char(sahire,'MM'))/3) = (select floor(to_number(to_char(sahire,'MM'))/3) from sawon where saname = '이미자')

select avg(sapay) from sawon

select * from sawon
where sapay > (select avg(sapay) from sawon)

-- 사원테이블에서 최초 입사자가 누구인가
select min(sahire) from sawon

select * from sawon
where sahire = (select min(sahire) from sawon)

select * from sawon
where to_char(sahire,'YYYY-MM-DD') = (select min(to_char(sahire,'YYYY-MM-DD')) from sawon)

-- 사원테이블에서 최근 입사자 구하기

select * from sawon
where sahire in (select max(sahire) from sawon)

select * from sawon
where sahire in (select min(sahire) from sawon) or 
	  sahire in (select max(sahire) from sawon)
	  
insert into sawon values(18, '최불암', '남자', 20, '과장', to_date('1984-7-25 13:00:00', 'YYYY-MM-DD HH24:MI:SS'),2, 3800)

select deptno from sawon
	order by deptno

-- 사원테이블에서 최고급여자를 확인하기
select * from sawon
where sapay = (select max(sapay) from sawon)

-- 사원테이블에서 각 부서별 최고급여자 추출하기
select * from sawon
where sapay = (select max(sapay) from sawon where deptno = 10) and deptno = 10
	  or
	  sapay = (select max(sapay) from sawon where deptno = 20) and deptno = 20
	  or
	  sapay = (select max(sapay) from sawon where deptno = 30) and deptno = 30
	  or
	  sapay = (select max(sapay) from sawon where deptno = 40) and deptno = 40
	  or
	  sapay = (select max(sapay) from sawon where deptno = 50) and deptno = 50
order by deptno asc

-- 부서가 늘어날때마다 계속 구문을 추가해주어야 하는 문제가 있다.

-- 상관쿼리를 사용하면 위의 SQL구문의 문제를 해결할 수 있다.
-- 상관쿼리: 주쿼리의 정보를 서브쿼리가 이용해서 추출된 결과를 주 쿼리를 선택하는데 사용한다.
-- s1라는 임시테이블을 지정하고 참조할 부서번호의 값을 구한 뒤 값을 비교한다.
select * from sawon s1
where sapay = (select max(sapay) from sawon where deptno = s1.deptno)
order by s1.deptno asc
-- 메인쿼리의 레코드 수 만큼 서브쿼리가 수행되므로 성능저하의 요인이 된다. 
-- 가급적이면 사용하지 말것






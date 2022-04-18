-- 정렬(sort)
asc -- 오름차순
desc -- 내림차순
-- 정렬방식 생략시 기본값은 asc
order by fieldName asc,--1차정렬
		 fieldName2 desc -- 2차정렬

select * from sawon
order by deptno asc, sasex asc

-- 그룹통계
group by fieldName -- 그룹화시킬 컬럼
select 
	deptno as 부서번호, 
	count(*) as 인원수, 
	sum(sapay) as 급여합계,
	avg(sapay) as 급여평균,
	max(sapay) as 최대급여,
	min(sapay) as 최소급여,
	min(sahire) as 최초입사일자,
	max(sahire) as 최근입사일자
from sawon 
group by deptno order by deptno

-- 부서별 성별 인원수 구하기
select
deptno,
sasex,
count(*)
from sawon
group by deptno, sasex
order by deptno

-- 직급별 인원수 구하기
select
deptno,
sajob,
count(*)
from sawon
group by sajob, deptno
order by deptno

-- 입사년도별 인원수
select
	to_char(sahire,'YYYY') as 입사년도,
	count(*)
from sawon
group by to_char(sahire,'YYYY')
order by to_char(sahire,'YYYY')

-- 입사월별 인원수
select
	to_char(sahire,'MM')||'월' as 입사월,
	count(*) ||'명'as 입사인원
from sawon
group by to_char(sahire,'MM')
order by to_char(sahire,'MM')

-- 입사년대별 인원수
select 
trunc(to_char(sahire,'YYYY'),-1)||'년대' as 입사년대,
count(*)|| '명' as 인원수
from sawon
group by trunc(to_char(sahire,'YYYY'),-1)
order by trunc(to_char(sahire,'YYYY'),-1)




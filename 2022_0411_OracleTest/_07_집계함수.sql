-- 집계함수
-- count(필드): 도메인 갯수 구하기 (null 불포함)
-- count(*): 전체 레코드 수 구하기
select count(*), count(samgr) from sawon

-- sum(숫자): 도메인의 합
-- avg(숫자): 도메인의 평균
-- max(숫자): 도메인 내의 최대값
-- min(숫자): 도메인 내의 최소값

select 
	sum(sapay) as 전체급여, 
	floor(avg(sapay)) as 평균급여,
	max(sapay) as 최대급여액,
	min(sapay) as 최소급여액,
	max(sahire) as 최근입사일자,
	min(sahire) as 최초입사일자
from sawon


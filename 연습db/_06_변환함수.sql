/*

-- number -> character 

-- 콤마 예제
SELECT TO_CHAR(12345678,'999,999,999') comma FROM DUAL;
 
-- 소숫점 예제  
SELECT TO_CHAR(123.45678,'999,999,999.99') period FROM DUAL; 
 
-- $ 표시 예제
SELECT TO_CHAR(12345678,'$999,999,999') dollar  FROM DUAL;
 
-- Local 화폐 표시 예제 (한국의 경우 ￦로 자동 변환 됨)
SELECT TO_CHAR(12345678,'L999,999,999') local  FROM DUAL;
 
-- 왼쪽에 0을 삽입
SELECT TO_CHAR(123,'09999') zero FROM DUAL;  
 
-- 16진수로 변환
SELECT TO_CHAR(123,'XXXX') hexadecimal  FROM DUAL;


 */

-- 날짜형 -> 문자형

-- 년,월,일,시,분,초 예제
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') "sysdate"
FROM DUAL;
 
-- 365일 중 몇 일째인지 조회
SELECT TO_CHAR(SYSDATE, 'DDD') "Day of year" FROM DUAL;
 
-- 53주 중 몇 주차 인지 조회
SELECT TO_CHAR(SYSDATE, 'IW') "Week of year" FROM DUAL;
 
-- 해당 월의 이름 조회
SELECT TO_CHAR(SYSDATE, 'MONTH') "Name of month" FROM DUAL;

-- 문자를 날짜로 변환
select to_date('2022-4-14 15:39:14','YYYY-MM-DD HH24:MI:SS') from dual

-- 문자를 숫자로 변환
select to_number('123') + 1 from dual

-- 사원테이블에서 입사년도, 입사월, 입사일 별도로 추출하기
select sabun, saname, sahire,
to_char(sahire,'YYYY') 입사년도,
to_char(sahire,'MM') 입사월,
to_char(sahire,'DD') 입사일
from sawon

select * from sawon
where to_char(sahire,'YYYY')<2000

-- 사원테이블에서 7월에 입사한 직원 추출
select * from sawon
where to_char(sahire,'MM')=7


-- 사원테이블에서 봄에 입사한 직원 추출
select * from sawon
where to_char(sahire,'MM')>=3 and to_char(sahire,'MM') <6

select * from sawon
where floor(to_number(to_char(sahire,'MM'))/3) = 1

-- 고객테이블에서 서울 사는 고객만 추출
select * from gogek
where goaddr like '서울%'






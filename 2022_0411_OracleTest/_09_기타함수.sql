
SELECT * FROM DEPT
/*
DEPTNO DNAME LOC
 ------ ----- ---
     10 총무부   101
     20 영업부   202
     30 전산실   303
     40 관리부   404
     50 경리부   505
*/
SELECT * FROM SAWON

-- 1. DECODE
-- 형식: DECODE(필드(연산식), 비교값, 결과값, 
--                        비교값2, 결과값2
-- 						  기본값)

SELECT 
	SABUN 사번,
	SANAME 이름,
	DEPTNO 부서,
	DECODE(DEPTNO, 10, '총무부', 
				   20, '영업부', 
				   30, '전산실', 
				   40, '관리부', 
				   50, '경리부') 부서명
FROM SAWON

/*
-- 2. CASE ~END
--  형식1
		CASE FIELDNAME(연산식)
			WHEN 비교값1 THEN 결과값1
			WHEN 비교값2 THEN 결과값2
			WHEN 비교값3 THEN 결과값3
		END
-- 형식2
		CASE 
			WHEN 조건1 THEN 결과값1
			WHEN 조건2 THEN 결과값2
			ELSE 기본값
		END

*/
SELECT 
	SABUN,
	SANAME,
	DEPTNO,
	CASE DEPTNO
		WHEN 10 THEN '총무부'
		WHEN 20 THEN '영업부'
		WHEN 30 THEN '전산실'
		WHEN 40 THEN '관리부'
		ELSE '경리부'
	END AS DENAME
FROM SAWON
ORDER BY DEPTNO, SABUN

-- CASE END 문을 사용해서 고객테이블에서 성별 추출
SELECT
	GOBUN,
	GONAME,
	GOJUMIN,
	CASE 
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,8,1))IN(1,3,5,7,9) THEN '남자'
		ELSE '여자'
	END AS GENDER
FROM GOGEK


-- 사원테이블에서 입사계절을 추출하세요 SABUN, SANAME, SAHIRE, SEASON
SELECT
	SABUN,
	SANAME,
	SAHIRE,
	CASE
		WHEN TO_CHAR(SAHIRE,'MM')IN(12,1,2) THEN '겨울'
		WHEN TO_CHAR(SAHIRE,'MM')IN(3,4,5) THEN '봄'
		WHEN TO_CHAR(SAHIRE,'MM')IN(6,7,8) THEN '여름'
		ELSE '가을'
	END AS SEASON
FROM SAWON

select * from sawon 
where sahire in
(select sahire from sawon where to_char(sahire,'MM') in (3,4,5))

-- 고객테이블에서 고객의 출생 계절을 추출하세요
SELECT 
	GOBUN,
	GONAME,
	GOJUMIN,
	CASE
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,3,2))IN(12,1,2) THEN '겨울'
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,3,2))IN(3,4,5) THEN '봄'
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,3,2))IN(6,7,8) THEN '여름'
		ELSE '가을'
	END AS SEASON
FROM GOGEK


-- 3. NVL (필드, 대체값)
-- NULL 값을 다른 값으로 치환해주는 함수
SELECT
	SABUN, SANAME, SAMGR, NVL(SAMGR,0) AS SAMGR2
FROM SAWON
-- 	  NVL2 (필드, 참값, 거짓값) 
SELECT
	SABUN, SANAME, SAMGR, NVL2(SAMGR,1,0) AS SAMGR2
FROM SAWON

-- 고객테이블에서 거주지별 지역별 인원수(광역시 기준)
SELECT 
	SUBSTR(GOADDR,1,2) AS 시도,
	COUNT(*)	
FROM GOGEK
GROUP BY SUBSTR(GOADDR,1,2)
ORDER BY SUBSTR(GOADDR,1,2)

SELECT * FROM GOGEK

-- 고객테이블에서 출생계절별 인원수 구하기
SELECT 
	CASE
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,3,2))IN(12,1,2) THEN '겨울'
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,3,2))IN(3,4,5) THEN '봄'
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,3,2))IN(6,7,8) THEN '여름'
		ELSE '가을'
	END AS SEASON,
	COUNT(*)
FROM GOGEK
GROUP BY CASE
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,3,2))IN(12,1,2) THEN '겨울'
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,3,2))IN(3,4,5) THEN '봄'
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,3,2))IN(6,7,8) THEN '여름'
		ELSE '가을'
	END

-- GROUP BY HAVING : GROUP BY 결과에 따른 조건절
SELECT
	DEPTNO,
	COUNT(*)
FROM SAWON
GROUP BY DEPTNO
	HAVING COUNT(*)>5
ORDER BY DEPTNO

SELECT
	DEPTNO 부서번호,
	FLOOR(AVG(SAPAY))||'만원' 연봉
FROM SAWON
GROUP BY DEPTNO
	HAVING AVG(SAPAY) BETWEEN 3000 AND 3500


-- 사원테이블에서 성씨별 인원수
SELECT 
	SUBSTR(SANAME,1,1) 성,
	COUNT(*) 인원수
FROM SAWON
GROUP BY SUBSTR(SANAME,1,1)

-- 사원테이블에서 입사계절별 인원수
SELECT
	CASE
		WHEN TO_NUMBER(TO_CHAR(SAHIRE,'MM')) IN (12,1,2) THEN '겨울'
		WHEN TO_NUMBER(TO_CHAR(SAHIRE,'MM')) IN (3,4,5) THEN '봄'
		WHEN TO_NUMBER(TO_CHAR(SAHIRE,'MM')) IN (6,7,8) THEN '여름'
		ELSE '가을'
	END AS 입사계절,
	COUNT(*)
FROM SAWON
GROUP BY CASE
		WHEN TO_NUMBER(TO_CHAR(SAHIRE,'MM')) IN (12,1,2) THEN '겨울'
		WHEN TO_NUMBER(TO_CHAR(SAHIRE,'MM')) IN (3,4,5) THEN '봄'
		WHEN TO_NUMBER(TO_CHAR(SAHIRE,'MM')) IN (6,7,8) THEN '여름'
		ELSE '가을'
	END
	
-- 고객테이블에서 다음과 같은 데이터를 추출하세요
-- GOBUN, GONAME, GOJUMIN, BIRTHYEAR
SELECT * FROM GOGEK
	
SELECT
	GOBUN,
	GONAME,
	GOJUMIN,
	CASE
		WHEN SUBSTR(GOJUMIN,8,1)IN(8,9) THEN TO_NUMBER(SUBSTR(GOJUMIN,1,2))+1800
		WHEN SUBSTR(GOJUMIN,8,1)IN(1,2) THEN TO_NUMBER(SUBSTR(GOJUMIN,1,2))+1900
		ELSE TO_NUMBER(SUBSTR(GOJUMIN,3,2))+2000
	END AS BIRTHYEAR
FROM GOGEK
ORDER BY BIRTHYEAR
	
-- 고객테이블에서 다음과 같은 데이터를 추출하세요
-- GOBUN, GONAME, GOJUMIN, LOCALCODE
SELECT
	GOBUN,
	GONAME,
	GOJUMIN,
	CASE
		WHEN SUBSTR(GOJUMIN,9,2)BETWEEN 0 AND 8 THEN '서울'
		WHEN SUBSTR(GOJUMIN,9,2)BETWEEN 9 AND 12 THEN '강원'
		WHEN SUBSTR(GOJUMIN,9,2)BETWEEN 13 AND 15 THEN '부산'
		WHEN SUBSTR(GOJUMIN,9,2)BETWEEN 30 AND 35 THEN '제주'
		ELSE '대한민국 어딘가...'
	END AS LOCALCODE
FROM GOGEK
ORDER BY LOCALCODE









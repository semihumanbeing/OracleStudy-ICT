/*  
 	-- DDL(Data definition langage) : create, drop, alter
 	-- 성적관리 테이블 만들기
	
	create table score --테이블명
	(
		-- 필요한 항목 만들기(column)
		-- 변수명, 자료형
		name varchar2(100), --1
		kor number(3),	    --2
		eng int,            --3
		math int 			--4 	sql문은 1부터시작한다
	)
	
	-- 테이블 수정 
	alter table score add sci int; -- 추가할 컬럼정보
	
	alter table score modify (sci int not null); -- 수정할 컬럼정보
	
	alter table score add music int;
	
	alter table score drop column music; -- 삭제할 컬럼정보
	
	-- 테이블 삭제
	drop table score
	
	--조회
	select * from score -- * 는 모든 컬럼을 의미한다
	select name, kor from score  -- 기본 필드
	
	-- 연산 필드(기본 필드를 사용해 부가적인 데이터 산출)
	select name,kor,eng,math,sci, 
	kor+eng+math+sci as total,  -- 전체값 구하기
	round((kor+eng+math+sci)/4,1) as average, -- 평균값 구하기
	rank() over (order by (kor+eng+math) desc) as rank
	from score 
	
	
	-- DML (data manipulation language) insert update delete <select
	-- 데이터 추가
	insert into score values('삼길동', 90, 80, 70);
						--입력 컬럼지정	
	insert into score(kor, eng, math, name) values(77, 88, 99, '이길동');
	
	-- 데이터 수정
	update score set sci = 50
	
	update score set kor = 10 where name = '이길동';
	
	update score set kor = 100, eng = 100, math = 100 where name = '일길동'
	
	-- 데이터 삭제
	delete from score where name='삼길동'
	
*/
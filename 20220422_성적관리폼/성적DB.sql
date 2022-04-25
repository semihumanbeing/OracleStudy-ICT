/*
-- 일련번호 관리 객체(시퀀스)
create sequence seq_sungtb_idx


-- 테이블 생성
create table sungtb
(
	idx int, -- primary key 일련번호
	name varchar2(100) not null, -- 이름
	kor int, -- 국어점수
	eng int, -- 영어점수
	mat int -- 수학점수
)

-- 기본키 설정
alter table sungtb 
	add constraint pk_sungtb_idx primary key(idx)

-- 체크제약
alter table sungtb
	add constraint ck_sungtb_kor check(kor between 0 and 100)
	
alter table sungtb
	add constraint ck_sungtb_eng check(eng between 0 and 100)

alter table sungtb
	add constraint ck_sungtb_mat check(mat between 0 and 100)
	
insert into sungtb values(seq_sungtb_idx.nextVal,'일길동',90,80,70)
insert into sungtb values(seq_sungtb_idx.nextVal,'이길동',80,80,80)
insert into sungtb values(seq_sungtb_idx.nextVal,'삼길동',90,100,90)

commit

select * from sungtb


-- 조회시 필요한 뷰를 생성
create or replace view sungtb_view
as
select
s.*, 
to_char((kor+eng+mat)) as tot,
to_char(round((kor+eng+mat)/3,1)) as avg,
to_char(rank() over(order by (kor+eng+mat) desc)) as rank
from (select * from sungtb) s
order by idx

select * from sungtb_view

delete from sungtb where idx = 6

update sungtb set name = '일길동', kor = 100, eng = 80, mat = 70 where idx = 1














*/

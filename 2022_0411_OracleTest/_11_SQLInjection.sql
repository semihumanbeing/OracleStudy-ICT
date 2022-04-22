create table testMember
(
idx int,
id varchar2(100) not null,
pwd varchar2(100) not null,
name varchar2(100) not null
)
-- 기본키
alter table testMember
	add constraint pk_testMember_idx primary key(idx)

-- unique
alter table testMember
	add constraint unique_testMember_id unique(id)
	
-- sample data
insert into testMember values(1,'gildong1','1234','일길동');
insert into testMember values(2,'gildong2','1234','이길동');
insert into testMember values(3,'gildong3','1234','삼길동');
insert into testMember values(4,'gildong4','1234','사길동');
insert into testMember values(5,'gildong5','1234','오길동');
commit

-- login sql
-- SQL injection 기능 사용하기 (or 1=1 하면 항상 참이 되기 때문에 모든 테이블 정보가 나온다.)
-- prepared statement 로 쓰면 이런 현상이 발생하지않는다.
select * from testMember where id ='gildong1' and pwd = '12345' or 1=1


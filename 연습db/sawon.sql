drop table sawon

create table sawon
(
   sabun number(3),
   saname varchar2(30),
   sasex  varchar2(10),
   deptno  number(3),
   sajob   varchar2(10),
   sahire  date,
   samgr  number(3),
   sapay   number(8),
   constraint pk_sawon_sabun primary key(sabun)
)
/
alter table sawon 
	add constraint fk_sawon_deptno foreign key(deptno)
references dept(deptno)
-- on delete cascade - 부모키가 삭제되면 참조하는 foreign key 를 소유하는 레코드도 삭제한다. 

alter table sawon
	add constraint fk_sawon_samgr foreign key(samgr)
                                  references sawon(sabun)

select * from test.sawon

select constraint_name from user_constraints where table_name = 'SAWON'

alter table sawon
	drop constraint fk_sawon_samgr

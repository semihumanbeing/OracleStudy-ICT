create table testMember
(
idx int,
id varchar2(100) not null,
pwd varchar2(100) not null,
name varchar2(100) not null
)
-- �⺻Ű
alter table testMember
	add constraint pk_testMember_idx primary key(idx)

-- unique
alter table testMember
	add constraint unique_testMember_id unique(id)
	
-- sample data
insert into testMember values(1,'gildong1','1234','�ϱ浿');
insert into testMember values(2,'gildong2','1234','�̱浿');
insert into testMember values(3,'gildong3','1234','��浿');
insert into testMember values(4,'gildong4','1234','��浿');
insert into testMember values(5,'gildong5','1234','���浿');
commit

-- login sql
-- SQL injection ��� ����ϱ� (or 1=1 �ϸ� �׻� ���� �Ǳ� ������ ��� ���̺� ������ ���´�.)
-- prepared statement �� ���� �̷� ������ �߻������ʴ´�.
select * from testMember where id ='gildong1' and pwd = '12345' or 1=1


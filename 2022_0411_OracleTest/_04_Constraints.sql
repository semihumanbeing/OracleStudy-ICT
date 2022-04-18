/*
 
 ��������(Constraint)
 1. ������ ���Ἲ(data integrity) �� �����ϱ����� ����
 2. ����
 	1) not null(null�� ������) or null(�����)
 	2) unique (�ϳ��� ���� �����)
 	3) check (���ǿ� �´� ���� ���)
 	4) default (�⺻��)
 	5) primary key (�⺻Ű) - not null + unique + index ����
 	6. foreign key (�ܷ�Ű) - �����Է�(����)���� ��ȿ���� �ܺ����̺� �θ�Ű(�÷�)�� �����ؼ� üũ
  
  
 -- not null �������� : inline ������θ� �� �� �ִ�.
create table tb1
(
  --�÷��� - �ڷ��� - ��������
name varchar2(100) not null,
nickname varchar2(100) null
)

insert into tb1 values('�ϱ浿', '�ϳ�');
insert into tb1(name) values ('�̱浿');
insert into tb1 values ('��浿', null);
insert into tb1(nickname) values ('�����'); -- not null ���࿡ ����Ǳ⶧���� �����������

select * from tb1

 -- unique �������� : �����γ� �ߺ����� ��������ʴ´�

create table tb2
(
	id varchar2(100) not null unique, -- ���������� �ߺ����� ��
	pwd varchar2(100) not null
)

insert into tb2 values('one','1234');
insert into tb2 values('two','1234');
insert into tb2 values('one','5678'); -- �������� ����� �����������

-- ���̺� ���� �� ������ ���� ��� : �������Ǹ��� ����ڰ� ����
create table tb3
(
	id varchar2(100) not null,
	pwd varchar2(100) not null
)

-- id �÷��� �߰��� unique �������� �ɱ�
alter table tb3 
	add constraint unique_tb3_id unique(id); -- ���������� �̸��� �� �ָ� ������ ������ �� ���� ã�Ƴ� �� �ִ�.

insert into tb3 values ('one','1234');
insert into tb3 values ('one','5678'); -- ORA-00001: unique constraint (TEST.UNIQUE_TB3_ID)

-- check ��������: ���ǿ� �´� ���� ����Ѵ�.
���������: +, -, *, /, mod(�������� ��, ������ ��) �Լ�
������: >, >=, <, <=, =, !=
�Ϲݳ�������: and, or, not
��Ÿ������: �ʵ� between A and B (�ʵ��� ������ A���� B�����ΰ�?)
		 �ʵ� in(A,B,C) (�ʵ� = A or �ʵ� = B or �ʵ� = C)
		 
create table tb4
(
	name varchar2(100) not null, 
	kor int check(kor > 0 and kor <= 100), -- inline check ���༳�� (�ʵ弳���� ���ÿ� �������� ����)
	eng int,
	math int, 
	-- �������� ����
	constraint check_tb4_eng check(eng between 0 and 100)
)

alter table tb4 
	add constraint check_tb4_math check(math between 0 and 100);

-- �������� Ȯ�ι�� - ���������� dictionary �� user_constraints�� ����ȴ�.
select constraint_type,constraint_name,table_name from user_constraints
where table_name='TB4' 

----------
insert into tb4 values ('eric', '70', '70', '70');
update tb4 set kor = 50 where name = 'eric'
update tb4 set eng = 150 where name = 'eric'
select * from tb4

-- �������� ������ ����/���ڸ� �Էµǵ��� �������� �����ϱ�
create table tb5
(
	name varchar2(100) not null,
	gender varchar2(100) not null
)

alter table tb5
	add constraint check_tb5_gender check(gender = 'male' or gender = 'female');
alter table tb5
	drop constraint check_tb5_gender

insert into tb5 values ('eric', 'male');
insert into tb5 values ('eric', 'lalala'); --ORA-02290: check constraint (TEST.CHECK_TB5_GENDER) violated

-- default ���� : �Է����� �ʾ��� �� �⺻���� ����
create table tb6
(
name varchar2(100) not null,
age int default 1,
gender varchar2(100) default 'male',
regdate date default sysdate
)

insert into tb6 values('�ϱ浿', 20, 'male', to_date('2022-04-12','yyyy-mm-dd'));
insert into tb6(name) values('�̱浿');
insert into tb6 values('��浿', default, default, default);

select * from tb6

-- primary key : �⺻Ű <- not null + unique + index ����

create table tb7
(
idx int,
name varchar2(100) not null,
tel varchar2(100) 
)
-- �⺻Ű ����
alter table tb7 
	add constraint pk_tb5_idx primary key(idx);
	
insert into tb7 values(1,'�ϱ浿','010-111-1111');
insert into tb7(name) values('eric');
insert into tb7(name) values(1,'eric','010-222-1111'); - �ε����� ���Ƽ� ������ ���


-- 2�� �̻��� �÷��� ��� PK�� ����� �� �ִ�.
create table tb55
(
idx int,
name varchar2(100),
regdate date
)
alter table tb55
	add constraint pk_tb55_idx_regdate primary key(idx, regdate);

insert into tb55 values(1,'eric',sysdate);

-- �������� �̿��� idxó��
sequence: �Ϸù�ȣ ������ü

create table tb555
(
idx int,
regdate date default sysdate
)

alter table tb555
	add constraint pk_tb555_idx primary key(idx);
--����
create sequence seq_tb555_idx
--���
select seq_tb555_idx.nextVal, seq_tb555_idx.currVal from dual;
--����
drop sequence seq_tb555_idx;

-- �������� �̿��ؼ� tb555�� idx���� �ֱ�
insert into tb555 values(seq_tb555_idx.nextVal, sysdate);

-- �ܷ�Ű (foreign key): �����ϴ� �θ�Ű ���� �̿��ؼ� insert/update ���� ����
create table student
(
�й� int,
name varchar2(100) not null,
tel varchar2(100) not null,
��ȣ�ڸ� varchar2(100) not null,
��ȣ������ varchar2(100) not null,
address varchar2(100)
)

alter table student
	add constraint pk_student_�й� primary key(�й�)

insert into student values(1, 'eric', '111-1111', 'dad', 'teacher', 'seoul');
insert into student values(2, 'dahee', '222-2222', 'lalala', 'programmer', 'incheon');

select * from student

create table score
(
no int,
studentNo int,
kor int,
eng int,
math int,
grade int,
semester int,
exam varchar2(100)
)

-- �⺻Ű
alter table score
	add constraint pk_score_no primary key(no); 

-- �ܷ�Ű
alter table score
	add constraint fk_score_studentNo foreign key(studentNo) references student(�й�);

insert into score values(1,1,100,90,80,1,1,'�߰����');
insert into score values(1,3,100,90,80,1,1,'�߰����'); -- ����

select * from score










*/
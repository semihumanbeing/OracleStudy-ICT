/*
 
 제약조건(Constraint)
 1. 데이터 무결성(data integrity) 를 유지하기위한 성질
 2. 종류
 	1) not null(null값 허용안함) or null(허용함)
 	2) unique (하나의 값만 허용함)
 	3) check (조건에 맞는 값만 허용)
 	4) default (기본값)
 	5) primary key (기본키) - not null + unique + index 설정
 	6. foreign key (외래키) - 현재입력(수정)값의 유효성을 외부테이블 부모키(컬럼)를 참조해서 체크
  
  
 -- not null 제약조건 : inline 방식으로만 할 수 있다.
create table tb1
(
  --컬럼명 - 자료형 - 제약조건
name varchar2(100) not null,
nickname varchar2(100) null
)

insert into tb1 values('일길동', '하나');
insert into tb1(name) values ('이길동');
insert into tb1 values ('삼길동', null);
insert into tb1(nickname) values ('삼식이'); -- not null 제약에 위배되기때문에 실행되지않음

select * from tb1

 -- unique 제약조건 : 도메인내 중복값을 허용하지않는다

create table tb2
(
	id varchar2(100) not null unique, -- 제약조건이 중복으로 들어감
	pwd varchar2(100) not null
)

insert into tb2 values('one','1234');
insert into tb2 values('two','1234');
insert into tb2 values('one','5678'); -- 제약조건 위배로 실행되지않음

-- 테이블 생성 후 수정을 통한 방식 : 제약조건명을 사용자가 지정
create table tb3
(
	id varchar2(100) not null,
	pwd varchar2(100) not null
)

-- id 컬럼에 추가로 unique 제약조건 걸기
alter table tb3 
	add constraint unique_tb3_id unique(id); -- 제약조건의 이름을 잘 주면 오류가 나왔을 때 쉽게 찾아낼 수 있다.

insert into tb3 values ('one','1234');
insert into tb3 values ('one','5678'); -- ORA-00001: unique constraint (TEST.UNIQUE_TB3_ID)

-- check 제약조건: 조건에 맞는 값만 허용한다.
산술연산자: +, -, *, /, mod(나눠지는 수, 나누는 수) 함수
연산자: >, >=, <, <=, =, !=
일반논리연산자: and, or, not
기타연산자: 필드 between A and B (필드의 범위가 A부터 B사이인가?)
		 필드 in(A,B,C) (필드 = A or 필드 = B or 필드 = C)
		 
create table tb4
(
	name varchar2(100) not null, 
	kor int check(kor > 0 and kor <= 100), -- inline check 제약설정 (필드설정과 동시에 제약조건 설정)
	eng int,
	math int, 
	-- 제약조건 설정
	constraint check_tb4_eng check(eng between 0 and 100)
)

alter table tb4 
	add constraint check_tb4_math check(math between 0 and 100);

-- 제약조건 확인방법 - 제약조건은 dictionary 에 user_constraints에 저장된다.
select constraint_type,constraint_name,table_name from user_constraints
where table_name='TB4' 

----------
insert into tb4 values ('eric', '70', '70', '70');
update tb4 set kor = 50 where name = 'eric'
update tb4 set eng = 150 where name = 'eric'
select * from tb4

-- 조건으로 성별이 남자/여자만 입력되도록 제약조건 설정하기
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

-- default 제약 : 입력하지 않았을 때 기본값을 설정
create table tb6
(
name varchar2(100) not null,
age int default 1,
gender varchar2(100) default 'male',
regdate date default sysdate
)

insert into tb6 values('일길동', 20, 'male', to_date('2022-04-12','yyyy-mm-dd'));
insert into tb6(name) values('이길동');
insert into tb6 values('삼길동', default, default, default);

select * from tb6

-- primary key : 기본키 <- not null + unique + index 설정

create table tb7
(
idx int,
name varchar2(100) not null,
tel varchar2(100) 
)
-- 기본키 설정
alter table tb7 
	add constraint pk_tb5_idx primary key(idx);
	
insert into tb7 values(1,'일길동','010-111-1111');
insert into tb7(name) values('eric');
insert into tb7(name) values(1,'eric','010-222-1111'); - 인덱스가 같아서 오류가 뜬다


-- 2개 이상의 컬럼을 묶어서 PK로 사용할 수 있다.
create table tb55
(
idx int,
name varchar2(100),
regdate date
)
alter table tb55
	add constraint pk_tb55_idx_regdate primary key(idx, regdate);

insert into tb55 values(1,'eric',sysdate);

-- 시퀀스를 이용한 idx처리
sequence: 일련번호 관리객체

create table tb555
(
idx int,
regdate date default sysdate
)

alter table tb555
	add constraint pk_tb555_idx primary key(idx);
--생성
create sequence seq_tb555_idx
--사용
select seq_tb555_idx.nextVal, seq_tb555_idx.currVal from dual;
--삭제
drop sequence seq_tb555_idx;

-- 시퀀스를 이용해서 tb555에 idx값을 넣기
insert into tb555 values(seq_tb555_idx.nextVal, sysdate);

-- 외래키 (foreign key): 참조하는 부모키 값을 이용해서 insert/update 내용 결정
create table student
(
학번 int,
name varchar2(100) not null,
tel varchar2(100) not null,
보호자명 varchar2(100) not null,
보호자직업 varchar2(100) not null,
address varchar2(100)
)

alter table student
	add constraint pk_student_학번 primary key(학번)

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

-- 기본키
alter table score
	add constraint pk_score_no primary key(no); 

-- 외래키
alter table score
	add constraint fk_score_studentNo foreign key(studentNo) references student(학번);

insert into score values(1,1,100,90,80,1,1,'중간고사');
insert into score values(1,3,100,90,80,1,1,'중간고사'); -- 오류

select * from score










*/
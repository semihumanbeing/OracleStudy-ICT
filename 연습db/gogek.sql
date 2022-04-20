create table gogek
(
    gobun number(3),
    goname varchar2(30),
    goaddr varchar2(30),
    gojumin  varchar2(14),
    godam  number(3),
    constraint pk_gogek_gobun primary key(gobun) -- 제약조건의 이름을 써주어야 제약위반이 되었을때 바로바로 알 수 있다.
)
/
-- 외래키 잡기
alter table gogek
add constraint fk_gogek_godam foreign key(godam)
references sawon(sabun)
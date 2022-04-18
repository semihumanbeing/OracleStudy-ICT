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
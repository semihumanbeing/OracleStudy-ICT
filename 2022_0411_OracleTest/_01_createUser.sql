/*
 DDL (Data definition language): create drop alter
 1. 유저 생성
 create user test identified by test
 
 DCL (Data control language): grant(부여) revoke(취소)
 2. 권한 부여
 grant connect to test -- 연결 권한
 grant resource to test  -- 자원 권한 (table/view사용권한)
 
 grant connect, resource to test -- 2개 명령을 한번에 처리하기
 
 3. 권한 회수
 revoke connect, resource from test
 
 
 -- 객체권한: scott 이 test에게 scott.dept를 조회할 수 있는 권한 부여하기
       (권한)     (대상)
 grant select on dept to test -- 권한 부여
 
 revoke select on dept from test -- 권한 회수
 
  
 */

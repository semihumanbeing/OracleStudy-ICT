/*
	
	1. 문자형: 크기(byte)
		char(크기) : 고정길이
		varchar2(크기) : 가변길이
	ex) memo char(2000) = 'a' -> 총 할당크기 2000byte
		memo varchar2(2000) = 'a' -> 총 할당크기 1byte
	
	2. 숫자형: 길이(자릿수)
		number(길이)
		number(p,s) -> p: 전체길이, s: 소수점 자리수
		int -> number(38) 동일한 자료형
		
	3. 날짜형
		date(자료형)
		sysdate <- 현재 시스템 날짜/시간
		select sysdate from dual -- dual(임시테이블)
		
	4. LOB(large object): 최대 저장용량: 4gb
		BLOB(Binary large object): 동영상, 사운드, 이미지
		CLOB(Character larger object): 대용량 문자
	
	5. raw: 소량의 binary type
	   LONG(1record에 1개만 사용) 
		


*/
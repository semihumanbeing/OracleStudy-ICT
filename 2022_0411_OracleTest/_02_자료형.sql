/*
	
	1. ������: ũ��(byte)
		char(ũ��) : ��������
		varchar2(ũ��) : ��������
	ex) memo char(2000) = 'a' -> �� �Ҵ�ũ�� 2000byte
		memo varchar2(2000) = 'a' -> �� �Ҵ�ũ�� 1byte
	
	2. ������: ����(�ڸ���)
		number(����)
		number(p,s) -> p: ��ü����, s: �Ҽ��� �ڸ���
		int -> number(38) ������ �ڷ���
		
	3. ��¥��
		date(�ڷ���)
		sysdate <- ���� �ý��� ��¥/�ð�
		select sysdate from dual -- dual(�ӽ����̺�)
		
	4. LOB(large object): �ִ� ����뷮: 4gb
		BLOB(Binary large object): ������, ����, �̹���
		CLOB(Character larger object): ��뷮 ����
	
	5. raw: �ҷ��� binary type
	   LONG(1record�� 1���� ���) 
		


*/
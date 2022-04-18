/*  
 	-- DDL(Data definition langage) : create, drop, alter
 	-- �������� ���̺� �����
	
	create table score --���̺��
	(
		-- �ʿ��� �׸� �����(column)
		-- ������, �ڷ���
		name varchar2(100), --1
		kor number(3),	    --2
		eng int,            --3
		math int 			--4 	sql���� 1���ͽ����Ѵ�
	)
	
	-- ���̺� ���� 
	alter table score add sci int; -- �߰��� �÷�����
	
	alter table score modify (sci int not null); -- ������ �÷�����
	
	alter table score add music int;
	
	alter table score drop column music; -- ������ �÷�����
	
	-- ���̺� ����
	drop table score
	
	--��ȸ
	select * from score -- * �� ��� �÷��� �ǹ��Ѵ�
	select name, kor from score  -- �⺻ �ʵ�
	
	-- ���� �ʵ�(�⺻ �ʵ带 ����� �ΰ����� ������ ����)
	select name,kor,eng,math,sci, 
	kor+eng+math+sci as total,  -- ��ü�� ���ϱ�
	round((kor+eng+math+sci)/4,1) as average, -- ��հ� ���ϱ�
	rank() over (order by (kor+eng+math) desc) as rank
	from score 
	
	
	-- DML (data manipulation language) insert update delete <select
	-- ������ �߰�
	insert into score values('��浿', 90, 80, 70);
						--�Է� �÷�����	
	insert into score(kor, eng, math, name) values(77, 88, 99, '�̱浿');
	
	-- ������ ����
	update score set sci = 50
	
	update score set kor = 10 where name = '�̱浿';
	
	update score set kor = 100, eng = 100, math = 100 where name = '�ϱ浿'
	
	-- ������ ����
	delete from score where name='��浿'
	
*/
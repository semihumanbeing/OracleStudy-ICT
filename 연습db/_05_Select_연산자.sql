/*
������
1. ���������: * / + - mod
2. ���迬����: > >= < <= =
3. ��������: and or not
4. ��Ÿ������: �ʵ� between a and b
			�ʵ� in (A,B,C)
5. ���ڿ�����: ||
6. ���ڿ� ����˻�: �ʵ� like ''
				% : ��� ����(���̰������)
			    _ : ��� ����(1����)
			    
			    ex) �̷� �����ϴ� ���ڸ� ã������� �ʵ� like '��%'
			
-- ���������
*/
select saname || '�� ���غ� ���� ��������' ������ from sawon

select 5+3, 6-4, 3*5, 10/3, mod(10,3) from dual
select * from test.sawon

select * from GOGEK


select sabun as ���, saname �����,sajob,sapay from sawon

-- ������̺��� 10�� �μ� ������ ����
select * from SAWON where deptno = 10

-- �ʵ���� as �� ������ �� �ִ�.
select
	sabun as ���,
	saname �����,
	sajob as "�� ��",
	sapay,
	sapay * 0.1 as bonus
from sawon

-- ������̺��� ���常 ����
select * from SAWON
where sajob = '����'

-- ������̺��� 10�� �μ��� ���常 ����
select * from sawon
	where sajob = '����' and deptno = 10

-- ������̺��� ������ ����, �븮�϶� ����
select * from sawon
	where sajob = '����' or sajob = '�븮'
	
	
-- ���� 3000 �̻� �޴� ���
select * from sawon
	where sapay >= 3000
	

-- ���� 3500 �̻� 4000���� �޴� ���
select * from sawon
	where sapay >= 3500 and sapay <=4000
	
select * from sawon
where sapay between 3500 and sapay
	
-- samgr �� null�� ���� ����
-- null üũ�ϴ� ������
select * from sawon
where samgr is null
-- null�� �ƴ� ���� üũ�Ҷ�
select * from sawon
where samgr is not null
-- not�� where not samgr is null �� ����ϸ� sql�� 2�� �����ϰ� �ϹǷ� ��������.

-- ������̺��� 20�� �μ��� ���������� �����ϼ���
select * from sawon
where sasex = '����' and deptno = 20
	
-- �μ��� �߿��� ������ 4000�ʰ��� ������ �����ϼ���
select * from sawon
where sajob = '����' and sapay > 4000

-- ������̺��� ���� '�̾��� ��������(���ڿ� ����˻���: %)
select * from sawon
where saname like '��%'

-- ������̺��� �̸��� 2��° ���ڰ� '��' �� ���� ����
select * from sawon
where saname like '_��'

-- �����̺��� ���ڸ� ���
select * from gogek
where gojumin like '______-1%' or 
	  gojumin like '______-3%' or 
	  gojumin like '______-5%' or 
	  gojumin like '______-7%'

	
-- ������̺��� 2000�� ���Ŀ� �Ի��� ���� ����
select * from SAWON
where sahire >= to_date('2000-1-1','YYYY-MM-DD')
	
select to_date('2000-1-1', 'YYYY-MM-DD') FROM dual

-- ����(sort)
asc -- ��������
desc -- ��������
-- ���Ĺ�� ������ �⺻���� asc
order by fieldName asc,--1������
		 fieldName2 desc -- 2������

select * from sawon
order by deptno asc, sasex asc

-- �׷����
group by fieldName -- �׷�ȭ��ų �÷�
select 
	deptno as �μ���ȣ, 
	count(*) as �ο���, 
	sum(sapay) as �޿��հ�,
	avg(sapay) as �޿����,
	max(sapay) as �ִ�޿�,
	min(sapay) as �ּұ޿�,
	min(sahire) as �����Ի�����,
	max(sahire) as �ֱ��Ի�����
from sawon 
group by deptno order by deptno

-- �μ��� ���� �ο��� ���ϱ�
select
deptno,
sasex,
count(*)
from sawon
group by deptno, sasex
order by deptno

-- ���޺� �ο��� ���ϱ�
select
deptno,
sajob,
count(*)
from sawon
group by sajob, deptno
order by deptno

-- �Ի�⵵�� �ο���
select
	to_char(sahire,'YYYY') as �Ի�⵵,
	count(*)
from sawon
group by to_char(sahire,'YYYY')
order by to_char(sahire,'YYYY')

-- �Ի���� �ο���
select
	to_char(sahire,'MM')||'��' as �Ի��,
	count(*) ||'��'as �Ի��ο�
from sawon
group by to_char(sahire,'MM')
order by to_char(sahire,'MM')

-- �Ի��뺰 �ο���
select 
trunc(to_char(sahire,'YYYY'),-1)||'���' as �Ի���,
count(*)|| '��' as �ο���
from sawon
group by trunc(to_char(sahire,'YYYY'),-1)
order by trunc(to_char(sahire,'YYYY'),-1)




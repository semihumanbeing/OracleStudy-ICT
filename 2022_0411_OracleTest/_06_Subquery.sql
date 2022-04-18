-- subquery 
-- subquery�� ���� ����� �̿��ؼ� mainquery�� �����ϴ� ������

-- ������̺��� �ֺҾϰ� ������ �μ� �������� �����ϱ�
-- 1. �ֺҾ��� �μ����� ���ϱ�
select deptno from sawon where saname = '�ֺҾ�'
-- 2. 10�� �μ� ���� ����
select * from sawon where deptno = 10

select * from sawon 
where deptno in (select deptno from sawon where saname = '�ֺҾ�')-- �̰��� ��������

-- ������̺��� �̹��ں��� �޿��� ���� �޴� ������ �����ϱ�
select * from sawon
where sapay >= (select sapay from sawon where saname = '�̹���')

-- ������̺��� �����ٰ� ������ �⵵�� �Ի��� ���� ����
select to_char(sahire, 'YYYY') from sawon where saname = '������'

where to_char(sahire,'YYYY') = (select to_char(sahire,'YYYY') from sawon where saname = '������')

--������̺��� �嵿�ǰ� ������ �޿� �Ի��� ����
select to_char(sahire,'MM') from sawon where saname = '�嵿��'
select * from sawon
where to_char(sahire,'MM') = (select to_char(sahire,'MM') from sawon where saname = '�嵿��')

-- ������̺��� �̹��ڿ� ������ ������ �Ի��� ���� ����
select floor(to_number(to_char(sahire,'MM'))/3) from sawon where saname = '�̹���'

select * from sawon
where floor(to_number(to_char(sahire,'MM'))/3) = (select floor(to_number(to_char(sahire,'MM'))/3) from sawon where saname = '�̹���')

select avg(sapay) from sawon

select * from sawon
where sapay > (select avg(sapay) from sawon)

-- ������̺��� ���� �Ի��ڰ� �����ΰ�
select min(sahire) from sawon

select * from sawon
where sahire = (select min(sahire) from sawon)

select * from sawon
where to_char(sahire,'YYYY-MM-DD') = (select min(to_char(sahire,'YYYY-MM-DD')) from sawon)

-- ������̺��� �ֱ� �Ի��� ���ϱ�

select * from sawon
where sahire in (select max(sahire) from sawon)

select * from sawon
where sahire in (select min(sahire) from sawon) or 
	  sahire in (select max(sahire) from sawon)
	  
insert into sawon values(18, '�ֺҾ�', '����', 20, '����', to_date('1984-7-25 13:00:00', 'YYYY-MM-DD HH24:MI:SS'),2, 3800)

select deptno from sawon
	order by deptno

-- ������̺��� �ְ�޿��ڸ� Ȯ���ϱ�
select * from sawon
where sapay = (select max(sapay) from sawon)

-- ������̺��� �� �μ��� �ְ�޿��� �����ϱ�
select * from sawon
where sapay = (select max(sapay) from sawon where deptno = 10) and deptno = 10
	  or
	  sapay = (select max(sapay) from sawon where deptno = 20) and deptno = 20
	  or
	  sapay = (select max(sapay) from sawon where deptno = 30) and deptno = 30
	  or
	  sapay = (select max(sapay) from sawon where deptno = 40) and deptno = 40
	  or
	  sapay = (select max(sapay) from sawon where deptno = 50) and deptno = 50
order by deptno asc

-- �μ��� �þ������ ��� ������ �߰����־�� �ϴ� ������ �ִ�.

-- ��������� ����ϸ� ���� SQL������ ������ �ذ��� �� �ִ�.
-- �������: �������� ������ ���������� �̿��ؼ� ����� ����� �� ������ �����ϴµ� ����Ѵ�.
-- s1��� �ӽ����̺��� �����ϰ� ������ �μ���ȣ�� ���� ���� �� ���� ���Ѵ�.
select * from sawon s1
where sapay = (select max(sapay) from sawon where deptno = s1.deptno)
order by s1.deptno asc
-- ���������� ���ڵ� �� ��ŭ ���������� ����ǹǷ� ���������� ������ �ȴ�. 
-- �������̸� ������� ����






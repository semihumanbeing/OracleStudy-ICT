/*

2�� �̻��� ���̺��� �����Ͽ� �����͸� �˻��ϴ� ����̴�

���� �� �̻��� ����� ����� �� PRIMARY KEY �� FOREIGN KEY ���� ����Ͽ� �����Ѵ�.

�� ���� ���̺��� SELECT ���� �ȿ��� �����Ϸ��� ��� �ϳ��� �÷��� �� ���̺� ���̿��� �����Ǿ���Ѵ�.

���� - 
	1. A Inner join B : ��� ���� 1:1�� ����
	2. Outer join 
	: A Left outer join B: A���̺� ���� ��� ����, B���̺��� �� ���ǿ� �����ϴ� �ุ ����
	: A Right outer join B: B ���̺����� ��� ����, A���̺��� �� ���ǿ� �����ϴ� �ุ ����
	: A Full outer join B: ���ǿ� �´� ���� ���� + ���ǿ� ���� �ʴ��� A,B������ �� ��� ����
	3. A Cross join B: A�� ���� * B�� ���� 
	4. Self join: ���̺�� �����ϴ� ����� �ڽ��� ��
	
*/

-- 1. inner join (equi join):
select sabun, saname, dname, loc from dept, sawon
where dept.deptno = sawon.deptno

-- ANSI-92 SQL (ǥ�� SQL): �����ϴ� ��� DBMS���� ���������� ���Ǵ� ���
select * from dept inner join sawon

select * from dept d inner join sawon s on d.deptno = s.deptno
--					 (���ι��) 		    on (��������)

-- 2. cross join: ���� ���Ǿ��� ����:
select * from dept,sawon
-- ANSI-92
select * from dept cross join sawon



-- 3. self join + inner join
select 
	s1.sabun, s1.sajob, s1.saname, 
	s2.sabun, s2.sajob, s2.saname 
from sawon s1, sawon s2
where s1.samgr = s2.sabun(+) -- (+) �ϸ� null���� �־ ���̺��� ���´�.
order by s1.sabun

-- cf) MS-SQL server
where s1.samgr * = s2.sabun

-- ANSI-92
SELECT
S1.SABUN, S1.SAJOB, S1.SANAME,
S2.SABUN, S2.SAJOB, S2.SANAME
FROM SAWON S1 LEFT OUTER JOIN SAWON S2 ON S1.SAMGR = S2.SABUN
ORDER BY S1.SABUN

-- FULL OUTER JOIN (ANSI-92)
SELECT
* 
FROM DEPT D FULL OUTER JOIN SAWON S ON D.DEPTNO = S.DEPTNO

-- sawon + gogek

select * from sawon s inner join gogek g on s.sabun = g.godam
where gobun is null
order by s.sabun

-- ��� ����� �μ���ȣ �μ��� ����ȣ ����
SELECT 
D.DEPTNO, DNAME,
S.SABUN, SANAME,
G.GOBUN, GONAME
FROM SAWON S LEFT OUTER JOIN DEPT D ON D.DEPTNO = S.SABUN -- �μ��� ����� ���� �̾���
			LEFT OUTER JOIN GOGEK G ON S.SABUN = G.GODAM -- �״��� �μ�������� ����� ������ڿ� �̾���
ORDER BY SABUN

-- ��� ����� / �μ���ȣ �μ��� / ����ȣ ���� / ����ȣ ���� / ������ȣ ������

SELECT
S1.SABUN ���, S1.SANAME �����,
D.DEPTNO �μ���ȣ, D.DNAME �μ���,
G1.GOBUN ����ȣ, G1.GONAME ����,
S2.SABUN ����ȣ, S2.SANAME ����,
G2.GOBUN ������ȣ, G2.GONAME ������
FROM SAWON S1 INNER JOIN DEPT D ON S1.DEPTNO = D.DEPTNO
			  LEFT OUTER JOIN GOGEK G1 ON S1.SABUN = G1.GODAM
			  LEFT OUTER JOIN SAWON S2 ON S1.SAMGR = S2.SABUN
			  LEFT OUTER JOIN GOGEK G2 ON S2.SABUN = G2.GODAM
ORDER BY S1.SABUN














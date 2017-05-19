CREATE DATABASE TEST

create table student(
sno varchar(10) primary key,
sname varchar(20),
sage numeric(2),
ssex varchar(5)
);
create table teacher(
tno varchar(10) primary key,
tname varchar(20)
);
create table course(
cno varchar(10),
cname varchar(20),
tno varchar(20),
constraint pk_course primary key (cno,tno)	
);
create table sc(
sno varchar(10),
cno varchar(10),
score numeric(4,2),
constraint pk_sc primary key (sno,cno)
);
--/*******��ʼ��ѧ���������******/
insert into student values ('s001','����',23,'��');
insert into student values ('s002','����',23,'��');
insert into student values ('s003','����',25,'��');
insert into student values ('s004','����',20,'Ů');
insert into student values ('s005','����',20,'Ů');
insert into student values ('s006','�',21,'��');
insert into student values ('s007','����',21,'��');
insert into student values ('s008','����',21,'Ů');
insert into student values ('s009','������',23,'Ů');
insert into student values ('s010','����',22,'Ů');
commit;
--/******************��ʼ����ʦ��***********************/
insert into teacher values ('t001', '����');
insert into teacher values ('t002', '����');
insert into teacher values ('t003', '������');
commit;
--/***************��ʼ���γ̱�****************************/
insert into course values ('c001','J2SE','t002');
insert into course values ('c002','Java Web','t002');
insert into course values ('c003','SSH','t001');
insert into course values ('c004','Oracle','t001');
insert into course values ('c005','SQL SERVER 2005','t003');
insert into course values ('c006','C#','t003');
insert into course values ('c007','JavaScript','t002');
insert into course values ('c008','DIV+CSS','t001');
insert into course values ('c009','PHP','t003');
insert into course values ('c010','EJB3.0','t002');
commit;
--/***************��ʼ���ɼ���***********************/
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9);
insert into sc values ('s003','c001',81.9);
insert into sc values ('s004','c001',60.9);
insert into sc values ('s001','c002',82.9);
insert into sc values ('s002','c002',72.9);
insert into sc values ('s003','c002',81.9);
insert into sc values ('s001','c003','59');


--1����ѯ��c001���γ̱ȡ�c002���γ̳ɼ��ߵ�����ѧ����ѧ�ţ�
SELECT A.SNO 
FROM (SELECT * FROM SC WHERE SC.CNO='C001') A,
	(SELECT * FROM SC WHERE SC.CNO='C002') B
WHERE A.SCORE>B.SCORE AND A.SNO=B.SNO

--2����ѯƽ���ɼ�����60 �ֵ�ͬѧ��ѧ�ź�ƽ���ɼ���
SELECT SNO AS 'ѧ��', AVG(SCORE) AS 'ƽ���ɼ�'
FROM SC GROUP BY SNO HAVING AVG(SCORE)>60

--3����ѯ����ͬѧ��ѧ�š�������ѡ�������ܳɼ���
SELECT
	SC.SNO AS 'ѧ��',
	(SELECT S.SNAME FROM STUDENT S WHERE S.SNO=SC.SNO) AS '����',
	COUNT(CNO) AS 'ѡ����',
	SUM(SCORE) AS '�ܳɼ�'
FROM SC
GROUP BY SC.SNO

--4����ѯ�ա���������ʦ�ĸ�����
SELECT COUNT(TNO)
FROM TEACHER T WHERE T.TNAME LIKE '��%'

--5����ѯûѧ�������ࡱ��ʦ�ε�ͬѧ��ѧ�š�������
SELECT 
	SNO AS 'ѧ��',
	SNAME AS '����'
FROM STUDENT
WHERE 
	SNO NOT IN 
	(SELECT SNO FROM SC WHERE CNO IN (SELECT CNO FROM COURSE WHERE TNO IN (SELECT TNO FROM TEACHER WHERE TNAME='����')))

--6����ѯѧ����c001������Ҳѧ����š�c002���γ̵�ͬѧ��ѧ�š�������
SELECT A.SNO AS 'ѧ��',
	S.SNAME AS '����'
FROM 
	(SELECT * FROM SC WHERE SC.CNO='C001') A,
	(SELECT * FROM SC WHERE SC.CNO='C002') B,
	STUDENT S
WHERE A.SNO=B.SNO AND S.SNO=A.SNO

--7����ѯѧ�������ࡱ��ʦ���̵����пε�ͬѧ��ѧ�š�������???????????????????????????????????
SELECT 
	SNO AS 'ѧ��',
	SNAME AS '����'
FROM STUDENT
WHERE 
	SNO IN 
	(SELECT SNO FROM SC WHERE CNO IN (SELECT CNO FROM COURSE WHERE TNO IN (SELECT TNO FROM TEACHER WHERE TNAME='����')))

--8����ѯ�γ̱�š�c002���ĳɼ��ȿγ̱�š�c001���γ̵͵�����ͬѧ��ѧ�š�������
SELECT A.SNO 
FROM (SELECT * FROM SC WHERE SC.CNO='C001') A,
	(SELECT * FROM SC WHERE SC.CNO='C002') B
WHERE A.SCORE>B.SCORE AND A.SNO=B.SNO

--9����ѯ���пγ̳ɼ�С��60 �ֵ�ͬѧ��ѧ�š�������
SELECT
	SC.SNO AS 'ѧ��',
	(SELECT S.SNAME FROM STUDENT S WHERE S.SNO=SC.SNO) AS '����'
FROM SC
WHERE SCORE<60

--10����ѯû��ѧȫ���пε�ͬѧ��ѧ�š�������
SELECT 
	SNO AS 'ѧ��',
	SNAME AS '����'
FROM STUDENT
WHERE SNO NOT IN (SELECT SNO FROM SC WHERE (SELECT COUNT(C.CNO) FROM COURSE C) IN (SELECT COUNT(CNO) FROM SC GROUP BY SNO))

--11����ѯ������һ�ſ���ѧ��Ϊ��s001����ͬѧ��ѧ��ͬ��ͬѧ��ѧ�ź�������
SELECT DISTINCT
	SNO AS 'ѧ��',
	(SELECT S.SNAME FROM STUDENT S WHERE S.SNO=SC.SNO) AS '����'
FROM SC
WHERE SNO!='S001' AND CNO IN(SELECT CNO FROM SC WHERE SNO='S001')

--12����ѯ����ѧ��ѧ��Ϊ��s001��ͬѧ����һ�ſε�����ͬѧѧ�ź�������
xxxxxxxxxxxxx

--13���ѡ�SC�����С����ࡱ��ʦ�̵Ŀεĳɼ�������Ϊ�˿γ̵�ƽ���ɼ�����������
UPDATE SC SET SCORE = (
	SELECT AVG(SCORE) FROM SC WHERE CNO IN (
SELECT CNO FROM COURSE WHERE TNO=(
SELECT TNO FROM TEACHER WHERE TNAME='����')) GROUP BY CNO)
WHERE CNO IN (SELECT CNO FROM COURSE WHERE TNO=(
SELECT TNO FROM TEACHER WHERE TNAME='����'))

--14����ѯ�͡�s001���ŵ�ͬѧѧϰ�Ŀγ���ȫ��ͬ������ͬѧѧ�ź�������
SELECT 
	S.SNO AS 'ѧ��',
	(SELECT S.SNAME FROM STUDENT S,SC WHERE S.SNO=SC.SNO) AS '����'
FROM (SELECT * FROM SC WHERE CNO IN (SELECT CNO FROM SC WHERE SNO='S001')) S
GROUP BY SNO
HAVING COUNT(CNO) = (SELECT COUNT(CNO)FROM SC WHERE SNO='S001') AND SNO!='S001'

--17����ѯ���Ƴɼ���ߺ���͵ķ֣���������ʽ��ʾ���γ�ID����߷֣���ͷ�
SELECT
	CNO AS'�γ�ID',
	MAX(SCORE) AS '��߷�',
	MIN(SCORE) AS '��ͷ�'
FROM SC GROUP BY CNO

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
--/*******初始化学生表的数据******/
insert into student values ('s001','张三',23,'男');
insert into student values ('s002','李四',23,'男');
insert into student values ('s003','吴鹏',25,'男');
insert into student values ('s004','琴沁',20,'女');
insert into student values ('s005','王丽',20,'女');
insert into student values ('s006','李波',21,'男');
insert into student values ('s007','刘玉',21,'男');
insert into student values ('s008','萧蓉',21,'女');
insert into student values ('s009','陈萧晓',23,'女');
insert into student values ('s010','陈美',22,'女');
commit;
--/******************初始化教师表***********************/
insert into teacher values ('t001', '刘阳');
insert into teacher values ('t002', '谌燕');
insert into teacher values ('t003', '胡明星');
commit;
--/***************初始化课程表****************************/
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
--/***************初始化成绩表***********************/
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9);
insert into sc values ('s003','c001',81.9);
insert into sc values ('s004','c001',60.9);
insert into sc values ('s001','c002',82.9);
insert into sc values ('s002','c002',72.9);
insert into sc values ('s003','c002',81.9);
insert into sc values ('s001','c003','59');


--1、查询“c001”课程比“c002”课程成绩高的所有学生的学号；
SELECT A.SNO 
FROM (SELECT * FROM SC WHERE SC.CNO='C001') A,
	(SELECT * FROM SC WHERE SC.CNO='C002') B
WHERE A.SCORE>B.SCORE AND A.SNO=B.SNO

--2、查询平均成绩大于60 分的同学的学号和平均成绩；
SELECT SNO AS '学号', AVG(SCORE) AS '平均成绩'
FROM SC GROUP BY SNO HAVING AVG(SCORE)>60

--3、查询所有同学的学号、姓名、选课数、总成绩；
SELECT
	SC.SNO AS '学号',
	(SELECT S.SNAME FROM STUDENT S WHERE S.SNO=SC.SNO) AS '姓名',
	COUNT(CNO) AS '选课数',
	SUM(SCORE) AS '总成绩'
FROM SC
GROUP BY SC.SNO

--4、查询姓“刘”的老师的个数；
SELECT COUNT(TNO)
FROM TEACHER T WHERE T.TNAME LIKE '刘%'

--5、查询没学过“谌燕”老师课的同学的学号、姓名；
SELECT 
	SNO AS '学号',
	SNAME AS '姓名'
FROM STUDENT
WHERE 
	SNO NOT IN 
	(SELECT SNO FROM SC WHERE CNO IN (SELECT CNO FROM COURSE WHERE TNO IN (SELECT TNO FROM TEACHER WHERE TNAME='谌燕')))

--6、查询学过“c001”并且也学过编号“c002”课程的同学的学号、姓名；
SELECT A.SNO AS '学号',
	S.SNAME AS '姓名'
FROM 
	(SELECT * FROM SC WHERE SC.CNO='C001') A,
	(SELECT * FROM SC WHERE SC.CNO='C002') B,
	STUDENT S
WHERE A.SNO=B.SNO AND S.SNO=A.SNO

--7、查询学过“谌燕”老师所教的所有课的同学的学号、姓名；???????????????????????????????????
SELECT 
	SNO AS '学号',
	SNAME AS '姓名'
FROM STUDENT
WHERE 
	SNO IN 
	(SELECT SNO FROM SC WHERE CNO IN (SELECT CNO FROM COURSE WHERE TNO IN (SELECT TNO FROM TEACHER WHERE TNAME='谌燕')))

--8、查询课程编号“c002”的成绩比课程编号“c001”课程低的所有同学的学号、姓名；
SELECT A.SNO 
FROM (SELECT * FROM SC WHERE SC.CNO='C001') A,
	(SELECT * FROM SC WHERE SC.CNO='C002') B
WHERE A.SCORE>B.SCORE AND A.SNO=B.SNO

--9、查询所有课程成绩小于60 分的同学的学号、姓名；
SELECT
	SC.SNO AS '学号',
	(SELECT S.SNAME FROM STUDENT S WHERE S.SNO=SC.SNO) AS '姓名'
FROM SC
WHERE SCORE<60

--10、查询没有学全所有课的同学的学号、姓名；
SELECT 
	SNO AS '学号',
	SNAME AS '姓名'
FROM STUDENT
WHERE SNO NOT IN (SELECT SNO FROM SC WHERE (SELECT COUNT(C.CNO) FROM COURSE C) IN (SELECT COUNT(CNO) FROM SC GROUP BY SNO))

--11、查询至少有一门课与学号为“s001”的同学所学相同的同学的学号和姓名；
SELECT DISTINCT
	SNO AS '学号',
	(SELECT S.SNAME FROM STUDENT S WHERE S.SNO=SC.SNO) AS '姓名'
FROM SC
WHERE SNO!='S001' AND CNO IN(SELECT CNO FROM SC WHERE SNO='S001')

--12、查询至少学过学号为“s001”同学所有一门课的其他同学学号和姓名；
xxxxxxxxxxxxx

--13、把“SC”表中“谌燕”老师教的课的成绩都更改为此课程的平均成绩；（不明）
UPDATE SC SET SCORE = (
	SELECT AVG(SCORE) FROM SC WHERE CNO IN (
SELECT CNO FROM COURSE WHERE TNO=(
SELECT TNO FROM TEACHER WHERE TNAME='谌燕')) GROUP BY CNO)
WHERE CNO IN (SELECT CNO FROM COURSE WHERE TNO=(
SELECT TNO FROM TEACHER WHERE TNAME='谌燕'))

--14、查询和“s001”号的同学学习的课程完全相同的其他同学学号和姓名；
SELECT 
	S.SNO AS '学号',
	(SELECT S.SNAME FROM STUDENT S,SC WHERE S.SNO=SC.SNO) AS '姓名'
FROM (SELECT * FROM SC WHERE CNO IN (SELECT CNO FROM SC WHERE SNO='S001')) S
GROUP BY SNO
HAVING COUNT(CNO) = (SELECT COUNT(CNO)FROM SC WHERE SNO='S001') AND SNO!='S001'

--17、查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分
SELECT
	CNO AS'课程ID',
	MAX(SCORE) AS '最高分',
	MIN(SCORE) AS '最低分'
FROM SC GROUP BY CNO

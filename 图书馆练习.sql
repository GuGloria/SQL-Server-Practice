CREATE DATABASE ESchool
USE ESchool
--创建BOOK:（图书表）
CREATE TABLE BOOK (
 BOOK_ID int,
 SORT VARCHAR(10),
 BOOK_NAME VARCHAR(50),
 WRITER VARCHAR(10),
 OUTPUT VARCHAR(50),
 PRICE float);

--创建READER:（读者表）
CREATE TABLE READER (
READER_ID int,
COMPANY VARCHAR(10),
NAME VARCHAR(10),
SEX VARCHAR(2),
GRADE VARCHAR(10),
ADDR VARCHAR(50));
--创建BORROW:（借阅表）

CREATE  TABLE  BORROW (
 READER_ID  int,
 BOOK_ID  int,
 BORROW_DATE  datetime)

--插入数据:
--BOOK表:
insert into BOOK values(445501,'TP3/12','数据库导论','王强','科学出版社',17.90);
insert into BOOK values(445502,'TP3/12','数据库导论','王强','科学出版社',17.90);
insert into BOOK values(445503,'TP3/12','数据库导论','王强','科学出版社',17.90);
insert into BOOK values(332211,'TP5/10','计算机基础','李伟','高等教育出版社',18.00);
insert into BOOK values(112266,'TP3/12','FoxBASE','张三','电子工业出版社',23.60);
insert into BOOK values(665544,'TS7/21','高等数学','刘明','高等教育出版社',20.00);
insert into BOOK values(114455,'TR9/12','线性代数','孙业','北京大学出版社',20.80);
insert into BOOK values(113388,'TR7/90','大学英语','胡玲','清华大学出版社',12.50);
insert into BOOK values(446601,'TP4/13','数据库基础','马凌云','人民邮电出版社',22.50);
insert into BOOK values(446602,'TP4/13','数据库基础','马凌云','人民邮电出版社',22.50);
insert into BOOK values(446603,'TP4/13','数据库基础','马凌云','人民邮电出版社',22.50);
insert into BOOK values(449901,'TP4/14','FoxPro大全','周虹','科学出版社',32.70);
insert into BOOK values(449902,'TP4/14','FoxPro大全','周虹','科学出版社',32.70);
insert into BOOK values(118801,'TP4/15','计算机网络','黄力钧','高等教育出版社',21.80);
insert into BOOK values(118802,'TP4/15','计算机网络','黄力钧','高等教育出版社',21.80);
--READER表:
insert into reader values(111,'信息系','王维利','女','教授','1号楼424');
insert into reader values(112,'财会系','李  立','男','副教授','2号楼316');
insert into reader values(113,'经济系','张  三','男','讲师','3号楼105');
insert into reader values(114,'信息系','周华发','男','讲师','1号楼316');
insert into reader values(115,'信息系','赵正义','男','工程师','1号楼224');
insert into reader values(116,'信息系','李  明','男','副教授','1号楼318');
insert into reader values(117,'计算机系','李小峰','男','助教','1号楼214');
insert into reader values(118,'计算机系','许鹏飞','男','助工','1号楼216');
insert into reader values(119,'计算机系','刘大龙','男','教授','1号楼318');
insert into reader values(120,'国际贸易','李  雪','男','副教授','4号楼506');
insert into reader values(121,'国际贸易','李  爽','女','讲师','4号楼510');
insert into reader values(122,'国际贸易','王  纯','女','讲师','4号楼512');
insert into reader values(123,'财会系','沈小霞','女','助教','2号楼202');
insert into reader values(124,'财会系','朱  海','男','讲师','2号楼210');
insert into reader values(125,'财会系','马英明','男','副教授','2号楼212');

--BORROW表:
insert into borrow values(112,445501,'3-19-2006');
insert into borrow values(125,332211,'2-12-2006');
insert into borrow values(111,445503,'8-21-2006');
insert into borrow values(112,112266,'3-14-2006');
insert into borrow values(114,665544,'10-21-2006');
insert into borrow values(120,114455,'11-2-2006');
insert into borrow values(120,118801,'10-18-2006');
insert into borrow values(119,446603,'11-12-2006');
insert into borrow values(112,449901,'10-23-2006');
insert into borrow values(115,449902,'8-21-2006');
insert into borrow values(115,118801,'9-21-2006');
insert into borrow values(118,118801,'9-10-2006');
insert into borrow values(115,449901,'10-28-2006');



--1) 找出姓李的读者姓名(NAME)和所在单位(COMPANY)。
SELECT NAME,COMPANY FROM READER WHERE NAME LIKE '李%'

--2) 列出图书库中所有藏书的书名(BOOK_NAME)及出版单位(OUTPUT)。
SELECT BOOK_NAME,OUTPUT FROM BOOK

--3) 查找“高等教育出版社”的所有图书名称(BOOK_NAME)及单价(PRICE)，结果按单价降序排序。
SELECT BOOK_NAME,PRICE FROM BOOK WHERE OUTPUT='高等教育出版社' ORDER BY PRICE DESC

--4) 查找价格介于10元和20元之间的图书种类(SORT)，结果按出版单位(OUTPUT)和单价(PRICE)升序排序。
SELECT SORT FROM BOOK WHERE PRICE BETWEEN 10 AND 20 ORDER BY OUTPUT,PRICE 

--5) 查找书名以”计算机”开头的所有图书和作者(WRITER)。
SELECT BOOK_NAME,WRITER FROM BOOK WHERE BOOK_NAME LIKE '计算机%'

--6) 检索同时借阅了总编号(BOOK_ID)为112266和449901两本书的借书证号(READER_ID)。
SELECT READER_ID FROM BORROW 
WHERE BOOK_ID=112266 AND READER_ID IN (SELECT READER_ID FROM BORROW WHERE BOOK_ID =449901)

--7)* 查找所有借了书的读者的姓名(NAME)及所在单位(COMPANY)。
SELECT NAME,COMPANY FROM READER AS R,BORROW AS W WHERE R.READER_ID=W.READER_ID

--8)* 找出李某所借所有图书的书名及借书日期(BORROW_DATE)。 
SELECT B.BOOK_NAME,W.BORROW_DATE FROM BOOK AS B,BORROW AS W 
WHERE B.BOOK_ID=W.BOOK_ID AND W.READER_ID IN (SELECT READER_ID FROM READER WHERE NAME LIKE '李%')

--9)* 无重复地查询2006年10月 以后借书的读者借书证号(READER_ID)、姓名和单位。
SELECT DISTINCT R.READER_ID , NAME , COMPANY FROM BORROW W , READER R 
WHERE W.READER_ID = R.READER_ID AND W.BORROW_DATE > '10-1-2006'

--10)* 找出借阅了<FoxPro大全>一书的借书证号。
SELECT DISTINCT READER_ID FROM BORROW AS W,BOOK AS B
WHERE B.BOOK_ID=W.BOOK_ID AND B.BOOK_NAME='FoxPro大全'

--11) 找出与”赵正义”在同一天借书的读者姓名、所在单位及借书日期 。
SELECT R.NAME,R.COMPANY,W.BORROW_DATE 
FROM READER AS R,BORROW AS W
WHERE R.READER_ID=W.READER_ID AND 
	R.NAME != '赵正义' AND
	W.BORROW_DATE IN (SELECT BORROW_DATE FROM BORROW AS W,READER AS R WHERE R.READER_ID=W.READER_ID AND R.NAME='赵正义')

--12) 查询2006年7月以后没有借书的读者借书证号、姓名及单位。
SELECT DISTINCT R.READER_ID , NAME , COMPANY FROM BORROW W , READER R WHERE R.READER_ID NOT IN (
SELECT R.READER_ID FROM BORROW W , READER R WHERE W.READER_ID = R.READER_ID AND W.BORROW_DATE > '7-1-2006')

--13) 求”科学出版社”图书的最高单价、最低单价、平均单价。
SELECT 
	MAX(PRICE) AS '最高单价' ,
	MIN(PRICE) AS '最低单价',
	AVG(PRICE) AS '平均单价'
FROM BOOK WHERE OUTPUT='科学出版社'

--14)* 求”信息系”当前借阅图书的读者人次数。
SELECT COUNT(W.READER_ID) FROM BORROW AS W,READER AS R
WHERE W.READER_ID=R.READER_ID AND R.READER_ID IN (SELECT READER_ID FROM READER WHERE COMPANY='信息系')

--15) 求出各个出版社图书的最高价格、最低价格和总册数。
SELECT 
	OUTPUT AS '出版社',
	MAX(PRICE) AS '最高价格' ,
	MIN(PRICE) AS '最低价格',
	COUNT(PRICE) AS '总册数'
FROM BOOK GROUP BY OUTPUT

--16) 分别找出各单位当前借阅图书的读者人数及所在单位。
SELECT 
	R.COMPANY AS '所在单位',
	COUNT(DISTINCT R.READER_ID) AS '人数'
FROM READER R,BORROW W
WHERE R.READER_ID=W.READER_ID AND W.READER_ID IN(SELECT W.READER_ID FROM READER R,BORROW W WHERE R.READER_ID=W.READER_ID)
GROUP BY COMPANY

--17)* 找出当前至少借阅了2本图书(大于等于2本)的读者姓名及其所在单位。 
SELECT NAME,COMPANY
FROM READER R,BORROW W
WHERE R.READER_ID=W.READER_ID GROUP BY NAME,COMPANY HAVING COUNT(R.READER_ID)>=2

--18) 分别找出借书人次数多于1人次的单位及人次数。 
SELECT 
	COMPANY AS '所在单位',
	COUNT(R.READER_ID) AS '人次数'
FROM READER R,BORROW W
WHERE R.READER_ID=W.READER_ID AND W.READER_ID IN(SELECT W.READER_ID FROM READER R,BORROW W WHERE R.READER_ID=W.READER_ID)
GROUP BY COMPANY 

--19) 找出藏书中各个出版单位的名称、每个出版社的书籍的总册数(每种可能有多册)、书的价值总额。
SELECT
	OUTPUT AS'出版单位',
	COUNT(BOOK_NAME) AS '总册数',
	SUM(PRICE) AS '价值总额'
FROM BOOK
GROUP BY OUTPUT
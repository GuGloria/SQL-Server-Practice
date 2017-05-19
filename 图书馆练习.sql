CREATE DATABASE ESchool
USE ESchool
--����BOOK:��ͼ���
CREATE TABLE BOOK (
 BOOK_ID int,
 SORT VARCHAR(10),
 BOOK_NAME VARCHAR(50),
 WRITER VARCHAR(10),
 OUTPUT VARCHAR(50),
 PRICE float);

--����READER:�����߱�
CREATE TABLE READER (
READER_ID int,
COMPANY VARCHAR(10),
NAME VARCHAR(10),
SEX VARCHAR(2),
GRADE VARCHAR(10),
ADDR VARCHAR(50));
--����BORROW:�����ı�

CREATE  TABLE  BORROW (
 READER_ID  int,
 BOOK_ID  int,
 BORROW_DATE  datetime)

--��������:
--BOOK��:
insert into BOOK values(445501,'TP3/12','���ݿ⵼��','��ǿ','��ѧ������',17.90);
insert into BOOK values(445502,'TP3/12','���ݿ⵼��','��ǿ','��ѧ������',17.90);
insert into BOOK values(445503,'TP3/12','���ݿ⵼��','��ǿ','��ѧ������',17.90);
insert into BOOK values(332211,'TP5/10','���������','��ΰ','�ߵȽ���������',18.00);
insert into BOOK values(112266,'TP3/12','FoxBASE','����','���ӹ�ҵ������',23.60);
insert into BOOK values(665544,'TS7/21','�ߵ���ѧ','����','�ߵȽ���������',20.00);
insert into BOOK values(114455,'TR9/12','���Դ���','��ҵ','������ѧ������',20.80);
insert into BOOK values(113388,'TR7/90','��ѧӢ��','����','�廪��ѧ������',12.50);
insert into BOOK values(446601,'TP4/13','���ݿ����','������','�����ʵ������',22.50);
insert into BOOK values(446602,'TP4/13','���ݿ����','������','�����ʵ������',22.50);
insert into BOOK values(446603,'TP4/13','���ݿ����','������','�����ʵ������',22.50);
insert into BOOK values(449901,'TP4/14','FoxPro��ȫ','�ܺ�','��ѧ������',32.70);
insert into BOOK values(449902,'TP4/14','FoxPro��ȫ','�ܺ�','��ѧ������',32.70);
insert into BOOK values(118801,'TP4/15','���������','������','�ߵȽ���������',21.80);
insert into BOOK values(118802,'TP4/15','���������','������','�ߵȽ���������',21.80);
--READER��:
insert into reader values(111,'��Ϣϵ','��ά��','Ů','����','1��¥424');
insert into reader values(112,'�ƻ�ϵ','��  ��','��','������','2��¥316');
insert into reader values(113,'����ϵ','��  ��','��','��ʦ','3��¥105');
insert into reader values(114,'��Ϣϵ','�ܻ���','��','��ʦ','1��¥316');
insert into reader values(115,'��Ϣϵ','������','��','����ʦ','1��¥224');
insert into reader values(116,'��Ϣϵ','��  ��','��','������','1��¥318');
insert into reader values(117,'�����ϵ','��С��','��','����','1��¥214');
insert into reader values(118,'�����ϵ','������','��','����','1��¥216');
insert into reader values(119,'�����ϵ','������','��','����','1��¥318');
insert into reader values(120,'����ó��','��  ѩ','��','������','4��¥506');
insert into reader values(121,'����ó��','��  ˬ','Ů','��ʦ','4��¥510');
insert into reader values(122,'����ó��','��  ��','Ů','��ʦ','4��¥512');
insert into reader values(123,'�ƻ�ϵ','��Сϼ','Ů','����','2��¥202');
insert into reader values(124,'�ƻ�ϵ','��  ��','��','��ʦ','2��¥210');
insert into reader values(125,'�ƻ�ϵ','��Ӣ��','��','������','2��¥212');

--BORROW��:
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



--1) �ҳ�����Ķ�������(NAME)�����ڵ�λ(COMPANY)��
SELECT NAME,COMPANY FROM READER WHERE NAME LIKE '��%'

--2) �г�ͼ��������в��������(BOOK_NAME)�����浥λ(OUTPUT)��
SELECT BOOK_NAME,OUTPUT FROM BOOK

--3) ���ҡ��ߵȽ��������硱������ͼ������(BOOK_NAME)������(PRICE)����������۽�������
SELECT BOOK_NAME,PRICE FROM BOOK WHERE OUTPUT='�ߵȽ���������' ORDER BY PRICE DESC

--4) ���Ҽ۸����10Ԫ��20Ԫ֮���ͼ������(SORT)����������浥λ(OUTPUT)�͵���(PRICE)��������
SELECT SORT FROM BOOK WHERE PRICE BETWEEN 10 AND 20 ORDER BY OUTPUT,PRICE 

--5) ���������ԡ����������ͷ������ͼ�������(WRITER)��
SELECT BOOK_NAME,WRITER FROM BOOK WHERE BOOK_NAME LIKE '�����%'

--6) ����ͬʱ�������ܱ��(BOOK_ID)Ϊ112266��449901������Ľ���֤��(READER_ID)��
SELECT READER_ID FROM BORROW 
WHERE BOOK_ID=112266 AND READER_ID IN (SELECT READER_ID FROM BORROW WHERE BOOK_ID =449901)

--7)* �������н�����Ķ��ߵ�����(NAME)�����ڵ�λ(COMPANY)��
SELECT NAME,COMPANY FROM READER AS R,BORROW AS W WHERE R.READER_ID=W.READER_ID

--8)* �ҳ���ĳ��������ͼ�����������������(BORROW_DATE)�� 
SELECT B.BOOK_NAME,W.BORROW_DATE FROM BOOK AS B,BORROW AS W 
WHERE B.BOOK_ID=W.BOOK_ID AND W.READER_ID IN (SELECT READER_ID FROM READER WHERE NAME LIKE '��%')

--9)* ���ظ��ز�ѯ2006��10�� �Ժ����Ķ��߽���֤��(READER_ID)�������͵�λ��
SELECT DISTINCT R.READER_ID , NAME , COMPANY FROM BORROW W , READER R 
WHERE W.READER_ID = R.READER_ID AND W.BORROW_DATE > '10-1-2006'

--10)* �ҳ�������<FoxPro��ȫ>һ��Ľ���֤�š�
SELECT DISTINCT READER_ID FROM BORROW AS W,BOOK AS B
WHERE B.BOOK_ID=W.BOOK_ID AND B.BOOK_NAME='FoxPro��ȫ'

--11) �ҳ��롱�����塱��ͬһ�����Ķ������������ڵ�λ���������� ��
SELECT R.NAME,R.COMPANY,W.BORROW_DATE 
FROM READER AS R,BORROW AS W
WHERE R.READER_ID=W.READER_ID AND 
	R.NAME != '������' AND
	W.BORROW_DATE IN (SELECT BORROW_DATE FROM BORROW AS W,READER AS R WHERE R.READER_ID=W.READER_ID AND R.NAME='������')

--12) ��ѯ2006��7���Ժ�û�н���Ķ��߽���֤�š���������λ��
SELECT DISTINCT R.READER_ID , NAME , COMPANY FROM BORROW W , READER R WHERE R.READER_ID NOT IN (
SELECT R.READER_ID FROM BORROW W , READER R WHERE W.READER_ID = R.READER_ID AND W.BORROW_DATE > '7-1-2006')

--13) �󡱿�ѧ�����硱ͼ�����ߵ��ۡ���͵��ۡ�ƽ�����ۡ�
SELECT 
	MAX(PRICE) AS '��ߵ���' ,
	MIN(PRICE) AS '��͵���',
	AVG(PRICE) AS 'ƽ������'
FROM BOOK WHERE OUTPUT='��ѧ������'

--14)* ����Ϣϵ����ǰ����ͼ��Ķ����˴�����
SELECT COUNT(W.READER_ID) FROM BORROW AS W,READER AS R
WHERE W.READER_ID=R.READER_ID AND R.READER_ID IN (SELECT READER_ID FROM READER WHERE COMPANY='��Ϣϵ')

--15) �������������ͼ�����߼۸���ͼ۸���ܲ�����
SELECT 
	OUTPUT AS '������',
	MAX(PRICE) AS '��߼۸�' ,
	MIN(PRICE) AS '��ͼ۸�',
	COUNT(PRICE) AS '�ܲ���'
FROM BOOK GROUP BY OUTPUT

--16) �ֱ��ҳ�����λ��ǰ����ͼ��Ķ������������ڵ�λ��
SELECT 
	R.COMPANY AS '���ڵ�λ',
	COUNT(DISTINCT R.READER_ID) AS '����'
FROM READER R,BORROW W
WHERE R.READER_ID=W.READER_ID AND W.READER_ID IN(SELECT W.READER_ID FROM READER R,BORROW W WHERE R.READER_ID=W.READER_ID)
GROUP BY COMPANY

--17)* �ҳ���ǰ���ٽ�����2��ͼ��(���ڵ���2��)�Ķ��������������ڵ�λ�� 
SELECT NAME,COMPANY
FROM READER R,BORROW W
WHERE R.READER_ID=W.READER_ID GROUP BY NAME,COMPANY HAVING COUNT(R.READER_ID)>=2

--18) �ֱ��ҳ������˴�������1�˴εĵ�λ���˴����� 
SELECT 
	COMPANY AS '���ڵ�λ',
	COUNT(R.READER_ID) AS '�˴���'
FROM READER R,BORROW W
WHERE R.READER_ID=W.READER_ID AND W.READER_ID IN(SELECT W.READER_ID FROM READER R,BORROW W WHERE R.READER_ID=W.READER_ID)
GROUP BY COMPANY 

--19) �ҳ������и������浥λ�����ơ�ÿ����������鼮���ܲ���(ÿ�ֿ����ж��)����ļ�ֵ�ܶ
SELECT
	OUTPUT AS'���浥λ',
	COUNT(BOOK_NAME) AS '�ܲ���',
	SUM(PRICE) AS '��ֵ�ܶ�'
FROM BOOK
GROUP BY OUTPUT

--��ѯ�������γ���߷ֵ�ѧԱ��
SELECT name 
FROM baseuser AS b ,score AS s 
WHERE b.id=s.uid AND 
	s.score=(
		SELECT MAX(score) FROM score AS s WHERE sid=(SELECT id FROM syllabus WHERE name='�������'))
	AND s.sid=(SELECT id FROM syllabus WHERE name='�������')

--��ѯ�������γ���ͷֵ�ѧԱ��
SELECT name 
FROM baseuser AS b ,score AS s 
WHERE b.id=s.uid AND 
	s.score=(
		SELECT MIN(score) FROM score AS s WHERE sid=(SELECT id FROM syllabus WHERE name='�������'))
	AND s.sid=(SELECT id FROM syllabus WHERE name='�������')

--��ѯ��ͷֵĿ�Ŀ
SELECT name FROM syllabus AS s,score AS e
WHERE 
	s.id=e.sid AND 
	e.sid=(SELECT sid FROM score WHERE score=(SELECT MIN(score) AS '��ͷ�' FROM score))AND 
	e.score=(SELECT MIN(score) AS '��ͷ�' FROM score)

--��ѯ��߷ֵĿ�Ŀ
SELECT name FROM syllabus AS s,score AS e
WHERE 
	s.id=e.sid AND 
	e.sid IN (SELECT sid FROM score WHERE score = (SELECT MAX(score) AS '��߷�' FROM score))AND 
	e.score = (SELECT MAX(score) AS '��߷�' FROM score)

--��ѯDB���Ե�������
SELECT COUNT(s.id) AS '������' FROM score AS s,syllabus AS u 
WHERE 
	s.sid =u.id AND
	u.id=(SELECT id FROM syllabus WHERE name='DB')

--��ѯDB���ܳɼ�
SELECT SUM(score) AS '�ܷ�' FROM score AS s,syllabus AS u 
WHERE 
	s.sid =u.id AND
	u.id=(SELECT id FROM syllabus WHERE name='DB')

--��ѯ�������ܳɼ�
SELECT SUM(score) AS '�ܷ�' FROM score AS s,baseuser AS b
WHERE 
	b.id=s.uid AND
	b.id=(SELECT id FROM baseuser WHERE name='����')

--��ѯ�������Ż�����ƽ���ɼ�
SELECT AVG(score) AS 'ƽ���ɼ�' FROM score AS s,syllabus AS u  
WHERE
	s.sid =u.id AND
	u.id=(SELECT id FROM syllabus WHERE name='DB')

--��ѯƽ���ɼ���ߵ���
SELECT DISTINCT name FROM baseuser AS b,score AS s
WHERE b.id=s.uid AND s.uid=(
SELECT TOP 1 uid FROM score GROUP BY uid ORDER BY AVG(score) DESC)

--ÿһ�Ƶ�ƽ����
SELECT AVG(score) AS 'ƽ����' FROM score GROUP BY sid

--ÿһ�Ƶ���߷�
SELECT MAX(score) AS '��߷�' FROM score GROUP BY sid

--ƽ���ɼ�С��60����
SELECT uid FROM score GROUP BY uid HAVING AVG(score)<60

--�ܷ���ߵĿ�Ŀ��
SELECT TOP 1 sid,SUM(score) FROM score GROUP BY sid ORDER BY SUM(score)

--��Ů����
SELECT 
(SELECT COUNT(sex) FROM students WHERE sex='��')/
(SELECT COUNT(sex) FROM students WHERE sex='Ů')
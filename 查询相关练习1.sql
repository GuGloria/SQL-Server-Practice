--��ѯ����java��ʦ
SELECT
	 (SELECT name FROM baseuser AS b WHERE b.id=t.uid) AS '��ʦ��'
FROM 
	teacher AS t 
WHERE 
	subject_id= 
		(SELECT id FROM subject WHERE sname='JAVA')

--��ѯ���г�����ʦ������
SELECT
	 (SELECT name FROM baseuser AS b WHERE b.id=t.uid) AS '��ʦ��'
FROM 
	teacher AS t 
WHERE 
	type_id= 
		(SELECT id FROM type WHERE type='������ʦ')

--��ʾ���н�ʦ�����͡��绰��qq�����ơ�����
SELECT 
	(SELECT type FROM type AS p WHERE p.id=t.type_id ) AS '����',
	tel AS '�绰',
	qq AS 'qq',
	(SELECT sname FROM subject AS s WHERE s.id=t.subject_id) AS '����',
	(SELECT name FROM baseuser AS b WHERE b.id=t.uid) AS '����'
FROM teacher AS t

--��ʾ����Ů��������
SELECT 
	(SELECT name FROM baseuser AS b WHERE b.id=s.uid) AS '����'
FROM students as s
WHERE sex='Ů'

--��ʾ����������Ŀ��������󡯣��ɼ�70�����ϵ�ѧԱ
SELECT 
	(SELECT name FROM baseuser AS b WHERE b.id=s.uid)AS '����'
FROM score AS s
WHERE sid=(SELECT id FROM syllabus WHERE name='�������') AND score > 70

--��ʾ����Ŀ��ѧԱ�����ɼ�
SELECT
	(SELECT name FROM syllabus AS y WHERE y.id=s.sid) AS '��Ŀ',
	(SELECT name FROM baseuser AS b WHERE b.id=s.uid) AS 'ѧԱ��',
	score
FROM score AS s

--��ʾ����������Ŀ��DB�� ��ѧԱ�����ɼ�
SELECT
	(SELECT name FROM baseuser AS b WHERE b.id=s.uid) AS 'ѧԱ��',
	score
FROM score AS s
WHERE sid=(SELECT id FROM syllabus WHERE name='DB')
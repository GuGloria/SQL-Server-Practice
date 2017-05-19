--查询所有java讲师
SELECT
	 (SELECT name FROM baseuser AS b WHERE b.id=t.uid) AS '讲师名'
FROM 
	teacher AS t 
WHERE 
	subject_id= 
		(SELECT id FROM subject WHERE sname='JAVA')

--查询所有初级讲师的名字
SELECT
	 (SELECT name FROM baseuser AS b WHERE b.id=t.uid) AS '讲师名'
FROM 
	teacher AS t 
WHERE 
	type_id= 
		(SELECT id FROM type WHERE type='初级讲师')

--显示所有讲师的类型、电话、qq、主科、名字
SELECT 
	(SELECT type FROM type AS p WHERE p.id=t.type_id ) AS '类型',
	tel AS '电话',
	qq AS 'qq',
	(SELECT sname FROM subject AS s WHERE s.id=t.subject_id) AS '主科',
	(SELECT name FROM baseuser AS b WHERE b.id=t.uid) AS '名字'
FROM teacher AS t

--显示所有女生的名字
SELECT 
	(SELECT name FROM baseuser AS b WHERE b.id=s.uid) AS '姓名'
FROM students as s
WHERE sex='女'

--显示，条件：科目‘面向对象’，成绩70分以上的学员
SELECT 
	(SELECT name FROM baseuser AS b WHERE b.id=s.uid)AS '姓名'
FROM score AS s
WHERE sid=(SELECT id FROM syllabus WHERE name='面向对象') AND score > 70

--显示，课目，学员名，成绩
SELECT
	(SELECT name FROM syllabus AS y WHERE y.id=s.sid) AS '课目',
	(SELECT name FROM baseuser AS b WHERE b.id=s.uid) AS '学员名',
	score
FROM score AS s

--显示，条件：课目‘DB’ 。学员名，成绩
SELECT
	(SELECT name FROM baseuser AS b WHERE b.id=s.uid) AS '学员名',
	score
FROM score AS s
WHERE sid=(SELECT id FROM syllabus WHERE name='DB')

--查询面向对象课程最高分的学员名
SELECT name 
FROM baseuser AS b ,score AS s 
WHERE b.id=s.uid AND 
	s.score=(
		SELECT MAX(score) FROM score AS s WHERE sid=(SELECT id FROM syllabus WHERE name='面向对象'))
	AND s.sid=(SELECT id FROM syllabus WHERE name='面向对象')

--查询面向对象课程最低分的学员名
SELECT name 
FROM baseuser AS b ,score AS s 
WHERE b.id=s.uid AND 
	s.score=(
		SELECT MIN(score) FROM score AS s WHERE sid=(SELECT id FROM syllabus WHERE name='面向对象'))
	AND s.sid=(SELECT id FROM syllabus WHERE name='面向对象')

--查询最低分的科目
SELECT name FROM syllabus AS s,score AS e
WHERE 
	s.id=e.sid AND 
	e.sid=(SELECT sid FROM score WHERE score=(SELECT MIN(score) AS '最低分' FROM score))AND 
	e.score=(SELECT MIN(score) AS '最低分' FROM score)

--查询最高分的科目
SELECT name FROM syllabus AS s,score AS e
WHERE 
	s.id=e.sid AND 
	e.sid IN (SELECT sid FROM score WHERE score = (SELECT MAX(score) AS '最高分' FROM score))AND 
	e.score = (SELECT MAX(score) AS '最高分' FROM score)

--查询DB考试的总人数
SELECT COUNT(s.id) AS '总人数' FROM score AS s,syllabus AS u 
WHERE 
	s.sid =u.id AND
	u.id=(SELECT id FROM syllabus WHERE name='DB')

--查询DB的总成绩
SELECT SUM(score) AS '总分' FROM score AS s,syllabus AS u 
WHERE 
	s.sid =u.id AND
	u.id=(SELECT id FROM syllabus WHERE name='DB')

--查询张三的总成绩
SELECT SUM(score) AS '总分' FROM score AS s,baseuser AS b
WHERE 
	b.id=s.uid AND
	b.id=(SELECT id FROM baseuser WHERE name='张三')

--查询程序入门基础的平均成绩
SELECT AVG(score) AS '平均成绩' FROM score AS s,syllabus AS u  
WHERE
	s.sid =u.id AND
	u.id=(SELECT id FROM syllabus WHERE name='DB')

--查询平均成绩最高的人
SELECT DISTINCT name FROM baseuser AS b,score AS s
WHERE b.id=s.uid AND s.uid=(
SELECT TOP 1 uid FROM score GROUP BY uid ORDER BY AVG(score) DESC)

--每一科的平均分
SELECT AVG(score) AS '平均分' FROM score GROUP BY sid

--每一科的最高分
SELECT MAX(score) AS '最高分' FROM score GROUP BY sid

--平均成绩小于60的人
SELECT uid FROM score GROUP BY uid HAVING AVG(score)<60

--总分最高的科目名
SELECT TOP 1 sid,SUM(score) FROM score GROUP BY sid ORDER BY SUM(score)

--男女比例
SELECT 
(SELECT COUNT(sex) FROM students WHERE sex='男')/
(SELECT COUNT(sex) FROM students WHERE sex='女')
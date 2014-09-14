--Q1
SELECT name
FROM Highschooler
WHERE ID IN (SELECT ID1 FROM (Friend JOIN Highschooler ON FRIEND.ID2=Highschooler.ID) WHERE name='Gabriel');


--Q2
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Highschooler H1 JOIN Likes ON (H1.ID = Likes.ID1) JOIN Highschooler H2 ON(H2.ID = Likes.ID2)
WHERE (H1.grade-H2.grade)>=2;

--Q3
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Highschooler H1, Highschooler H2,
(SELECT * FROM Likes
INTERSECT
SELECT ID2, ID1 FROM Likes) AS mutualLikes
WHERE H1.ID = mutualLikes.ID1 AND H2.ID = mutualLikes.ID2 AND H1.ID<H2.ID
ORDER BY H1.name, H2.name;

--Q4
SELECT name, grade
FROM (SELECT H1.name AS name, H1.grade AS grade, H2.name AS fname, H2.grade AS fgrade
FROM Highschooler H1, Highschooler H2, Friend
WHERE (H1.ID = Friend.ID1) AND (H2.ID = Friend.ID2)) T
GROUP BY 1, 2
HAVING min(fgrade)=max(fgrade)
ORDER BY grade, name;

--Q5
SELECT name, grade
FROM Highschooler JOIN Likes ON (ID=ID2)
GROUP BY name, grade
HAVING COUNT(*)>1;
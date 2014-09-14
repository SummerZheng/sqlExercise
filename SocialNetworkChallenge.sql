--Q1
--Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade. 
SELECT name, grade
FROM HIghschooler
WHERE ID NOT IN (SELECT ID1 FROM Likes UNION SELECT ID2 FROM Likes)
ORDER BY grade, name;

--Q2
--For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C
SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM Friend F1, Friend F2,
     ((SELECT ID1, ID2 FROM Likes)
      EXCEPT
     (SELECT ID1, ID2 FROM Friend)) L, 
     Highschooler H1, Highschooler H2, Highschooler H3
WHERE F1.ID1 = L.ID1 AND F2.ID1 = L.ID2 AND F1.ID2 = F2.ID2
      AND F1.ID1=H1.ID AND F2.ID1=H2.ID AND F1.ID2 = H3.ID;


--Q3
--Find the difference between the number of students in the school and the number of different first names.
SELECT (COUNT(*)-COUNT(DISTINCT name)) AS diff
FROM Highschooler;

--Q4
--What is the average number of friends per student? (Your result should be just one number.) 
SELECT AVG(avgF)
FROM (SELECT COUNT(ID2) AS avgF FROM Friend GROUP BY ID1) F; 

--Q5
--Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend
SELECT COUNT(*)
FROM  ((SELECT F1.ID2 FROM
       Highschooler H JOIN Friend F1 ON (H.ID=F1.ID1 AND H.name='Cassandra'))
       UNION
       (SELECT F2.ID2 FROM
       Highschooler H JOIN Friend F1 ON (H.ID=F1.ID1 AND H.name='Cassandra') JOIN Friend F2 ON (F1.ID2 = F2.ID1))
       EXCEPT
       (SELECT ID FROM Highschooler H JOIN Friend F1 ON (H.ID=F1.ID1 AND H.name='Cassandra') )) F;

--Q6
--Find the name and grade of the student(s) with the greatest number of friends. 
SELECT DISTINCT name, grade
FROM Highschooler JOIN Friend ON (ID=ID1)
WHERE ID IN (SELECT ID1
	     FROM Friend 
             GROUP BY ID1
             HAVING COUNT(*) = (SELECT MAX(nFriend) FROM 
			       (SELECT COUNT(*) AS nFriend FROM Friend GROUP BY ID1) T));


SELECT name, grade
FROM Highschooler JOIN Friend ON (ID=ID1)
GROUP BY ID, name, grade
HAVING COUNT(*) = (SELECT MAX(nFriend) FROM 
	          (SELECT COUNT(*) AS nFriend FROM Friend GROUP BY ID1) T);
			 

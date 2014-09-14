/*
--Q1
--It's time for the seniors to graduate. Remove all 12th graders from Highschooler
DELETE FROM Highschooler
WHERE grade=12; 

--Q2  
--If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. 
DELETE FROM Likes
WHERE EXISTS (SELECT * FROM ((SELECT ID1, ID2 FROM Likes)
			    INTERSECT
			    (SELECT ID1, ID2 FROM Friend)
			     EXCEPT
			    (SELECT ID2, ID1 FROM Likes)) T
	     WHERE Likes.ID1 = T.ID1 AND Likes.ID2=T.ID2);
*/

--Q3
--For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself.
INSERT INTO Friend
(SELECT F1.ID1, F2.ID2
FROM Friend F1 JOIN Friend F2 ON (F1.ID2=F2.ID1)
WHERE F1.ID1<>F2.ID2) 
EXCEPT (SELECT * FROM Friend)

--Q1
SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Highschooler H1 JOIN Likes ON (H1.ID = Likes.ID1) JOIN Highschooler H2 ON(H2.ID = Likes.ID2)
WHERE H2.ID NOT IN (SELECT ID1 FROM Likes);

--Q2
SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM Likes L1 JOIN Likes L2 ON (L1.ID2=L2.ID1) JOIN
     Highschooler H1 ON (H1.ID = L1.ID1) JOIN 
     Highschooler H2 ON (H2.ID = L1.ID2) JOIN
     Highschooler H3 ON (H3.ID = L2.ID2)
WHERE L2.ID2<>L1.ID1;

--Q3
SELECT DISTINCT C1.name, C1.grade
FROM (Highschooler H1 JOIN Friend ON (ID = ID1)) C1
WHERE C1.grade NOT IN (SELECT grade FROM (Highschooler H2 JOIN Friend ON (ID = ID2)) C2
                       WHERE C1.ID1 = C2.ID1); 

--Q1
SELECT title, (MAX(stars)-MIN(stars)) AS spread
FROM Rating JOIN Movie USING(mID)
GROUP BY title
ORDER BY spread DESC, title;

--Q2
SELECT AVG(old_movie_rate) - AVG(new_movie_rate) AS dif_star
FROM (SELECT avg(stars) AS old_movie_rate FROM Rating JOIN Movie USING(mID) WHERE year < 1980 GROUP BY mID) oldMovie,
     (SELECT avg(stars) AS new_movie_rate FROM Rating JOIN Movie USING(mID) WHERE year >= 1980 GROUP BY mID) newMovie;


--Q3 with count
SELECT director, title
FROM Movie
WHERE director IN (SELECT director FROM MOVIE GROUP BY director HAVING Count(*)>1)
ORDER BY director, title;

--Q3 without count
SELECT m1.director, m1.title
FROM Movie m1 JOIN Movie m2
     ON m1.director = m2.director AND m1.title<>m2.title
ORDER BY m1.director, m1.title;

--Q3 without count2
SELECT director, title
FROM Movie m1
WHERE director IN (SELECT director FROM MOVIE m2 WHERE m1.director = m2.director AND m1.title<>m2.title)
ORDER BY director, title;

--Q4
SELECT title, avg(stars) AS avgStar
FROM Movie JOIN Rating USING(mID)
GROUP BY title
HAVING avg(stars) >= ALL (SELECT AVG(stars) FROM Rating GROUP BY mID);

--Q5
SELECT title, avg(stars) AS avgStar
FROM Movie JOIN Rating USING(mID)
GROUP BY title
HAVING avg(stars) = (SELECT MIN(avgRate) FROM
                    (SELECT AVG(stars) AS avgRate FROM Rating GROUP BY mID) T);

--Q6
SELECT DISTINCT R.director, R.title, hr
FROM (SELECT director, MAX(stars) AS hr
FROM Movie JOIN Rating USING(mID)
GROUP BY 1) AS T, (Rating JOIN Movie USING(mID)) AS R
WHERE T.director = R.director AND stars = hr;

/*
select distinct director, title, stars
from
(movie join rating using(mID)) MR1
where director is not null and
      MR1.stars >= (select max(stars) from (movie join rating using(mID)) MR2
      		   	   where MR2.director = MR1.director);
*/
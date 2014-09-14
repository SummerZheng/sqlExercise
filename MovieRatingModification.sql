--Q1
--Add the reviewer Roger Ebert to your database, with an rID of 209. 
INSERT INTO Reviewer
VALUES(209, 'Roger Ebert');


--Q2
--Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL.
INSERT INTO Rating
SELECT rID, mID, 5, NULL
FROM (SELECT rID FROM Reviewer WHERE name = 'James Cameron') R, Movie;


--Q3
--For all movies that have an average rating of 4 stars or higher, add 25 to the release year
UPDATE Movie
SET year = year+25
WHERE mID IN (SELECT mID
              FROM Rating
              GROUP BY mID
              HAVING AVG(stars)>=4);


--Q4  
--Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars. 
DELETE FROM Rating
WHERE stars<4 AND mID NOT IN (SELECT mID
                          FROM Movie NATURAL JOIN Rating 
                          WHERE year BETWEEN 1970 AND 2000)

select * from review;
create or replace view review as 
SELECT
    title,
    genre,
    CAST(user_rating AS DECIMAL(3,1)) AS cleaned_user_rating,
    number_of_votes,
    runtime_minutes,
    original_year_string,
    summary,
    stars,
    certificate,
    metascore,
    gross,
    episode,
    episode_title,
    CASE
        WHEN CAST(user_rating AS DECIMAL(3,1)) >= 9.0 THEN 'Excellent'
        WHEN CAST(user_rating AS DECIMAL(3,1)) >= 8.0 THEN 'Very Good'
        WHEN CAST(user_rating AS DECIMAL(3,1)) >= 7.0 THEN 'Good'
        WHEN CAST(user_rating AS DECIMAL(3,1)) >= 6.0 THEN 'Average'
        WHEN CAST(user_rating AS DECIMAL(3,1)) < 6.0 THEN 'Poor'
        ELSE 'No Rating'
    END AS review_category
FROM
    anime_imdb_ratings_1;
    
    
    CREATE TABLE  TEST1 (FNAME VARCHAR(255), LNAME VARCHAR(255), SSN BIGINT, PHN1 BIGINT, PHN2 BIGINT, ST VARCHAR(255) );

INSERT INTO TEST1 (FNAME , LNAME , SSN , PHN1 , PHN2 , ST  ) VALUES ("SA",'WAL',1234,8974561521,null,'TX') ;

INSERT INTO TEST1 (FNAME , LNAME , SSN , PHN1 , PHN2 , ST  ) VALUES ('S','W',12345,NULL,null,'TX');


WITH 
T1 AS (SELECT * FROM TEST1 WHERE PHN1 IS NOT NULL),

T2 AS (SELECT * FROM TEST1 WHERE PHN2 IS NOT NULL),

T3 AS (SELECT T1.FNAME, T1.LNAME,T1.SSN, IFNULL(T1.PHN1,T2.PHN1) AS P1,  IFNULL(T1.PHN2,T2.PHN2) AS P2, T1.ST 

FROM T1 JOIN T2 ON T1.FNAME = T2.FNAME AND T1.LNAME = T2.LNAME AND T1.SSN = T2.SSN AND T1.ST = T2.ST)

SELECT DISTINCT FNAME, LNAME, SSN, P1, P2, ST FROM T3;

select * from test1;




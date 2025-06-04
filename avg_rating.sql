create or replace view avg_user_rating as 
SELECT
    start_year,
    AVG(CAST(user_rating AS DECIMAL(3,1))) AS average_user_rating 
FROM
    anime_imdb_ratings_1
WHERE
    user_rating IS NOT NULL
    AND user_rating REGEXP '^[0-9]+\\.?[0-9]*$'
    AND start_year IS NOT NULL
    AND start_year REGEXP '[0-9]{4}'
GROUP BY
    start_year
ORDER BY
    start_year ASC;
    
select * from avg_user_rating;


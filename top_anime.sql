create or replace view top_anime as
 SELECT
    title,
    user_rating,
    number_of_votes 
FROM
    anime_imdb_ratings_1
WHERE
    user_rating IS NOT NULL
    AND user_rating REGEXP '^[0-9]+\\.?[0-9]*$' 
    AND CAST(REPLACE(number_of_votes, ',', '') AS UNSIGNED) >= 1000 
ORDER BY
    user_rating DESC
;

select * from top_anime;
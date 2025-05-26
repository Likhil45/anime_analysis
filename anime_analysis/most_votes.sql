create or replace view most_voted as 
SELECT
    title,
    CAST(REPLACE(number_of_votes, ',', '') AS UNSIGNED) AS cleaned_number_of_votes,
    CAST(user_rating AS DECIMAL(3,1)) AS cleaned_user_rating
FROM
    anime_imdb_ratings_1
WHERE
    number_of_votes IS NOT NULL
    AND REPLACE(number_of_votes, ',', '') REGEXP '^[0-9]+$' -- Ensure it's a valid number
ORDER BY
    cleaned_number_of_votes DESC
;

select * from most_voted;


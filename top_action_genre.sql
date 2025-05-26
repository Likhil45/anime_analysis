create view top_action_genre as 
SELECT
    title,
    CAST(user_rating AS DECIMAL(3,1)) AS cleaned_user_rating,
    CAST(REPLACE(number_of_votes, ',', '') AS UNSIGNED) AS cleaned_number_of_votes
FROM
    anime_imdb_ratings_1
WHERE
    genre LIKE '%Action%' 
    AND user_rating IS NOT NULL
    AND user_rating REGEXP '^[0-9]+\\.?[0-9]*$'
    AND CAST(REPLACE(number_of_votes, ',', '') AS UNSIGNED) >= 500 
ORDER BY
    cleaned_user_rating DESC
;

select * from top_action_genre;
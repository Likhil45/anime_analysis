create or replace view top_action_genre as 
SELECT
    title,
    user_rating,
    number_of_votes
FROM
    anime_imdb_ratings_1
WHERE
    genre LIKE '%Action%' 
    AND user_rating IS NOT NULL
    AND user_rating REGEXP '^[0-9]+\\.?[0-9]*$'
    AND number_of_votes >= 500 
ORDER BY
    user_rating DESC
;

select * from top_action_genre;
select * from review;
create view review as 
SELECT
    title,
    genre,
    CAST(user_rating AS DECIMAL(3,1)) AS cleaned_user_rating,
    number_of_votes,
    run_time,
    year,
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

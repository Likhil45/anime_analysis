
create view most_popular_genre as
WITH GenreSplit AS (
    SELECT
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(genre, ',', n), ',', -1)) AS single_genre
    FROM
        anime_imdb_ratings_1
    JOIN
        (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS numbers
    ON
        CHAR_LENGTH(genre) - CHAR_LENGTH(REPLACE(genre, ',', '')) >= n - 1
    WHERE
        genre IS NOT NULL AND genre != ''
)
SELECT
    single_genre,
    COUNT(*) AS genre_count
FROM
    GenreSplit
WHERE
    single_genre != '' -- Filter out empty strings that might result from extra commas
GROUP BY
    single_genre
ORDER BY
    genre_count DESC
;

select * from most_popular_genre;

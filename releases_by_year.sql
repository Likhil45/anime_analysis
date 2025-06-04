create or replace view releases_by_year as
SELECT
    start_year,
    COUNT(*) AS number_of_releases
FROM
    anime_imdb_ratings_1
WHERE
    start_year IS NOT NULL
    AND start_year REGEXP '[0-9]{4}' -- Ensure the year format is valid (e.g., '(YYYY')
GROUP BY
    start_year
ORDER BY
    start_year ASC;

select * from releases_by_year;
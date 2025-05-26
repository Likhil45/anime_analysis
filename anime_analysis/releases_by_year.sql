create view releases_by_year as
SELECT
    CAST(SUBSTRING(year, LOCATE('(', year) + 1, 4) AS UNSIGNED) AS release_year,
    COUNT(*) AS number_of_releases
FROM
    anime_imdb_ratings_1
WHERE
    year IS NOT NULL
    AND year REGEXP '\\([0-9]{4}' -- Ensure the year format is valid (e.g., '(YYYY')
GROUP BY
    release_year
ORDER BY
    release_year ASC;

select * from releases_by_year;
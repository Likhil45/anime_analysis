create or replace view avg_runtime as 
SELECT
    CAST(SUBSTRING(year, LOCATE('(', year) + 1, 4) AS UNSIGNED) AS release_year,
    AVG(CAST(SUBSTRING_INDEX(run_time, ' ', 1) AS UNSIGNED)) AS average_runtime_minutes
FROM
    anime_imdb_ratings_1
WHERE
    run_time IS NOT NULL
    AND run_time LIKE '% min%'
    AND year IS NOT NULL
    AND year REGEXP '\\([0-9]{4}'
GROUP BY
    release_year
ORDER BY
    release_year ASC;
    
select * from avg_runtime;
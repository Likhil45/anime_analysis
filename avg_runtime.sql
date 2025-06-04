create or replace view avg_runtime as 
SELECT
    start_year,
    AVG(runtime_minutes)
FROM
    anime_imdb_ratings_1
WHERE
    runtime_minutes IS NOT NULL
    
    AND start_year IS NOT NULL
    AND start_year REGEXP '[0-9]{4}'
GROUP BY
    start_year
ORDER BY
    start_year ASC;
    
select * from avg_runtime;
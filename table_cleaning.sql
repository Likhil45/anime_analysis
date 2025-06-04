create database anime_reviews;
use anime_reviews;
create table anime_ratings(
title varchar(255),
genre varchar(255),
user_rating varchar(255),
number_of_votes varchar(255),
run_time varchar(255),
year varchar(255),
summary text,
stars text,
certificate varchar(20),
metascore varchar(20),
gross varchar(255),
episode varchar(255),
episode_title varchar(255));

CREATE TABLE anime_ratings_1 (
  title TEXT,
  genre TEXT,
  user_rating TEXT,
  number_of_votes TEXT,
  run_time TEXT,
  year TEXT,
  summary TEXT,
  stars TEXT,
  certificate TEXT,
  metascore TEXT,
  gross TEXT,
  episode TEXT,
  episode_title TEXT
);


SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN title IS NULL OR title = '' THEN 1 ELSE 0 END) AS null_title,
    SUM(CASE WHEN genre IS NULL OR genre = '' THEN 1 ELSE 0 END) AS null_genre,
    SUM(CASE WHEN user_rating IS NULL OR user_rating = '' THEN 1 ELSE 0 END) AS null_user_rating,
    SUM(CASE WHEN number_of_votes IS NULL OR number_of_votes = '' THEN 1 ELSE 0 END) AS null_number_of_votes,
    SUM(CASE WHEN run_time IS NULL OR run_time = '' THEN 1 ELSE 0 END) AS null_run_time,
    SUM(CASE WHEN year IS NULL OR year = '' THEN 1 ELSE 0 END) AS null_year,
    SUM(CASE WHEN summary IS NULL OR summary = '' THEN 1 ELSE 0 END) AS null_summary,
    SUM(CASE WHEN stars IS NULL OR stars = '' THEN 1 ELSE 0 END) AS null_stars,
    SUM(CASE WHEN certificate IS NULL OR certificate = '' THEN 1 ELSE 0 END) AS null_certificate,
    SUM(CASE WHEN metascore IS NULL OR metascore = '' THEN 1 ELSE 0 END) AS null_metascore,
    SUM(CASE WHEN gross IS NULL OR gross = '' THEN 1 ELSE 0 END) AS null_gross,
    SUM(CASE WHEN episode IS NULL OR episode = '' THEN 1 ELSE 0 END) AS null_episode,
    SUM(CASE WHEN episode_title IS NULL OR episode_title = '' THEN 1 ELSE 0 END) AS null_episode_title
FROM
    anime_imdb_ratings_1;
    
CREATE TABLE anime_imdb_ratings_1_backup AS
SELECT * FROM anime_imdb_ratings_1;

CREATE TABLE anime_imdb_ratings_1_deduplicated LIKE anime_imdb_ratings_1;

INSERT INTO anime_imdb_ratings_1_deduplicated
SELECT DISTINCT *
FROM anime_imdb_ratings_1;

DROP TABLE anime_imdb_ratings_1;

RENAME TABLE anime_imdb_ratings_1_deduplicated TO anime_imdb_ratings_1;

SELECT COUNT(*) FROM anime_imdb_ratings_1; -- Check total rows

SET GLOBAL local_infile = 1;
SET SQL_SAFE_UPDATES = 0;

create database loan;
use loan;

load data local infile 'C:/Users/likhi/Downloads/loan_data.csv'
into table loan_data
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


show warnings limit 10;

CREATE TABLE anime_imdb_ratings_1_pre_type_change_backup AS
SELECT * FROM anime_imdb_ratings_1;

ALTER TABLE anime_imdb_ratings_1
ADD COLUMN temp_title VARCHAR(255) COLLATE utf8mb4_unicode_ci,
ADD COLUMN temp_genre VARCHAR(255) COLLATE utf8mb4_unicode_ci,
ADD COLUMN temp_user_rating DECIMAL(3,1), -- e.g., 8.9
ADD COLUMN temp_number_of_votes BIGINT UNSIGNED, -- Can handle large vote counts
ADD COLUMN temp_runtime_minutes SMALLINT UNSIGNED, -- e.g., 24 min (store as 24)
ADD COLUMN temp_original_year_string VARCHAR(15) COLLATE utf8mb4_unicode_ci, -- To preserve original string like "(1985-1988)"
ADD COLUMN temp_start_year SMALLINT UNSIGNED, -- e.g., 1985
ADD COLUMN temp_summary TEXT COLLATE utf8mb4_unicode_ci, -- TEXT is generally fine for long summaries
ADD COLUMN temp_stars VARCHAR(500) COLLATE utf8mb4_unicode_ci, -- For comma-separated star names
ADD COLUMN temp_certificate VARCHAR(50) COLLATE utf8mb4_unicode_ci,
ADD COLUMN temp_metascore TINYINT UNSIGNED, -- Metascores are usually 0-100
ADD COLUMN temp_gross BIGINT UNSIGNED, -- For large currency values
ADD COLUMN temp_episode INT UNSIGNED,
ADD COLUMN temp_episode_title VARCHAR(255) COLLATE utf8mb4_unicode_ci;

UPDATE anime_imdb_ratings_1
SET
    temp_title = LEFT(title, 255), -- Truncate if original title is longer than 255 chars
    temp_genre = LEFT(genre, 255),
    temp_user_rating = CASE
        WHEN user_rating REGEXP '^[0-9]+\\.?[0-9]*$' THEN CAST(user_rating AS DECIMAL(3,1))
        ELSE NULL
    END,
    temp_number_of_votes = CASE
        WHEN REPLACE(number_of_votes, ',', '') REGEXP '^[0-9]+$' THEN CAST(REPLACE(number_of_votes, ',', '') AS UNSIGNED)
        ELSE NULL
    END,
    temp_runtime_minutes = CASE
        WHEN run_time LIKE '% min%' AND SUBSTRING_INDEX(run_time, ' ', 1) REGEXP '^[0-9]+$' THEN CAST(SUBSTRING_INDEX(run_time, ' ', 1) AS UNSIGNED)
        ELSE NULL
    END,
    temp_original_year_string = LEFT(year, 15), -- Copy original year string
    temp_start_year = CASE
        -- Check if year is not NULL, contains '(YYYY', AND the extracted 4 characters are purely digits
        WHEN year IS NOT NULL
             AND year REGEXP '\\([0-9]{4}'
             AND SUBSTRING(year, LOCATE('(', year) + 1, 4) REGEXP '^[0-9]{4}$'
            THEN CAST(SUBSTRING(year, LOCATE('(', year) + 1, 4) AS UNSIGNED)
        ELSE NULL
    END,
    temp_summary = summary, -- Copy summary as is (TEXT to TEXT)
    temp_stars = LEFT(stars, 500),
    temp_certificate = LEFT(certificate, 50),
    temp_metascore = CASE
        WHEN metascore REGEXP '^[0-9]+$' THEN CAST(metascore AS  UNSIGNED)
        ELSE NULL
    END,
    temp_gross = CASE
        WHEN REPLACE(gross, ',', '') REGEXP '^[0-9]+$' THEN CAST(REPLACE(gross, ',', '') AS UNSIGNED)
        ELSE NULL
    END,
    temp_episode = CASE
        WHEN episode REGEXP '^[0-9]+$' THEN CAST(episode AS UNSIGNED)
        ELSE NULL
    END,
    temp_episode_title = LEFT(episode_title, 255);
    
    
    ALTER TABLE anime_imdb_ratings_1
DROP COLUMN title,
DROP COLUMN genre,
DROP COLUMN user_rating,
DROP COLUMN number_of_votes,
DROP COLUMN run_time,
DROP COLUMN year,
DROP COLUMN summary,
DROP COLUMN stars,
DROP COLUMN certificate,
DROP COLUMN metascore,
DROP COLUMN gross,
DROP COLUMN episode,
DROP COLUMN episode_title;


ALTER TABLE anime_imdb_ratings_1
RENAME COLUMN temp_title TO title,
RENAME COLUMN temp_genre TO genre,
RENAME COLUMN temp_user_rating TO user_rating,
RENAME COLUMN temp_number_of_votes TO number_of_votes,
RENAME COLUMN temp_runtime_minutes TO runtime_minutes,
RENAME COLUMN temp_original_year_string TO original_year_string, -- Keep this for the original year string
RENAME COLUMN temp_start_year TO start_year, -- This is the new numeric year column
RENAME COLUMN temp_summary TO summary,
RENAME COLUMN temp_stars TO stars,
RENAME COLUMN temp_certificate TO certificate,
RENAME COLUMN temp_metascore TO metascore,
RENAME COLUMN temp_gross TO gross,
RENAME COLUMN temp_episode TO episode,
RENAME COLUMN temp_episode_title TO episode_title;

ALTER TABLE anime_imdb_ratings_1
MODIFY COLUMN title VARCHAR(255) NOT NULL,
MODIFY COLUMN genre VARCHAR(255) NOT NULL,
MODIFY COLUMN user_rating DECIMAL(3,1), -- Can be NULL if no rating
MODIFY COLUMN number_of_votes BIGINT UNSIGNED, -- Can be NULL if no votes (using BIGINT UNSIGNED again as it's the correct type)
MODIFY COLUMN runtime_minutes SMALLINT UNSIGNED, -- Can be NULL
MODIFY COLUMN original_year_string VARCHAR(15), -- Can be NULL
MODIFY COLUMN start_year SMALLINT UNSIGNED, -- Can be NULL
MODIFY COLUMN summary TEXT,
MODIFY COLUMN stars VARCHAR(500),
MODIFY COLUMN certificate VARCHAR(50),
MODIFY COLUMN metascore TINYINT UNSIGNED,
MODIFY COLUMN gross BIGINT UNSIGNED, -- Using BIGINT UNSIGNED again
MODIFY COLUMN episode INT UNSIGNED,
MODIFY COLUMN episode_title VARCHAR(255);

DESCRIBE anime_imdb_ratings_1;
SELECT * FROM anime_imdb_ratings_1 LIMIT 5;

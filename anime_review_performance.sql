
create or replace view anime_review_results as    
SELECT review_category, count(*) as number_of_anime
 
FROM
    review
GROUP BY
    review_category
ORDER BY
    number_of_anime DESC;
    
select * from anime_review_results;
{{ config(
    schema='target_schema',
    materialized='table'
) }}
 
SELECT CAST(regexp_replace(reviews.pull_request_url,'^.*/pull/(\d+)$', '\1') AS INTEGER) AS "Comment_Id",
body AS "Comment"
FROM intern_test.reviews
UNION
SELECT  
CAST(regexp_replace(comments.issue_url,'https://api.github.com/repos/Gaya3gireesh/mental_health_bot/issues/(\d+)$', '\1') AS INTEGER) AS  "Comment_Id",
body AS "Comment"
FROM intern_test.comments
ORDER BY "Comment_Id"
 
 
 
 
 
 
{{ config(
    schema='target_schema',
    materialized='table'
) }}


SELECT
    "Comment_Id" AS "Id",
    COUNT(*) AS "Comment_Count"
FROM intern_test_target_schema.comment_table


GROUP BY "Comment_Id"
ORDER BY "Comment_Id"
 
 
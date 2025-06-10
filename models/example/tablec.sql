{{ config(
    schema='target_schema',
    materialized='table'
) }}

SELECT 
    created_at,
    P_id,
    Portfolio,
    url,
    PR_State,
    Authors,
    CASE
        WHEN BOOL_OR(tb.Reviewers IS NULL ) THEN 'No Reviewers'
        ELSE tb.Reviewers
    END AS Reviewers,
    Review_State,
    CASE
        WHEN BOOL_OR(count."Comment_Count" IS NULL ) THEN CAST(0 AS INTEGER)
        ELSE count."Comment_Count"
    END AS Comment_Count
FROM intern_test_target_schema.table tb
LEFT JOIN intern_test_target_schema.count
    ON tb.P_id = count."Id"

GROUP BY
    created_at,
    P_id,
    Portfolio,
    url,
    PR_State,
    Authors,
    tb.reviewers,
    Review_State,
    count."Comment_Count"


ORDER BY tb.P_id
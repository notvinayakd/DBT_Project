{{ config(
    schema='target_schema',
    materialized='table'
) }}

SELECT
    pr.created_at,
    CAST(regexp_replace(pr._links -> 'html' ->> 'href', 'https://github.com/Gaya3gireesh/mental_health_bot/pull/(\d+)$', '\1') AS INTEGER) AS P_id,
    pr.repository AS Portfolio,
    pr._links -> 'html' ->> 'href' AS "url", 
    pr.state AS PR_State,
    pr.user ->> 'login' AS Authors,
    STRING_AGG(DISTINCT rv.user ->> 'login', ', ') AS Reviewers,

    CASE
        WHEN BOOL_OR(rv.state = 'APPROVED') THEN 'APPROVED'
        WHEN BOOL_OR(rv.state = 'COMMENTED') THEN 'COMMENTED'
        ELSE 'NOT REVIEWED'
    END AS Review_State


FROM intern_test.pull_requests pr

LEFT JOIN intern_test.reviews rv
    ON (pr._links -> 'html' ->> 'href') = rv.pull_request_url

GROUP BY
    pr.created_at,
    pr.repository,
    pr._links,
    pr.state,
    pr.user,
    P_id

ORDER BY CAST(regexp_replace(pr._links -> 'html' ->> 'href', '^.*/pull/(\d+)$', '\1') AS INTEGER)


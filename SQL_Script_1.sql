-- Customer Onboarding Funnel Analysis
WITH onboarding_steps AS (
    SELECT user_id,
           event_name,
           event_timestamp,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY event_timestamp) AS step_order
    FROM user_activity_log
    WHERE event_name IN ('Signup', 'Email Verification', 'App Download', 'First Login')
)
SELECT user_id,
       COUNT(*) AS steps_completed,
       MIN(event_timestamp) AS start_time,
       MAX(event_timestamp) AS end_time
FROM onboarding_steps
GROUP BY user_id;

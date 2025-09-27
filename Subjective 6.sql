WITH UserEngagement AS (
    SELECT
        u.id,
        u.username,
        COUNT(DISTINCT p.id) AS post_count,
        COUNT(DISTINCT l.user_id) AS likes_given,
        COUNT(DISTINCT c.id) AS comments_made,
        (COUNT(DISTINCT p.id) + COUNT(DISTINCT l.user_id) + COUNT(DISTINCT c.id)) AS engagement_score
    FROM users u
    LEFT JOIN photos p ON u.id = p.user_id
    LEFT JOIN likes l ON u.id = l.user_id
    LEFT JOIN comments c ON u.id = c.user_id
    GROUP BY u.id, u.username
), Activity_segment AS (
SELECT
    id,
    username,
    engagement_score,
    CASE
        WHEN engagement_score > 50 THEN 'Highly Active'
        WHEN engagement_score BETWEEN 11 AND 50 THEN 'Moderately Active'
        WHEN engagement_score BETWEEN 1 AND 10 THEN "Low Active"
        WHEN engagement_score = 0 THEN  'Inactive'
    END AS activity_segment
FROM UserEngagement)

SELECT 
   activity_segment,
   COUNT(*) AS user_count
FROM Activity_segment
GROUP BY activity_segment;


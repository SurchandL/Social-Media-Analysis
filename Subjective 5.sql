WITH Follower_Counts AS (
    SELECT
        u.id AS user_id,
        u.username,
        COUNT(f.follower_id) AS follower_count
    FROM users u
    LEFT JOIN follows f ON u.id = f.followee_id
    GROUP BY u.id, u.username
),
Engagement_Rates AS (
    SELECT
        u.id AS user_id,
        AVG(COALESCE(l.likes_count, 0) + COALESCE(c.comments_count, 0)) AS avg_engagement
    FROM users u
    LEFT JOIN photos p ON u.id = p.user_id
    LEFT JOIN (
        SELECT photo_id, COUNT(*) AS likes_count FROM likes GROUP BY photo_id
    ) l ON p.id = l.photo_id
    LEFT JOIN (
        SELECT photo_id, COUNT(*) AS comments_count FROM comments GROUP BY photo_id
    ) c ON p.id = c.photo_id
    GROUP BY u.id
), rank_on_follower AS (
SELECT
    fc.user_id,
    fc.username,
    fc.follower_count,
    er.avg_engagement,
    RANK()OVER(ORDER BY fc.follower_count DESC) AS RK
FROM Follower_Counts fc
JOIN Engagement_Rates er ON fc.user_id = er.user_id)

SELECT 
   user_id,
   username,
   follower_count,
   avg_engagement
FROM rank_on_follower
WHERE RK = 1 AND avg_engagement != 0
ORDER BY avg_engagement DESC;

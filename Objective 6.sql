SELECT 
    u.id AS user_id,
    u.username,
    COUNT(DISTINCT l.user_id) + COUNT(DISTINCT c.id) AS total_engagements,
    COUNT(DISTINCT p.id) AS num_posts,
    ROUND(
        (COUNT(DISTINCT l.user_id) + COUNT(DISTINCT c.id)) / NULLIF(COUNT(DISTINCT p.id), 0), 
        2
    ) AS avg_engagement_per_post
FROM users u
LEFT JOIN photos p ON u.id = p.user_id
LEFT JOIN likes l ON p.id = l.photo_id
LEFT JOIN comments c ON p.id = c.photo_id
GROUP BY u.id, u.username
ORDER BY avg_engagement_per_post DESC;




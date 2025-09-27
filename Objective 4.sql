use ig_clone;
SELECT 
    u.id AS user_id,
    u.username,
    COUNT(DISTINCT l.user_id) AS total_likes,
    COUNT(DISTINCT c.id) AS total_comments,
    (COUNT(DISTINCT l.user_id) + COUNT(DISTINCT c.id)) AS engagement_score,
    RANK() OVER (ORDER BY (COUNT(DISTINCT l.user_id) + COUNT(DISTINCT c.id)) DESC) AS rk
FROM users u
LEFT JOIN photos p ON u.id = p.user_id
LEFT JOIN likes l ON p.id = l.photo_id
LEFT JOIN comments c ON p.id = c.photo_id
GROUP BY u.id, u.username
ORDER BY engagement_score DESC;



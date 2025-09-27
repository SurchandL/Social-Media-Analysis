SELECT
    t.tag_name,
    AVG(photo_engagement.total_likes + photo_engagement.total_comments) AS avg_engagement_per_photo
FROM (
    SELECT 
        p.id AS photo_id,
        COUNT(DISTINCT l.user_id) AS total_likes,
        COUNT(DISTINCT c.id) AS total_comments
    FROM photos p
    LEFT JOIN likes l ON p.id = l.photo_id
    LEFT JOIN comments c ON p.id = c.photo_id
    GROUP BY p.id
) AS photo_engagement
JOIN photo_tags pt ON photo_engagement.photo_id = pt.photo_id
JOIN tags t ON pt.tag_id = t.id
GROUP BY t.tag_name
ORDER BY avg_engagement_per_photo DESC;

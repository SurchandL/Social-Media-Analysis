WITH Hashtag_AvgLikes AS (
    SELECT
        t.tag_name,
        AVG(likes_per_photo.likes_count) AS avg_likes
    FROM tags t
    JOIN photo_tags pt ON t.id = pt.tag_id
    JOIN (
        SELECT
            p.id AS photo_id,
            COUNT(l.user_id) AS likes_count
        FROM photos p
        LEFT JOIN likes l ON p.id = l.photo_id
        GROUP BY p.id
    ) likes_per_photo ON pt.photo_id = likes_per_photo.photo_id
    GROUP BY t.tag_name
)
SELECT
    tag_name,
    avg_likes
FROM Hashtag_AvgLikes
ORDER BY avg_likes DESC;

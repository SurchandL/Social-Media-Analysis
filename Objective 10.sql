WITH Likes_CTE AS (
    SELECT 
        p.user_id,
        COUNT(l.user_id) AS total_likes
    FROM photos p
    LEFT JOIN likes l ON p.id = l.photo_id
    GROUP BY p.user_id
),
Comments_CTE AS (
    SELECT 
        p.user_id,
        COUNT(c.id) AS total_comments
    FROM photos p
    LEFT JOIN comments c ON p.id = c.photo_id
    GROUP BY p.user_id
),
Tags_CTE AS (
    SELECT
        p.user_id,
        COUNT(pt.tag_id) AS total_photo_tags
    FROM photos p
    LEFT JOIN photo_tags pt ON p.id = pt.photo_id
    GROUP BY p.user_id
)

SELECT 
    u.id AS user_id,
    u.username,
    COALESCE(L.total_likes, 0) AS total_likes,
    COALESCE(C.total_comments, 0) AS total_comments,
    COALESCE(T.total_photo_tags, 0) AS total_photo_tags
FROM users u
LEFT JOIN Likes_CTE L ON u.id = L.user_id
LEFT JOIN Comments_CTE C ON u.id = C.user_id
LEFT JOIN Tags_CTE T ON u.id = T.user_id
ORDER BY u.id;

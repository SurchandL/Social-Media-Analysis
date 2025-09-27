WITH user_engagement AS (
    SELECT
        p.user_id,
        DATE_FORMAT(p.created_dat,"%Y-%m") AS month,
        COUNT(DISTINCT l.user_id) AS total_likes,
        COUNT(DISTINCT c.id) AS total_comments,
        (COUNT(DISTINCT l.user_id) + COUNT(DISTINCT c.id)) AS total_engagement
    FROM photos p
    LEFT JOIN likes l 
        ON p.id = l.photo_id 
        AND date_format(l.created_at,"%Y-%m") = DATE_FORMAT(p.created_dat,"%Y-%m")
    LEFT JOIN comments c 
        ON p.id = c.photo_id 
        AND DATE_FORMAT(c.created_at,"%Y-%m") = DATE_FORMAT(p.created_dat,"%Y-%m")
    GROUP BY p.user_id, DATE_FORMAT(p.created_dat,"%Y-%m")
)
SELECT
    ue.user_id,
    u.username,
    ue.month,
    ue.total_likes,
    ue.total_comments,
    ue.total_engagement,
    RANK() OVER (PARTITION BY ue.month ORDER BY ue.total_engagement DESC) AS engagement_rank
FROM user_engagement ue
JOIN users u ON ue.user_id = u.id
ORDER BY ue.month DESC, engagement_rank;

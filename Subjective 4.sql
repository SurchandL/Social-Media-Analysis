WITH Hashtag_Stats AS (
    SELECT
        t.tag_name,
        COUNT(DISTINCT pt.photo_id) AS post_count,
        COALESCE(SUM(l.likes_count), 0) AS like_count,
        COALESCE(SUM(c.comments_count), 0) AS comment_count,
        AVG(COALESCE(l.likes_count, 0) + COALESCE(c.comments_count, 0)) AS avg_engagement
    FROM tags t
    JOIN photo_tags pt ON t.id = pt.tag_id
    JOIN photos p ON pt.photo_id = p.id
    LEFT JOIN (
        SELECT photo_id, COUNT(*) AS likes_count
        FROM likes
        GROUP BY photo_id
    ) l ON p.id = l.photo_id
    LEFT JOIN (
        SELECT photo_id, COUNT(*) AS comments_count
        FROM comments
        GROUP BY photo_id
    ) c ON p.id = c.photo_id
    GROUP BY t.tag_name
)
SELECT 
    tag_name,
    post_count,
    like_count,
    comment_count,
    ROUND(avg_engagement,2) AS avg_engagement
FROM Hashtag_Stats
ORDER BY avg_engagement DESC;



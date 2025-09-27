WITH Hashtag_Engagement AS (
    SELECT
        t.tag_name,
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
SELECT tag_name, avg_engagement
FROM Hashtag_Engagement
ORDER BY avg_engagement DESC;

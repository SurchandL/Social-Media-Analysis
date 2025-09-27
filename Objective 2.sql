SELECT activity_level, COUNT(*) AS user_count FROM (
    SELECT sub.id AS user_id,
           CASE
               WHEN (post_count + like_count + comment_count) = 0 
                    THEN 'Inactive'
               WHEN (post_count + like_count + comment_count) <= 10 
                    THEN 'Low'
               WHEN (post_count + like_count + comment_count) <= 50 
                    THEN 'Medium'
               ELSE 'High'
           END AS activity_level
    FROM (
        SELECT u.id,
               COALESCE(COUNT(DISTINCT p.id),0) AS post_count,
               COALESCE(COUNT(DISTINCT l.photo_id),0) AS like_count,
               COALESCE(COUNT(DISTINCT c.id),0) AS comment_count
        FROM users u
        LEFT JOIN photos p ON u.id = p.user_id
        LEFT JOIN likes l ON u.id = l.user_id
        LEFT JOIN comments c ON u.id = c.user_id
        GROUP BY u.id
    ) sub
) t
GROUP BY activity_level
ORDER BY user_count DESC;
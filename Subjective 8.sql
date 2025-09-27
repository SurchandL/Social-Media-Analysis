SELECT
    u.id,
    u.username,
    COUNT(DISTINCT p.id) AS post_count,
    COUNT(DISTINCT l.user_id) AS likes_received,
    COUNT(DISTINCT c.id) AS comments_received,
    COUNT(DISTINCT f.follower_id) AS follower_count
FROM users u
LEFT JOIN photos p ON u.id = p.user_id
LEFT JOIN likes l ON p.id = l.photo_id
LEFT JOIN comments c ON p.id = c.photo_id
LEFT JOIN follows f ON u.id = f.followee_id
GROUP BY u.id, u.username
HAVING post_count>0 AND likes_received>0 AND comments_received>0 AND follower_count>0
ORDER BY follower_count DESC, likes_received DESC, comments_received DESC, post_count DESC
LIMIT 10;

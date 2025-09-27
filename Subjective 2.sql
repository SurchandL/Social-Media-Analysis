SELECT u.id AS user_id, u.username
FROM users u
LEFT JOIN photos p ON u.id = p.user_id
LEFT JOIN likes l ON u.id = l.user_id
LEFT JOIN comments c ON u.id = c.user_id
WHERE p.id IS NULL AND l.photo_id IS NULL AND c.photo_id IS NULL;

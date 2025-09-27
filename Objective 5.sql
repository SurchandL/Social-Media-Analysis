WITH follower_data AS (
SELECT 
    u.id,
    u.username,
    COUNT(f.follower_id) AS follower_count,
    RANK()OVER(ORDER BY COUNT(f.follower_id) DESC) AS rk
FROM users u
LEFT JOIN follows f ON u.id = f.followee_id
GROUP BY u.id, u.username)
SELECT 
    id,
    username,
    follower_count
FROM follower_data
WHERE rk=1;


WITH following_data AS (
SELECT 
    u.id,
    u.username,
    COUNT(f.followee_id) AS following_count,
    RANK()OVER(ORDER BY COUNT(f.followee_id) DESC) AS rk
FROM users u
LEFT JOIN follows f ON u.id = f.follower_id
GROUP BY u.id, u.username)
SELECT 
    id,
    username,
    following_count
FROM following_data
WHERE rk=1;





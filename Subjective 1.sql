use ig_clone;
WITH User_Engagement AS (
    SELECT 
        u.id AS user_id,
        u.username,
        COUNT(DISTINCT p.id) AS total_posts,
        COUNT(DISTINCT l.user_id) AS total_likes,
        COUNT(DISTINCT c.id) AS total_comments,
        (COUNT(DISTINCT p.id) + COUNT(DISTINCT l.user_id) + COUNT(DISTINCT c.id)) AS engagement_score
    FROM users u
    LEFT JOIN photos p ON u.id = p.user_id
    LEFT JOIN likes l ON p.id = l.photo_id
    LEFT JOIN comments c ON p.id = c.photo_id
    GROUP BY u.id, u.username
), Ranked_Users AS (
SELECT 
    user_id,
    username,
    total_posts,
    total_likes,
    total_comments,
    engagement_score,
    RANK() OVER (ORDER BY engagement_score DESC) AS engagement_rank
FROM User_Engagement
ORDER BY engagement_rank
LIMIT 10)  -- Top 10 most engaged users

SELECT
  user_id,
  username,
  engagement_score,
  CASE 
    WHEN engagement_rank = 1 THEN 'Gold - Exclusive Access + Gifts'
    WHEN engagement_rank BETWEEN 2 AND 5 THEN 'Silver - Discounts + Badges'
    WHEN engagement_rank BETWEEN 6 AND 10 THEN 'Bronze - Recognition + Small Perks'
    ELSE 'Standard User'
  END AS reward_tier
FROM Ranked_Users;



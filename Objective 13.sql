SELECT
  f1.follower_id AS user_id,
  f1.followee_id AS followed_user_id,
  f1.created_at AS followed_time,
  f2.created_at AS followed_back_time
FROM follows f1
JOIN follows f2 ON f1.follower_id = f2.followee_id AND f1.followee_id = f2.follower_id
WHERE f1.created_at > f2.created_at
ORDER BY f1.follower_id, f1.created_at;

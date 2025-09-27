use ig_clone;
SELECT 
    ROUND(AVG(tag_count),2) AS avg_tags_per_post
FROM (
    SELECT 
        pt.photo_id,
        COUNT(pt.tag_id) AS tag_count
    FROM photo_tags pt
    JOIN photos p ON p.id = pt.photo_id
    GROUP BY pt.photo_id
) AS photo_tag_counts;
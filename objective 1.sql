use ig_clone;
-- to filter out rows with null value in comments table
select 
  *
from  comments
where  id is null 
   or  comment_text is null
   or  user_id is null
   or  photo_id is null
   or  created_at is null;


-- to filter out rows with duplicates in comments table
 Select 
   id,
   comment_text,
   user_id,
   photo_id,
   created_at,
   count(*) as cnt
from comments
group by id,comment_text,user_id,photo_id,created_at
having count(*)>1;


-- to filter out rows with null value in follows table
select 
  *
from  follows
where follower_id is null
   or  followee_id is null
   or  created_at is null;


-- to filter out rows with duplicates in follows table
 Select 
   follower_id,followee_id,created_at,
   count(*) as cnt
from follows
group by follower_id,followee_id,created_at
having count(*)>1;

-- to filter out rows with null value in likes table
select 
  *
from  likes
where  user_id is null 
   or  photo_id is null
   or  created_at is null;


-- to filter out rows with duplicates in likes table
 Select 
   user_id,photo_id,created_at,
   count(*) as cnt
from likes
group by user_id,photo_id,created_at
having count(*)>1;


-- to filter out rows with null value in photo_tags table
select 
  *
from  photo_tags
where  photo_id is null 
   or  tag_id is null;


-- to filter out rows with duplicates in photo_tags table
 Select 
  photo_id,tag_id,
   count(*) as cnt
from photo_tags
group by photo_id,tag_id
having count(*)>1;


-- to filter out rows with null value in photos table
select 
  *
from  photos
where  id is null 
   or  image_url is null
   or  user_id is null
   or  created_dat is null;


-- to filter out rows with duplicates in photos table
 Select 
   id,
   image_url,
   user_id,
   created_dat,
   count(*) as cnt
from photos
group by id,image_url,user_id,created_dat
having count(*)>1;


-- to filter out rows with null value in tags table
select 
  *
from  tags
where  id is null 
   or  tag_name is null
   or  created_at is null;


-- to filter out rows with duplicates in tags table
 Select 
   id,
   tag_name,
   created_at,
   count(*) as cnt
from tags
group by id,tag_name,created_at
having count(*)>1;


-- to filter out rows with null value in users table
select 
  *
from  users
where  id is null 
   or  username is null
   or  created_at is null;


-- to filter out rows with duplicates in users table
 Select 
   id,
   username,
   created_at,
   count(*) as cnt
from users
group by id,username,created_at
having count(*)>1;
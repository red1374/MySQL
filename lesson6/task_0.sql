-- Fix for friends_request table. -- 
UPDATE friends_request SET target_user_id = (
    SELECT id FROM users WHERE target_user_id <> id ORDER BY rand() LIMIT 1)
WHERE initiator_user_id = target_user_id;
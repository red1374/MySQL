UPDATE friends_request SET target_user_id = (
    SELECT target_user_id FROM friends_request WHERE initiator_user_id <> target_user_id ORDER BY RAND LIMIT 1)
WHERE initiator_user_id = target_user_id
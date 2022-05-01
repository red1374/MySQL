-- Из всех друзей заданного пользователя найти человека, который больше всех с ним общался --
SET @user_id = 262;

SELECT to_user_id 
FROM (SELECT count(*) AS qty, to_user_id
    FROM mesasages m 
    WHERE to_user_id = @user_id AND from_user_id IN (
        -- Get friends --        
        SELECT target_user_id
            FROM friends_request fr 
            WHERE status = 'approved' AND initiator_user_id = @user_id
        UNION 
            SELECT initiator_user_id
            FROM friends_request fr 
            WHERE status = 'approved' AND target_user_id = @user_id
    )    
    GROUP BY to_user_id
    ORDER BY qty DESC
    LIMIT 1
) AS T;
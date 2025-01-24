-- 1.
create index "search_users_by_last_login"
on "users"("last_login_date")

explain query plan
select *
from users
where "last_login_date" >= '2024-01-01'

-- 2.
explain query plan
select "expires_timestamp"
from messages
where id = 151 -- primary key 会自动创建一个index

-- 3.
create index "search_message_by_from_user_id"
on "messages"("from_user_id");

EXPLAIN query plan
select to_user_id, count(*) as "count"
from messages
where from_user_id = (
    select id
    from users
    where username = 'creativewisdom377'
)
group by to_user_id order by "count" desc limit 3;

-- 4.
create index "search_message_by_to_user_id"
on "messages"("to_user_id");

explain query plan
select "to_user_id", count(*) as "count"
from messages
group by to_user_id
order by "count" desc limit 1;

-- 5.

select friend_id
from friends
WHERE user_id = (
    select id
    from users
    where username = 'lovelytrust487'
)
INTERSECT
select friend_id
from friends
where user_id = (
  	select id
  	from users
  	where username = 'exceptionalinspiration482'
)

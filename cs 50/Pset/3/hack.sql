-- Alter: 修改管理员账户的密码
-- Erase: 删除修改记录
-- Add: 添加虚假数据：在用户修改日志中添加一条修改记录，管理员的密码被修改成另一个用户的密码（虚假）

insert into user_logs("type", "old_username", "new_username", "old_password", "new_password")
SELECT 'update', 'admin', 'admin', 
  (
  select "password"
  from users
  where username = 'admin'
  ),
  
  (
  SELECT "password"
  from users
  where "username" = 'emily33'
  );

  

UPDATE users
set password = 'c8b2f9f2a846d1ac2fc7bc0a1a58681a'
where username = 'admin';

DELETE from user_logs
where new_password = 'c8b2f9f2a846d1ac2fc7bc0a1a58681a';

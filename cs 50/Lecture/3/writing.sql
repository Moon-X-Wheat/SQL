-- 导入数据（从csv导入

-- 删除数据
delete from table_name
where conditions
on delete on action | default | cascade | set null -- 当表格被另一个表格引用为外键时，删除行同时对另一个表格引用处进行的操作
  
-- updata data
UPDATE votes set "title" = trim("title") -- 去除前后空格
UPDATE votes set "title" = lower("title") -- 转小写
  
UPDATE votes set "title" = 'Profusion of flowers'-- 修改值
WHERE title LIKE 'pro%'; -- 按条件修改

-- trigger触发器
create trigger_name
after | before insert | update | delete -- 在动作（插入、更新、删除）之后或者之前启动触发器
on table_name -- 触发器关联的表格
for each row -- 每一次操作执行一次，例如同时删除或者插入多行
begin 
  -- 触发器逻辑
  ;
end;

create TRIGGER "sold"
before DELETE
on "collections"
for each ROW
BEGIN
	insert into "transaction"("title", "action")
    VALUES (old."title", 'sold');
end;

create trigger "buy"
after INSERT
on "collections"
for each ROW
BEGIN
	insert into "transaction"("title", "action")
    values (new."title", 'buy');
end;

-- soft delection
-- 不彻底删除数据，而是创建一个表示删除或者不删除的列，在用筛选。

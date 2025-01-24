-- transaction:事务。类似金钱账户交易。支出方和收入方之间的动作必须是一次性的，不能被分解，也不会因为系统崩溃而卡在一半，会回到提交时的状态。
-- atomicity, consistency, isolation, durability
begin TRANSACTION;
update accounts 
set balance = balance - 10 WHERE name = 'Charlie';
update accounts
set balance = balance + 10 where name = 'Alice';
commit;

-- rollback
BEGIN TRANSACTION;
update accounts set balance = balance + 30 WHERE id = 1;
update accounts set balance = balance - 30 where id = 2; -- 执行此条语句时会报错，这时事务中断。

ROLLBACK; -- 需要执行rollback回到初始状态，不然数据库将会一直处于事务进行中的状态。

-- 创建索引，提高检索速度
create INDEX "title_index" on "movies"("title") -- table_name(column_name)

-- 查看用什么方式进行检索
EXPLAIN QUERY PLAN
select * from "movies"
WHERE "title" = 'Love Actually'

-- covering index：覆盖索引，从索引就可以得出所有信息，而不需要查看整个表
create index "person_index" on "stars"("person_id", "movie_id")

-- 创建索引，提高检索速度
create INDEX "title_index" on "movies"("title") -- table_name(column_name)

-- 查看用什么方式进行检索
EXPLAIN QUERY PLAN
select * from "movies"
WHERE "title" = 'Love Actually'

-- covering index：覆盖索引，从索引就可以得出所有信息，而不需要查看整个表
create index "person_index" on "stars"("person_id", "movie_id")

EXPLAIN QUERY plan
SELECT title from movies
WHERE id in (
  SELECT movie_id from stars
  WHERE person_id = (
    select id from "people"
    WHERE name = 'Tom Hanks'
  )
)

-- partial index: 部分索引，只用表格的一部分数据（行）创建索引
create index "movies_2023" on "movies"("title") 
where "year" = 2023

-- Vacuum: 优化数据库空间，将已经删除的文件的空间还回去。

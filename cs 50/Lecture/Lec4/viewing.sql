-- 创建视窗，"储存"临时结果
create view "longlist" as
SELECT name, title
from authors
join authored on authors.id = authored.author_id
join books on books.id = authored.book_id

-- 使用聚合函数
create view 'books ratings' as
select title, round(avg(rating),2) as 'average rating'
from books
JOIN ratings on ratings.book_id = books.id
group by book_id

-- 更新基础数据，视图中的数据也会随之更新

-- 从视窗建立视窗
create view "year_average_rating" as
SELECT year, round(avg("average_rating"),2) as "average_rating"
from "books_ratings"
group by year

-- 创建临时视窗
create temporary view name as

-- common table expression
with "year_rating" as (
  select "title", "year", avg(rating) as "average_rating"
  from books
  join ratings on "ratings"."book_id" = books.id
  group by "book_id"
)
  
 select "year", round(avg("average_rating"),2) as "average_rating"
 from "year_rating"
 group by "year"

-- 可以使用视窗来对数据进行分组

create view "no_riders" as
select id, origin, destination, 'anonymous' as "riders" -- 创建新的一列"riders"，用"anonymous"填充
from rides
-- 在其它数据库管理系统中，可以设置表格和视窗的访问权限。但是sqlite不可以。

-- 通过视窗功能来进行软删除
alter table collections
add column "deleted" integer DEFAULT 0 -- 添加一列来判断数据是否被删除

create view "current_collections" as
select "id", "title", "accession_number", "acquired"
from collections
WHERE deleted = 0

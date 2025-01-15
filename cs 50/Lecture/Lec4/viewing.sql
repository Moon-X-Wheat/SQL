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
add column "deleted" integer DEFAULT 0; -- 添加一列来判断数据是否被删除

create view "current_collections" as
select "id", "title", "accession_number", "acquired"
from collections
WHERE deleted = 0 -- 筛选视窗的内容

Update "collection"
set "deleted" = 1
where title like 'Farmer%'; -- 更改原来列中的数据，视窗随之更新。


-- 视窗结合触发器进行软删除
-- 不能直接修改视窗的数据，可以直接修改底层表。如上。
-- 另一种方法是，使用触发器，当试图对视窗进行删除时，触发器启动修改底层表。（适用与底层表被设置访问权限的情况）

create trigger "delete"
instead of delete on "current_collections" -- 启动触发器的动作
for each ROW
BEGIN
	update "collections" -- 触发器被启动后开展的行为
    set "deleted" = 1
    where id = old.id; -- 将被删除的行的deleted值修改为1
end;

-- 视窗结合触发器增加新数据
-- 同理，可以从底层表中直接添加，或者使用触发器在试图修改视窗时修改底层表
create trigger "insert_when_exist"
instead of insert on "current_collections"
for each row
when new."accession_number" in (
	SELECT "accession_number" from "collections"
  ) -- 设置修改的条件。只有在满足条件时（新输入的编号已经存在）才会执行下面的语句。相当于有两个触发器，一个在捕捉到动作时启动，一个在满足条件时执行。
BEGIN
	update "collections"
    set "deleted" = 0
    where "accession_number" = new."accession_number";
end;

insert into "current_collections" ("title", "accession_number", "acquired")
values ('Imaginative landscape', '56.496', null);

create trigger "insert_new_item"
instead of insert on "current_collections"
for each ROW
when new."accession_number" not in (
  SELECT accession_number from collections
  )
BEGIN
	insert into collections ("title", accession_number, acquired)
    values(new."title", new."accession_number", new."acquired");
end;

insert into "current_collections" ("title", "accession_number", "acquired")
values ('Roooooar', '95.496', null)

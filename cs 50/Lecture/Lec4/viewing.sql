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

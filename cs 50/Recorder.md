## what is database
储存、管理、组织数据的系统。就像一个高级版的表格（更复杂），或者说是一个大型的电子文件柜。可以储存大量信息。
## Database management system
用于操作数据库的软件
### genre
- MySQL
- PostgreSQL
- SQLite
- Oracle
## what is SQL
structured query langauage：结构化查询语言。和数据库进行交互的语言。

## 1216
1. 从表中选择列

选择所有列
SELECT * FROM 'authored';

选择特定列：双引号表示列名或者表格名
SELECT "name", "country" FROM "authors" LIMIT 10;


2. 查询

字符串用单引号
SELECT "name", "country"" FROM "authors" WHERE "country" = 'China';

条件判断：= != < > <>（这个表示小于或者大于，相当于不等于）
SELECT "title", "format",year FROM books WHERE year > 2022; 


逻辑判断词：AND, OR, NOT
SELECT "title", "format",year FROM books WHERE NOT format == 'hardcover'; 

SELECT "title", "format",year FROM books 
WHERE "year" == 2021 OR "year" == 2023

SELECT "title", "format",year FROM books 
WHERE ("year" == 2021 OR "year" == 2023)
and format = 'hardcover';

SELECT title, year FROM books
WHERE year BETWEEN 2019  AND 2022;

SELECT title, year pages FROM books
WHERE (year BETWEEN 2019 and 2022) and pages > 1000 ;

SELECT name, birth FROM authors
WHERE birth IS NULL;
（找出缺失值）

3. 查找
SELECT title FROM books
WHERE title LIKE 'love';
（模糊查找，包括含有love的单词，不区分大小写）

SELECT title, year, pages FROM books
WHERE "title" = 'tyll';
(区分大小写）

SELECT title FROM books
WHERE title LIKE '%love';
（以love开头）

SELECT title FROM books
WHERE title LIKE 'The %';
（the 后面紧跟空格）

SELECT title FROM books
WHERE title LIKE '_ove';
（短线可替代所有符号）

4. 排序
SELECT * FROM ratings
ORDER by rating DESC LIMIT 10;
（默认升序，可设置为降序）

SELECT title, rating, votes FROM longlist
ORDER by rating DESC, votes DESC
limit 10;
（设置两个筛选条件）

## 1217

1. 计算函数

求平均值
SELECT AVG(rating) FROM longlist;

四舍五入
SELECT ROUND(AVG(rating),2) FROM longlist;

应用函数同时改名
SELECT ROUND(AVG(rating),2) AS 'Average Rating' FROM longlist;

SELECT MAX("rating")  FROM longlist;

SELECT MIN("rating")  FROM longlist;

SELECT SUM("votes")  FROM longlist;

SELECT COUNT(*)  FROM longlist;

SELECT COUNT("translator")  FROM longlist;

找到不重复的值
SELECT DISTINCT publisher FROM longlist;

SELECT COUNT(DISTINCT publisher) FROM longlist;


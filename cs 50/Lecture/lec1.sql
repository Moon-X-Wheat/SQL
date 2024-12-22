-- relational database: there are relationships between tables and tables within database
/*
one by one
one by many
many by many

Primary Key：给某些表格的数据赋予一个唯一的标识符，数据就可以在表格之间"游走"
 - 主键和外键：当主键游走到其它表格中的时候，就变成了外键
 - 不同表的主键可以作为外键相互结合，形成一个新的表。（方便解决一对多或者多对多的问题）
*/

-- 从另一个列表中提取主键信息（嵌套搜索）: one to many
SELECT
 AVG(rating)
FROM
	ratings
WHERE
	book_id = (
      SELECT
      	id
      FROM
      	books
      WHERE
      	title like '%memory'
      );

-- 嵌套搜索： many to many，一个列表中的键是另外几个列表的外键。要从同时从其它几个列表中提取信息
SELECT name from authors WHERE id = ( 
	SELECT author_id from authored WHERE book_id = (
		SELECT id from books 
      	WHERE title = 'Flights')
	);

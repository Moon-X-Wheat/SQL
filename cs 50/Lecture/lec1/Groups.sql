-- 按照分组使用聚合函数
SELECT AVG("rating") as 'Average Rating'
FROM ratings
GROUP by book_id;

--
SELECT book_id, AVG("rating") as "Average Rating"
FROM ratings
GROUP by book_id
HAVING "Average Rating" > 4; -- Average Rating包含的内容是组，对组使用条件的关键词是HAVING

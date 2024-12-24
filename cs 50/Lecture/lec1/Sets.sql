-- 集合

-- 并集：找到在表1或在表2中的项（自动删除重复项）
SELECT name 
FROM authors
UNION
SELECT name
FROM translators;

-- 选择列的同时创造一个新的列
SELECT 'author' as "profession", name -- 列的标签为'profession'， 列的内容为author
FROM authors;

--
SELECT 'author' as "profession", name
FROM authors
UNION
SELECT 'translator' AS "profession", name
FROM translators;

-- 且：既在表1也在表2中的项
SELECT name
FROM authors
INTERSECT
SELECT name
from translators;

-- 练习：找到两个翻译者共同翻译的书
SELECT book_id
FROM translated
WHERE translator_id = (
  SELECT id
  FROM translators
  WHERE name LIKE '%costa'
)
INTERSECT
SELECT book_id
FROM translated
WHERE translator_id = (
  SELECT id
  FROM translators
  WHERE name LIKE 'sophie%'
 );

-- 排除：在表1中但是不在表2中的项
SELECT name
FROM authors
EXCEPT
SELECT name
from translators;

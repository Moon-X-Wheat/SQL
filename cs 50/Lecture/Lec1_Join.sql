-- 将两个表连接到一起（这两个表有一列互为主键和外键）

-- 内连接：将键匹配的项连接到一起。主键为两个表都匹配的。不匹配的（一个有，另一个没有）删掉。
SELECT * 
FROM sea_lions
JOIN migrations on sea_lions.id =  migrations.id;

-- 左连接。保留左边的表的主键。按照匹配的键连接，不匹配的依然保留。
SELECT *
FROM sea_lions
LEFT JOIN migrations on sea_lions.id = migrations.id;

-- 右连接。保留右边的表的主键。按匹配的项连接，不匹配的保留（赋值为空）
SELECT *
FROM migrations
RIGHT JOIN sea_lions on sea_lions.id = migrations.id;

-- 全连接。保留两个表所有的键。
SELECT *
FROM sea_lions
FULL JOIN migrations on sea_lions.id = migrations.id;

-- 自然连接。类似内连接。自动匹配主键相同的项，不用单独写ON的条件
SELECT *
FROM sea_lions
NATURAL JOIN migrations 

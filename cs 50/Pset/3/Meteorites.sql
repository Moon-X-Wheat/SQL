-- 清除Null数据


-- 小数转换
update "temp"
set long = round(lat, 2), mass = round(mass,2), long = round(long, 2)


-- all meteorites with nametype "relict" are not include
DELETE from "temp"
where nametype = 'Relict'

-- sorted by year, name


-- updated IDs

insert into meteorites ("name", "nametype", "class", "mass", "dicovery", "year", "lat", "long")
SELECT "name", "nametype", "class", "mass", "discovery", "year", "lat", "long"
from "temp"
order by "year", "name";

-- 先创建一个临时表格，导入数据。在临时表格内进行数据清洗。
-- 创建一个正式的表格，表格的列就是要求的列。
-- 将临时表格的内容导入正式表格。如果需要按照排序后的内容再重新编号，就在导入时排序

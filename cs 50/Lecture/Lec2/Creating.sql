-- 创建数据库
create database balabala

-- 创建表格
CREATE TABLE "station" (
  "id" integer,
  "name" text,
  "line" text
 )
 
-- data type: null, integer, real, text, blob(01001)
-- data affinity: numeric, integer, real, text, blob(01001)

-- 创建主键和外键 (table constraint)
  CREATE TABLE "station" (
    "id" integer,
    "name" text,
    "line" text,
    PRIMARY key ("id") -- 显式主键
  );

  CREATE table "visits" (
    "rider_id" integer,
    "station_id" integer,
    FOREIGN key ("rider_id") REFERENCES "rider"("id") -- 创建外键
    FOREIGN key ("station_id") REFERENCES "station"("id")
  )

-- column constraint
-- not null 非空
-- unique 不可重复
CREATE TABLE "station" (
    "id" integer,
    "name" text not null UNIQUE,
    "line" text not null,
    PRIMARY key ("id")
  );

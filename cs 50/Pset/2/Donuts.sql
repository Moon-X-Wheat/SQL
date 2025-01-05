create table "ingredients" (
  "id" integer,
  "name" text not null,
  "unit" text not null,
  "price($)" numeric not null,
  primary key ("id")
);

create table "donuts" (
  "id" integer,
  "name" text not null unique,
  "gluten-free" text not null check("gluten-free" in ('yes', 'no')),
  "price($)" numeric not null,
  primary key ("id")
);

create table "donunts_ingredients" (
  "donut_id" integer,
  "ingredient_id" integer,
  foreign key ("donut_id") references "donuts"("id"),
  foreign key ("ingredient_id") references "ingredients"("id")
);


create table "order_record" (
  "id" integer,
  "customer_id" integer,
  primary key ("id"),
  foreign key ("customer_id") references "customers"("id")
);


create table "orders" (
  "order_id" integer,
  "donut_id" integer,
  "count" integer default 1,
  "customer_id" integer, 
  primary key ("order_id", "donut_id"),
  foreign key ("order_id") references "order_record"("id"),
  foreign key ("donut_id") references "donuts"("id"),
  foreign key ("customer_id") references "customers"("id")
);

create table "customers" (
  "id" integer,
  "first name" text,
  "last name" text,
  primary key ("id")
);





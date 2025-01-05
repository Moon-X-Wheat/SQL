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

create table "order_history" (
  "order_number" integer,
  "customer_id" integer,
  primary key ("order_number"),
  foreign key ("customer_id") references "customers"("id")
);

create table "orders_donuts" (
  "order_number" integer,
  "donuts_id" integer,
  "count" integer default 1,
  foreign key ("order_number") references "orders"("order_number"),
  foreign key ("order_number") references "donuts"("id")
);

create table "customers" (
  "id" integer,
  "first name" text,
  "last name" text,
  primary key ("id")
);





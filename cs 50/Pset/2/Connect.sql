create table "user" (
  "id" integer,
  "first name" text not null,
  "last name" text not null,
  "user_name" integer not null unique,
  "password" text not null,
  primary key ("id")
);

create table "schools" (
  "id" integer,
  "name" text unique not null,
  "type" text not null,
  "location" text not null,
  "year" integer,
  primary key ("id")
);

create table "companies" (
  "id" integer,
  "name" text not null,
  "industry" text not null,
  "location" text not null,
  primary key ("id")
);


create table "users_connection" (
  "id" integer,
  "user_A_id" integer,
  "user_B_id" integer,
  primary key ("id")
  foreign key ("user_A_id") references "user"("id"),
  foreign key ("user_B_id") references "user"("id")
);

create table "schools_connections" (
  "id" integer,
  "user_id" integer,
  "school_id" integer,
  "start date" date,
  "end date" date,
  "degree" text,
  primary key ("id"),
  foreign key ("user_id") references "user"("id"),
  foreign key ("school_id") references "schools"("id")
);

create table "companies_connections" (
  "id" integer,
  "user_id" integer,
  "company_id" integer,
  "start date" date,
  "end date" date,
  "title" text,
  primary key ("id"),
  foreign key ("user_id") references "user"("id"),
  foreign key ("company_id") references "schools"("id")
);

insert into "user"
values (1, 'Alan', 'Garber', 'alan', 'password');

insert into "user"
values (2, 'Reid', 'Hoffman', 'reid', 'password');

insert into "school"
values (1, 'Harvard University', 'University', 'Cambridge Massachusetts', '1636');

insert into "companies"
values (1, 'Linkedln', 'Technology', 'Sunnyvale, California');

insert into "schools_connections"
values (1, 1, 1, '1973-09-01', '1976-06-01', 'BA');

insert into "companies_connections"
values (1, 2, '1', '2003-01-01', '2007-02-01', 'CEO, Chairman');

ALTER TABLE companies_connections
add COLUMN "status" text CHECK ("status" in ('earned', 'pursued')) -- 添加列：是否在职；是否在读


  
  
  

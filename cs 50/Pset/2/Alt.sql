create table "passenger" (
  "id" integer,
  "first_name" text not null,
  "last_name" text not null,
  "age" integer not null,
  PRIMARY key ("id")
  );
  
create table "check-ins" (
  "id" integer,
  "passenger_id" integer,
  "time" numeric not null,
  "flight_id" integer,
  PRIMARY key ("id"),
  FOREIGN key ("flight_id") REFERENCES "flights"("id")
  FOREIGN key ("passenger_id") REFERENCES "passenger"("id")
 );
 
 create table "airlines" (
   "id" integer,
   "name" text not null UNIQUE,
   "concourse" text not null,
   PRIMARY key ("id")
  );
  
  create table "flight" (
    "id" integer,
    "flight number" integer not null,
    "airline_id" integer,
    "to airport" text not null,
    "heading airport code" text not null,
    "departure time" numeric not null,
    "arrival time" numeric not null,
    PRIMARY key ("id"),
    FOREIGN key ("airline_id") REFERENCES "airlines"("id")
  );
  
  



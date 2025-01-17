create table "triplets" (
  "id" integer PRIMARY key,
  "sentences_id" integer,
  "character_id" integer,
  "lenght" integer);

insert into "triplets" ("sentences_id", "character_id", "lenght")
VALUES 
	(14, 98, 4),
	(114, 3, 5),
    (618, 72, 9),
    (630, 7, 3),
    (932, 12, 5),
    (2230, 50, 7),
    (2346, 44, 10),
    (3041, 14, 5);

create view "message" as 

with "pool" as (
select "sentences_id", "character_id", "lenght", "sentence"
from sentences
join triplets on "sentences"."id" = "triplets"."sentences_id")

SELECT substr("sentence", "character_id", "lenght") as "phrase"
from "pool"

create view message as
select
    s.id,
    s.sentence,
    t.starting_char,
    t.length,
    substr(s.sentence, t.starting_char, t.length) as phrase
from
    sentences as s
inner join
    triplets as t on s.id = t.sentence_id;

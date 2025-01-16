-- Rural
create view "rural" as
SELECT * from census
where "locality" like '%rural%'

-- Total
create view "total" as
select 
    sum("families") as "families", 
    sum("households") as "households", 
    sum("population") as "population",
    sum("male") as "male",
    sum("female") as "female"
from census


-- By district
create view "by_district" as
select 
	"id", 
    "district", 
    sum("families") as "families", 
    sum("households") as "households", 
    sum("population") as "population",
    sum("male") as "male",
    sum("female") as "female"
from census
group by "district"

-- Most Populated
create view "most_populated" as
select 
	"id", 
    "district", 
    sum("families") as "families", 
    sum("households") as "households", 
    sum("population") as "population",
    sum("male") as "male",
    sum("female") as "female"
from census
group by "district"
order by "population" DESC

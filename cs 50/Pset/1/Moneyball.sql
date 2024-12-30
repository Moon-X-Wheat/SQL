-- 1. 
SELECT year, ROUND(AVG(salary), 2) as "average salary"
FROM salaries
GROUP by year
ORDER by "year" DESC;


-- 2.
SELECT year, salary
FROM salaries
WHERE player_id = (
  select id
  from players
  WHERE first_name = 'Cal' and last_name = 'Ripken'
)
ORDER by year Desc;

-- 3.
select year, hr
FROM performances
WHERE player_id = (
  SELECT id
  FROM players
  WHERE first_name = 'Ken' and last_name = 'Griffey' and birth_year = 1969
)
ORDER by year Desc;

-- 4.
SELECT "players"."first_name", "players"."last_name", "salaries"."salary"
FROM players
join salaries on "players"."id" = "salaries"."player_id"
WHERE year = 2001
ORDER by salary, first_name, last_name, player_id
limit 50;

-- 5. all teams SP played for, only teams' names
select name
FROM teams
WHERE id in (
  SELECT DISTINCT team_id
  FROM performances
  WHERE player_id = (
    SELECT id
    FROM players
    WHERE first_name = 'Satchel'
  )
)

-- 6. the top 5 teams, sorted by the total number of hits players 2001: column name: totals hits; 
SELECT "teams"."name", SUM("performances"."H") as "total hits"
FROM teams
JOIN performances on "teams"."id" = "performances"."team_id"
WHERE "performances"."year" = 2001
GROUP by "teams"."name"
order by "total hits" DESC
limit 5;

-- 7. player who's been paid the highest salary, of all time: two columns: first name and last name
SELECT first_name, last_name
FROM players
WHERE id = (
  SELECT player_id
  FROM salaries
  GROUP by player_id
  HAVING SUM(salary) = (
    SELECT  SUM(salary) as "total salary"
    FROM salaries
    GROUP by player_id
    ORDER by "total salary" DESC
    LIMIT 1
  )
)

-- 8. 2001 salary of the player who hit the most home runs in 2001: only salary 1030000
WITH "most home runs" as (
SELECT player_id, SUM(hr) as "total hits"
FROM performances
where year =2001
group by player_id
ORDER by "total hits" Desc
LIMIT 1
)
SELECT salary
from salaries
WHERE 
	player_id = (
  	SELECT "player_id"
  	from "most home runs"
	) 
	and year = 2001

select salary
from salaries
join performances on performances.player_id = salaries.player_id
WHERE performances.year = 2001 and salaries.year = 2001
order by HR DESC
LIMIT 1

-- 9. 5 lowest paying teams (by average salary) in 2001: round the average salary to two decimal places and call it "average salary:; sort by average salary, least to greatest; two columns: names and average salary
SELECT name, ROUND(AVG(salary), 2) as "average salary"
from salaries
join teams on "teams"."id" = "salaries"."team_id"
WHERE "teams"."year" = 2001
GROUP by name
ORDER by "average salary"
limit 5

-- 10. each player's name, salary for each year, numner of home runs for each year. 6 columns: first name, last name, salaries, year of the salaries, homes runs, year of the home runs
SELECT first_name, last_name, salary, salaries.year, HR
FROM players
join salaries on salaries.player_id = players.id
join performances on performances.player_id = players.id and performances.year = salaries.year
order by players.id, salaries.year Desc, HR DESC, salary DESC

-- 11. 10 least expensive players per hit in 2001
SELECT first_name, last_name, salary/H as "dollars per hit"
from players
join performances on performances.player_id = players.id
join salaries on salaries.player_id = players.id and salaries.year = performances.year
WHERE salaries.year = 2001 and H != 0
order by "dollars per hit", first_name, last_name
LIMIT 10

-- 12. among 10 least expensive players per hit and among the 10 least expensive players per RBI in 2001




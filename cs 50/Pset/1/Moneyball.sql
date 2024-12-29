-- 1. 
SELECT year, AVG(salary) as "average salary"
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

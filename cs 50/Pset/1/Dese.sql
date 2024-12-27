-- 1. names and cities of all public schools in M
SELECT name, city
FROM schools
WHERE type like 'public%'

-- 2. districts that are no longer operational
SELECT name
FROM districts
WHERE name LIKE '%(non-op)';

-- 3. how much money, on average, districts spent per-pupil last year
SELECT SUM(pupils * per_pupil_expenditure)/SUM(pupils) as "Average District Per-Pupil expenditure"
from expenditures

-- 4. find the 10 cities with the most public schools. return the names of the cities and the number of public schools, ordered from greatest to least, then order alphabetically.
SELECT city, COUNT(name) as "Number of public schools"
from schools
GROUP by city
ORDER by "Number of public schools" DESC, city
LIMIT 10;

-- 5. find cities with 3 or fewer public schools, return names and number of public school, ordered from greatest to least
SELECT city, COUNT(name) as "Number of public schools"
from schools
GROUP by city
HAVING "Number of public schools" <= 3
ORDER by "Number of public schools" DESC, city;

-- 6. names of school achieved a 100% graduation rate
SELECT name
FROM schools
WHERE id in (
  SELECT school_id
  FROM graduation_rates
  WHERE graduated = 100
);

-- 7. names of schools in the Cambridge school district.
SELECT name
FROM schools
WHERE district_id = (
  SELECT id
  FROM districts
  WHERE name = 'Cambridge'
)

-- 8. names of schools districts andthe numbers of pupils
SELECT "districts"."id", "districts"."name", "expenditures"."pupils"
FROM districts
LEFT join expenditures
ON "districts"."id" = "expenditures"."district_id"

-- 9. name of the school district with the single least number of pupils
SELECT name
FROM districts
WHERE id = (
  SELECT district_id
  FROM expenditures
  ORDER by pupils
  LIMIT 1
)

-- 10. 10 public school districts with the highest per-pupil expenditures, with names and per-pupil expenditure for each
SELECT "districts"."id","districts"."name", "expenditures"."per_pupil_expenditure"
FROM districts
LEFT JOIN expenditures
ON "expenditures"."district_id" = "districts"."id"
WHERE "districts"."type" LIKE 'Public%'
ORDER by "expenditures"."per_pupil_expenditure" DESC

-- 11. names of schools, per-pupil expenditure, graduation rate, sorted from greatest per-pupil expenditure to least, than school name.
SELECT "schools"."id", "schools"."name","graduation_rates"."graduated", "expenditures"."per_pupil_expenditure"
FROM schools
LEFT join graduation_rates
on "schools"."id" = "graduation_rates"."school_id"
LEFT join expenditures
on "schools"."district_id" = "expenditures"."district_id"
ORDER by per_pupil_expenditure DESC, name

-- school districts with above-average percentage of teachers rated "exemplary", and above-average per-pupil expenditures, sorted by exemplary and by expenditure
SELECT "districts"."id", "districts"."name", "staff_evaluations"."exemplary", "expenditures"."per_pupil_expenditure"
FROM districts
left join staff_evaluations
on "districts"."id" = "staff_evaluations"."district_id"
LEFT JOIN expenditures
on "districts"."id" = "expenditures"."district_id"
WHERE 
	exemplary > (
      SELECT AVG(exemplary)
  		FROM staff_evaluations
    )
  AND
  per_pupil_expenditure > (
      SELECT AVG(per_pupil_expenditure)
  		FROM expenditures
    )
ORDER by exemplary DESC, per_pupil_expenditure DESC

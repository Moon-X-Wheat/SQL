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

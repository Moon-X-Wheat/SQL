- 1.
SELECT
	first_name,
    last_name,
    birth_city,
    birth_state,
    birth_country
FROM
	players
WHERE
	first_name = 'Jackie'
    AND
    last_name = 'Robinson';

- 2.
SELECT
	first_name, last_name, bats
FROM
	players
WHERE
	first_name = 'Babe' and last_name = 'Ruth';

- 3.
SELECT
	id
FROM
	players
WHERE
	debut is NULL;
    
-4.
SELECT
	first_name, last_name, birth_country
FROM
	players
WHERE
	birth_country != 'USA'
ORDER BY
	first_name, last_name;
    
    


- 5.
SELECT
	first_name, last_name, bats
FROM
	players
WHERE
	bats = 'L'
ORDER BY
	first_name, last_name;

- 6.
SELECT
	first_name, last_name, debut, birth_city, birth_state
FROM
	players
WHERE
	birth_city = 'Pittsburgh' AND birth_state = 'PA'
ORDER BY
	debut DESC, first_name, last_name;
    
- 7.
SELECT
	COUNT(*)
FROM
	players
WHERE
	(bats = 'L' AND throws = 'R') or (bats = 'R' and throws = 'L');
    
- 8.
SELECT
	ROUND(AVG(height), 2) AS 'Average Height', 
    	ROUND(AVG(weight), 2) as 'Average Weight'
FROM
	players
WHERE
	debut >= '2000%'
    
- 9.
SELECT
	first_name, last_name, final_game
FROM
	players
WHERE
	final_game LIKE '2022%'
order BY
	first_name, last_name;
    
    
    
    

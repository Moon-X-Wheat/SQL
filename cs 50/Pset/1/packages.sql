-- Lost Letter
-- At what type of address did the lost letter end up: Residential
-- At what address did the lost letter end up: 2 Finnigan Street
-- At what type of address did th lost letter end up:
SELECT address, type
from addresses
WHERE id = (
  SELECT address_id
  FROM scans
  WHERE 
      package_id = (
      SELECT id
      from packages
      WHERE contents LIKE '%congratulatory%'
      )
      AND
      "action" = 'Drop'
);

-- The Devious Delivery
-- At what type of address did the devious delivery end up: Police Station
-- What are the content of the devious delivery: Duck debugger
SELECT address, type
from addresses
WHERE id = (
  SELECT address_id
  from scans
  WHERE 
    package_id = (
      SELECT id
      from packages
      WHERE 
          contents LIKE '%duck%'
          AND
          from_address_id IS NULL
    )
    AND
    "action" = 'Drop'
);


-- The forgotten gift
-- what are the content of the forgotten gift: Flowers
-- who has the forgotten gift: Mikel
SELECT name
from drivers
WHERE id = (
  SELECT driver_id
  from scans
  WHERE timestamp = (
    SELECT MAX("timestamp")
    from scans
    WHERE package_id = (
      SELECT id
      FROM packages
      WHERE from_address_id = (
        SELECT id
        FROM addresses
        WHERE address like '%109 Tileston%'
      )
    )
  )
 )


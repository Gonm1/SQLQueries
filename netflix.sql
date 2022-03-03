SELECT * FROM netflix

SELECT type, count(*)
FROM netflix
GROUP BY type

-- Directors with most shows
SELECT director, count(*)
FROM netflix
WHERE director is not NULL
GROUP BY director
ORDER BY count(*) DESC
LIMIT 20

SELECT date_added
from netflix
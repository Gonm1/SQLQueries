-- Amount of shows per type
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

-- Amount of shows or movies added to netflix by year
SELECT substr(date_added, -4) as "Year", count(*) as "Shows added"
FROM netflix
WHERE substr(date_added, -4) IS NOT NULL
GROUP BY substr(date_added, -4)
ORDER BY substr(date_added, -4) DESC

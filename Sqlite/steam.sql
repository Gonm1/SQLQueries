-- Top 10 publishers on steam of all time
SELECT publisher, count(*) as "published games"
FROM steam
GROUP BY publisher
ORDER BY count(*) DESC
LIMIT 10;

-- Show date range of the data
SELECT min(release_date), max(release_date)
FROM steam;

-- Top 10 publishers on steam on 2019 (only 5 months of data)
SELECT publisher, count(*)
FROM steam
WHERE date(release_date) BETWEEN date("2019-01-01") and date("2019-12-31")
GROUP BY publisher
ORDER BY count(*) DESC
LIMIT 10;

-- Top 10 publishers on steam on 2018
SELECT publisher, count(*)
FROM steam
WHERE date(release_date) BETWEEN date("2018-01-01") and date("2018-12-31")
GROUP BY publisher
ORDER BY count(*) DESC
LIMIT 10;

-- Games per platform
SELECT platforms, count(*)
FROM steam
GROUP BY platforms
ORDER BY count(*) DESC

-- Most played game on average
SELECT name, developer, publisher, release_date, average_playtime
FROM steam
WHERE average_playtime = (SELECT max(average_playtime) FROM steam)

-- Top 10 games with the most positive ratings
SELECT name, developer, publisher, release_date, positive_ratings
FROM steam
ORDER BY positive_ratings DESC
LIMIT 10

-- Top 10 games with the most positive ratings and released on on 2018
SELECT name, developer, publisher, release_date, positive_ratings
FROM steam
WHERE date(release_date) BETWEEN date("2018-01-01") and date("2018-12-31")
ORDER BY positive_ratings DESC
LIMIT 10

-- Amount of games released by year
SELECT strftime('%Y',release_date) as year, count(*)
FROM steam
GROUP BY year
ORDER BY year DESC

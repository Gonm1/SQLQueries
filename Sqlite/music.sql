-- Join tables
SELECT tracks.Name AS "Song name", albums.Title as "Album title", genres.Name as "Genre", artists.Name as "Artist"
FROM tracks
JOIN albums ON albums.AlbumId = tracks.AlbumId
JOIN genres ON tracks.GenreId = genres.GenreId
JOIN artists ON  artists.ArtistId = albums.ArtistId

-- List rock artists with the top 10 longest songs
SELECT tracks.Name as "Song name", artists.Name as "Artist", tracks.Milliseconds as "Length in ms", genres.Name as "Genre"
FROM tracks
JOIN albums ON albums.AlbumId = tracks.AlbumId
JOIN genres ON tracks.GenreId = genres.GenreId
JOIN artists ON  artists.ArtistId = albums.ArtistId
WHERE genres.Name = "Rock"
ORDER BY tracks.Milliseconds DESC
LIMIT 10

-- List top 10 customers by amount bought
-- summing individual items
SELECT (customers.FirstName || " " || customers.LastName) as "Customer name", customers.Company, sum(invoice_items.UnitPrice) as "Total bought"
FROM invoices
JOIN customers ON invoices.CustomerId = customers.CustomerId
JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
GROUP BY customers.FirstName, customers.LastName, customers.Company
ORDER BY sum(invoice_items.UnitPrice) DESC
 -- OR
 -- using total of invoice
SELECT (customers.FirstName || " " || customers.LastName) as "Customer name", customers.Company, sum(invoices.Total) as "Total bought"
FROM invoices
JOIN customers ON invoices.CustomerId = customers.CustomerId
GROUP BY customers.FirstName, customers.LastName, customers.Company
ORDER BY  sum(invoices.Total) DESC

-- Date range
SELECT min(InvoiceDate), max(InvoiceDate)
FROM invoices

-- Total sells Q4 2012
SELECT strftime("%Y",InvoiceDate) as "Q4", sum(Total)
FROM invoices
WHERE strftime("%Y",InvoiceDate) = "2012" 
AND (strftime("%m",InvoiceDate) = "10" OR strftime("%m",InvoiceDate) = "11" OR strftime("%m",InvoiceDate) = "12")
GROUP BY strftime("%Y",InvoiceDate)

-- List employees and the amount of customers assingned to each
SELECT employees.FirstName, employees.LastName, employees.Title, count(*) as "Customers assigned"
FROM employees
JOIN customers ON  employees.EmployeeId = customers.SupportRepId
GROUP BY employees.FirstName, employees.LastName, employees.Title

-- List songs ordered by the total times sold
SELECT tracks.Name, sum(invoice_items.UnitPrice) as "Revenue", count(*) as "Amount sold"
FROM invoice_items
JOIN tracks ON invoice_items.TrackId = tracks.TrackId
GROUP BY tracks.Name
ORDER BY count(*) DESC
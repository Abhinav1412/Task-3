--a.Use SELECT, WHERE, ORDER BY, GROUP BY (earthquakes above magnitude 4, ordered by magnitude)
SELECT id, place, mag
FROM earthquakes
WHERE mag > 4
ORDER BY mag DESC;

-- (Count of earthquakes grouped by place)
SELECT place, COUNT(*) AS num_quakes
FROM earthquakes
GROUP BY place

-- Creating a table stations for joins:
CREATE TABLE stations (
    id TEXT PRIMARY KEY,
    name TEXT
);
INSERT INTO stations (id, name)
SELECT DISTINCT net, net
FROM earthquakes
WHERE net IS NOT NULL;

-- b.Use JOINS (INNER, LEFT, RIGHT) LEFT JOIN: (All earthquakes, even ones without the station data)
SELECT e.id, e.place, e.net, s.name AS station_name
FROM earthquakes e
LEFT JOIN stations s ON e.net = s.id
LIMIT 20;

-- RIGHT JOIN: (LEFT JOIN from other side)
SELECT s.id AS station_id, s.name AS station_name, e.place, e.mag
FROM stations s
LEFT JOIN earthquakes e ON s.id = e.net
LIMIT 20;

-- INNER JOIN:
SELECT e.id, e.place, e.net, s.name AS station_name
FROM earthquakes e
INNER JOIN stations s ON e.net = s.id
LIMIT 20;

-- c.Write subqueries (Earthquakes stronger than average)
SELECT id, place, mag
FROM earthquakes
WHERE mag > (
    SELECT AVG(mag) FROM earthquakes
);

-- d.Use aggregate functions (SUM, AVG) 
-- AVG (Average magnitude by region)
SELECT place, AVG(mag) AS avg_mag
FROM earthquakes
GROUP BY place;

-- SUM (Total depth per place)
SELECT place, SUM(depth) AS total_depth
FROM earthquakes
GROUP BY place;

-- e.Create views for analysis 
-- (A view for all high-magnitude earthquakes)
CREATE VIEW high_mag_quakes AS
SELECT id, place, mag
FROM earthquakes
WHERE mag >= 6;

-- (Query the view)
SELECT * FROM high_mag_quakes ORDER BY mag DESC;

--  f. Optimize Queries with Indexes 
-- (An index on magnitude)
CREATE INDEX idx_mag ON earthquakes(mag);

-- (Index on multiple columns)
CREATE INDEX idx_place_mag ON earthquakes(place, mag);

SELECT * FROM earthquakes WHERE mag > 5.0 ORDER BY mag DESC LIMIT 10;xes
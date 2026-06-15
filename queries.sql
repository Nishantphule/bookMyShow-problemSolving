USE bookmyshow;

-- P2 - list shows for a theatre on a specific date
-- update the date and theatre_id as needed

SELECT
    m.title         AS movie_name,
    l.language_name AS language,
    m.format        AS movie_format,
    sc.screen_name,
    s.show_date,
    s.show_time,
    s.available_seats,
    s.price
FROM `Show` s
JOIN Screen sc ON s.screen_id = sc.screen_id
JOIN Theatre t ON sc.theatre_id = t.theatre_id
JOIN Movie m ON s.movie_id = m.movie_id
JOIN Language l ON m.language_id = l.language_id
WHERE s.show_date = '2023-04-25'
  AND t.theatre_id = 1
ORDER BY m.title, s.show_time;

-- same query but filter by theatre name instead of id

SELECT
    m.title         AS movie_name,
    l.language_name AS language,
    m.format        AS movie_format,
    sc.screen_name,
    s.show_date,
    s.show_time,
    s.available_seats,
    s.price
FROM `Show` s
JOIN Screen sc ON s.screen_id = sc.screen_id
JOIN Theatre t ON sc.theatre_id = t.theatre_id
JOIN Movie m ON s.movie_id = m.movie_id
JOIN Language l ON m.language_id = l.language_id
WHERE s.show_date = '2023-04-25'
  AND t.name LIKE '%PVR%Nexus%'
ORDER BY m.title, s.show_time;

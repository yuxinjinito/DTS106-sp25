SELECT
  f.title AS movie_title,
  ROUND(AVG(r.imdb_score), 2) AS average_score
FROM films AS f
JOIN reviews AS r
  ON f.id = r.film_id
GROUP BY f.id, f.title
ORDER BY average_score DESC
LIMIT 5;

SELECT
  f.title AS movie_title,
  COUNT(r.id) AS review_count
FROM films AS f
JOIN reviews AS r
  ON f.id = r.film_id
GROUP BY f.id, f.title
HAVING COUNT(r.id) > 5;

SELECT
  p.name AS actor_name,
  COUNT(DISTINCT r.film_id) AS film_count
FROM roles AS r
JOIN films AS f
  ON r.film_id = f.id
JOIN people AS p
  ON r.people_id = p.id
GROUP BY p.id, p.name;


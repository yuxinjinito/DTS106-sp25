SELECT
  m.title,
  ROUND(AVG(r.score),2) AS avg_score,
  COUNT(r.review_id)    AS review_count
FROM movie m
JOIN review r
  ON r.movie_id = m.movie_id
WHERE m.release_year   > 2018
  AND m.is_deleted      = FALSE
  AND r.is_deleted      = FALSE
GROUP BY m.movie_id, m.title
HAVING AVG(r.score)    > 7
   AND COUNT(r.review_id) > 1
ORDER BY avg_score DESC;

SELECT
  m.title,
  ROUND(AVG(r.score),2) AS avg_score
FROM movie m
JOIN review r
  ON r.movie_id    = m.movie_id
WHERE m.genre_id   = (
        SELECT genre_id
        FROM genre
        WHERE name = 'Science Fiction'
      )
  AND m.director_id = (
        SELECT director_id
        FROM director
        WHERE name = 'Greta Gerwig'
      )
  AND m.is_deleted  = FALSE
  AND r.is_deleted  = FALSE
GROUP BY m.movie_id, m.title
HAVING AVG(r.score) > 7
ORDER BY avg_score DESC;

SELECT
  m.title                                 AS movie_title,
  r.score                                 AS current_score,
  r.content                               AS current_comment,
  ARRAY_AGG(rl.score ORDER BY rl.op_time)   AS prior_scores,
  ARRAY_AGG(rl.content ORDER BY rl.op_time) AS prior_comments
FROM review r
JOIN "user" u
  ON r.user_id    = u.user_id
JOIN movie m
  ON r.movie_id   = m.movie_id
LEFT JOIN reviewlog rl
  ON rl.review_id = r.review_id
 AND rl.op_time   < r.updated_at
WHERE u.email        = 'eve@example.com'
  AND r.created_at   BETWEEN '2023-05-01 00:00' AND '2023-05-31 23:59'
  AND r.score        < 7
  AND u.is_deleted   = FALSE
  AND r.is_deleted   = FALSE
  AND m.is_deleted   = FALSE
GROUP BY r.review_id, m.title, r.score, r.content
ORDER BY r.created_at;

SELECT
  u.email,
  COUNT(op.olog_id) AS update_count
FROM operationlog op
JOIN movie    m ON op.movie_id = m.movie_id
JOIN "user"   u ON op.user_id  = u.user_id
WHERE m.title       = 'SciFi Galaxy'
  AND op.action     = 'UPDATE'
  AND op.op_time    BETWEEN '2023-01-01 00:00' AND '2023-12-31 23:59'
GROUP BY u.email
ORDER BY update_count DESC;

SELECT
  u.email               AS user_email,
  m.title               AS movie_title,
  MIN(rl.score)         AS lowest_historical_score,
  r.score               AS current_score,
  COUNT(*)              AS num_improvements
FROM reviewlog rl
JOIN review   r  ON rl.review_id = r.review_id
JOIN "user"   u  ON r.user_id    = u.user_id
JOIN movie    m  ON r.movie_id   = m.movie_id
WHERE rl.score      < r.score
  AND u.is_deleted   = FALSE
  AND r.is_deleted   = FALSE
  AND m.is_deleted   = FALSE
GROUP BY u.email, m.title, r.score
ORDER BY num_improvements DESC;
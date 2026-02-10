CREATE TABLE films (
  id            INTEGER        PRIMARY KEY,
  title         VARCHAR(200)   NOT NULL,
  release_year  INTEGER        NOT NULL,
  place_name    VARCHAR(50)    NOT NULL,
  duration      NUMERIC(5,1),
  language      VARCHAR(30),
  certification VARCHAR(20),
  gross         NUMERIC(12,2),
  budget        NUMERIC(14,2),
  UNIQUE (title, release_year, place_name)
);

CREATE TABLE people (
  id         INTEGER      PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  birthdate  TEXT,
  deathdate  TEXT
);

CREATE TABLE reviews (
  id             INTEGER       PRIMARY KEY,
  film_id        INTEGER       NOT NULL
                            REFERENCES films(id),
  num_critic     INTEGER,
  imdb_score     NUMERIC(3,1)  NOT NULL,
  num_votes      INTEGER,
  facebook_likes INTEGER
);

CREATE TABLE roles (
  id          INTEGER       PRIMARY KEY,
  film_id     INTEGER       NOT NULL
                         REFERENCES films(id),
  people_id   INTEGER       NOT NULL
                         REFERENCES people(id),
  role        VARCHAR(20)   NOT NULL
);

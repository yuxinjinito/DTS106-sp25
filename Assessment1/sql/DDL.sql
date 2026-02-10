CREATE TABLE "user" (
    user_id   SERIAL PRIMARY KEY,
    email     VARCHAR(200) NOT NULL UNIQUE,
    password  VARCHAR(255) NOT NULL,
    reg_ip    VARCHAR(45)  NOT NULL,
    is_deleted BOOLEAN     DEFAULT FALSE
);

CREATE TABLE genre (
    genre_id SERIAL PRIMARY KEY,
    name     VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE director (
    director_id SERIAL PRIMARY KEY,
    name        VARCHAR(150) NOT NULL
);

CREATE TABLE actor (
    actor_id INTEGER   PRIMARY KEY,
    name     VARCHAR(150) NOT NULL
);

CREATE TABLE movie (
    movie_id     SERIAL PRIMARY KEY,
    title        VARCHAR(200) NOT NULL,
    release_year SMALLINT    NOT NULL
                   CHECK (release_year BETWEEN 1888 AND EXTRACT(YEAR FROM CURRENT_DATE)+1),
    synopsis     TEXT,
    media_url    VARCHAR(500),
    genre_id     INTEGER     NOT NULL REFERENCES genre(genre_id),
	director_id  INTEGER     NOT NULL REFERENCES director(director_id),
    is_deleted   BOOLEAN     DEFAULT FALSE
);

CREATE TABLE features (
    movie_id  INTEGER NOT NULL
               REFERENCES movie(movie_id),
    actor_id  INTEGER NOT NULL
               REFERENCES actor(actor_id),
    role_name VARCHAR(100),
    PRIMARY KEY (movie_id, actor_id)
);

CREATE TABLE review (
    review_id  SERIAL PRIMARY KEY,
    user_id    INTEGER NOT NULL
               REFERENCES "user"(user_id),
    movie_id   INTEGER NOT NULL
               REFERENCES movie(movie_id),
    score      SMALLINT NOT NULL
               CHECK (score BETWEEN 0 AND 10),
    content    VARCHAR(500),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN   DEFAULT FALSE,
    UNIQUE (user_id, movie_id)
);

CREATE TABLE reviewlog (
    rlog_id   SERIAL PRIMARY KEY,
    review_id INTEGER NOT NULL
              REFERENCES review(review_id),
    user_id   INTEGER NOT NULL
              REFERENCES "user"(user_id),
    movie_id  INTEGER NOT NULL
              REFERENCES movie(movie_id),
    score     SMALLINT NOT NULL CHECK (score BETWEEN 0 AND 10),
    content   VARCHAR(500),
    op_time   TIMESTAMP NOT NULL,
    op_ip     VARCHAR(45) NOT NULL
);

CREATE TABLE operationlog (
    olog_id  SERIAL PRIMARY KEY,
    user_id  INTEGER NOT NULL
             REFERENCES "user"(user_id),
    movie_id INTEGER NOT NULL
             REFERENCES movie(movie_id),
    action   VARCHAR(50) NOT NULL,
    op_time  TIMESTAMP   NOT NULL
             DEFAULT NOW()
);

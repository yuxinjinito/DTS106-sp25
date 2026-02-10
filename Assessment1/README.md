# Assessment 1 — Movie Review Database

This assignment implements a database design and queries for movies and user reviews.

## Directory Structure

```
Assessment1/
├── README.md           # This file
├── Assessment1 Req.pdf  # Assignment requirements
├── report1.docx        # Written report
├── report1.pdf
└── sql/
    ├── dbschema.sql    # Database schema overview
    ├── DDL.sql         # Data definition (table creation)
    ├── DML.sql         # Data manipulation (sample data inserts)
    └── DQL.sql         # Data queries (sample queries)
```

## Database Overview

- **DBMS**: PostgreSQL (uses `SERIAL`, `ARRAY_AGG`, etc.).
- **Core entities**: Users, movies, genres, directors, actors, reviews, and audit/log tables.

### Main Tables

| Table | Description |
|-------|-------------|
| `user` | Users (email, password, registration IP, soft delete) |
| `genre` | Movie genres |
| `director` | Directors |
| `actor` | Actors |
| `movie` | Movies (title, year, synopsis, genre, director, soft delete, etc.) |
| `features` | Movie–actor many-to-many (with role name) |
| `review` | User ratings and comments (0–10, updatable) |
| `reviewlog` | Review change history (score, content, operation time, IP) |
| `operationlog` | User operation log on movies (CREATE/UPDATE/DELETE) |

## Execution Order

Run the SQL files in PostgreSQL in this order:

1. **DDL.sql** — Create all tables
2. **DML.sql** — Insert sample data
3. **DQL.sql** — Run sample queries (read-only; can be run anytime)

## DQL Queries

`DQL.sql` contains 5 sample queries:

1. **High-rated movies**: Movies released after 2018, not deleted, average score > 7 and review count > 1, ordered by average score descending.
2. **Genre + director**: Science Fiction movies directed by Greta Gerwig with average score > 7.
3. **User review history**: For a given user (e.g. eve@example.com), reviews in May 2023 with score < 7, with prior scores and content from `reviewlog`.
4. **Update count**: Users who performed UPDATE on the movie "SciFi Galaxy" in 2023 and how many times.
5. **Score improvements**: Compare `reviewlog` with `review` to find reviews where the lowest historical score is less than the current score, ordered by number of improvements.

## Reports and Requirements

- Full assignment and grading criteria: **Assessment1 Req.pdf**
- Design and analysis: **report1.docx** / **report1.pdf**

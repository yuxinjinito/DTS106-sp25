# Assessment 2 — Film Dataset Queries

This assignment builds tables and queries on a given film dataset (films, people, reviews, roles).

## Directory Structure

```
Assessment2/
├── README.md           # This file
├── Assessment2 Req.pdf # Assignment requirements
├── report2.docx        # Written report
├── report2.pdf
└── sql/
    ├── film_dbschema.sql # Database schema overview
    ├── DDL.sql           # Data definition (table creation)
    └── DQL.sql           # Data queries (sample queries)
```

The **Dataset/** folder at the project root provides the source CSV files:

- `films.csv`   — Film metadata
- `people.csv`  — People (actors, directors, etc.)
- `reviews.csv` — Reviews/scores (e.g. IMDB score, vote count)
- `roles.csv`   — Film–people role relationships

## Database Overview

- **Core tables**: `films`, `people`, `reviews`, `roles`.
- Designed as a relational schema for loading CSV data and running analytical queries.

### Main Tables

| Table | Description |
|-------|-------------|
| `films` | Films (id, title, release year, place, duration, language, certification, gross, budget, etc.) |
| `people` | People (id, name, birthdate, deathdate) |
| `reviews` | Reviews/scores (linked by film_id; num_critic, imdb_score, num_votes, facebook_likes, etc.) |
| `roles` | Roles (film_id, people_id, role — who played what in which film) |

## Execution Order

1. **DDL.sql** — Create `films`, `people`, `reviews`, and `roles` (respect foreign key order).
2. Use your DB’s CSV import or a script to load the CSVs from **Dataset/** into these tables.
3. **DQL.sql** — Run the sample queries (read-only).

## DQL Queries

`DQL.sql` contains 3 sample queries:

1. **Top 5 by average score**: Group by film, average `reviews.imdb_score`, return the 5 films with highest average.
2. **Review count filter**: Count reviews per film and keep only films with more than 5 reviews.
3. **Actor film count**: Group by person and count distinct films via `roles` (`COUNT(DISTINCT film_id)`).

## Reports and Requirements

- Full assignment and grading criteria: **Assessment2 Req.pdf**
- Design and analysis: **report2.docx** / **report2.pdf**

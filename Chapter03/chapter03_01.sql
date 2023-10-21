-- Chapter 3
-- Listing 1: Example role creation

CREATE ROLE book_authors
WITH NOLOGIN;

CREATE ROLE luca
WITH LOGIN PASSWORD 'xxx'
IN ROLE book_authors;

CREATE ROLE enrico
WITH LOGIN PASSWORD 'xxx'
IN ROLE book_authors;

-- create 1000 users
insert into users(username, gecos, email)
select
    'user-' || v as a,
    'Automatically generated user #' || v as b,
    'author' || v || '@learn-postgresql.org' as c
from generate_series(1, 1000) as v;

-- generate 5000 post per author
-- this will create a table around 400 MB in size!
insert into posts(title, author, category, editable)
select
    'Thread-' || v as c,
    a.pk as d,
    v % 3 + 1 as e
    -- coalesce('0', false) as f
from generate_series(1, 5000) as v, users as a;

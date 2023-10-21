select * from categories ORDER BY description;

select name, setting
from pg_settings
where name LIKE 'cpu%\_cost'
OR name LIKE '%page\_cost'
ORDER BY setting DESC;

CREATE INDEX idx_post_category on posts( category );

CREATE INDEX idx_author_created_on on posts( author, created_on );

CREATE INDEX idx_post_created_on on posts USING hash ( created_on );

\d posts

select relname, relpages, reltuples,
i.indisunique, i.indisclustered, i.indisvalid,
pg_catalog.pg_get_indexdef(i.indexrelid, 0, true)
from pg_class c JOIN pg_index i on c.oid = i.indrelid
where c.relname = 'posts';

UPDATE pg_index SET indisvalid = false
where indexrelid = ( select oid from pg_class
where relkind = 'i'
AND relname = 'idx_author_created_on' );

EXPLAIN select * from categories;

EXPLAIN select title from categories ORDER BY description DESC;

EXPLAIN ( FORMAT JSON ) select * from categories;

EXPLAIN select * from categories;

EXPLAIN ANALYZE select * from categories;

EXPLAIN (VERBOSE on) select * from categories;

EXPLAIN (COSTS off) select * from categories;

EXPLAIN (COSTS on) select * from categories;

EXPLAIN (ANALYZE on, TIMING off) select * from categories;

EXPLAIN (ANALYZE, SUMMARY on) select * from categories;

EXPLAIN (ANALYZE, BUFFERS on) select * from categories;

EXPLAIN (WAL on, ANALYZE on, FORMAT yaml)
insert into users( username, gecos, email)
select 'username'||v, v, v||'@c.b.com' from generate_series(1, 100000) v;

EXPLAIN select * from posts ORDER BY created_on;

EXPLAIN ANALYZE select * from posts ORDER BY created_on;

CREATE INDEX idx_posts_date on posts( created_on );

EXPLAIN ANALYZE select * from posts ORDER BY created_on;

select pg_size_pretty( pg_relation_size( 'posts' ) ) AS table_size,
pg_size_pretty( pg_relation_size( 'idx_posts_date' ) ) AS index_size;

EXPLAIN select p.title, u.username
from posts p
JOIN users u on u.pk = p.author
where u.username = 'fluca1978'
AND
daterange( CURRENT_DATE - 2, CURRENT_DATE ) @> p.created_on::date;

EXPLAIN ANALYZE select p.title, u.username
from posts p
JOIN users u on u.pk = p.author
where u.username = 'fluca1978'
AND daterange( CURRENT_DATE - 2, CURRENT_DATE ) @> p.created_on::date;

CREATE INDEX idx_posts_author on posts( author );

EXPLAIN ANALYZE select p.title, u.username
from posts p
JOIN users u on u.pk = p.author
where u.username = 'fluca1978'
AND daterange( CURRENT_DATE - 2, CURRENT_DATE ) @> p.created_on::date;

select pg_size_pretty( pg_relation_size( 'posts') ) AS table_size,
pg_size_pretty( pg_relation_size( 'idx_posts_date' ) ) AS idx_date_size,
pg_size_pretty( pg_relation_size( 'idx_posts_author' ) ) AS idx_author_size;

select indexrelname, idx_scan, idx_tup_read, idx_tup_fetch from
pg_stat_user_indexes where relname = 'posts';


\timing

ANALYZE posts ;

select n_distinct
from pg_stats
where attname = 'author' AND tablename = 'posts';

select * from pg_stats;

select count(*) from posts where author = 2358;

select count(*) -- p.title, u.username
from posts p
JOIN users u on u.pk = p.author
where u.username = 'fluca1978'
AND daterange( CURRENT_DATE - 20, CURRENT_DATE ) @> p.created_on::date;

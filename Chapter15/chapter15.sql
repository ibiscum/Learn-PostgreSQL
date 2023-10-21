CREATE DATABASE forumdb_test WITH OWNER luca;

\i backup_forumdb.sql

select * from tags;

select * from public.tags;

select pg_catalog.set_config('search_path', 'public,"$user"', false);

select * from tags;

DROP DATABASE forumdb;

\i backup_forumdb.sql

select count(*) from tags;

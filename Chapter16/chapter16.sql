select name, setting || ' ' || unit AS current_value, short_desc,extra_desc, min_val, max_val, reset_val
from pg_settings;

select name, setting AS current_value, sourcefile, sourceline,pending_restart from pg_settings;

select name, setting, sourcefile, sourceline, applied, error from pg_file_settings ORDER BY name;

select name, setting, sourcefile, sourceline, applied, error from pg_file_settings ORDER BY name;

select distinct context from pg_settings ORDER BY context;

ALTER SYSTEM SET archive_mode = 'on';

ALTER SYSTEM SET archive_mode TO DEFAULT;

ALTER SYSTEM RESET archive_mode;

ALTER SYSTEM RESET ALL;

select usename, datname, client_addr, application_name,backend_start, query_start,state, backend_xid, query
from pg_stat_activity;

select a.usename, a.application_name, a.datname, a.query,l.granted, l.mode
from pg_locks l
JOIN pg_stat_activity a on a.pid = l.pid;

select query, backend_start, xact_start, query_start,state_change, state,now()::time - state_change::time AS locked_since,pid, wait_event_type, wait_event
from pg_stat_activity
where wait_event_type is NOT null
ORDER BY locked_since DESC;

select datname, xact_commit, xact_rollback, blks_read, conflicts,deadlocks,tup_fetched, tup_inserted, tup_updated, tup_deleted, stats_reset
from pg_stat_database;

select relname, seq_scan, idx_scan,n_tup_ins, n_tup_del, n_tup_upd, n_tup_hot_upd,n_live_tup, n_dead_tup,
last_vacuum, last_autovacuum,last_analyze, last_autoanalyze
from pg_stat_user_tables;

select auth.rolname,query, db.datname, calls, min_time, max_time
from pg_stat_statements
JOIN pg_authid auth on auth.oid = userid
JOIN pg_database db on db.oid = dbid
ORDER BY calls DESC;

select pg_stat_statements_reset();

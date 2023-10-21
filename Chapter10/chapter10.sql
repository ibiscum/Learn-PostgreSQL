
CREATE ROLE luca;

CREATE ROLE luca WITH NOCREATEROLE NOCREATEDB;

ALTER ROLE luca WITH CREATEDB;

ALTER ROLE luca WITH CREATEROLE;

ALTER ROLE luca CREATEROLE CREATEDB;

ALTER ROLE luca NOCREATEROLE, NOCREATEDB;

ALTER ROLE enrico RENAME TO enrico_pirozzi;

ALTER ROLE enrico RENAME TO enrico_pirozzi;

select current_user, session_user;

SET ROLE forum_stats;

SET client_min_messages TO 'DEBUG';

ALTER ROLE luca IN DATABASE forumdb SET client_min_messages TO 'DEBUG';

ALTER ROLE luca IN DATABASE forumdb RESET ALL;

\du

select * from pg_authid where rolname = 'luca';

select * from pg_roles where rolname = 'luca';

select r.rolname, g.rolname AS group, m.admin_option AS is_admin
from pg_auth_members m
JOIN pg_roles r on r.oid = m.member
JOIN pg_roles g on g.oid = m.roleid
ORDER BY r.rolname;


CREATE ROLE forum_admins WITH NOLOGIN;

CREATE ROLE forum_stats WITH NOLOGIN;

REVOKE ALL on users from forum_stats;

grant select (username, gecos) on users TO forum_stats;

grant forum_admins TO enrico;

grant forum_stats;

select * from users;

grant select on users TO luca;

REVOKE select on users from luca;

CREATE ROLE forum_emails WITH NOLOGIN NOINHERIT;

grant select (email) on users TO forum_emails;

grant forum_emails TO forum_stats;

select username, gecos, email from users;

select current_role;

SET ROLE TO forum_emails;

select email from users;

select gecos from users;

ALTER ROLE forum_emails WITH INHERIT;

select gecos, username, email from users;

\dp categories

grant select, UPDATE, insert on categories TO luca;

grant DELETE on categories TO PUBLIC;

CREATE TABLE foo();

\dp foo

grant select, insert,UPDATE, DELETE on foo TO enrico;

\dp foo

REVOKE TRUNCATE on foo from enrico;

REVOKE insert on foo from PUBLIC;

select acldefault( 'r', r.oid )
from pg_roles r
where r.rolname = CURRENT_ROLE;

select acldefault( 'f', r.oid )
from pg_roles r
where r.rolname = CURRENT_ROLE;

REVOKE ALL on categories from forum_stats;

grant select, insert, UPDATE on categories TO forum_stats;

\dp categories

REVOKE ALL on users from forum_stats;

grant select (username, gecos),
UPDATE (gecos)
on users TO forum_stats;

select * from users;

select gecos, username from users;

UPDATE users SET username = upper( username );

UPDATE users SET gecos = lower( gecos );

\dp users

grant select on users TO forum_stats;

select * from users;

REVOKE select (pk, email) on users from forum_stats

\dp users

REVOKE select on users from forum_stats;

REVOKE ALL on SEQUENCE categories_pk_seq from luca;

select nextval( 'categories_pk_seq' );

forumdb=# grant USAGE on SEQUENCE categories_pk_seq TO luca;

select setval( 'categories_pk_seq', 10 );

select nextval( 'categories_pk_seq' );

CREATE SCHEMA configuration;

CREATE TABLE configuration.conf( param text,value text,UNIQUE (param) );

grant CREATE on SCHEMA configuration TO luca;

grant USAGE on SCHEMA configuration TO luca;

CREATE TABLE configuration.conf( param text,value text,UNIQUE (param) );

insert INTO configuration.conf VALUES( 'posts_per_page', '10' );

REVOKE USAGE on SCHEMA configuration from luca;

select * from configuration.conf;

grant USAGE on SCHEMA configuration TO luca;

REVOKE CREATE on SCHEMA configuration from luca;

REVOKE ALL on ALL TABLES IN SCHEMA configuration from luca;

REVOKE grant select, insert, UPDATE on ALL TABLES;

REVOKE USAGE on LANGUAGE plperl from PUBLIC;

DO LANGUAGE plperl $$ elog( INFO, "Hello World" ); $$;

grant USAGE on LANGUAGE plperl TO luca;

CREATE FUNCTION get_max( a int, b int ) RETURNS int AS $$
BEGIN
  IF a > b THEN
    RETURN a;
  ELSE
    RETURN b;
    END IF;
END $$ LANGUAGE plpgsql;

REVOKE EXECUTE on ROUTINE get_max from PUBLIC;

grant EXECUTE on ROUTINE get_max TO luca;

REVOKE CONNECT on DATABASE forumdb from PUBLIC;

REVOKE ALL on DATABASE forumdb from public;

grant CONNECT, CREATE on DATABASE forumdb TO luca;

ALTER TABLE categories OWNER TO luca;

ALTER ROUTINE get_max OWNER TO luca;

\dp categories

select relname, relacl from pg_class where relname = 'categories';

WITH acl AS (
  select relname,
  (aclexplode(relacl)).grantor,
  (aclexplode(relacl)).grantee,
  (aclexplode(relacl)).privilege_type
  from pg_class
)
select g.rolname AS grantee,acl.privilege_type AS permission,gg.rolname AS grantor
from acl
JOIN pg_roles g on g.oid = acl.grantee
JOIN pg_roles gg on gg.oid = acl.grantor
where acl.relname = 'categories';

CREATE POLICY show_only_my_posts  on posts
FOR select
USING ( author = ( select pk from users
where username = CURRENT_ROLE ) );


ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

CREATE POLICY manage_only_my_posts on posts
FOR ALL
USING ( author = ( select pk from users
where username = CURRENT_ROLE ) )
WITH CHECK ( author = ( select pk from users
where username = CURRENT_ROLE )
AND
last_edited_on + '1 day'::interval >=
CURRENT_TIMESTAMP );

EXPLAIN select * from posts;

UPDATE posts SET last_edited_on = last_edited_on - '2 weeks'::interval;

\dp posts

ALTER TABLE posts DISABLE ROW LEVEL SECURITY;

ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

select name, setting, enumvals
from pg_settings
where name = 'password_encryption';

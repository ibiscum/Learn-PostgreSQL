select CURRENT_DATE;

select 1 + 1;

select count(*) from posts;

PREPARE my_query( text ) AS select * from categories where title like $1;

EXECUTE my_query( 'PROGRAMMING%' );

CREATE EXTENSION pgaudit;

SET pgaudit.log TO 'write, ddl';

select count(*) from categories;

insert INTO categories( description, title ) VALUES( 'Fake', 'A Malicious Category' );

select count(*) from categories;

insert INTO categories( description, title ) VALUES( 'Fake2','Another Malicious Category' );

DO $$ BEGIN
EXECUTE 'TRUNCATE TABLE ' || 'tags CASCADE';
END $$;

CREATE ROLE auditor WITH NOLOGIN;

grant DELETE on ALL TABLES IN SCHEMA public TO auditor;

grant insert on posts TO auditor;

grant insert on categories TO auditor;

SET pgaudit.role TO auditor;

insert INTO categories( title, description ) VALUES( 'PgAudit','Topics related to auditing in PostgreSQL' );

insert INTO tags( tag ) VALUES( 'pgaudit' );

DELETE from posts where author NOT IN ( select pk from users where username NOT IN ( 'fluca1978', 'sscotty71' ) );

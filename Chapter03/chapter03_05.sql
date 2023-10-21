-- Chapter 3
-- Listing 5: Inspecting a specific role

select
    rolname,
    rolcanlogin,
    rolconnlimit,
    rolpassword
from pg_authid
where rolname = 'luca';

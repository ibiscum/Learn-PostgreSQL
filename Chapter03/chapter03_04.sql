-- Chapter 3
-- Listing 4: Inspecting a specific role

select
    rolname,
    rolcanlogin,
    rolconnlimit,
    rolpassword
from pg_roles
where rolname = 'luca';

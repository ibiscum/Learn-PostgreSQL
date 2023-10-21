-- Chapter 3 
-- Listing 6: Creating two groups to handle different permissions

CREATE ROLE forum_admins;

CREATE ROLE forum_stats;

grant ALL on users TO forum_admins;

REVOKE ALL on users from forum_stats;

grant select (username, gecos) on users TO forum_stats;

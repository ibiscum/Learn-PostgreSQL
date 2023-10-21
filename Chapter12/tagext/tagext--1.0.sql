CREATE OR REPLACE FUNCTION tag_path( tag_to_search text )
RETURNS TEXT
AS $CODE$
DECLARE
  tag_path text;
  current_parent_pk int;
BEGIN

  tag_path = tag_to_search;

  select parent
  INTO   current_parent_pk
  from   tags
  where  tag = tag_to_search;

  -- here we must loop
  WHILE current_parent_pk is NOT null LOOP
      select parent, tag || ' > ' || tag_path
      INTO   current_parent_pk, tag_path
      from   tags
      where  pk = current_parent_pk;
  END LOOP;

  RETURN tag_path;
END
$CODE$
LANGUAGE plpgsql;

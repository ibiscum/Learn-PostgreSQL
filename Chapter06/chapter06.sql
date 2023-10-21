select
    category,
    count(*)
from posts
group by category
order by category;

select
    category,
    count(*) over (partition by category)
from posts
order by category;

select
    category,
    count(*) over (partition by category),
    count(*) over ()
from posts
order by category;

select distinct
    category,
    count(*) over (partition by category),
    count(*) over ()
from posts
order by category;

select distinct
    category,
    count(*) over w1,
    count(*) over w2
from posts
window
    w1 as (partition by category),
    w2 as ()
order by category;

select generate_series(1, 5);

select
    category,
    count(*) over w
from posts
window
    w as (partition by category)
order by category;

select
    category,
    title,
    row_number() over w
from posts
window
    w as (partition by category)
order by category;

select
    category,
    title,
    row_number() over w
from posts
window
    w as (partition by category order by title)
order by category;

select
    category,
    title,
    row_number() over w,
    first_value(title) over w
from posts
window
    w as (partition by category order by category)
order by category;

select
    category,
    title,
    row_number() over w,
    last_value(title) over w
from posts
window
    w as (partition by category order by category)
order by category;

select
    pk,
    title,
    author,
    category,
    rank() over ()
from posts
order by category;

select
    pk,
    title,
    author,
    category,
    rank() over (order by author)
from posts;

select
    pk,
    title,
    author,
    category,
    rank() over (partition by author order by category)
from posts
order by author;

select
    pk,
    title,
    author,
    category,
    dense_rank() over (order by author)
from posts
order by category;

select x from (select generate_series(1, 5) as x) v;

select
    x,
    lag(x) over w
from (select generate_series(1, 5) as x) v
window
    w as (order by x);

select
    x,
    lag(x, 2) over w
from (select generate_series(1, 5) as x) v
window 
    w as (order by x);

select
    x,
    lead(x) over w
from (select generate_series(1, 5) as x) v
window
    w as (order by x);

select
    x,
    lead(x, 2) over w
from (select generate_series(1, 5) as x) v
window
    w as (order by x);

select
    x,
    cume_dist() over w
from (select generate_series(1, 5) as x) v
window
    w as (order by x);

select x,ntile(2) over w from (select generate_series(1,6) as x) V window w as (order by x) ;

select x,ntile(3) over w from (select generate_series(1,6) as x) V window w as (order by x) ;

select distinct category, count(*) over w1
from posts
window w1 as (partition by category range between unbounded preceding and current row)
order by category;

select x from (select generate_series(1,5) as x) V window w as (order by x) ;

select x, SUM(x) over w
from (select generate_series(1,5) as x) V
window w AS (order by x ROWS BETWEEN unbounded preceding and current row);

select x, SUM(x) over w
from (select generate_series(1,5) as x) V
window w AS (order by x range between 1 preceding and current row);

select x, SUM(x) over w
from (select generate_series(1,5) as x) V
window w AS (order by X ROWS BETWEEN CURRENT ROW AND unbounded FOLLOWING);

select generate_series(1,10) % 5 as x order by 1;

select x, row_number() over w, SUM(x) over w from (select generate_series(1,10) % 5 as x) V
window w AS (order by x ROWS BETWEEN 1 preceding and current row);

select x, row_number() over w, SUM(x) over w
from (select generate_series(1,10) % 5 as x) V
window w AS (order by x range between 1 preceding and current row);

select x,row_number() over w, dense_rank() over w,sum(x) over w
from (select generate_series(1,10) % 5 as x) V
window w AS (order by x desc range between 1 preceding and current row);

select x, row_number() over w, SUM(x) over w
from (select generate_series(1,10) % 5 as x) V
window w AS (order by x range between 1 preceding and current row);

select x,row_number() over w, dense_rank() over w,sum(x) over w
from (select generate_series(1,10) % 5 as x) V
window w AS (order by x desc ROWS BETWEEN 1 preceding and current row);

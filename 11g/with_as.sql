/*********************************
with as examples

with tempName as (select ....)
select ...

*********************************/
-- 1. create a temporary table tmp
with tmp as (
    select 1000 qty, to_date('20221017', 'yyyymmdd') c_time from dual
    union
    select 1100 qty, to_date('20221018', 'yyyymmdd') c_time from dual
    union
    select 1200 qty, to_date('20221019', 'yyyymmdd') c_time from dual
    union
    select 1300 qty, to_date('20221020', 'yyyymmdd') c_time from dual
    union
    select 1400 qty, to_date('20221021', 'yyyymmdd') c_time from dual
)
select * from tmp;

-- 2. create two temporary tables e and d
with
    e as (select * from scott.emp),
    d as (select * from scott.dept)
select * from e, d where e.deptno = d.deptno;

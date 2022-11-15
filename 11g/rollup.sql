/*********************************
rollup examples

rollup(a, b) --> group by (a, b), group by (a, null), group by (null, null)
*********************************/

-- rollup(dep)先算各个部门薪水总和, 再算所有部门薪水总和. 等于先group by (dep)再group by (null)
with emp as (
    select 'A' dep, 15000 salary, 'Tom' name from dual
    union
    select 'B' dep, 20000 salary, 'Jerry' name from dual
    union
    select 'A' dep, 10000 salary, 'Bob' name from dual
    union
    select 'B' dep, 30000 salary, 'Mark' name from dual
)
select dep, sum(salary) salary from emp group by rollup(dep);


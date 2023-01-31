/*********************************
listagg examples
*********************************/

-- data
with emp as (
    select '20' deptno, 'John' ename from dual
    union
    select '20' deptno, 'Bob' ename from dual
    union
    select '20' deptno, 'Wick' ename from dual
    union
    select '30' deptno, 'Alex' ename from dual
)
select deptno, ename from emp

-- example1 多行合并成一行 listagg() within group (), separated by comma
with emp as (
    select '20' deptno, 'John' ename from dual
    union
    select '20' deptno, 'Bob' ename from dual
    union
    select '20' deptno, 'Wick' ename from dual
    union
    select '30' deptno, 'Alex' ename from dual
)
select deptno,
       listagg(ename, ',') within group ( order by ename) ename
from emp
group by deptno

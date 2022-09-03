/*********************************
decode examples
decode(field|expression, condition1, result1, condition2, result2, ..., conditionN, resultN, defaultValue);
defaultValue can be ignored
*********************************/

-- example1
select empno,
       decode(empno, 7369, 'Smith', 7499, 'Allen', 'unknow') name,
  from emp;

-- example2 列转行
select sum(decode(e.ename, 'Smith', sal, 0)) smith,
       sum(decode(e.ename, 'Allen', sal, 0)) allen,
       sum(decode(e.ename, 'Ward', sal, 0)) ward,
       sum(decode(e.ename, 'Jones', sal, 0)) jones,
       sum(decode(e.ename, 'Martin', sal, 0)) martin
  from scott.emp e;

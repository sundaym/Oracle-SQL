/************************************************************************************************************
grouping(), grouping_id() 判断筛选rollup cube汇总的列
grouping对小计合计的列返回1，否则返回0
grouping_id按列从左到右顺序计算，如果列是分组列则为0，是小计或合计则为1，然后按顺序将计算结果组成二进制，再转为十进制
**************************************************************************************************************/

--1. grouping 只能接收一个参数 判断总计
-- rollup汇总的那条数据字段是空，如果原始数据中有空就容易混淆，因此用grouping判断是否为汇总，将汇总的数据和原始数据的NULL区分
---- 获取每个部门的工资成本并获取所有部门的工资成本
with salary as (
    select 'Tom' name, 'A' dept, 10230 money from dual
    union
    select 'Alice' name, 'A' dept, 11000 money from dual
    union
    select 'John' name, 'A' dept, 13200 money from dual
    union
    select 'Mark' name, 'A' dept, 11200 money from dual
    union
    select 'Bob' name, 'B' dept, 10440 money from dual
    union
    select 'Frank' name, 'B' dept, 13000 money from dual
    union
    select 'Jerry' name, 'B' dept, 11200 money from dual
    union
    select 'XX' name, '' dept, 11200 money from dual
)
select DECODE(GROUPING(dept), 1, 'ALL DEPARTMENTS', dept) dept, sum(money) from salary group by rollup(dept);

--2. grouping_id可以接收多个参数, 判断小计 总计
---- 获取每个部门每个岗位的工资成本，并获取总成本
with salary as (
    select 'Tom' name, 'A' dept, 'SALES' job, 10230 money from dual
    union
    select 'Alice' name, 'A' dept, 'SALES' job, 11000 money from dual
    union
    select 'John' name, 'A' dept, 'DEVELOPER' job, 13200 money from dual
    union
    select 'Mark' name, 'A' dept, 'DEVELOPER' job, 11200 money from dual
    union
    select 'Bob' name, 'B' dept, 'SALES' job, 10440 money from dual
    union
    select 'Frank' name, 'B' dept, 'DEVELOPER' job, 13000 money from dual
    union
    select 'Jerry' name, 'B' dept, 'DEVELOPER' job, 11200 money from dual
    union
    select 'Andy' name, 'B' dept, 'SALES' job, 12200 money from dual
)
select dept, job, sum(money) from salary group by rollup(dept, job) having grouping_id(dept, job) in (0, 3);

/***************************************************************************
  rollup分组grouping_id结果Example
  分组                    位向量            grouping_id结果
  dept,job                0 0                  0
  dept, null小计          1 0                  2
  null, null合计          1 1                  3
***************************************************************************/

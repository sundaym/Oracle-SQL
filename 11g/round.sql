/*************************************************
round(n, p)
p为0表示截取整数部分
p为正数表示截取小数个数
**************************************************/

-- 3
select round(3.14) from dual;
select round(3.14, 0) from dual;

-- 3.14
select round(3.1415, 2) from dual;

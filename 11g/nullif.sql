/***************************************
NULLIF function
NULLIF(expression1, expression2)
expression1=expression2, return null
**************************************/

-- 除数为0, :B = 0
select 1/nullif(:B, 0) from dual;

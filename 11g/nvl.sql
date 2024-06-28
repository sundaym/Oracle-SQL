/**
* NVL函数注意事项
**/
-- NVL(arg1, arg2) 函数，两个参数类型要一致，否则会报错

-- example, 左边是date，右边是字符串，报错ORA-01861: literal does not match format string
SELECT nvl(SYSDATE, '123') from dual

-- 正确写法，将date类型转为char类型
SELECT nvl(to_char(SYSDATE, 'yyyy-mm-dd'), '123') from dual

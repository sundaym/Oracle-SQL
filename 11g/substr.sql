/******************************************************************

  substr(string, start_position, [length])
  start_position从0开始
  length可选，子字符串个数
******************************************************************/

select substr('ABCDEFG', 0) from dual; -- ABCDEFG, 截取所有字符串
select substr('ABCDEFG', 2) from dual; -- CDEFG, 截取从C开始之后所有字符
select substr('ABCDEFG', 0, 3) from dual; -- ABC, 从A开始截3个字符
select substr('ABCDEFG', -2) from dual; -- 负值表示从尾部算起

/************************************************************************************************
  时间相关操作
*************************************************************************************************/

---- 抽取年，月，日...
select to_char(sysdate, 'q') from dual;  -- 季度
select to_char(sysdate, 'yyyy') from dual; -- 年
select to_char(sysdate, 'mm') from dual; -- 月
select to_char(sysdate, 'dd') from dual; -- 日
select to_char(sysdate, 'd') from dual;  -- 星期中的第几天
select to_char(sysdate, 'DAY') from dual; -- 星期几
select to_char(sysdate, 'ddd') from dual; -- 一年中的第几天
select to_char(sysdate, 'iw') from dual; -- 获取ISO周数, 星期一至星期日算1周,且每年的第一个星期一为第1周
select to_char(sysdate, 'ww') from dual; -- 获取周数, 每年1月1日为第1周开始, 日期+6天为每1周结尾

---- 两个时间段是否有交集, (start, end), (start_time, end_time)
-- 两个时间段存在交集的情况比较多，但不存在交集的情况就比较少，所以排除不存在交集的情况，取反就能获得存在交集的结果
-- 不存在交集的情况一个是 end < start_time, 一个是 start > end_time, end < start_time || start > end_time
select * from test_table where not ((end < start_time) or (start > end_time));

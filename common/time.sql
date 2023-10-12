/************************************************************************************************
  时间相关操作
*************************************************************************************************/

---- 时间格式化, 日期+日内时间
select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual; -- 24小时
select to_char(sysdate,'YYYY-MM-DD HH12:MI:SS AM')from dual; -- 12小时
select to_date('2023-10-12 13:00:00', 'yyyy-mm-dd hh24:mi:ss') from dual;

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

-- timestamp
SELECT EXTRACT(YEAR FROM SYSTIMESTAMP) YEAR,
       EXTRACT(MONTH FROM SYSTIMESTAMP) MONTH,
       EXTRACT(DAY FROM SYSTIMESTAMP) DAY,
       EXTRACT(MINUTE FROM SYSTIMESTAMP) MINUTE,
       EXTRACT(SECOND FROM SYSTIMESTAMP) SECOND,
       EXTRACT(TIMEZONE_HOUR FROM SYSTIMESTAMP) TH,
       EXTRACT(TIMEZONE_MINUTE FROM SYSTIMESTAMP) TM,
       EXTRACT(TIMEZONE_REGION FROM SYSTIMESTAMP) TR,
       EXTRACT(TIMEZONE_ABBR FROM SYSTIMESTAMP) TA
FROM DUAL

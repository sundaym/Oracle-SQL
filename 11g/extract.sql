/***********************************
extract() 提取时间 年,月,日
***********************************/

-- date
select extract(year from sysdate), extract(month from sysdate), extract(day from sysdate)
from dual;

-- timestamp
select extract(year from systimestamp)            year
     , extract(month from systimestamp)           month
     , extract(day from systimestamp)             day
     , extract(minute from systimestamp)          minute
     , extract(second from systimestamp)          second
     , extract(timezone_hour from systimestamp)   th
     , extract(timezone_minute from systimestamp) tm
     , extract(timezone_region from systimestamp) tr
     , extract(timezone_abbr from systimestamp)   ta
from dual

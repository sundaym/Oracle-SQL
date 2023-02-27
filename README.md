## Oracle-SQL
Oracle 11g SQL examples:  
merge into  
decode  
with as  
listagg  
rollup, grouping, grouping_id  
round  
nullif  
extract  
...

## plsql developer IDE
AutoReplace.txt
```
s=select
f=from
w=where
tab=table
sf=select * from
sfc=select count(*) from
fu=for update
ob=order by
ii=insert into
df=delete from
up=update
echo=dbms_output.put_line(
tt=truncate table
gb=group by
dist=distinct
lj=left join
rj=right join
ij=inner join
```

## Oracle Memory View
```SQL
select 'SGA' as name, round(sum(value) / 1024 / 1024, 2) || 'M' as "SIZE(M)"
from v$sga
union
select 'PGA' as name, round(value / 1024 / 1024, 2) || 'M' as "SIZE(M)"
from v$pgastat
where name = 'total PGA allocated'
```

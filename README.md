## sql文件开头注释
```
/***************************************************************************
name: init system sql
desc: DDL and DML for initializing system
version: 2025

*****************************************************************************/

```

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
sfd=select from dual
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

## Oracle查看锁表和解锁
1.查看是否有被锁的表：
```
select b.owner,b.object_name,a.session_id,a.locked_mode
from v$locked_object a,dba_objects b
where b.object_id = a.object_id
```
2.查看是哪个进程锁的
```
select b.username,b.sid,b.serial#,logon_time
from v$locked_object a,v$session b
where a.session_id = b.sid order by b.logon_time
```
3.杀掉进程
```
alter system kill session 'sid,serial#';
-- alter system kill session '10,32835'
```
## Oracle Keywords
```SQL
select * from v$reserved_words WHERE KEYWORD=UPPER('size');
```

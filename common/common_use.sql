/********************************************************

 常用sql查询

********************************************************/

--1. 查看表空间的名称及大小
select t.tablespace_name, round(sum(bytes/(1024*1024)),0) ts_size
from dba_tablespaces t, dba_data_files d
where t.tablespace_name = d.tablespace_name
group by t.tablespace_name;

--2. 查看表空间物理文件的名称及大小
select tablespace_name, file_id, file_name,
       round(bytes/(1024*1024),0) total_space
from dba_data_files
order by tablespace_name;

--3. 查看回滚段名称及大小
select segment_name, tablespace_name, r.status,
       (initial_extent/1024) InitialExtent,(next_extent/1024) NextExtent,
       max_extents, v.curext CurExtent
From dba_rollback_segs r, v$rollstat v
Where r.segment_id = v.usn(+)
order by segment_name;

--4. 查看控制文件
select name from v$controlfile;

--5. 查看日志文件
select member from v$logfile;

--6. 查看表空间的使用情况
select sum(bytes)/(1024*1024) as free_space,tablespace_name
from dba_free_space
group by tablespace_name;

SELECT A.TABLESPACE_NAME,A.BYTES TOTAL,B.BYTES USED, C.BYTES FREE,
       (B.BYTES*100)/A.BYTES "% USED",(C.BYTES*100)/A.BYTES "% FREE"
FROM SYS.SM$TS_AVAIL A,SYS.SM$TS_USED B,SYS.SM$TS_FREE C
WHERE A.TABLESPACE_NAME=B.TABLESPACE_NAME AND A.TABLESPACE_NAME=C.TABLESPACE_NAME;

--7. 查看数据库库对象
select owner, object_type, status, count(*) count# from all_objects group by owner, object_type, status;

--8. 查看数据库的版本
Select version FROM Product_component_version
Where SUBSTR(PRODUCT,1,6)='Oracle';

--9. 查看数据库的创建日期和归档方式

Select Created, Log_Mode, Log_Mode From V$Database;

--10. 捕捉运行很久的SQL
column username format a12
column opname format a16
column progress format a8

select username,sid,opname,
       round(sofar*100 / totalwork,0) || '%' as progress,
       time_remaining,sql_text
from v$session_longops , v$sql
where time_remaining <> 0
  and sql_address = address
  and sql_hash_value = hash_value
/

--11. 查看数据表的参数信息
SELECT   partition_name, high_value, high_value_length, tablespace_name,
         pct_free, pct_used, ini_trans, max_trans, initial_extent,
         next_extent, min_extent, max_extent, pct_increase, FREELISTS,
         freelist_groups, LOGGING, BUFFER_POOL, num_rows, blocks,
         empty_blocks, avg_space, chain_cnt, avg_row_len, sample_size,
         last_analyzed
FROM dba_tab_partitions
     --WHERE table_name = :tname AND table_owner = :towner
ORDER BY partition_position

--12. 查看还没提交的事务
select * from v$locked_object;
select * from v$transaction;

--13. 查找object为哪些进程所用
select
    p.spid,
    s.sid,
    s.serial# serial_num,
    s.username user_name,
    a.type  object_type,
    s.osuser os_user_name,
    a.owner,
    a.object object_name,
    decode(sign(48 - command),
           1,
           to_char(command), 'Action Code #' || to_char(command) ) action,
    p.program oracle_process,
    s.terminal terminal,
    s.program program,
    s.status session_status
from v$session s, v$access a, v$process p
where s.paddr = p.addr and
        s.type = 'USER' and
        a.sid = s.sid   and
        a.object='SUBSCRIBER_ATTR'
order by s.username, s.osuser

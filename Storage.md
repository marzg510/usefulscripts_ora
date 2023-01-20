# Storage

```SQL
select
  FILE#,
  ts.name TABLESPACE_NAME,
  df.name DATAFILE_NAME,
  bytes/1024/1024 MBYTES,
  status DATAFILE_STATUS,
  to_char(checkpoint_time,'YYYY-MM-DD HH:MI.SS') CHECKPOINT_TIME
from 
  v$tablespace ts, 
  v$datafile df
where ts.ts#=df.ts#
order by file#
/

```

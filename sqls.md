```SQL
SELECT
  sysdate() as SYSDATE
  s.sid,
  s.serial#,
  s.status,
  s.machine,
  s.osuser,
  s.module,
  s.username,
  s.process,
  p.program,
  a.sql_text
FROM v$session s,
     v$sqlarea a,
     v$process p
WHERE s.PREV_HASH_VALUE = a.hash_value
  AND s.PREV_SQL_ADDR = a.address
  AND s.paddr = p.addr
  -- AND s.SID = 123
;
```SQL

```SQL
SELECT
  sysdate
  ,s.sid
  ,s.serial#
  ,s.status
  ,trunc((sysdate - s.SQL_EXEC_START) * 24 * 60 * 60,2) as "progress_time"
  ,a.sql_fulltext
  ,s.wait_time
  ,s.event
  ,s.machine
  ,s.osuser
  ,s.module
  ,s.username
  ,s.process
--  p.program,
FROM v$session s 
INNER JOIN v$sqlarea a ON s.SQL_ID = a.SQL_ID
INNER JOIN v$process p ON s.paddr = p.addr
WHERE 0=0
  AND s.username is not null
;
```
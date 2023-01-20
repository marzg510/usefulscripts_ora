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
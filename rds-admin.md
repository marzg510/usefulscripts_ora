# RDS Admin

## AlertLog

```SQL
SELECT message_text FROM alertlog;

SELECT record_id, message_text,ORIGINATING_TIMESTAMP, message_type,message_level FROM alertlog;

SELECT record_id, ORIGINATING_TIMESTAMP, message_text, message_type,message_level FROM alertlog 
where 0=0
-- AND message_text like '%ORA-%'
AND message_text like '%Resize%'
AND ORIGINATING_TIMESTAMP > '23-02-09 09:00:00.00000'
;

SELECT * FROM
(
SELECT record_id, ORIGINATING_TIMESTAMP, message_text, message_type,message_level FROM alertlog
WHERE ORIGINATING_TIMESTAMP > '23-01-20 09:00:00.00000'
ORDER BY record_id DESC
FETCH FIRST 100 ROWS ONLY
)
ORDER BY record_id ASc
;

```

## KILL SESSION(RDS)

``` SQL
SELECT SYS_CONTEXT('USERENV', 'SESSION_USER')  FROM DUAL;

SELECT SID, SERIAL#, USERNAME FROM V$SESSION
WHERE 0=0
AND USERNAME='NBUA05';
-- AND SID=in_sid and SERIAL#=in_serial
;
EXECUTE rdsadmin.rdsadmin_util.kill( SID, SERIAL# 'IMMEDIATE' );
 ```

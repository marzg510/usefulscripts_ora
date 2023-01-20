# RDS Admin

## AlertLog

```SQL
SELECT message_text FROM alertlog;

SELECT record_id, message_text,ORIGINATING_TIMESTAMP, message_type,message_level FROM alertlog;

SELECT record_id, ORIGINATING_TIMESTAMP, message_text, message_type,message_level FROM alertlog where message_text like '%ORA-%';

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

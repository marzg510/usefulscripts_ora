# RDS AlertLog
```SQL
SELECT message_text FROM alertlog;
SELECT record_id, message_text,ORIGINATING_TIMESTAMP, message_type,message_level FROM alertlog;
SELECT record_id, ORIGINATING_TIMESTAMP, message_text, message_type,message_level FROM alertlog where message_text like '%ORA-%';

```
```SQL
--Oracleの現在のセッション数とプロセス数を確認する
SELECT * FROM V$RESOURCE_LIMIT
 WHERE RESOURCE_NAME = 'processes' 
 OR RESOURCE_NAME = 'sessions';

```

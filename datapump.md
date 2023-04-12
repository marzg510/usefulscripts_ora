## expdp
```Powershell
expdp user/*****@conn DUMPFILE=DATA_PUMP_DIR:user_$(Get-Date -format "yyyyMMdd_HHmmss")_test.dmp DIRECTORY=DATA_PUMP_DIR

```
```SQL
-- https://dev.classmethod.jp/articles/data-pump-on-rds-for-oracle/
-- expdp
DECLARE
  h NUMBER;
  dt varchar2(1000);
  filename varchar2(1000);
  dirname varchar2(1000);
  logname varchar2(1000);
  targetschema varchar2(1000);
BEGIN
  dt := TO_CHAR(sysdate,'YYYYMMDD_HH24MISS');
  targetschema := 'user';
  filename := targetschema || '_' || dt || '.dmp';
  dirname := 'DATA_PUMP_DIR';
  logname := 'exp_' || targetschema || '_' || dt || '.log';

  h := DBMS_DATAPUMP.open( operation => 'EXPORT', job_mode => 'SCHEMA', job_name=>null);
  DBMS_DATAPUMP.ADD_FILE( handle => h, filename => filename, directory => dirname, filetype => dbms_datapump.ku$_file_type_dump_file);
  DBMS_DATAPUMP.add_file( handle => h, filename => logname , directory => dirname, filetype => dbms_datapump.ku$_file_type_log_file);
  DBMS_DATAPUMP.METADATA_FILTER(h,'SCHEMA_EXPR','IN (''' || targetschema || ''')');
  
  DBMS_DATAPUMP.start_job(h);

END;
/

-- LOG
SELECT TEXT FROM TABLE(RDSADMIN.RDS_FILE_UTIL.READ_TEXT_FILE('DATA_PUMP_DIR','exp.log'));

-- DIR
SELECT * from table(RDSADMIN.RDS_FILE_UTIL.LISTDIR('DATA_PUMP_DIR')) order by MTIME desc;

```

## impdp
```powershell
impdp user/pass@con_str REMAP_SCHEMA=src:target DUMPFILE=DATA_PUMP_DIR:exp.dmp

# DRY-RUN: expdp : ESTIMATE_ONLY=Y
# DRY-RUN: impdp : SQLFILE='dummy.sql'

```

```SQL
DECLARE
  h NUMBER;
BEGIN
  h := DBMS_DATAPUMP.open( operation => 'IMPORT', job_mode => 'SCHEMA', job_name=>null);
  DBMS_DATAPUMP.ADD_FILE( handle => h, filename => 'tab1_copied.dmp', directory => 'DATA_PUMP_DIR', filetype => dbms_datapump.ku$_file_type_dump_file);
  DBMS_DATAPUMP.add_file( handle => h, filename => 'imp.log', directory => 'DATA_PUMP_DIR', filetype => dbms_datapump.ku$_file_type_log_file);
  DBMS_DATAPUMP.METADATA_FILTER(h,'SCHEMA_EXPR','IN (''ADMIN'')');
  DBMS_DATAPUMP.start_job(h);
END;
/
```

## files
```SQL
-- 削除
EXEC UTL_FILE.FREMOVE('DATA_PUMP_DIR','exp.log');

DECLARE
  filename varchar2(1000);
BEGIN
  FOR recFile IN (
    SELECT * from table(RDSADMIN.RDS_FILE_UTIL.LISTDIR('DATA_PUMP_DIR'))
    WHERE FILENAME LIKE '%NBDV80%'
  ) LOOP
--    DBMS_OUTPUT.PUT_LINE(FILENAME);
     UTL_FILE.FREMOVE('DATA_PUMP_DIR',recFile.FILENAME);
  END LOOP;
END;
/

```



## Directory Object

- https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/Appendix.Oracle.CommonDBATasks.Misc.html


```SQL
EXEC rdsadmin.rdsadmin_util.create_directory(p_directory_name => 'DATA_PUMP_DIR');

```


```SQL
SELECT * FROM DBA_DATAPUMP_JOBS;

```
impdp mgoto@xxxx attach=<JOB_NAME>

kill_job
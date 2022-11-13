SET SERVEROUTPUT ON

DECLARE
  s varchar2(4000);
  opt varchar2(1000);
  otype varchar2(1000);
BEGIN
  FOR cur IN ( SELECT object_name,object_type FROM user_objects WHERE 0=0 AND status = 'INVALID')
  LOOP
    opt := CASE cur.object_type
            WHEN 'PACKAGE' THEN
              ' PACKAGE'
            WHEN 'PACKAGE BODY' THEN
              ' BODY'
            ELSE
              ''
          END;
    otype := CASE cur.object_type
            WHEN 'PACKAGE' THEN
              'PACKAGE'
            WHEN 'PACKAGE BODY' THEN
              'PACKAGE'
            ELSE
              cur.object_type
          END;
    s := 'ALTER ' || otype || ' ' || cur.object_name || ' COMPILE' || opt;
    DBMS_OUTPUT.PUT(s);
    BEGIN
        EXECUTE IMMEDIATE s;
        DBMS_OUTPUT.PUT_LINE('');
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' | ERROR: SQLCODE=' || SQLCODE || ', SQLERRM=' || SQLERRM );
    END;
  END LOOP;
END;
/

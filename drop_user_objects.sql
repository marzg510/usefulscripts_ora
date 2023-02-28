set serveroutput on
begin
  FOR cur IN (
    WITH target_objects AS (
                SELECT 'MATERIALIZED VIEW' as object_type, 10 as drop_order FROM DUAL
      UNION ALL SELECT 'TABLE', 20 FROM DUAL
      UNION ALL SELECT 'VIEW', 30 FROM DUAL
      UNION ALL SELECT 'SYNONYM', 40 FROM DUAL
      UNION ALL SELECT 'TYPE', 50 FROM DUAL
      UNION ALL SELECT 'FUNCTION', 60 FROM DUAL
      UNION ALL SELECT 'PROCEDURE', 70 FROM DUAL
      UNION ALL SELECT 'PACKAGE', 80 FROM DUAL
      UNION ALL SELECT 'SEQUENCE', 100 FROM DUAL
    )
    SELECT uo.object_name,uo.object_type,tob.drop_order
    FROM user_objects uo
    INNER JOIN target_objects tob ON uo.object_type = tob.object_type
    WHERE 0=0
    ORDER BY tob.drop_order
    ) LOOP
    DBMS_OUTPUT.PUT_LINE('DROP ' || cur.object_type || ' ' || cur.object_name || ';');
  END LOOP;

end;
/
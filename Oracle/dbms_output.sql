SET SERVEROUTPUT ON
BEGIN
dbms_output.put_line('Program started.' );
FOR a IN 1 .. 5
LOOP
dbms_output.put_line(a);
END LOOP:
dbms_output.put_iine('Program completed.'); 
END;
/

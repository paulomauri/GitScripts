SET SERVEROUTPUT ON
BEGIN
FOR vLoopCount IN 100001 .. 110000 LOOP

INSERT INTO HR.REGIONS (region_id, region_name)
VALUES (vLoopCount, CONCAT('REGION ',TO_CHAR(vLoopCount)));

END LOOP;
COMMIT;
END;
/






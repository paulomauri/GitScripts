SET LINES 200 PAGES 0 HEAD OFF LONG 100000
COL dummy_value NOPRINT

SELECT 'dummy_value' dummy_value,
	'USERNAME	: ' || S.USERNAME	 || CHR(10) ||
	'SCHEMA		: ' || S.SCHEMANAME 	 || CHR(10) ||
	'OSUSER		: ' || S.OSUSER		 || CHR(10) ||
	'MODULE		: ' || S.PROGRAM	 || CHR(10) ||
	'ACTION 	: ' || S.SCHEMANAME	 || CHR(10) ||
	'CLIENT INFO	: ' || S.OSUSER		 || CHR(10) ||
	'PROGRAM	: ' || S.PROGRAM	 || CHR(10) ||
	'SPID		: ' || P.SPID		 || CHR(10) ||
	'SID		: ' || S.SID		 || CHR(10) ||
	'SERIAL#	: ' || S.SERIAL#	 || CHR(10) ||
	'KILL STRING 	: ' || '''' || S.SID || ',' || S.SERIAL# || '''' || CHR(10) ||
	'MACHINE	: ' || S.MACHINE 	 || CHR(10) ||
	'TYPE		: ' || S.TYPE		 || CHR(10) ||
	'TERMINAL	: ' || S.TERMINAL	 || CHR(10) ||
	'CPU 		: ' || Q.CPU_TIME/10000000 || CHR(10) ||
	'ELAPSED_TIME	: ' || Q.ELAPSED_TIME/10000000 || CHR(10) ||
	'BUFFER_GETS	: ' || Q.BUFFER_GETS 	 || CHR(10) ||
	'SQL_ID		: ' || Q.SQL_ID		 || CHR(10) ||
	'CHILD_NUM	: ' || Q.CHILD_NUMBER	 || CHR(10) ||
	'START_TIME	: ' || TO_CHAR(S.SQL_EXEC_START,'dd-mon-yy hh24:mi') || CHR(10) ||
	'STATUS		: ' || S.STATUS		 || CHR(10) ||
	'SQL_TEXT	: ' || Q.SQL_FULLTEXT
FROM V$SESSION S
JOIN V$PROCESS P ON (S.PADDR = P.ADDR)
LEFT JOIN V$SQL Q ON (S.SQL_ID = Q.SQL_ID)
WHERE S.USERNAME IS NOT NULL --ELIMINATE BACKGROUND PROCS
AND NVL(Q.SQL_TEXT,'x') NOT LIKE '%dummy_value%' --eliminates this query from output
AND P.SPID  = '&PID_FROM_OS'
ORDER BY Q.CPU_TIME;	
	


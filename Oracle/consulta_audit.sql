SELECT
	TIMESTAMP AS "LOGON",
	logoff_time AS "LOGOFF",
	logoff_lread AS "GETS",
	logoff_pread AS "READS",
	logoff_lwrite AS "WRITES",
	session_cpu AS "CPU"
FROM dba_audit_session
WHERE username != ''
AND logoff_time IS NOT NULL
ORDER BY TIMESTAMP;



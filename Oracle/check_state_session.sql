SELECT SID,
	DECODE(STATE, 'WAITING','Waiting','Working') state,
	DECODE(STATE, 'WAITING','So far' || seconds_in_wait, 'Last waited' || wait_time/100) || ' seconds for ' || event
FROM V$SESSION
WHERE SID='&session_id'
AND SERIAL#='&serial';

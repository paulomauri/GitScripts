SELECT
	tablespace_name,
	file_name,
	file_id,	
	BYTES / 1024 AS kb,
	 autoextensible,
	increment_by * 8192 / 1024 AS next_kb,
	maxbytes / 1024 AS max_kb
FROM dba_data_files
ORDER BY tablespace_name, file_id;


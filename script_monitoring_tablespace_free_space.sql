WITH
ts_free AS (SELECT tablespace_name, round(sum(bytes)/1048576) free_mb
		FROM dba_free_space GROUP BY tablespace_name),
ts_alloc AS (SELECT tablespace_name, round(sum(bytes)/1048576) alloc_mb
		FROM dba_data_files GROUP BY tablespace_name)
SELECT tablespace_name, status, alloc_mb,
	free_mb, alloc_mb-free_mb used_mb
FROM dba_tablespaces
JOIN ts_alloc USING (tablespace_name)
JOIN ts_free USING (tablespace_name)
;

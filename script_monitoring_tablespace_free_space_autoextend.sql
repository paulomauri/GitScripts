with
ts_free as (select tablespace_name, round(sum(bytes)/1048576) free_mb from dba_free_space group by tablespace_name),
ts_alloc as (select tablespace_name, round(sum(decode(autoextensible,'YES',maxbytes,bytes))/1048576) alloc_mb 
		from dba_data_files group by tablespace_name)
select tablespace_name, status, alloc_mb, free_mb, alloc_mb-free_mb useed_mb
from dba_tablespaces t
join ts_alloc a using (tablespace_name)
join ts_free f using (tablespace_name); 


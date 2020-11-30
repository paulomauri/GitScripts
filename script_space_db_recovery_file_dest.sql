select name, 
	(space_limit/1024/1024/1024) ||'GB' as Space_Limit, 
	(space_used/1024/1024/1024)||'GB' as Space_Used 
from v$recovery_file_dest;


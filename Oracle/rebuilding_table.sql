SET SERVEROUTPUT ON

declare
l_full_blocks	NUMBER;
L_fs1_blocks	number;
l_fs2_blocks	number;
l_fs3_blocks	number;
l_fs4_blocks	number;
l_unformatted_blocks	number;
l_full_bytes	number;
l_fs1_bytes	number;
l_fs2_bytes	number;
l_fs3_bytes	number;
l_fs4_bytes 	number;
l_unformatted_bytes	number;
BEGIN
	DBMS_SPACE.space_usage(segment_owner	=> 'HR',
				segment_name	=> 'REGIONS',
				segment_type	=> 'TABLE',
				unformatted_blocks => l_unformatted_blocks,
				unformatted_bytes => l_unformatted_bytes,
				fs1_blocks	=> l_fs1_blocks,
				fs1_bytes	=> l_fs1_bytes,
				fs2_blocks	=> l_fs2_blocks,
				fs2_bytes	=> l_fs2_bytes,
				fs3_blocks	=> l_fs3_blocks,
				fs3_bytes	=> l_fs3_bytes,
				fs4_blocks	=> l_fs4_blocks,
				fs4_bytes	=> l_fs4_bytes,
				full_blocks	=> l_full_blocks,
				full_bytes	=> l_full_bytes	
				);

	DBMS_OUTPUT.PUT_LINE('Full blocks:' || l_full_blocks);
	DBMS_OUTPUT.PUT_LINE('Upto 25% free:' || l_fs1_blocks);
	DBMS_OUTPUT.PUT_LINE('Upto 50% free:' || l_fs2_blocks);
	DBMS_OUTPUT.PUT_LINE('Upto 75% free:' || l_fs3_blocks);
	DBMS_OUTPUT.PUT_LINE('Upto 100% free:' || l_fs4_blocks);
	DBMS_OUTPUT.put_line('Unformatted blocks:' || l_unformatted_blocks);
END;
/

#!/bin/bash
nf=$(sqlplus -s / as sysdba <<EOF
SET HEAD OFF
SELECT COUNT(*) 
FROM V\$DATAFILE
WHERE STATUS = 'OFFLINE';
EOF)

echo "Offline count: $nf" 

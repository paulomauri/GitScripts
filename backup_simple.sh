#!/bin/bash

ORACLE_SID=$1
rman target / <<EOF
backup database;
EOF


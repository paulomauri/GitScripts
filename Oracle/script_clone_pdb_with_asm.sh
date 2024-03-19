#!/bin/bash
# no comando abaixo é criado o pdb ORCLDEV a partir do pdb ORCL sendo que os arquivos do ORCL usam o padrão OMF que controla
# o nome dos arquivos pelo ASM

#Elapsed: 00:00:00.15
#20:39:48 SYS@ORCLMT> CREATE PLUGGABLE DATABASE ORCLDEV FROM ORCL CREATE_FILE_DEST='+DATA';
#
#Pluggable database created.
#
#Elapsed: 00:03:30.81
#20:44:09 SYS@ORCLMT> 

CREATE PLUGGABLE DATABASE ORCLDEV FROM ORCL CREATE_FILE_DEST='+DATA';




connect target sys/&1;
 
CATALOG START WITH   '/u01/app/oracle/product/12.2.0.1/dbhome_1/assistants/dbca/templates//Seed_Database.dfb'  NOPROMPT  ;

RUN {  

set newname for datafile 1 to  '+DATA/MERC/system01.dbf' ; 

set newname for datafile 3 to  '+DATA/MERC/sysaux01.dbf' ; 

set newname for datafile 4 to  '+DATA/MERC/undotbs01.dbf' ; 

set newname for datafile 7 to  '+DATA/MERC/users01.dbf' ; 

restore datafile 1; 

restore datafile 3; 

restore datafile 4; 

restore datafile 7; }

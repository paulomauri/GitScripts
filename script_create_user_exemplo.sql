create user "USUARIO" identified by "SENHA" profile "DEFAULT" 
account unlock default tablespace "USERS" temporary tablespace "TEMP";

GRANT SELECT ANY TABLE to "USUARIO";
GRANT "CONNECT" to "USUARIO";
GRANT "CREATE SESSION" TO "USUARIO"
GRANT "RESOURCE" to "USUARIO";
GRANT "SELECT_CATALOG_ROLE" to "USUARIO";


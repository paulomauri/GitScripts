O índice BITMAP, ao contrário do B-TREE, contém uma entrada para cada valor indexado, que aponta (por um bitmap) para todos os registros que contém este valor.
Por causa desta arquitetura, durante um INSERT de um registro, seu BITMAP estará bloqueado durante esta operação. Ninguém poderá inserir um valor igual na coluna indexada.

Veja o teste abaixo:

Conectado a:

Oracle Database 11g Enterprise Edition Release 11.1.0.7.0 - Production

With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> CREATE TABLE T1 (C1 VARCHAR2(10)) TABLESPACE USERS;

Tabela criada.

SQL> CREATE BITMAP INDEX TI_IDX ON T1(C1) TABLESPACE USERS;

Indice criado.

SQL> INSERT INTO T1 VALUES (’Teste’);

1 linha criada.

SQL>

Deixe esta sessão como está, e em seguida, abra outra sessão, e tente executar o mesmo INSERT:

Conectado a:

Oracle Database 11g Enterprise Edition Release 11.1.0.7.0 - Production

With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> INSERT INTO T1 VALUES (’Teste’);

Este segundo INSERT irá esperar indefinidamente, até um COMMIT ou ROLLBACK da primeira sessão.
Parabéns, você fez o Oracle tornar-se monousuário para INSERTs.


Um bom uso para Índices BITMAP é em tabelas que possuem colunas onde são feitas agregações em que a performance é primordial.
Nestes casos, os Indices BITMAP serão melhores que os BTREE.
Veja o exemplo abaixo, onde criei uma grande tabela a partir de várias cópias da ALL_OBJECTS;

-- CREATE TABLE T AS SELECT * FROM DBA_OBJECTS;
-- INSERT INTO T SELECT * FROM DBA_OBJECTS; FAZER ESTE INSERT SELECT VARIAS VEZES.


SQL> SELECT COUNT(1) FROM T;
 COUNT(1)
 ———-
 10936000

SQL> set timing on;
 SQL> SELECT COUNT(DISTINCT(OWNER)) FROM T;

COUNT(DISTINCT(OWNER))
 ———————-
 28

Decorrido: 00:00:25.95
 SQL> SELECT COUNT(DISTINCT(OWNER)) FROM T;

COUNT(DISTINCT(OWNER))
 ———————-
 28

Decorrido: 00:00:26.51
 SQL> SELECT COUNT(DISTINCT(OWNER)) FROM T;

COUNT(DISTINCT(OWNER))
 ———————-
 28

Decorrido: 00:00:26.75
 SQL> CREATE INDEX T_IDX1 ON T(OWNER);

-ndice criado.

Decorrido: 00:04:35.95
 SQL> EXEC DBMS_STATS.GATHER_TABLE_STATS(’SCOTT’, ‘T’, CASCADE=>TRUE);

Procedimento PL/SQL concluÝdo com sucesso.

Decorrido: 00:01:01.14
 SQL> SELECT COUNT(DISTINCT(OWNER)) FROM T;

COUNT(DISTINCT(OWNER))
 ———————-
 28

Decorrido: 00:00:16.06
 SQL> SELECT COUNT(DISTINCT(OWNER)) FROM T;

COUNT(DISTINCT(OWNER))
 ———————-
 28

Decorrido: 00:00:05.57
 SQL> SELECT COUNT(DISTINCT(OWNER)) FROM T;

COUNT(DISTINCT(OWNER))
 ———————-
 28

Decorrido: 00:00:05.29
 SQL> DROP INDEX T_IDX1;

-ndice eliminado.

Decorrido: 00:00:00.32
 SQL> CREATE BITMAP INDEX T_IDX2 ON T(OWNER);

-ndice criado.

Decorrido: 00:00:30.84
 SQL> EXEC DBMS_STATS.GATHER_TABLE_STATS(’SCOTT’, ‘T’, CASCADE=>TRUE);

Procedimento PL/SQL concluÝdo com sucesso.

Decorrido: 00:01:01.14
 SQL> SELECT COUNT(DISTINCT(OWNER)) FROM T;

COUNT(DISTINCT(OWNER))
 ———————-
 28

Decorrido: 00:00:02.01
 SQL> SELECT COUNT(DISTINCT(OWNER)) FROM T;

COUNT(DISTINCT(OWNER))
 ———————-
 28

Decorrido: 00:00:01.90
 SQL> SELECT COUNT(DISTINCT(OWNER)) FROM T;

COUNT(DISTINCT(OWNER))
 ———————-
 28

Decorrido: 00:00:01.84
 SQL>

Tempo do COUNT DISTICT sem índices: 25 segundos, 26 segundos, e 26 segundos.

Tempo do COUNT DISTINCT com índice BTREE: 16 segundos, 5 segundos e 5 segundos

Tempo do COUNT DISTINCT com índice BITMAP: 2 segundos, 1 segundo e 1 segundo.

É interessante observar que o tempo de criação do índice também é bem menor (4 minutos e 35 segundos X 30 segundos). Este tempo menor é o mesmo para qualquer coluna da tabela, independente da cardinalidade.
